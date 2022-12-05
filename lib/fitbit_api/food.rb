# frozen_string_literal: true

module FitbitAPI
  class Client
    FOOD_RESOURCES = %w[caloriesIn water].freeze

    def food_logs(date = Date.today)
      get("user/#{user_id}/foods/log/date/#{format_date(date)}.json")
    end

    # Retrieves a list of public foods from the Fitbit foods database and private foods the user created
    #
    # @param query [String] The search query

    def search_foods(params)
      get('foods/search.json', params)
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

    # Creates a new private food for a user
    #
    # @param body [Hash] The POST request body

    def create_food(body)
      post("user/#{user_id}/foods.json", body)
    end

    # Deletes a custom food created by the user
    #
    # @param food_id [Integer] The ID of the food to be deleted

    def delete_food(food_id)
      delete("user/#{user_id}/foods/#{food_id}.json")
    end

    # Creates a food log entry
    #
    # @param body [Hash] The POST request body

    def create_food_log(body)
      post("user/#{user_id}/foods/log.json", body)
    end

    # Updates the quantity or calories consumed for a user's food log entry with the given Food Log ID
    #
    # @param food_log_id [Integer] The ID of the food log to edit
    # @param body [Hash] The POST request body

    def update_food_log(food_log_id, body)
      post("user/#{user_id}/foods/log/#{food_log_id}.json", body)
    end

    # Deletes a user's food log entry using the given log ID
    #
    # @param food_log_id [Integer] The id of the food log entry

    def delete_food_log(food_log_id)
      delete("user/#{user_id}/foods/log/#{food_log_id}.json")
    end

    # Adds a food with the given ID to the user's list of favorite foods

    def add_favorite_food(food_id)
      post("user/#{user_id}/foods/log/favorite/#{food_id}.json")
    end

    # Deletes a food with the given ID from the user's list of favorite foods
    #
    # @param food_id [Integer] The ID of the food to delete from the user's favorites

    def delete_favorite_food(food_id)
      delete("user/#{user_id}/foods/log/favorite/#{food_id}.json")
    end

    def food_time_series(resource, opts = {})
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today
      period     = opts[:period]

      unless FOOD_RESOURCES.include?(resource)
        raise FitbitAPI::InvalidArgumentError,
              "Invalid resource: \"#{resource}\". Please provide one of the following: #{FOOD_RESOURCES}."
      end

      raise FitbitAPI::InvalidArgumentError, 'A start_date or period is required.' if [period, start_date].none?

      if period && !PERIODS.include?(period)
        raise FitbitAPI::InvalidArgumentError,
              "Invalid period: \"#{period}\". Please provide one of the following: #{PERIODS}."
      end

      path = if period
               "user/#{user_id}/foods/log/#{resource}/date/#{format_date(end_date)}/#{period}.json"
             else
               "user/#{user_id}/foods/log/#{resource}/date/#{format_date(start_date)}/#{format_date(end_date)}.json"
             end
      result = get(path)

      strip_root_key(result)
    end

    # Retrieves the food locales used to search, log or create food

    def food_locales
      get('foods/locales.json')
    end

    # Retrieves a list of all valid Fitbit food units

    def food_units
      get('foods/units.json')
    end
  end
end
