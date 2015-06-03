module API
  module V1
    class UserGamesController < API::Controller
      include NestedUsersResources

      before_action :set_user_game, only: [:update, :destroy]

      def index
        render json: @user.user_games
      end

      def create
        @user_game = @user.user_games.new(create_params)
        authorize! :create, @user_game
        @user_game.save!

        render json: @user_game.to_hash
      end

      def update
        authorize! :update, @user_game
        @user_game.update!(update_params)

        render json: @user_game.to_hash
      end

      def destroy
        authorize! :destroy, @user_game
        @user_game.destroy!

        render nothing: true
      end

      private

      def set_user_game
        @user_game = @user.user_games.find(params[:id])
      end

      def create_params
        params.require(:user_game).permit(:nickname, :game_id)
      end

      def update_params
        params.require(:user_game).permit(:nickname)
      end
    end
  end
end
