module Api
  module Public
    class FriendshipInvitesController < Api::PublicController
      load_and_authorize_resource :user, class: Users::User
      load_and_authorize_resource :friendship_invite, class: Users::FriendshipInvite, through: :user
      
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
