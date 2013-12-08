require 'faker'

FactoryGirl.define do
  factory :product do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence(10) }
    details { Faker::Lorem.paragraph(3) }
    price 182.5
    product_category_id 5

    factory :nil_name_product do 
      name nil
    end

    factory :nil_product_category_id_product do
      product_category_id nil
    end
  end
end
