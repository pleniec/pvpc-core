json.total @total
json.models @models do |model|
  json.id model.id
  json.conversation_id model.conversation_id
  json.text model.text
  json.user { json.partial! 'partials/user/simple', model: model.user }
end
