class OrderSerializer < ActiveModel::Serializer
  attributes :id, :mode, :origin, :destination
  
end
