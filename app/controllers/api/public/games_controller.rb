module Api
  module Public
    class GamesController < Api::PublicController
      load_and_authorize_resource class: Games::Game

      def index
      end
    end
  end
end
