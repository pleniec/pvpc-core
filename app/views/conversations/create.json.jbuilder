json.id @model.id
json.conversation_participants @model.conversation_participants do |conversation_participant|
  json.id conversation_participant.id
  json.user { json.partial! 'partials/user/simple', model: conversation_participant.user }
end
