# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :driver do
    username { Faker::Internet.unique.user_name }
    email { Faker::Internet.email }
    vehicle_type "Go-Car"
    gopay 10000
    password "longpassword"
    password_confirmation "longpassword"

  end

  factory :invalid_driver do
    username nil
    email nil
    vehicle_type nil
    gopay nil
    password nil
    password_confirmation nil
  end
end
