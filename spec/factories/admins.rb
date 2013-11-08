require 'faker'

FactoryGirl.define do
  factory :admin do
    name { Faker::Name.name }
    password_digest "MyString"
  end
end
