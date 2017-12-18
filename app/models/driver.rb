class Driver < ApplicationRecord
  has_secure_password

  belongs_to :location
  # has_many :orders

  enum vehicle_type: {
    "Go-Bike" => 0,
    "Go-Car" => 1
  }

  validates :username, :email, presence: true, uniqueness: true
  validates :vehicle_type, presence: true, inclusion: vehicle_types.keys
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 8 }, allow_blank: true

  validates_with LocationDriverValidator


  def api_key
    api = 'AIzaSyAnf7gZ6J-IqIw7tHOuwMzBlBUmu5Mpm0w'
  end

  def get_google_api
    gmaps = GoogleMapsService::Client.new(key: api_key)
    if !location.empty?
      matrix = gmaps.geocode(location)
    end
  end


  def set_location
    if api_not_nil?
      location = get_google_api
    end
  end

  def api_not_nil?
    !get_google_api.nil?
  end

end

