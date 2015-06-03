module API
  module V1
    class UsersController < API::Controller
      skip_before_action :authenticate, only: [:create, :login]

      def create
        render json: User.create!(create_params).to_hash_with_access_token
      end

      def login
        render json: User.authenticate(params[:email], params[:password]).to_hash_with_access_token
      end

      def update
        @user = User.find(params[:id])
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
