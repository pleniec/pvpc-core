module Public
  class TeamsController < APIController
    protected

    def create_params
      super.permit(:name, :description, :tag, :founder_id)
    end
  end
end
