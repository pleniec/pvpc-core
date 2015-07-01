class UsersController < APIController
  skip_before_action :authenticate, only: [:create, :show, :index, :login]

  has_scope :nickname, :strangers_to_user_id, :limit, :offset

  def login
    @model = User.authenticate(params[:email], params[:password])
  end

  protected

  def create_params
    params.require(:user).permit(:email, :password, :nickname)
  end

  def update_params
    params.require(:user).permit(:nickname, :settings_mask)
  end
end
