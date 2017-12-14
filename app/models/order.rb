# require_relative 'validator/gopay_validator.rb'
# require_relative 'validator/location_validator.rb'

class Order < ApplicationRecord

  belongs_to :user

  
  enum payment: {
    "Cash" => 0,
    "Go-Pay" => 1
  }

  enum mode: {
    "Go-Bike" => 0,
    "Go-Car" => 1
  }
  
  validates :mode, :origin, :destination, :payment, presence: true
  validates :payment, inclusion: payments.keys
  validates_with GopayValidator
  validates_with LocationValidator


  def api_key
    api = 'AIzaSyBuw4zguWESelrOJ4hbsvrwoc77356zNNk'
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

  def distance
    if api_not_nil?
      if get_google_api[:status] == "OK"
        get_google_api[:distance][:value]
      end
    end
  end

  def total
    if api_not_nil?
      if mode == "Go-Bike"
        cost = (distance.to_f / 1000) * 5000
        cost.round
      else
        cost = (distance.to_f / 1000) * 10000
        cost.round
      end
    end
  end

  # def total
  #   if api_not_nil?
  #     total_price + delivery_cost
  #   end
  # end

  def reduce_gopay
    gopay = 0
    if payment == "Go-Pay"
      gopay = User.find(user_id).gopay
      gopay -= total_price
    end
    gopay
  end

  private

  def api_not_nil?
    !get_google_api.nil?
  end

end

