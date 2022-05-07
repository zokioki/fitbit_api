module FitbitAPI
  class Client
    BODY_RESOURCES = %w(bmi fat weight)

    def weight_logs(date=Date.today)
      get("user/-/body/log/weight/date/#{format_date(date)}.json")
    end

    def body_fat_logs(date=Date.today)
      get("user/-/body/log/fat/date/#{format_date(date)}.json")
    end

    def body_time_series(resource, opts={})
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today
      period     = opts[:period]

      unless BODY_RESOURCES.include?(resource)
        raise FitbitAPI::InvalidArgumentError, "Invalid resource: \"#{resource}\". Please provide one of the following: #{BODY_RESOURCES}."
      end

      if [period, start_date].none?
        raise FitbitAPI::InvalidArgumentError, 'A start_date or period is required.'
      end

      if period && !PERIODS.include?(period)
        raise FitbitAPI::InvalidArgumentError, "Invalid period: \"#{period}\". Please provide one of the following: #{PERIODS}."
      end

      if period
        result = get("user/#{user_id}/body/#{resource}/date/#{format_date(end_date)}/#{period}.json")
      else
        result = get("user/#{user_id}/body/#{resource}/date/#{format_date(start_date)}/#{format_date(end_date)}.json")
      end

      # remove root key from response
      result.values[0]
    end

    def log_weight(body)
      post("user/#{user_id}/body/log/weight.json", body)
    end

    def delete_weight_log(weight_log_id)
      delete("user/#{user_id}/body/log/weight/#{weight_log_id}.json")
    end

    def log_body_fat(body)
      post("user/#{user_id}/body/log/fat.json", body)
    end

    def delete_body_fat_log(body_fat_log_id)
      delete("user/#{user_id}/body/log/fat/#{body_fat_log_id}.json")
    end
  end
end
