# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FitbitAPI::Configuration do
  let(:klass) do
    Class.new do
      extend FitbitAPI::Configuration

      define_setting :some_setting, 'some_default_value'
    end
  end

  describe '#define_setting' do
    it 'defines getter and setter class methods for the specified setting' do
      expect(klass).to respond_to(:some_setting)
      expect(klass).to respond_to(:some_setting=)
    end

    it 'configures getter class method with a default value if specified' do
      expect(klass.some_setting).to eq('some_default_value')
    end
  end
end
