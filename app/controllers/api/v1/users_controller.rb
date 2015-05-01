class Api::V1::UsersController < Api::BaseController
  skip_before_action :authenticate

  def create
    @user = User.new(create_params)
    @user.generate_access_token!
    render status: @user.save ? :ok : :unprocessable_entity
  end

  def login
    @user = User.authenticate(params[:email], params[:password])
    render status: @user ? :ok : :unprocessable_entity
  end

  private

  def create_params
    params.require(:user).permit(:email, :password)
  end
end
