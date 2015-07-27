namespace :chat do
  task sync: :environment do
    Conversation.eager_load(:conversation_participants).all.each { |c| c.synchronize }
  end
end
