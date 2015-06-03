module API
  module V1
    class FriendshipsController < API::Controller
      include NestedUsersResources

      def index
        @friendships = @user.friendships
        
        render json: @friendships.map(&:to_hash)
      end

      def destroy
        @friendship = @user.friendships.find(params[:id])
        authorize! :destroy, @friendship
        @friendship.destroy!

        render nothing: true
      end
    end
  end
end
