class DriverSerializer < ActiveModel::Serializer
  attributes :id, :username, :location, :vehicle_type, :gopay
  has_many :orders
  
end
