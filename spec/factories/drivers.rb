# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :driver do
    username { Faker::Internet.unique.user_name }
    email { Faker::Internet.email }
    gopay 10000
    password "longpassword"
    password_confirmation "longpassword"
  end

  factory :invalid_driver do
    username nil
    email nil
    password nil
    password_confirmation nil
  end
end
