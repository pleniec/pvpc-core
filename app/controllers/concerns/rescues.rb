module Rescues
  extend ActiveSupport::Concern

  included do
    rescue_from(ActiveRecord::RecordNotFound) { |e| render json: {message: e.message}, status: :not_found }
    rescue_from(ActiveRecord::RecordInvalid) { |e| render json: e.record.errors, status: :unprocessable_entity }
    rescue_from(CanCan::AccessDenied) { |e| render json: {message: e.message}, status: :forbidden }
  end
end
