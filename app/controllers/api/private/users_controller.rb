module Api
  module Private
    class UsersController < Api::PrivateController
      def by_access_token
        @user = User.authenticate_with_access_token(params[:access_token])
        raise ActiveRecord::RecordNotFound unless @user
      end
    end
  end
end
