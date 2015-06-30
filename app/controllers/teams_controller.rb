class TeamsController < APIController
  protected

  def create_params
    params.require(:team).permit(:name, :description, :tag, :founder_id)
  end
end
