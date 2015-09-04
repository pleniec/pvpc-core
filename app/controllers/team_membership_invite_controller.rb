class TeamMembershipInviteController < ApplicationController
  has_scope :to_user_id

  def accept
    @model = TeamMembershipInvite.find(params[:id])
    authorize! :accept, @model
    @model.accept!
  end
  
  protected

  def create_params
    params.permit(:from_user_id, :to_user_id, :team_id)
  end
end
