require 'rails_helper'

RSpec.describe Flags do
  describe '.flags' do
    context 'when called inside class' do
      it 'defines #flags' do
        class Model
          include Flags
          flags :a, :b, :c, :d
        end

        expect(Model.new.methods).to include :flags
      end
    end
  end

  describe '#update(!)' do
    it 'updates flags and model attributes' do
      class Model
        include Flags

        attr_accessor :flags_mask
        attr_accessor :update_called

        flags :a, :b, :c, :d

        def initialize
          @flags_mask = 0
          @update_called = false
        end

        def update(attributes)
          @update_called = true
        end
      end
      model = Model.new

      model.update(flags: {a: true})

      expect(model.update_called).to be true
    end
  end
end
