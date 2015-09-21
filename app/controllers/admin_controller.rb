class AdminController < ActionController::Base
  include Actions::Index
  include Actions::Show
  include Actions::Create
  include Actions::Update
  include Actions::Destroy

  
end
