class Api::BaseController < ApplicationController
  http_basic_authenticate_with name: 'pvpc', password: 'pefalpe987'
  protect_from_forgery with: :null_session
  before_action :authenticate

  def authenticate
    return render nothing: true, status: :unauthorized unless params[:access_token]
    current_user = User.find_by_access_token(params[:access_token])
    render nothing: true, status: :unauthorized unless current_user
  end
end
