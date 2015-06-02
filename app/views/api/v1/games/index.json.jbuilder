json.array! @games do |game|
  json.merge! game.to_builder.attributes!
end
