json.total @total
json.models @models do |model|
  json.id model.id
  json.conversation_id model.conversation_id
end
