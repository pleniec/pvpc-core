module Actions
  module Create
    extend ActiveSupport::Concern
    include Actions::Base

    included do
      before_action(only: :create) { @model = model_class.new(create_params) }
    end

    def create
      @model.save!
      render create_view, status: :created
    end

    protected

    def create_view
      :create
    end
  end
end
