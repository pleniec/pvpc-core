module API
  module V1
    class UserGamesController < API::Controller
      include NestedUsersResources

      def index
        @user_games = Games::UserGame.where(user_id: params[:user_id])
      end

      def create
        @user_game = Games::UserGame.new(create_params.merge(user_id: params[:user_id]))
        authorize! :create, @user_game
        @user_game.save!
      end

      def update
        @user_game = Games::UserGame.find(params[:id])
        authorize! :update, @user_game
        @user_game.update!(update_params)
      end

      def destroy
        @user_game = Games::UserGame.find(params[:id])
        authorize! :destroy, @user_game
        @user_game.destroy!
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
