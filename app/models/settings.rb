class Settings
  class UnknownAttributeError < StandardError
    def initialize(attribute, model)
      super("unknown attribute #{attribute} for #{model.class}")
    end
  end

  def self.settings_attributes(model_attribute, settings_attributes)
    settings_attributes.each_with_index do |settings_attribute, index|
      define_method "#{settings_attribute}=" do |value|
        case value
        when true
          @model.send("#{model_attribute}=", @model.send(model_attribute) | (1 << index))
          true
        when false
          @model.send("#{model_attribute}=", @model.send(model_attribute) & ~(1 << index))
          false
        else
          raise ArgumentError, 'only boolean values are allowed'
        end
      end

      define_method settings_attribute do
        (@model.send(model_attribute) & (1 << index)) != 0
      end
    end

    define_method :to_builder do
      Jbuilder.new do |json|
        settings_attributes.each do |settings_attribute|
          json.set! settings_attribute.to_s, send(settings_attribute)
        end
      end
    end

    define_method :update do |attributes|
      attributes.each do |attribute, value|
        unless settings_attributes.include?(attribute)
          raise UnknownAttributeError.new(attribute, @model)
        end
        send("#{attribute}=", value)
      end
    end
  end

  def initialize(model)
    @model = model
  end
end
