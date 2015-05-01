class GameIconUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process convert: :jpg
  process resize_to_fit: [100, 100]
end
