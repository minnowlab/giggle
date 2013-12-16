class UserPicture < ActiveRecord::Base
	mount_uploader :picture, UserPictureUploader
	belongs_to :user
	validates :picture, presence: true

	before_save :update_picture_attributes



	private
	  def update_picture_attributes
	  	if picture.present? && picture.changed?
	  		self.picture_content_type = picture.file.content_type
	  		self.picture_file_size = picture.file.size
	  	end
	  end
end
