module API
  module V1
    class UserGamesController < API::Controller
      def index
        authorize! :index, UserGame
        @user_games = UserGame.eager_load(:game)
      end

      def create
        @user_game.save!
      end

      def update
        @user_game.update!(update_params)
      end

      def destroy
        @user_game.destroy!
        render nothing: true
      end

      private

      def create_params
        params.require(:user_game).permit(:nickname, :game_id)
      end

      def update_params
        params.require(:user_game).permit(:nickname)
      end
    end
  end
end
