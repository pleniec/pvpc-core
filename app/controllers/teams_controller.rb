class TeamsController < APIController
  protected

  def create_params
    params.permit(:name, :description, :tag, :founder_id)
  end

  def create_view
    :detailed
  end

  def show_view
    :detailed
  end
end
