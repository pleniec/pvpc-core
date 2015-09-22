class AdminController < ActionController::Base
  include Actions::Index
  include Actions::Show
  include Actions::Create
  include Actions::Update
  include Actions::Destroy

  include Rescues

  http_basic_authenticate_with name: 'admin', password: 'admin'
  protect_from_forgery with: :null_session

  def model_class
    Object.const_get(params[:model].singularize.capitalize)
  end

  protected

  def create_params
    params.except(:format, :controller, :action, :model).permit!
  end

  def update_params
    params.except(:format, :controller, :action, :model).permit!
  end
end
