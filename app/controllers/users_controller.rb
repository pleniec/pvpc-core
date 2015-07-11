class UsersController < APIController
  skip_before_action :authenticate, only: [:create, :show, :index, :login]

  has_scope :nickname, :strangers_to_user_id, :limit, :offset

  def login
    @model = User.authenticate(params[:email], params[:password])
  end

  protected

  def create_params
    super.permit(:email, :password, :nickname)
  end

  def update_params
    super.permit(:nickname, :settings_mask)
  end
end
