module Actions
  module Update
    extend ActiveSupport::Concern
    include Actions::Base

    def update
      @model = update_query.find(params[:id])
      authorize! :update, @model
      @model.update!(update_params)
      render :model
    end

    protected

    def update_query
      model_class
    end
  end
end
