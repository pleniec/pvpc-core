json.total @total
json.models @models do |model|
  json.id model.id
  json.conversation_id model.conversation_id
  json.text model.text
  json.user do
    json.id model.user.id
    json.email model.user.email
    json.nickname model.user.nickname
  end
end
