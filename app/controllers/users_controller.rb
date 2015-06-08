class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create, :login]

  inherit_resources
  load_and_authorize_resource

  def login
    @user = User.authenticate(params[:email], params[:password])
  end

  protected

  def user_params
    case action_name.to_sym
    when :create
      params.require(:user).permit(:email, :password, :nickname)
    when :update
      params.require(:user).permit(:nickname)
    end
  end
end
