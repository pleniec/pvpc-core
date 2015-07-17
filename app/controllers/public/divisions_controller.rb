module Public
  class DivisionsController < APIController
    has_scope :team_id, :game_id

    protected

    def create_params
      super.permit(:team_id, :game_id, :name)
    end

    def update_params
      super.permit(:name)
    end
  end
end
