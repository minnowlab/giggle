# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest "MyString"
    remember_token "MyString"
    name { Faker::Name.name }
  end
end
