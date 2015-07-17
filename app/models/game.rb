class Game < ActiveRecord::Base
  has_many :game_translations
  has_many :rules, class_name: 'GameRule'

  accepts_nested_attributes_for :game_translations, allow_destroy: true
  accepts_nested_attributes_for :rules, allow_destroy: true

  validates :name, presence: true

  def to_builder(controller, action)
    Jbuilder.new do |json|
      json.id id
      json.name name

      if action == :show
        json.rules rules do |rule|
          json.merge! rule.to_builder(controller, action).attributes!
        end
      end
    end
  end
end
