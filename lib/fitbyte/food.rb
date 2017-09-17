module FitbitAPI
  class Client
    FOOD_RESOURCES = %w(caloriesIn water)

    def food_logs(date=Date.today, opts={})
      get("user/#{user_id}/foods/log/date/#{format_date(date)}.json", opts)
    end

    def recent_foods(opts={})
      get("user/#{user_id}/foods/log/recent.json", opts)
    end

    def frequent_foods(opts={})
      get("user/#{user_id}/foods/log/frequent.json", opts)
    end

    def favorite_foods(opts={})
      get("user/#{user_id}/foods/log/favorite.json", opts)
    end

    def food_goals(opts={})
      get("user/#{user_id}/foods/log/goal.json", opts)
    end

    def food_time_series(resource, opts={})
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today
      period     = opts[:period]

      unless FOOD_RESOURCES.include?(resource)
        raise FitbitAPI::InvalidArgumentError, "Invalid resource: \"#{resource}\". Please provide one of the following: #{FOOD_RESOURCES}."
      end

      if [period, start_date].none?
        raise FitbitAPI::InvalidArgumentError, 'A start_date or period is required.'
      end

      if period && !PERIODS.include?(period)
        raise FitbitAPI::InvalidArgumentError, "Invalid period: \"#{period}\". Please provide one of the following: #{PERIODS}."
      end

      if period
        result = get("user/#{user_id}/foods/log/#{resource}/date/#{format_date(end_date)}/#{period}.json", opts)
      else
        result = get("user/#{user_id}/foods/log/#{resource}/date/#{format_date(start_date)}/#{format_date(end_date)}.json", opts)
      end
      # remove root key from response
      result.values[0]
    end
  end
end
