class TeamMembershipPropositionsController < ApplicationController
  has_scope :team_id, :user_id, :type, :limit, :offset

  def accept
    @model = TeamMembershipProposition.find(params[:id])
    authorize! :accept, @model
    @model.accept!
    render nothing: true, status: :no_content
  end

  private

  def create_params
    params.permit(:user_id, :team_id, :type)
  end
end
