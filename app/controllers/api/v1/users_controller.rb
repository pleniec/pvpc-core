module API
  module V1
    class UsersController < API::Controller
      skip_before_action :authenticate, only: [:create, :login]

      def create
        @user = Users::User.create!(create_params)

        render json: @user.to_hash_with_access_token
      end

      def login
        @user = Users::User.authenticate(params[:email], params[:password])

        render json: @user.to_hash_with_access_token
      end

      def update
        @user = Users::User.find(params[:id])
        authorize! :update, @user
        @user.update!(update_params)

        render nothing: true
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
