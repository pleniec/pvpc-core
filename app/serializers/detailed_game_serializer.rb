class DetailedGameSerializer < GameSerializer
  has_many :game_rules, serializer: GameRuleSerializer
end
