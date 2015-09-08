module Authentication
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user
    helper_method :current_user
    before_action :set_current_user
    before_action :authenticate
  end

  private

  def set_current_user
    @current_user = Session.new(access_token: params[:access_token]).to_user
  end

  def authenticate
    render json: {message: 'invalid access token'}, status: :unauthorized unless @current_user
  end
end
