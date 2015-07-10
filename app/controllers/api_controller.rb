class APIController < ActionController::Base
  include Actions::Index
  include Actions::Show
  include Actions::Create
  include Actions::Update
  include Actions::Destroy

  attr_reader :current_user

  http_basic_authenticate_with name: 'pvpc', password: 'pefalpe987'

  before_action :authenticate

  rescue_from(ActiveRecord::RecordNotFound) { |e| render json: {message: e.message}, status: :not_found }
  rescue_from(ActiveRecord::RecordInvalid) { |e| render json: e.record.errors, status: :unprocessable_entity }
  rescue_from(User::InvalidCredentials) { render json: {message: 'invalid credentials'}, status: :unprocessable_entity }
  rescue_from(CanCan::AccessDenied) { |e| render json: {message: e.message}, status: :forbidden }

  def current_ability
    @current_ability ||= Ability.new(current_user, params)
  end

  protected

  def model_class
    Object.const_get(controller_path.classify)
  end

  private

  def authenticate
    @current_user = Session.new(access_token: params[:access_token]).to_user
    render nothing: true, status: :unauthorized unless @current_user
  end
end
