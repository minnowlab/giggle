class ProductPicture < ActiveRecord::Base
  mount_uploader :picture, ProductPictureUploader
  belongs_to :product

  before_save :update_picture_attributes

  private
  
    def update_picture_attributes
      if picture.present? && picture_changed?
        self.picture_content_type = picture.file.content_type
        self.picture_file_size = picture.file.size
      end
    end
end
