module Api
  module V1
    class UserGamesController < Api::BaseController
      load_and_authorize_resource

      def index
      end

      def create
        UserGame.create!(create_params)
        render nothing: true
      end

      def update
        @user_game.update!(update_params)
        render nothing: true
      end

      def destroy
        @user_game.destroy!
        render nothing: true
      end

      private

      def create_params
        params.require(:user_game).permit(:nickname, :game_id).merge(user_id: current_user.id)
      end

      def update_params
        params.require(:user_game).permit(:nickname)
      end
    end
  end
end
