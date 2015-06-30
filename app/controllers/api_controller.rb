class APIController < ActionController::Base
  attr_reader :current_user

  http_basic_authenticate_with name: 'pvpc', password: 'pefalpe987'

  before_action :authenticate

  rescue_from(ActiveRecord::RecordNotFound) { |e| render json: {message: e.message}, status: :not_found }
  rescue_from(ActiveRecord::RecordInvalid) { |e| render json: e.record.errors, status: :unprocessable_entity }
  rescue_from(User::InvalidCredentials) { render json: {message: 'invalid credentials'}, status: :unprocessable_entity }
  rescue_from(CanCan::AccessDenied) { |e| render json: {message: e.message}, status: :forbidden }

  def current_ability
    @current_ability ||= Ability.new(current_user, params)
  end

  def index
    authorize! :index, model_class
    @models = index_query.to_a
  end

  def show
    @model = show_query.find(params[:id])
    authorize! :show, @model
  end

  def create
    @model = model_class.new(create_params)
    authorize! :create, @model
    @model.save!
    render status: :created
  end

  def update
    @model = update_query.find(params[:id])
    authorize! :update, @model
    @model.update!(update_params)
  end

  def destroy
    @model = destroy_query.find(params[:id])
    authorize! :destroy, @model
    @model.destroy!
  end

  protected

  def model_class
    Object.const_get(controller_path.classify)
  end

  def index_query
    apply_scopes(model_class).all
  end

  def show_query
    model_class
  end

  def update_query
    model_class
  end

  def destroy_query
    model_class
  end

  private

  def authenticate
    @current_user = Session.new(access_token: params[:access_token]).to_user
    render nothing: true, status: :unauthorized unless @current_user
  end
end
