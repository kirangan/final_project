# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    mode "Go-Bike"
    origin "sarinah, jakarta"
    destination "tanah abang, jakarta"
    payment "Cash"

    total_price 30000
    
  end

  factory :invalid_order, parent: :order do
    mode nil
    origin nil
    destination nil
    payment nil
  end
end
