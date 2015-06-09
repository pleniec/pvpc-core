class FriendshipsController < ApplicationController
  inherit_resources
  load_and_authorize_resource
  belongs_to :user

  protected

  def collection
    get_collection_ivar || set_collection_ivar(end_of_association_chain.eager_load(:friend))
  end
end
