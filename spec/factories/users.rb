require 'faker'

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "123456789"
    password_confirmation "123456789"
    name { Faker::Name.name }

    factory :nil_email_user do 
      email nil
    end

    factory :nil_password_user do 
      password nil
    end

    factory :nil_password_confirmation_user do 
      password_confirmation ""
    end
  end
end
