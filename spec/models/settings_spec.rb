require 'rails_helper'

RSpec.describe Settings do
  class SampleModel
    attr_accessor :settings

    def initialize(settings)
      @settings = settings
    end
  end

  class SampleSettings < Settings
    settings_attributes :settings, [
      :first,
      :second,
      :third,
      :fourth
    ]
  end
  
  before do
    @settings = SampleSettings.new(SampleModel.new(10))
  end

  it 'reads bit mask' do
    expect(@settings.first).to be false
    expect(@settings.second).to be true
    expect(@settings.third).to be false
    expect(@settings.fourth).to be true
  end

  it 'writes bit mask' do
    @settings.first = true
    @settings.second = true
    @settings.third = false
    @settings.fourth = false

    expect(@settings.first).to be true
    expect(@settings.second).to be true
    expect(@settings.third).to be false
    expect(@settings.fourth).to be false
  end
end
