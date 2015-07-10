module Authentication
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user
    before_action :authenticate
  end

  private

  def authenticate
    @current_user = Session.new(access_token: params[:access_token]).to_user
    render nothing: true, status: :unauthorized unless @current_user
  end
end
