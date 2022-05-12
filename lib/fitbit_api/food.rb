module FitbitAPI
  class Client
    FOOD_RESOURCES = %w(caloriesIn water)

    def food_logs(date=Date.today)
      get("user/#{user_id}/foods/log/date/#{format_date(date)}.json")
    end

    def recent_foods
      get("user/#{user_id}/foods/log/recent.json")
    end

    def frequent_foods
      get("user/#{user_id}/foods/log/frequent.json")
    end

    def favorite_foods
      get("user/#{user_id}/foods/log/favorite.json")
    end

    def food_goals
      get("user/#{user_id}/foods/log/goal.json")
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
        result = get("user/#{user_id}/foods/log/#{resource}/date/#{format_date(end_date)}/#{period}.json")
      else
        result = get("user/#{user_id}/foods/log/#{resource}/date/#{format_date(start_date)}/#{format_date(end_date)}.json")
      end

      # remove root key from response
      result.values[0]
    end

    # Retrieves the food locales used to search, log or create food

    def food_locales
      get("foods/locales.json")
    end

    # Retrieves a list of all valid Fitbit food units

    def food_units
      get("foods/units.json")
    end
  end
end
