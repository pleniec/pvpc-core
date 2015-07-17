class GameOwnershipsController < APIController
  has_scope :user_id

  protected

  def create_params
    super.permit(:user_id, :game_id, :nickname)
  end

  def update_params
    super.permit(:nickname)
  end
end
