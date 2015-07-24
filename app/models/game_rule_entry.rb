class GameRuleEntry < ActiveRecord::Base
  belongs_to :rule, class_name: 'GameRule', foreign_key: :game_rule_id

  validates :key, presence: true
  validates :value, presence: true
end
