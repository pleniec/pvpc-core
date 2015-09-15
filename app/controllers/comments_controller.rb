class CommentsController < ApplicationController
  skip_before_action :authenticate, only: [:index]

  has_scope :commentable_id, :commentable_type, :limit, :offset

  private

  def create_params
    params.permit(:user_id, :text, :commentable_id, :commentable_type)
  end

  def update_params
    params.permit(:text)
  end
end
