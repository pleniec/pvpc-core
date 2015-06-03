module Games
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

    def to_simple_hash
        {id: id, name: name, icon: icon}
    end

    def to_detailed_hash
        to_simple_hash.merge(image: image, rules: rules.map(&:to_hash))
    end
  end
end
