json.id model.id
json.name model.name
json.game_rules model.game_rules do |game_rule|
  json.id game_rule.id
  json.name game_rule.name
  json.properties { game_rule.properties.each { |k, v| json.set! k, v } }
end
