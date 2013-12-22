module UserPicturesHelper
  def user_picture_cover picture_cover, size, opts = {}
    picture_cover.present? ? image_tag(picture_cover, opts) : image_tag("default_user_picture/default_#{size}.png", opts)
  end
end
