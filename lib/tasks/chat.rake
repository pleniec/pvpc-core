namespace :chat do
  task sync: :environment do
    Conversation.eager_load(:conversation_participants).all.each do |conversation|
      key = "conversation:#{conversation.id}"
      Redis.current.del(key)
      Redis.current.sadd(key, conversation.conversation_participants.to_a)
    end
  end
end
