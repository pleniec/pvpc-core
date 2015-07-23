json.total @total
json.models @models do |model|
  json.id model.id
  json.email model.email
  json.nickname model.nickname
end
