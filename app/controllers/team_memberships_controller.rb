class TeamMembershipsController < APIController
  inherit_resources
  load_and_authorize_resource

  has_scope :team_id
  has_scope :user_id

  protected

  def collection
    get_collection_ivar || set_collection_ivar(end_of_association_chain.eager_load(:user, :team))
  end

  def team_membership_params
    case action_name
    when 'create'
      params.require(:team_membership).permit(:user_id, :team_id, :captain)
    when 'update'
      params.require(:team_membership).permit(:captain)
    end
  end
end
