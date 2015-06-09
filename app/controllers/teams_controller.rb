class TeamsController < APIController
  inherit_resources
  load_and_authorize_resource

  protected

  def team_params
    params.require(:team).permit(:name, :description, :tag, :founder_id)
  end
end
