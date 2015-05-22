module Api
  module Public
    class FriendshipsController < Api::PublicController
      load_and_authorize_resource :user
      load_and_authorize_resource :friendship, through: :user
      
      def index
      end

      def destroy
        @friendship.destroy!
      end
    end
  end
end
