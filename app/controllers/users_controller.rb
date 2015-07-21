class UsersController < APIController
  skip_before_action :authenticate, only: [:create, :show, :index, :login]

  has_scope :nickname, :strangers_to_user_id, :limit, :offset

  def login
    @model = User.authenticate(params[:email], params[:password])
    render json: {credentials: ['invalid']}, status: :unprocessable_entity if @model.nil?
    render :model
  end

  protected

  def create_params
    params.permit(:email, :password, :nickname)
  end

  def update_params
    params.permit(:nickname, :settings_mask)
  end
end
