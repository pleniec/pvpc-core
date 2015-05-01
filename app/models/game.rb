class Game < ActiveRecord::Base
  mount_uploader :icon, GameIconUploader
  mount_uploader :image, GameImageUploader

  has_many :game_translations

  accepts_nested_attributes_for :game_translations, allow_destroy: true

  validates :icon, presence: true
  validates :image, presence: true

  default_scope { eager_load(:game_translations) }
end
