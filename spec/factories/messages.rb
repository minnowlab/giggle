require 'faker'

FactoryGirl.define do
  factory :message do
    content { Faker::Lorem.sentence(10) }
    product_id 1
    user_id 1
    evaluate_id 1

    factory :nil_content_message do 
      content nil
    end
  end
end
