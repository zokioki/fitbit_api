require 'spec_helper'

describe FitbitAPI::Client do
  let(:client) do
    FitbitAPI::Client.new(client_id: 'ABC123', client_secret: 'xyz789')
  end

  describe '#format_date' do
    it 'formats Date, Time, and DateTime objects to yyyy-MM-dd string' do
      date = Date.parse('21-09-1991')
      time = Time.parse('21-09-1991')
      date_time = DateTime.parse('21-09-1991')

      [date, time, date_time].each do |obj|
        expect(client.format_date obj).to eq('1991-09-21')
      end
    end

    it 'verifies string input to be of yyyy-MM-dd format' do
      string = '91-9-21'
      expect{client.format_date string}.to raise_error(FitbitAPI::InvalidArgumentError)
    end

    it 'returns unaltered argument if argument is properly formatted' do
      string = '1991-09-21'
      expect(client.format_date string).to eq(string)
    end
  end

  describe '#format_time' do
    it 'formats Time, and DateTime objects to HH:mm string' do
      time = Time.parse('12:45')
      date_time = DateTime.parse('12:45')

      [time, date_time].each do |obj|
        expect(client.format_time obj).to eq('12:45')
      end
    end

    it 'verifies string input to be of HH:mm format' do
      string = '2:45'
      expect{client.format_time string}.to raise_error(FitbitAPI::InvalidArgumentError)
    end

    it 'returns unaltered argument if argument is properly formatted' do
      string = '12:45'
      expect(client.format_time string).to eq(string)
    end
  end

  describe '#format_scope' do
    it 'returns elements of an Array as single space delimited string' do
      scope = ['one', 'two', 'three']
      expect(client.format_scope scope).to eq('one two three')
    end

    it 'returns unaltered argument if argument is not an Array' do
      scope = 'one two three'
      expect(client.format_scope scope).to eq(scope)
    end
  end

  describe '#deep_keys_to_snake_case!' do
    it 'converts keys of hash to snake case format' do
      object = { 'keyOne' => 1, 'keyTwo' => 2, 'keyThree' => 3 }
      expect(client.deep_keys_to_snake_case! object).to eq({ 'key_one' => 1, 'key_two' => 2, 'key_three' => 3 })
    end

    it 'converts nested keys of hash to snake case format' do
      object = { 'keyOne' => 1, 'keyTwo' => { 'keyThree' => 3, 'keyFour' => 4 } }
      expect(client.deep_keys_to_snake_case! object).to eq({ 'key_one' => 1, 'key_two' => { 'key_three' => 3, 'key_four' => 4 } })
    end
  end

  describe '#deep_keys_to_camel_case!' do
    it 'converts keys of hash to camel case format' do
      object = { 'key_one' => 1, 'key_two' => 2, 'key_three' => 3 }
      expect(client.deep_keys_to_camel_case! object).to eq({ 'keyOne' => 1, 'keyTwo' => 2, 'keyThree' => 3 })
    end

    it 'converts nested keys of hash to camel case format' do
      object = { 'key_one' => 1, 'key_two' => { 'key_three' => 3, 'key_four' => 4 } }
      expect(client.deep_keys_to_camel_case! object).to eq({ 'keyOne' => 1, 'keyTwo' => { 'keyThree' => 3, 'keyFour' => 4 } })
    end

    it 'handles mixed input of camel cased and snake cased keys' do
      object = { 'key_one' => 1, 'keyTwo' => { 'key_three' => 3, keyFour: 4 } }
      expect(client.deep_keys_to_camel_case! object).to eq({ 'keyOne' => 1, 'keyTwo' => { 'keyThree' => 3, 'keyFour' => 4 } })
    end
  end

  describe '#deep_symbolize_keys!' do
    it 'converts keys of hash to symbol' do
      object = { 'keyOne' => 1, 'keyTwo' => 2, 'keyThree' => 3 }
      expect(client.deep_symbolize_keys! object).to eq({ keyOne: 1, keyTwo: 2, keyThree: 3 })
    end

    it 'converts nested keys of hash to symbol' do
      object = { 'keyOne' => 1, 'keyTwo' => { 'keyThree' => 3, 'keyFour' => 4 } }
      expect(client.deep_symbolize_keys! object).to eq({ keyOne: 1, keyTwo: { keyThree: 3, keyFour: 4 } })
    end
  end

  describe '#to_snake_case' do
    it 'converts camelCased words to snake_case format' do
      word = 'imMrMeeseeksLookAtMe'
      expect(client.to_snake_case word).to eq 'im_mr_meeseeks_look_at_me'
    end

    it 'properly recognizes series of capital letters as single word' do
      word = 'iThinkNASAIsCool'
      expect(client.to_snake_case word).to eq 'i_think_nasa_is_cool'
    end

    it 'processes dashes to underscore if :replace_dashes option is provided' do
      word = 'some-dashesAndSnakes'
      expect(client.to_snake_case word, replace_dashes: true).to eq 'some_dashes_and_snakes'
    end
  end

  describe '#to_camel_case' do
    it 'returns original string if already camelCased' do
      word = 'AlreadyCamel'
      expect(client.to_camel_case word).to eq 'AlreadyCamel'
    end

    it 'returns original string if already lowerCamelCased' do
      word = 'alreadyLowerCamel'
      expect(client.to_camel_case word, lower: true).to eq 'alreadyLowerCamel'
    end

    it 'converts snake_cased words to CamelCase format' do
      word = 'im_mr_meeseeks_look_at_me'
      expect(client.to_camel_case word).to eq 'ImMrMeeseeksLookAtMe'
    end

    it 'converts snake_cased words to lowerCamelCase format' do
      word = 'lower_camel'
      expect(client.to_camel_case word, lower: true).to eq 'lowerCamel'
    end
  end
end
