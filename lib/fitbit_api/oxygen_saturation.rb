module FitbitAPI
  class Client
    def oxygen_saturation_summary(opts={})
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
        get("user/#{user_id}/spo2/date/#{format_date(start_date)}/#{format_date(end_date)}.json")
      else
        get("user/#{user_id}/spo2/date/#{format_date(date)}.json")
      end
    end

    def oxygen_saturation_intraday(opts={})
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
        get("user/#{user_id}/spo2/date/#{format_date(start_date)}/#{format_date(end_date)}/all.json")
      else
        get("user/#{user_id}/spo2/date/#{format_date(date)}/all.json")
      end
    end
  end
end
