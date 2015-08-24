json.total @total
json.models @models do |model|
  json.id model.id
  json.user do
    json.id model.user.id
    json.email model.user.email
    json.nickname model.user.nickname
  end
  json.team do
    json.id model.team.id
    json.nickname model.team.nickname
  end
end
