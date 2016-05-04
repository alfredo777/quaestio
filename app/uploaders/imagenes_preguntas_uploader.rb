# encoding: utf-8

class ImagenesPreguntasUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::MiniMagick

  version :full do
     process :resize_to_fill => [550, 550]
  end

  version :small do 
     process :resize_to_fill => [200, 200]
  end
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
