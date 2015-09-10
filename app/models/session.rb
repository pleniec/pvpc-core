class Session
  SESSION_TTL = 30.minutes

  attr_reader :access_token

  def initialize(options = {})
    @user = options[:user]
    @access_token = options[:access_token]
  end

  def create
    @access_token = Devise.friendly_token
    Cache.session.setex(redis_key, SESSION_TTL, @user.id)
  end

  def destroy
    Cache.session.del(redis_key)
  end

  def to_user
    return nil unless access_token
    Cache.session.expire(redis_key, SESSION_TTL)
    User.find_by_id(Cache.session.get(redis_key))
  end

  private

  def redis_key
    "access_token:#{@access_token}"
  end
end
