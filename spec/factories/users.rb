# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username { Faker::Internet.unique.user_name }
    email { Faker::Internet.email }
    password "longpassword"
    password_confirmation "longpassword"
  end

  factory :invalid_user, parent: :user do
    username nil
    email nil
    password nil
    password_confirmation nil
  end
end
