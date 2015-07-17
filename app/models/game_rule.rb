class GameRule < ActiveRecord::Base
  belongs_to :game
  has_many :entries, class_name: 'GameRuleEntry', foreign_key: :game_rule_id

  accepts_nested_attributes_for :entries, allow_destroy: true

  validates :name, presence: true

  def to_builder(controller, action)
    Jbuilder.new do |json|
      json.id id
      json.name name
      json.entries entries do |entry|
        json.merge! entry.to_builder(controller, action).attributes!
      end
    end
  end
end
