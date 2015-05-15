class Game < ActiveRecord::Base
  mount_uploader :icon, GameIconUploader unless Rails.env.test?
  mount_uploader :image, GameImageUploader unless Rails.env.test?

  has_many :game_translations
  has_many :rules, class_name: 'GameRule', foreign_key: :game_id

  accepts_nested_attributes_for :game_translations, allow_destroy: true
  accepts_nested_attributes_for :rules, allow_destroy: true

  validates :name, presence: true
  validates :icon, presence: true
  validates :image, presence: true

  default_scope { eager_load(rules: :entries) }

  def to_builder(with_rules = false)
    Jbuilder.new do |json|
      json.id id
      json.name name
      json.icon icon
      json.image image
      json.rules rules { |r| json.merge! r.to_builder.attributes! } if with_rules
    end
  end
end
