module Api
  module V1
    class FriendshipInvitesController < Api::BaseController
      load_and_authorize_resource
      
      def index
      end

      def create
        current_user.sent_invitations.create!(create_params)
      end

      def update
        @friendship_invite.accept!
      end

      def destroy
        @friendship_invite.reject!
      end

      private

      def create_params
        params.require(:friendship_invite).permit(:to_user_id)
      end
    end
  end
end
