class DivisionsController < APIController
  has_scope :team_id, :game_id

  protected

  def create_params
    params.require(:division).permit(:team_id, :game_id, :name)
  end

  def update_params
    params.require(:division).permit(:name)
  end
end
