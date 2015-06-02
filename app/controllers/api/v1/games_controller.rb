module API
  module V1
    class GamesController < API::Controller
      def index
        @games = Games::Game.eager_load(rules: :entries).all
      end
    end
  end
end
