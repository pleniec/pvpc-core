module API
  module V1
    class TeamMembersController < API::Controller
      before_action :set_team

      def index
      end

      def create
      end

      def update
      end

      def destroy
      end

      private

      def set_team
        @team = Team.find(params[:id])
      end
    end
  end
end
