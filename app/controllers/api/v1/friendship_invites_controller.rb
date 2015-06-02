module API
  module V1
    class FriendshipInvitesController < API::Controller
      include NestedUsersResource

      before_action :set_friendship_invite, only: [:update, :destroy]

      def index
        @friendship_invites = @user.received_invites
        @friendship_invites.each { |fi| authorize! :index, fi }
      end

      def create
        @friendship_invite = @user.sent_invites.new(create_params)
        authorize! :create, @friendship_invite
        @friendship_invite.save!
      end

      def update
        authorize! :update, @friendship_invite
        @friendship_invite.accept!
      end

      def destroy
        authorize! :destroy, @friendship_invite
        @friendship_invite.destroy!
      end

      private

      def set_friendship_invite
        @friendship_invite = @user.received_invites.find(params[:id])
      end

      def create_params
        params.require(:friendship_invite).permit(:to_user_id)
      end
    end
  end
end
