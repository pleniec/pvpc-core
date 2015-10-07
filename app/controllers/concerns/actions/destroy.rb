module Actions
  module Destroy
    extend ActiveSupport::Concern
    include Actions::Base

    included do
      before_action(only: :destroy) { @model = model_class.find(params[:id]) }
    end

    def destroy
      @model.destroy!
      render nothing: true, status: :no_content
    end
  end
end
