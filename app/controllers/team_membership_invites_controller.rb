class TeamMembershipInvitesController < ApplicationController
  has_scope :to_user_id

  def accept
    @model = TeamMembershipInvite.find(params[:id])
    authorize! :accept, @model
    @model.accept!
    render nothing: true, status: :no_content
  end
  
  protected

  def create_params
    params.permit(:to_user_id, :team_id)
  end
end
