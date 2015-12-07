require "spec_helper"

describe Fitbyte do
  it "has a version number" do
    expect(Fitbyte::VERSION).not_to be nil
  end

  it "has a repository URL" do
    expect(Fitbyte::REPO_URL).not_to be nil
  end
end
