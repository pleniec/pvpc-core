class GameImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process convert: :jpg
  process resize_to_fit: [400, 300]
end
