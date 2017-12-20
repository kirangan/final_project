class Driver < ApplicationRecord
  has_secure_password
  has_many :orders

  geocoded_by :location
  after_validation :geocode, if: ->(obj){ obj.location.present? and obj.location_changed? }


  enum vehicle_type: {
    "Go-Bike" => 0,
    "Go-Car" => 1
  }

  validates :username, :email, presence: true, uniqueness: true
  validates :vehicle_type, presence: true, inclusion: vehicle_types.keys
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 8 }, allow_blank: true

  def self.update_gopay_driver_from_order(order)
    Driver.find(order.driver_near_first).update(gopay: order.increase_gopay)
  end

  def self.update_location_from_order(order)
    Driver.find(order.driver_near_first).update(location: order.change_driver_location )
  end

end

