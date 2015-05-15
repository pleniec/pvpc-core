module Api
  module V1
    class FriendshipInvitesController < Api::BaseController
      load_and_authorize_resource :user
      load_and_authorize_resource :friendship_invite, through: :user
      
      def index
      end

      def create
        @user.sent_invites.create!(create_params)
      end

      def update
        @friendship_invite.accept!
      end

      def destroy
        @friendship_invite.destroy!
      end

      private

      def create_params
        params.require(:friendship_invite).permit(:to_user_id)
      end
    end
  end
end
