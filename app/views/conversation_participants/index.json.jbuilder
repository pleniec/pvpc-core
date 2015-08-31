json.total @total
json.models @models do |model|
  json.id model.id
  json.conversation do
    json.id model.conversation.id
    json.conversation_participants model.conversation.conversation_participants do |conversation_participant|
      json.id conversation_participant.id
      json.user { json.partial! 'partials/user/simple', model: conversation_participant.user }
    end
  end
end
