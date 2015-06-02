module API
  class Controller < ApplicationController
    attr_reader :current_user

    http_basic_authenticate_with name: 'pvpc', password: 'pefalpe987'
    protect_from_forgery with: :null_session

    before_action :authenticate

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from Users::User::InvalidCredentials, with: :invalid_credentials
    rescue_from CanCan::AccessDenied, with: :access_denied
    rescue_from ActionView::MissingTemplate, with: :missing_template

    def current_ability
      @current_ability ||= Users::Ability.new(current_user)
    end

    private

    def record_not_found(e)
      render json: {message: e.message}, status: :not_found
    end

    def authenticate
      @current_user = Users::Session.new(access_token: params[:access_token]).to_user
      render nothing: true, status: :unauthorized unless @current_user
    end

    def record_invalid(e)
      render json: e.record.errors, status: :unprocessable_entity
    end

    def invalid_credentials
      render json: {message: 'invalid credentials'}, status: :unprocessable_entity
    end

    def access_denied(e)
      render json: {message: e.message}, status: :forbidden
    end

    def missing_template
      render nothing: true
    end
  end
end
