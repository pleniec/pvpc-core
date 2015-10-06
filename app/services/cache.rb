module Cache
  def self.session
    @session ||= Redis.new(Rails.application.config_for(:redis))
  end
end
