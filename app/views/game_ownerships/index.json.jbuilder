json.total @total
json.models @models do |model|
  json.id model.id
  json.nickname model.nickname
  json.game do
    json.id model.game.id
    json.name model.game.name
  end
end
