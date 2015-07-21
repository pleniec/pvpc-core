class DivisionsController < APIController
  has_scope :team_id, :game_id

  protected

  def create_params
    params.permit(:team_id, :game_id, :name)
  end

  def update_params
    params.permit(:name)
  end
end
