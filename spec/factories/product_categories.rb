require 'faker'

FactoryGirl.define do
  factory :product_category do
    name { Faker::Name.name }
    
    factory :nil_name_product_category do 
      name nil
    end
  end
end
