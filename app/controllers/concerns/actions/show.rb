module Actions
  module Show
    extend ActiveSupport::Concern
    include Actions::Base

    def show
      @model = show_query.find(params[:id])
      authorize! :show, @model
      render :model
    end

    protected

    def show_query
      model_class
    end
  end
end
