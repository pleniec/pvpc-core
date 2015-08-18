require 'rails_helper'

RSpec.describe Flags::Attribute do
  class Model
    attr_accessor :flags_mask

    def initialize(flags_mask = 0)
      @flags_mask = flags_mask
    end
  end

  before do
    @model = Model.new
    @flags_attribute = Flags::Attribute.new(@model, [:a, :b, :c, :d])
  end

  describe '#initialize' do
    it 'creates readers for flag attributes' do
      expect(@flags_attribute.methods).to include(:a, :b, :c, :d)
    end

    it 'creates writers for flag attributes' do
      expect(@flags_attribute.methods).to include(:a=, :b=, :c=, :d=)
    end
  end

  describe '#to_h' do
    it 'returns hash with flags values' do
      expect(@flags_attribute.to_h.keys).to include(:a, :b, :c, :d)
    end
  end

  describe '#update!' do
    context 'when provided attributes are defined' do
      it 'updates attributes' do
        @flags_attribute.update!(a: true)

        expect(@flags_attribute.a).to be true
      end
    end

    context 'when provided attributes are not defined' do
      it 'raises error' do
        expect do
          @flags_attribute.update!(e: true)
        end.to raise_error(Flags::UnknownAttributeError)
      end
    end
  end

  describe '#[flag attribute reader]' do
    context 'when is uninitialized' do
      it 'returns false' do
        expect(@flags_attribute.a).to be false
      end
    end

    context 'when bit is 1' do
      it 'returns true' do
        @model.flags_mask = 1

        expect(@flags_attribute.a).to be true
      end
    end
  end

  describe '#[flag attribute writer]' do
    context 'when true is set' do
      it 'sets bit' do
        @flags_attribute.a = true

        expect(@model.flags_mask).to eql 1
      end
    end

    context 'when false is set' do
      it 'clears bit' do
        @flags_attribute.a = false

        expect(@model.flags_mask).to eql 0
      end
    end

    context 'when not boolean value is set' do
      it 'raises error' do
        expect do
          @flags_attribute.a = 0
        end.to raise_error(ArgumentError)
      end
    end
  end
end
