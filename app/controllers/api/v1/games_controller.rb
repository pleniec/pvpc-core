module Api
  module V1
    class GamesController < Api::BaseController
      load_and_authorize_resource

      def index
      end
    end
  end
end
