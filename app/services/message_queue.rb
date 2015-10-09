module MessageQueue
  class << self
    def session
      @session ||= _session
    end

    def notifications
      session.create_channel.queue("notifications", arguments: {'x-message-ttl' => 5000})
    end

    private

    def _session
      session = Bunny.new(Rails.application.config_for(:rabbitmq).symbolize_keys)
      session.start
      session
    end
  end
end
