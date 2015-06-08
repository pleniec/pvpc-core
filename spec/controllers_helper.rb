module ControllersHelper
  [:get, :post, :patch, :delete].each do |method|
    define_method "#{method}_json" do |action, params|
      send method, action, params.merge(format: :json)
    end
  end

  def response_body
    @response_body ||= JSON.parse(response.body)
  end
end
