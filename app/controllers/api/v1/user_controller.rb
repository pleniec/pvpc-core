class Api::V1::UserController < Api::BaseController
  skip_before_action :authenticate, only: [:create, :login]

  def create
    @user = User.new(create_params)
    @user.generate_access_token!
    @user.save!
  end

  def login
    @user = User.authenticate(params[:email], params[:password])
    render status: @user ? :ok : :unprocessable_entity
  end

  private

  def create_params
    params.require(:user).permit(:email, :password, :nickname)
  end
end
