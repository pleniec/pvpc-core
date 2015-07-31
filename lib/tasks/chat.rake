namespace :chat do
  task sync: :environment do
    Conversation.eager_load(:conversation_participants).all.each { |c| c.synchronize }
  end

  task message_worker: :environment do
    bunny = Bunny.new(Rails.application.config_for(:rabbitmq).symbolize_keys)
    bunny.start
    bunny.create_channel.queue('chat:messages').subscribe(block: true) do |_, _, message_attributes_string|
      begin
        Message.create!(JSON.parse(message_attributes_string))
      rescue StandardError => e
        puts e
      end
    end
  end
end
