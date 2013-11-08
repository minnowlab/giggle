require 'faker'

FactoryGirl.define do
  factory :product do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence(10) }
    details { Faker::Lorem.paragraph(3) }
    price 182.5

    factory :invalid_product do 
      name nil
    end
  end
end
