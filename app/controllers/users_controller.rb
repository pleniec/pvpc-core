class UsersController < APIController
  skip_before_action :authenticate, only: [:create, :show, :login]

  inherit_resources
  load_and_authorize_resource

  def login
    @user = User.authenticate(params[:email], params[:password])
  end

  protected

  def resource
    get_resource_ivar || set_resource_ivar(end_of_association_chain.eager_load(:game_ownerships).find(params[:id]))
  end

  def user_params
    case action_name.to_sym
    when :create
      params.require(:user).permit(:email, :password, :nickname)
    when :update
      params.require(:user).permit(:nickname, :settings_mask)
    end
  end
end
