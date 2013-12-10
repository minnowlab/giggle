require 'faker'

FactoryGirl.define do
  factory :message do
    content { Faker::Lorem.sentence(10) }
    association :product
    association :user
    association :evaluate

    factory :nil_content_message do 
      content nil
    end
  end
end
