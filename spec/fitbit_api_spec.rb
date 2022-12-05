# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FitbitAPI do
  it 'has a version number' do
    expect(FitbitAPI::VERSION).not_to be nil
  end
end
