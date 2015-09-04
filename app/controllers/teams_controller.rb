class TeamsController < ApplicationController
  protected

  def create_params
    params.permit(:nickname, :description, :tag, :founder_id)
  end

  def create_view
    :detailed
  end

  def show_view
    :detailed
  end
end
