module Actions
  module Update
    extend ActiveSupport::Concern
    include Actions::Base

    included do
      before_action(only: :update) { @model = model_class.find(params[:id]) }
    end

    def update
      @model.update!(update_params)
      render nothing: true, status: :no_content
    end
  end
end
