module Api
  class PublicController < ApiController
    attr_reader :current_user

    http_basic_authenticate_with name: 'pvpc', password: 'pefalpe987'

    before_action :authenticate

    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from User::InvalidCredentials, with: :invalid_credentials
    rescue_from CanCan::AccessDenied, with: :access_denied
    rescue_from ActionView::MissingTemplate, with: :missing_template

    private

    def authenticate
      @current_user = User.authenticate_with_access_token(params[:access_token])
      render nothing: true, status: :unauthorized unless @current_user
    end

    def record_invalid(e)
      render json: e.record.errors, status: :unprocessable_entity
    end

    def invalid_credentials
      render json: {message: 'invalid credentials'}, status: :unprocessable_entity
    end

    def access_denied
      render nothing: true, status: :forbidden
    end

    def missing_template
      render nothing: true
    end
  end
end
