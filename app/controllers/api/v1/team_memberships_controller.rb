module API
  module V1
    class TeamMembershipsController < API::Controller
      before_action :set_team
      before_action :set_team_membership, only: [:update, :destroy]

      def index
        render json: @team.team_memberships.map(&:to_hash_with_user)
      end

      def create
        @team_membership = @team.team_memberships.new(create_params)
        authorize :create, @team_membership
        @team_membership.save!

        render nothing: true
      end

      def update
        authorize! :update, @team_membership
        @team_membership.update!(update_params)

        render nothing: true
      end

      def destroy
        authorize! :destroy, @team_membership
        @team_membership.destroy!

        render nothing: true
      end

      private

      def set_team
        @team = Team.find(params[:team_id])
      end

      def set_team_membership
        @team_membership = @team.team_memberships.find(params[:id])
      end

      def create_params
        params.require(:team_membership).permit(:user_id, :captain)
      end

      def update_params
        params.require(:team_membership).permit(:captain)
      end
    end
  end
end
