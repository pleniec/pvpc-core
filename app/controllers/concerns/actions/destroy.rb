module Actions
  module Destroy
    extend ActiveSupport::Concern

    def destroy
      @model = destroy_query.find(params[:id])
      authorize! :destroy, @model
      @model.destroy!
    end

    protected

    def destroy_query
      model_class
    end
  end
end
