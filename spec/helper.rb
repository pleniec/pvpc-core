module Helper
  [:get, :post, :patch, :delete].each do |method|
    define_method "#{method}_json" do |action, params = {}|
      send method, action, params.merge(format: :json)
    end
  end

  def index(params = {})
    get :index, params.merge(format: :json)
  end

  def show(params = {})
    get :show, params.merge(format: :json)
  end

  def create(params = {})
    post :create, params.merge(format: :json)
  end

  def update(params = {})
    patch :update, params.merge(format: :json)
  end

  def destroy(params = {})
    delete :destroy, params.merge(format: :json)
  end

  def response_body
    @response_body ||= JSON.parse(response.body)
  end
end
