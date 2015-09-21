module Actions
  module Destroy
    extend ActiveSupport::Concern
    include Actions::Base

    included do
      before_action(only: :destroy) { @model = destroy_query.find(params[:id]) }
    end

    def destroy
      @model.destroy!
      render nothing: true, status: :no_content
    end

    protected

    def destroy_query
      model_class
    end
  end
end
