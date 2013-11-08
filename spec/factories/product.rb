FactoryGirl.define do
  factory :product do
    name "MyString"
    description "MyString"
    details "MyString"
    price 15.2

    factory :invalid_product do 
      name nil
    end
  end
end
