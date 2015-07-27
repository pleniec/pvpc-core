namespace :chat do
  task sync: :environment do
    Conversation.eager_load(:conversation_participants).all.each do |conversation|
      key = "chat:conversation:#{conversation.id}"
      Redis.current.del(key)
      Redis.current.sadd(key, conversation.conversation_participants.map(&:id).to_a)
    end
  end
end
