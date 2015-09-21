class AdminController < ActionController::Base
  include Actions::Index
  include Actions::Show
  include Actions::Create
  include Actions::Update
  include Actions::Destroy

  def model_class
    Object.const_get(params[:model].singularize.capitalize)
  end
end
