module API
  module V1
    class GamesController < API::Controller
      load_and_authorize_resource class: Games::Game

      def index
      end
    end
  end
end
