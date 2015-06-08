class GamesController < ApplicationController
  skip_before_action :authenticate

  inherit_resources
  authorize_resource

  protected

  def resource
    get_resource_ivar || set_resource_ivar(end_of_association_chain.eager_load(:rules).find(params[:id]))
  end
end
