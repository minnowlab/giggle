# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :evaluate do
    title "MyString"
    details "MyText"
    product_id 1
    user_id 1
  end
end
