json.total @total
json.models @models do |model|
  json.id model.id
  json.from_user do
    json.id model.from_user.id
    json.email model.from_user.email
    json.nickname model.from_user.nickname
  end
end
