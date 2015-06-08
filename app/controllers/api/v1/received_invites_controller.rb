module API
  module V1
    class ReceivedInvitesController < API::Controller
      load_and_authorize_resource :user
      load_and_authorize_resource :received_invites, through: :user, class: 'FriendshipInvite'

      def index
      end

      def update
      end

      def destroy
      end
    end
  end
end
