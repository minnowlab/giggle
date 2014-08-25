FactoryGirl.define do
  factory :product do
    name { "Apple" }
    description { "Vero earum commodi soluta." }
    details { "Neque dicta enim quasi. Qui corrupti est quisquam. Facere animi quod aut. Qui nulla consequuntur consectetur sapiente." }
    price 182.5
    association :product_category

    factory :nil_name_product do 
      name nil
    end

    factory :nil_product_category_id_product do
      product_category_id nil
    end
  end
end
