module Api
  class PrivateController < ApplicationController
    http_basic_authenticate_with name: 'pvpc-secret', password: 'pefalpe987'
    protect_from_forgery with: :null_session
  end
end
