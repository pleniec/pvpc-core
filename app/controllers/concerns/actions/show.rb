module Actions
  module Show
    extend ActiveSupport::Concern
    include Actions::Base

    def show
      @model = show_query.find(params[:id])
      authorize! :show, @model
      render show_view
    end

    protected

    def show_query
      model_class
    end

    def show_view
      :show
    end
  end
end
