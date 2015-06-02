module API
  module V1
    class FriendshipsController < API::Controller
      load_and_authorize_resource :user, class: Users::User
      load_and_authorize_resource :friendship, class: Users::Friendship, through: :user
      
      def index
      end

      def destroy
        @friendship.destroy!
      end
    end
  end
end
