module API
  module V1
    class UserTeamsController < API::Controller
      include NestedUsersResources
      
      def index
        @user_teams = @user.user_teams.eager_load(:team)
      end
    end
  end
end
