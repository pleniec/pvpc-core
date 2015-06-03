module API
  module V1
    class GamesController < API::Controller
      def index
        @games = Games::Game.eager_load(rules: :entries).all

        render json: @games.map(&:to_detailed_hash)
      end
    end
  end
end
