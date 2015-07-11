class TeamMembershipsController < APIController
  has_scope :team_id, :user_id

  protected

  def create_params
    super.permit(:user_id, :team_id, :captain)
  end

  def update_params
    super.permit(:captain)
  end
end
