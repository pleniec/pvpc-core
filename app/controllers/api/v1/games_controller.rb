module API
  module V1
    class GamesController < API::Controller
      load_and_authorize_resource only: :index

      def index
      end

      def show
        @game = Game.eager_load(rules: :entries).find(params[:id])
      end
    end
  end
end
