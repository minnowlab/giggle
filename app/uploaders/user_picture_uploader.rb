# encoding: utf-8

class UserPictureUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  version :large do
    process :resize_and_pad => [800, 800]
  end

  version :small do
    process :resize_and_pad => [400, 400]
  end

  version :mini do
    process :resize_and_pad => [80, 80]
  end

  version :cover do
    process :resize_and_pad => [60, 60]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
