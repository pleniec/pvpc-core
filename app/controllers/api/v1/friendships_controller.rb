module API
  module V1
    class FriendshipsController < API::Controller
      include NestedUsersResource

      def index
        @friendships = @user.friendships
      end

      def destroy
        @friendship = @user.friendships.find(params[:id])
        authorize! :destroy, @friendship
        @friendship.destroy!
      end
    end
  end
end
