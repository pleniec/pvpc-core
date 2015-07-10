module Actions
  module Create
    extend ActiveSupport::Concern
    include Actions::Base

    def create
      @model = model_class.new(create_params)
      authorize! :create, @model
      @model.save!
      render status: :created
    end
  end
end
