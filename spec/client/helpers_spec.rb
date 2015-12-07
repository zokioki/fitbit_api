require "spec_helper"

describe Fitbyte::Client do
  let(:client) do
    Fitbyte::Client.new(client_id: "ABC123",
                        client_secret: "xyz789",
                        redirect_uri: "http://example.com")
  end

  describe "#format_date" do
    it "formats Date, Time, and DateTime objects to yyyy-MM-dd string" do
      date = Date.parse("21-09-1991")
      time = Time.parse("21-09-1991")
      date_time = DateTime.parse("21-09-1991")

      [date, time, date_time].each do |obj|
        expect(client.format_date obj).to eq("1991-09-21")
      end
    end

    it "verifies string input to be of yyyy-MM-dd format" do
      string = "91-9-21"
      expect{client.format_date string}.to raise_error(ArgumentError)
    end

    it "returns unaltered argument if argument is properly formatted" do
      string = "1991-09-21"
      expect(client.format_date string).to eq(string)
    end
  end

  describe "#format_scope" do
    it "returns elements of an Array as single space delimited string" do
      scope = ["one", "two", "three"]
      expect(client.format_scope scope).to eq("one two three")
    end

    it "returns unaltered argument if argument is not an Array" do
      scope = "one two three"
      expect(client.format_scope scope).to eq(scope)
    end
  end
end
