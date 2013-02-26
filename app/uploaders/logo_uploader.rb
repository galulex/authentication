# encoding: utf-8

class LogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process resize_to_fill: [124, 124]

  version :small do
    process resize_to_fill: [55, 55]
  end

  storage :file
  # storage :fog
  #

  def cache_dir
    "#{Rails.root}/tmp/uploads/#{Rails.env}/logos"
  end

  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
