FactoryGirl.define do
  factory :product_picture do
    picture "MyString"
    choice false
    picture_content_type "MyString"
    picture_file_size 1
    product nil
  end
end
