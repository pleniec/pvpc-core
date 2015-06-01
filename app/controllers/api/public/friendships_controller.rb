module Api
  module Public
    class FriendshipsController < Api::PublicController
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
