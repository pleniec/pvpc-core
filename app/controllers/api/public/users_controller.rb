module Api
  module Public
    class UsersController < Api::PublicController
      load_and_authorize_resource class: Users::User
      skip_before_action :authenticate, only: [:create, :login]

      def index
      end

      def create
        @user = Users::User.create!(create_params)
      end

      def login
        @user = Users::User.authenticate(params[:email], params[:password])
      end

      def update
        @user.update!(update_params)
      end

      private

      def create_params
        params.require(:user).permit(:email, :password, :nickname)
      end

      def update_params
        params.require(:user).permit(:email, :nickname)
      end
    end
  end
end
