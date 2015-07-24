json.id @model.id
json.conversation_participants @model.conversation_participants do |conversation_participant|
  json.id conversation_participant.id
  json.user do
    json.id conversation_participant.user.id
    json.email conversation_participant.user.email
    json.nickname conversation_participant.user.nickname
  end
end