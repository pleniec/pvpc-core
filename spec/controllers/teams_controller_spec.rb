require 'rails_helper'

RSpec.describe TeamsController do
  include_examples :authentication, restricted: {create: :post}, free: {index: :get, show: :get}

  include_examples :create,
                   permitted_params: ->(user) { FactoryGirl.build(:team, founder_id: user.id).attributes },
                   forbidden_params: ->(user) { FactoryGirl.build(:team).attributes }

  include_examples :index,
                   create_permitted_model: ->(user) { FactoryGirl.create(:team) },
                   permitted_params: ->(model) { {name_like: model.name[0..2]} }

  include_examples :show,
                   create_permitted_model: ->(user) { FactoryGirl.create(:team) }

  include_examples :update, params: {name: 'koqsy', description: 'we da best', tag: 'HeHe', image_url: 'nope'},
                   create_permitted_model: ->(user) { FactoryGirl.create(:team, founder: user) },
                   create_forbidden_model: ->(user) { FactoryGirl.create(:team) }

end
