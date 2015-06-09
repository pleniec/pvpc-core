class FriendshipInvitesController < APIController
  inherit_resources
  load_and_authorize_resource

  has_scope :to_user_id

  def accept
    FriendshipInvite.find(params[:id]).accept!
    render nothing: true, status: :no_content
  end

  protected

  def friendship_invite_params
    params.require(:friendship_invite).permit(:from_user_id, :to_user_id)
  end
end
