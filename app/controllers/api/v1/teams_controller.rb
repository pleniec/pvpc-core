module API
  module V1
    class TeamsController < API::Controller
      has_scope :offset
      has_scope :limit

      def index
        @teams = apply_scopes(Teams::Team).all

        render json: @teams.map(&:to_simple_hash)
      end

      def show
        @team = Teams::Team.eager_load(:founder).find(params[:id])

        render json: @team.to_detailed_hash
      end

      def create
        @team = Teams::Team.new(create_params)
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
