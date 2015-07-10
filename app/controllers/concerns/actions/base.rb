module Actions
  module Base
    def model_class
      Object.const_get(controller_path.classify)
    end
  end
end
