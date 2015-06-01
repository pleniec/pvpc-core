module Api
  module Public
    class UserGamesController < Api::PublicController
      load_and_authorize_resource :user, class: Users::User
      load_and_authorize_resource :user_game, class: Games::UserGame, through: :user

      def index
      end

      def create
        @user_game.save!
      end

      def update
        @user_game.update!(update_params)
      end

      def destroy
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
