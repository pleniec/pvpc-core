class GameOwnershipsController < APIController
  inherit_resources
  load_and_authorize_resource
  belongs_to :user

  protected

  def collection
    get_collection_ivar || set_collection_ivar(end_of_association_chain.eager_load(:game))
  end

  def game_ownership_params
    case action_name.to_sym
    when :create
      params.require(:game_ownership).permit(:user_id, :game_id, :nickname)
    when :update
      params.require(:game_ownership).permit(:nickname)
    end
  end
end
