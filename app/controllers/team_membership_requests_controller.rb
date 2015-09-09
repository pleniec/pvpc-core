class TeamMembershipRequestsController < ApplicationController
  has_scope :team_id

  def accept
    @model = TeamMembershipRequest.find(params[:id])
    authorize! :accept, @model
    @model.accept!
    render nothing: true, status: :no_content
  end

  private

  def create_params
    params.permit(:from_user_id, :team_id)
  end
end
