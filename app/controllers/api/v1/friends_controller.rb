module Api
  module V1
    class FriendshipsController < Api::BaseController
      load_and_authorize_resource
      
      def index
      end

      def destroy
        @friendship.destroy!
      end
    end
  end
end
