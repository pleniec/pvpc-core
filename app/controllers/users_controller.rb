class UsersController < APIController
  skip_before_action :authenticate, only: [:create, :show, :login]

  def login
    @model = User.authenticate(params[:email], params[:password])
  end

  def strangers
    @models = User.find(params[:id]).strangers
  end

  protected

  def create_params
    params.require(:user).permit(:email, :password, :nickname)
  end

  def update_params
    params.require(:user).permit(:nickname, :settings_mask)
  end
end
