module Api
  module V1
    class FriendshipsController < Api::BaseController
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