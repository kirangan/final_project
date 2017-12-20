class Order < ApplicationRecord

  belongs_to :user
  belongs_to :driver, optional: true

  geocoded_by :origin
  after_validation :geocode, if: ->(obj){ obj.origin.present? and obj.origin_changed? }

  after_validation :available_driver
  after_validation :not_over_max_destination

  enum payment: {
    "Cash" => 0,
    "Go-Pay" => 1
  }

  enum mode: {
    "Go-Bike" => 0,
    "Go-Car" => 1
  }
  
  validates :mode, :origin, :destination, :payment, presence: true
  validates_with GopayValidator
  validates_with LocationValidator
 
  def max_destination
    50
  end

  def max_driver_around
    5
  end

  def go_bike_price_per_km
    5000
  end

  def go_car_price_per_km
    10000
  end

  def api_key
    api = 'AIzaSyBuCtNpyRMsidzXxQKcAInhkFI4jK3buUs'
  end

  def get_google_api
    gmaps = GoogleMapsService::Client.new(key: api_key)
    origins = origin
    destinations = destination
    if !origins.empty? && !destinations.empty?
      matrix = gmaps.distance_matrix(origins, destinations, mode: 'driving', language: 'en-AU', avoid: 'tolls')
      matrix[:rows][0][:elements][0]
    end
  end

  def distance_length
    if api_not_nil?
      if get_google_api[:status] == "OK"
        get_google_api[:distance][:value]
      end
    end
  end

  def total
    if api_not_nil?
      if mode == "Go-Bike"
        if (distance_length.to_f / 1000) < 1
          cost = go_bike_price_per_km
        else
          cost = ((distance_length.to_f / 1000) * go_bike_price_per_km).round(-2)
        end
      else
        if (distance_length.to_f / 1000) < 1
          cost = go_car_price_per_km
        else
          cost = ((distance_length.to_f / 1000) * go_car_price_per_km).round(-2)
        end
      end
    end
  end

  def driver_near_first
    if !check_driver.blank?
      check_driver.first.id
    end
  end

  def reduce_gopay
    gopay = 0
    if payment == "Go-Pay"
      gopay = User.find(user_id).gopay
      gopay -= total
    end
    gopay
  end

  def increase_gopay
    gopay = 0
    if payment == "Go-Pay"
      gopay = Driver.find(driver_near_first).gopay
      gopay += total
    end
    gopay
  end

  def change_driver_location 
    Driver.find(driver_near_first).location = destination
  end


  private

  def api_not_nil?
    !get_google_api.nil?
  end

  def not_over_max_destination
    if !distance_length.nil?
      if (distance_length.to_f / 1000) > max_destination
        errors.add(:destination, "Sorry service too far")
      end
    end
  end

  def check_driver
    driver = Driver.all
    driver.where(vehicle_type: mode).near(origin, max_driver_around, :units => :km)
  end

  def available_driver
    if check_driver.blank?
      errors.add(:origin, "Sorry there are no drivers around you")
    end
  end
end