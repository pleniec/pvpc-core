json.total @total
json.models @models do |model|
  json.id model.id
  json.nickname model.nickname
end
