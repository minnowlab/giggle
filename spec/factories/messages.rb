FactoryGirl.define do
  factory :message do
    content { "Neque dicta enim quasi. Qui corrupti est quisquam. Facere animi quod aut. Qui nulla consequuntur consectetur sapiente." }
    association :product
    association :user
    association :evaluate

    factory :nil_content_message do 
      content nil
    end
  end
end
