module Actions
  module Create
    extend ActiveSupport::Concern

    def create
      @model = model_class.new(create_params)
      authorize! :create, @model
      @model.save!
      render status: :created
    end
  end
end
