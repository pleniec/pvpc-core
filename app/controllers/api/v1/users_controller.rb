module Api
  module V1
    class UsersController < Api::BaseController
      load_and_authorize_resource
      skip_before_action :authenticate, only: [:create, :login]

      def index
      end

      def create
        @user = User.create!(create_params)
      end

      def login
        @user = User.authenticate(params[:email], params[:password])
      end

      def update
        User.find(params[:id]).update!(update_params)
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
