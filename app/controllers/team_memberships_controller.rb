class TeamMembershipsController < APIController
  has_scope :team_id, :user_id

  protected

  def create_params
    params.permit(:user_id, :team_id, :captain)
  end

  def update_params
    params.permit(:captain)
  end
end
