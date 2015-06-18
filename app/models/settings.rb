class Settings
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
  end

  def initialize(model)
    @model = model
  end
end
