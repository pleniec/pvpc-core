class TeamsController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show]

  has_scope :name_like

  protected

  def create_params
    params.permit(:name, :description, :tag, :founder_id, :image_url)
  end

  def update_params
    params.permit(:name, :description, :tag, :image_url)
  end
end
