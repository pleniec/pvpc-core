require 'rails_helper'

RSpec.describe CommentsController do
  include_examples :authentication, restricted: [:create, :update, :destroy], free: [:index]

  include_examples :create,
                   permitted_params: ->(user) { FactoryGirl.create(:comment, user: user).attributes },
                   forbidden_params: ->(user) { FactoryGirl.create(:comment).attributes }

  include_examples :index,
                   create_permitted_model: ->(user) { FactoryGirl.create(:comment, user: user) },
                   permitted_params: ->(model) { {commentable_id: model.commentable_id,
                                                  commentable_type: model.commentable_type} }

  include_examples :update, params: {'text' => 'nice one!'},
                   create_permitted_model: ->(user) { FactoryGirl.create(:comment, user: user) },
                   create_forbidden_model: ->(user) { FactoryGirl.create(:comment) }
                   
  include_examples :destroy,
                   create_permitted_model: ->(user) { FactoryGirl.create(:comment, user: user) },
                   create_forbidden_model: ->(user) { FactoryGirl.create(:comment) }
end
