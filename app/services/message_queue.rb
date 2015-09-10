module MessageQueue
  class << self
    def session
      @session ||= _session
    end

    private

    def _session
      session = Bunny.new(Rails.application.config_for(:rabbitmq).symbolize_keys)
      session.start
      session
    end
  end
end
