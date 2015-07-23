json.total @total
json.models @models do |model|
  json.id model.id
  json.friend do
    json.id model.friend.id
    json.email model.friend.email
    json.nickname model.friend.nickname
  end
end
