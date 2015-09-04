class ConversationsController < ApplicationController
  protected

  def create_params
    params.permit(conversation_participants_attributes: [:user_id])
  end
end
