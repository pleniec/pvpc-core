class TeamMembershipsController < APIController
  has_scope :team_id, :user_id

  protected

  def create_params
    params.require(:team_membership).permit(:user_id, :team_id, :captain)
  end

  def update_params
    params.require(:team_membership).permit(:captain)
  end
end
