class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def current_ability
    @current_ability ||= Users::Ability.new(current_user)
  end

  private

  def record_not_found(e)
    render json: {message: e.message}, status: :not_found
  end
end
