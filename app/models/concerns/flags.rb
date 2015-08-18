module Flags
  extend ActiveSupport::Concern

  class UnknownAttributeError < StandardError
    def initialize(attribute, model)
      super("unknown attribute #{attribute} for #{model.class}")
    end
  end

  class Attribute
    def initialize(model, attributes)
      @model = model
      @attributes = attributes

      @attributes.each_with_index do |attribute, index|
        self.define_singleton_method attribute do
          (@model.flags_mask & (1 << index)) != 0
        end

        self.define_singleton_method "#{attribute}=" do |value|
          case value
          when true
            @model.flags_mask = (@model.flags_mask | (1 << index))
            true
          when false
            @model.flags_mask = (@model.flags_mask & ~(1 << index))
            false
          else
            raise ArgumentError, 'only boolean values are allowed'
          end
        end
      end
    end

    def update!(attributes)
      return if attributes.nil?
      attributes.each do |attribute, value|
        unless @attributes.include?(attribute.to_sym)
          raise Flags::UnknownAttributeError.new(attribute, @model)
        end
        send("#{attribute}=", value)
      end
    end

    def to_h
      @attributes.map { |a| [a, send(a)] }.to_h
    end
  end

  module ClassMethods
    def flags(*attributes)
      define_method :flags do
        Flags::Attribute.new(self, attributes)
      end
    end
  end

  def update(attributes = {})
    flags.update!(attributes[:flags])
    super(attributes.except(:flags))
  end

  def update!(attributes = {})
    flags.update!(attributes[:flags])
    super(attributes.except(:flags))
  end
end
