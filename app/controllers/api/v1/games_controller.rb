class Api::V1::GamesController < Api::BaseController
  def index
    @games = Game.all
  end

  def show
    @game = Game.eager_load(:translations, :rules).find(params[:id])
  end
end
