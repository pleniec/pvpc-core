class Game < ActiveRecord::Base
  mount_uploader :icon, GameIconUploader unless Rails.env.test?
  mount_uploader :image, GameImageUploader unless Rails.env.test?

  has_many :game_translations
  has_many :rules, class_name: 'GameRule'

  accepts_nested_attributes_for :game_translations, allow_destroy: true
  accepts_nested_attributes_for :rules, allow_destroy: true

  validates :name, presence: true
  validates :icon, presence: true
  validates :image, presence: true

  def to_builder(detailed = false)
    Jbuilder.new do |json|
      json.id id
      json.name name
      json.icon icon

      if detailed
        json.image image
        json.rules rules do |rule|
          json.merge! rule.to_builder.attributes!
        end
      end
    end
  end
end
