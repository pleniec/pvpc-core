class Api::V1::UserGamesController < Api::BaseController
  def index
    @games = current_user.games
  end

  def create
    UserGame.create!(user_id: current_user.id,
                     game_id: params[:game_id],
                     nickname: params[:nickname])
    render nothing: true
  end

  def update
    UserGame.find_by!(user_id: current_user.id,
                      game_id: params[:game_id]).update!(update_params)
    render nothing: true
  end

  def destroy
    UserGame.find_by!(user_id: current_user.id,
                      game_id: params[:game_id]).destroy!
    render nothing: true
  end

  private

  def update_params
    {nickname: params[:nickname]}
  end
end
