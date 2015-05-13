json.array! @games do |game|
  json.id game.id
  json.name game.name
  json.icon game.icon
  json.image game.image
end
