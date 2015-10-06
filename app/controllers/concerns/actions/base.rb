module Actions
  module Base
    def model_class
      Object.const_get(controller_path.classify)
    end

    def serializer_class
      Object.const_get("#{controller_path.classify}Serializer")
    end

    def detailed_serializer_class
      Object.const_get("Detailed#{controller_path.classify}Serializer")
    end
  end
end
