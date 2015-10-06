require 'rails_helper'

RSpec.describe GamesController do
  include_examples :authentication, free: {index: :get, show: :get}

  include_examples :index,
                   create_permitted_model: ->(user) { FactoryGirl.create(:game) },
                   permitted_params: ->(model) { {} }

  include_examples :show,
                   create_permitted_model: ->(user) { FactoryGirl.create(:game) }
end
