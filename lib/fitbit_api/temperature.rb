module FitbitAPI
  class Client
    # Returns the core temperature data for a given date or date range.
    # If both a date and a date range are given, the date range takes precedence.
    #
    #   core_temperature_summary(date: Date.parse('2021-04-16'))
    #   core_temperature_summary(start_date: Date.parse('2021-05-18'), end_date: Date.parse('2021-05-24'))
    #
    # @param params [Hash] The request parameters
    #
    # @option params :date [Date] The target date
    # @option params :start_date [Date] The start of the date range
    # @option params :end_date [Date] The end of the date range

    def core_temperature_summary(opts={})
      date       = opts[:date] || Date.today
      start_date = opts[:start_date]
      end_date   = opts[:end_date]

      if start_date && !end_date
        end_date = Date.today
      end

      unless date || start_date
        raise FitbitAPI::InvalidArgumentError, 'A date or start_date and end_date are required.'
      end

      if start_date
        result = get("user/#{user_id}/temp/core/date/#{format_date(start_date)}/#{format_date(end_date)}.json")
      else
        result = get("user/#{user_id}/temp/core/date/#{format_date(date)}.json")
      end

      # remove root key from response
      result.values[0]
    end

    # Returns the skin temperature data for a given date or date range.
    # If both a date and a date range are given, the date range takes precedence.
    #
    #   skin_temperature_summary(date: Date.parse('2021-04-16'))
    #   skin_temperature_summary(start_date: Date.parse('2021-05-18'), end_date: Date.parse('2021-05-24'))
    #
    # @param params [Hash] The request parameters
    #
    # @option params :date [Date] The target date
    # @option params :start_date [Date] The start of the date range
    # @option params :end_date [Date] The end of the date range

    def skin_temperature_summary(opts={})
      date       = opts[:date] || Date.today
      start_date = opts[:start_date]
      end_date   = opts[:end_date]

      if start_date && !end_date
        end_date = Date.today
      end

      unless date || start_date
        raise FitbitAPI::InvalidArgumentError, 'A date or start_date and end_date are required.'
      end

      if start_date
        result = get("user/#{user_id}/temp/skin/date/#{format_date(start_date)}/#{format_date(end_date)}.json")
      else
        result = get("user/#{user_id}/temp/skin/date/#{format_date(date)}.json")
      end

      # remove root key from response
      result.values[0]
    end
  end
end
