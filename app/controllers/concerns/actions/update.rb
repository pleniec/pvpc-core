module Actions
  module Update
    extend ActiveSupport::Concern
    include Actions::Base

    included do
      before_action(only: :update) { @model = update_query.find(params[:id]) }
    end

    def update
      @model.update!(update_params)
      render update_view
    end

    protected

    def update_query
      model_class
    end

    def update_view
      :update
    end
  end
end
