class GameOwnershipsController < ApplicationController
  has_scope :user_id

  protected

  def create_params
    params.permit(:user_id, :game_id, :nickname)
  end

  def update_params
    params.permit(:nickname)
  end
end
