module Authorization
  extend ActiveSupport::Concern

  def index
    authorize! :index, model_class
    super
  end

  def create
    authorize! :create, @model
    super
  end

  def destroy
    authorize! :destroy, @model
    super
  end

  def show
    authorize! :show, @model
    super
  end

  def update
    authorize! :update, @model
    super
  end   
end
