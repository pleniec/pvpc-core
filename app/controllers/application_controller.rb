class ApplicationController < ActionController::Base
  include Actions::Index
  include Actions::Show
  include Actions::Create
  include Actions::Update
  include Actions::Destroy

  include Authentication
  include Authorization
  include Rescues

  http_basic_authenticate_with name: 'pvpc', password: 'pefalpe987'
  protect_from_forgery with: :null_session
end
