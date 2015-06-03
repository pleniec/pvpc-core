module API
  module V1
    class TeamsController < API::Controller
      has_scope :offset
      has_scope :limit

      def index
        render json: apply_scopes(Team).all.map(&:to_simple_hash)
      end

      def show
        render json: Team.eager_load(:founder).find(params[:id]).to_detailed_hash
      end

      def create
        @team = Team.new(create_params)
        authorize! :create, @team
        @team.save!
        
        render json: @team.to_detailed_hash
      end

      private

      def create_params
        params.require(:team).permit(:name, :description, :tag, :founder_id)
      end
    end
  end
end
