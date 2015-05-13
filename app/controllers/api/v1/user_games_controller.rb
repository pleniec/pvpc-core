class Api::V1::UserGamesController < Api::BaseController
  def index
    @games = current_user.games
  end

  def create
    UserGame.create!(user_id: current_user.id,
                     game_id: params[:id],
                     nickname: create_params[:nickname])
    render nothing: true
  end

  def update
    UserGame.find_by!(user_id: current_user.id,
                      game_id: params[:id]).update!(update_params)
    render nothing: true
  end

  def destroy
    UserGame.find_by!(user_id: current_user.id,
                      game_id: params[:id]).destroy!
    render nothing: true
  end

  private

  def create_params
    params.require(:user_game).permit(:nickname)
  end

  def update_params
    params.require(:user_game).permit(:nickname)
  end
end
