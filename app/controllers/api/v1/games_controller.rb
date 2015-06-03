module API
  module V1
    class GamesController < API::Controller
      def index
        render json: Games::Game.eager_load(rules: :entries).map(&:to_detailed_hash)
      end
    end
  end
end
