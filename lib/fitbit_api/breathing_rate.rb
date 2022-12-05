module FitbitAPI
  class Client
    # Returns the average breathing rate data for a given date or date range.
    # If both a date and a date range are given, the date range takes precedence.
    #
    #   breathing_rate_summary(date: Date.parse('2021-04-16'))
    #   breathing_rate_summary(start_date: Date.parse('2021-05-18'), end_date: Date.parse('2021-05-24'))
    #
    # @param params [Hash] The request parameters
    #
    # @option params :date [Date] The target date
    # @option params :start_date [Date] The start of the date range
    # @option params :end_date [Date] The end of the date range

    def breathing_rate_summary(opts = {})
      date       = opts[:date] || Date.today
      start_date = opts[:start_date]
      end_date   = opts[:end_date]

      end_date = Date.today if start_date && !end_date

      raise FitbitAPI::InvalidArgumentError, 'A date or start_date and end_date are required.' unless date || start_date

      result = if start_date
                 get("user/#{user_id}/br/date/#{format_date(start_date)}/#{format_date(end_date)}.json")
               else
                 get("user/#{user_id}/br/date/#{format_date(date)}.json")
               end

      strip_root_key(result)
    end

    # Returns the intraday breathing rate data for a given date or date range.
    # If both a date and a date range are given, the date range takes precedence.
    #
    #   breathing_rate_intraday(date: Date.parse('2021-04-16'))
    #   breathing_rate_intraday(start_date: Date.parse('2021-05-18'), end_date: Date.parse('2021-05-24'))
    #
    # @param params [Hash] The request parameters
    #
    # @option params :date [Date] The target date
    # @option params :start_date [Date] The start of the date range
    # @option params :end_date [Date] The end of the date range

    def breathing_rate_intraday(opts = {})
      date       = opts[:date] || Date.today
      start_date = opts[:start_date]
      end_date   = opts[:end_date]

      end_date = Date.today if start_date && !end_date

      raise FitbitAPI::InvalidArgumentError, 'A date or start_date and end_date are required.' unless date || start_date

      result = if start_date
                 get("user/#{user_id}/br/date/#{format_date(start_date)}/#{format_date(end_date)}/all.json")
               else
                 get("user/#{user_id}/br/date/#{format_date(date)}/all.json")
               end

      strip_root_key(result)
    end
  end
end
