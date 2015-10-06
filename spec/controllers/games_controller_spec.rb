require 'rails_helper'

RSpec.describe GamesController do
  it 'lols' do
    FactoryGirl.create_list(:game, 3)

    index

    raise Exception, response_body
  end
=begin
  include_examples :authentication, free: {index: :get, show: :get}

  include_examples :index,
                   create_permitted_model: ->(user) { FactoryGirl.create(:game) },
                   permitted_params: ->(model) { {} }

  include_examples :show,
                   create_permitted_model: ->(user) { FactoryGirl.create(:game) }
=end
end
