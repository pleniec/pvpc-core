module API
  module V1
    class GamesController < API::Controller
      def index
        render json: Game.all.map(&:to_simple_hash)
      end

      def show
        render json: Game.eager_load(rules: :entries).find(params[:id]).to_detailed_hash
      end
    end
  end
end
