# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_picture do
    picture "MyString"
    picture_content_type "MyString"
    picture_file_size 1
    user_id 1
  end
end
