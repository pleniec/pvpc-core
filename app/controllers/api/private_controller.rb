module Api
  class PrivateController < ApiController
    http_basic_authenticate_with name: 'pvpc-secret', password: 'pefalpe987'
  end
end
