module Actions
  module Show
    extend ActiveSupport::Concern

    def show
      @model = show_query.find(params[:id])
      authorize! :show, @model
    end

    protected

    def show_query
      model_class
    end
  end
end
