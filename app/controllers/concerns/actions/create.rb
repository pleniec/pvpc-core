module Actions
  module Create
    extend ActiveSupport::Concern
    include Actions::Base

    included do
      before_action(only: :create) { @model = model_class.new(create_params) }
    end

    def create
      @model.save!
      render json: @model, serializer: detailed_serializer_class, status: :created,
             scope: current_user
    end
  end
end
