module Actions
  module Show
    extend ActiveSupport::Concern
    include Actions::Base

    included do
      before_action(only: :show) { @model = show_query.find(params[:id]) }
    end

    def show
      render json: @model, serializer: detailed_serializer_class,
             scope: current_user
    end

    protected

    def show_query
      model_class
    end
  end
end
