require 'spec_helper'

describe FitbitAPI do
  it 'has a version number' do
    expect(FitbitAPI::VERSION).not_to be nil
  end

  it 'has a repository URL' do
    expect(FitbitAPI::REPO_URL).not_to be nil
  end
end
