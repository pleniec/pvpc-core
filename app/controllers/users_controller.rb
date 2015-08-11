class UsersController < APIController
  skip_before_action :authenticate, only: [:create, :show, :index, :login]

  has_scope :nickname, :strangers_to_user_id, :limit, :offset

  def login
    @model = User.authenticate(params[:email], params[:password])
    if @model.nil?
      render json: {credentials: ['invalid']}, status: :unprocessable_entity
    else
      render :private
    end
  end

  protected

  def create_params
    params.permit(:email, :password, :nickname, :sex, :age, :nationality)
  end

  def update_params
    params.permit(:password, :nickname, :sex, :age, :nationality, flags: User::FLAGS)
  end

  def create_view
    :private
  end

  def update_view
    :private
  end
end
