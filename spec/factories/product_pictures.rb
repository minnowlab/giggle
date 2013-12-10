FactoryGirl.define do
  factory :product_picture do
    picture { File.open(File.join(Rails.root, '/spec/support/images/product_picture_test.png')) }
    cover false
    association :product

    after(:create) do |product_picture, picture|
      if picture.present?
        product_picture.picture_content_type = product_picture.picture.file.content_type
        product_picture.picture_file_size = product_picture.picture.file.size
      end
    end
  end
end
