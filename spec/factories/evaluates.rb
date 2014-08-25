FactoryGirl.define do
  factory :evaluate do
    title { "Vero earum commodi soluta." }
    details { "Neque dicta enim quasi. Qui corrupti est quisquam. Facere animi quod aut. Qui nulla consequuntur consectetur sapiente." }
    association :user
    association :product

    factory :nil_title_evaluate do 
      title nil
    end

    factory :nil_details_evaluate do 
      details nil
    end

    factory :nil_product_id_evaluate do 
      product_id nil
    end

    factory :nil_user_id_evaluate do 
      user_id nil
    end
  end
end
