namespace :chat do
  task sync: :environment do
    Conversation.eager_load(:conversation_participants).all.each do |conversation|
      Redis.current.sadd("conversation:#{conversation.id}", conversation.conversation_participants.to_a)
    end
  end
end
