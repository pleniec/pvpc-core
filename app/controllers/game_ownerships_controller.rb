class GameOwnershipsController < APIController
  has_scope :user_id

  def create_params
    params.require(:game_ownership).permit(:user_id, :game_id, :nickname)
  end

  def update_params
    params.require(:game_ownership).permit(:nickname)
  end
end
