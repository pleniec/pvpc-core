module Actions
  module Destroy
    extend ActiveSupport::Concern
    include Actions::Base

    def destroy
      @model = destroy_query.find(params[:id])
      authorize! :destroy, @model
      @model.destroy!
      render nothing: true, status: :no_content
    end

    protected

    def destroy_query
      model_class
    end
  end
end
