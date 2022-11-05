module FitbitAPI
  class Client
    def heart_rate_variability_summary(opts={})
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
        result = get("user/#{user_id}/hrv/date/#{format_date(start_date)}/#{format_date(end_date)}.json")
      else
        result = get("user/#{user_id}/hrv/date/#{format_date(date)}.json")
      end

      # remove root key from response
      result.values[0]
    end

    def heart_rate_variability_intraday(opts={})
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
        result = get("user/#{user_id}/hrv/date/#{format_date(start_date)}/#{format_date(end_date)}/all.json")
      else
        result = get("user/#{user_id}/hrv/date/#{format_date(date)}/all.json")
      end

      # remove root key from response
      result.values[0]
    end
  end
end
