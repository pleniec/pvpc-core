module API
  module V1
    class UsersController < API::Controller
      skip_before_action :authenticate, only: [:create, :login]

      def create
        @user = Users::User.create!(create_params)
      end

      def login
        @user = Users::User.authenticate(params[:email], params[:password])
      end

      def update
        @user = Users::User.find(params[:id])
        authorize! :update, @user
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
