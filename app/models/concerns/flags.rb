module Flags
  extend ActiveSupport::Concern

  class UnknownAttributeError < StandardError
    def initialize(attribute, record)
      super("unknown attribute #{attribute} for #{record.class}")
    end
  end

  class Attribute
    def initialize(record, attributes)
      @record = record
      @attributes = attributes

      @attributes.each_with_index do |attribute, index|
        self.define_singleton_method attribute do
          (@record.flags_mask & (1 << index)) != 0
        end

        self.define_singleton_method "#{attribute}=" do |value|
          case value
          when true
            @record.flags_mask = (@record.flags_mask | (1 << index))
            true
          when false
            @record.flags_mask = (@record.flags_mask & ~(1 << index))
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
        unless @attributes.include?(attribute)
          raise Flags::UnknownAttributeError.new(attribute, @record)
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

  def update(attributes)
    flags.update!(attributes[:flags])
    super
  end

  def update!(attributes)
    flags.update!(attributes[:flags])
    super
  end
end
