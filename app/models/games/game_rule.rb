module Games
  class GameRule < ActiveRecord::Base
    belongs_to :game
    has_many :entries, class_name: 'GameRuleEntry', foreign_key: :game_rule_id

    accepts_nested_attributes_for :entries, allow_destroy: true

    validates :name, presence: true

    def to_builder
      Jbuilder.new do |json|
        json.name name
        json.entries entries do |entry|
          json.set! entry.key, entry.value
        end
      end
    end
  end
end
