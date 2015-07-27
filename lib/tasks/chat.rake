namespace :chat do
  task sync: :environment do
    Conversation.eager_load(:conversation_participants).all.each do |conversation|
      conversation.synchronize
    end
  end
end
