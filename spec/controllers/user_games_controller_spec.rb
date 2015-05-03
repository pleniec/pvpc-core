require 'rails_helper'

RSpec.describe Api::V1::UserGamesController do
  include_examples 'unauthenticated',
                   index: {method: :get},
                   create: {method: :post},
                   update: {method: :patch, id: 1},
                   destroy: {method: :delete, id: 1}

  context 'authenticated' do
    include_context 'authenticated'

    it 'lols' do
      game = FactoryGirl.create(:game)
    end
  end
end
