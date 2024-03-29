# frozen_string_literal: true

module FitbitAPI
  class Client
    # Retrieves a user's current weight goal.

    def weight_goal
      get("user/#{user_id}/body/log/weight/goal.json")
    end

    # Retrieves a user's current body fat percentage goal.

    def body_fat_goal
      get("user/#{user_id}/body/log/fat/goal.json")
    end

    # Retrieves a user's current daily activity goals.

    def daily_activity_goals
      get("user/#{user_id}/activities/goals/daily.json")
    end

    # Retrieves a user's current weekly activity goals.

    def weekly_activity_goals
      get("user/#{user_id}/activities/goals/weekly.json")
    end

    # Retrieves a user's current sleep goal.

    def sleep_goal
      get("user/#{user_id}/sleep/goal.json")
    end

    # Retrieves the user's current daily calorie consumption goal and/or food plan.

    def food_goals
      get("user/#{user_id}/foods/log/goal.json")
    end

    # Retrieves a user's daily water consumption goal.

    def water_goal
      get("user/#{user_id}/foods/log/water/goal.json")
    end

    # Creates or updates a user's daily activity goals and returns a response using units
    # in the unit system which corresponds to the Accept-Language header provided.
    #
    #   update_daily_activity_goals(calories_out: 2000, active_minutes: 90, floors: 5)
    #
    # @param body [Hash] The POST request body
    #
    # @option body :calories_out [Integer] Calories output goal value
    # @option body :active_minutes [Integer] Active minutes goal value
    # @option body :floors [Integer] Floor goal value
    # @option body :distance [Integer, Float] Distance goal value
    # @option body :steps [Integer] Steps goal value

    def update_daily_activity_goals(body = {})
      post("user/#{user_id}/activities/goals/daily.json", body)
    end

    # Creates or updates a user's weekly activity goals and returns a response using units
    # in the unit system which corresponds to the Accept-Language header provided.
    #
    #   update_weekly_activity_goals(active_minutes: 300, floors: 20)
    #
    # @param body [Hash] The POST request body
    #
    # @option body :calories_out [Integer] Calories output goal value
    # @option body :active_minutes [Integer] Active minutes goal value
    # @option body :floors [Integer] Floor goal value
    # @option body :distance [Integer, Float] Distance goal value
    # @option body :steps [Integer] Steps goal value

    def update_weekly_activity_goals(body = {})
      post("user/#{user_id}/activities/goals/weekly.json", body)
    end

    # Creates or updates a user's weight goal.
    #
    # @param body [Hash] the POST request body
    def update_weight_goal(body)
      post("user/#{user_id}/body/log/weight/goal.json", body)
    end

    # Creates or updates a user's body fat goal.
    #
    # @param body [Hash] the POST request body

    def update_body_fat_goal(body)
      post("user/#{user_id}/body/log/fat/goal.json", body)
    end

    # Create or update a user's sleep goal.
    #
    # @param body [Hash] the POST request body

    def update_sleep_goal(body)
      post("user/#{user_id}/sleep/goal.json", body)
    end

    # Creates or updates a user's daily calorie consumption or food plan goals.
    #
    # @param body [Hash] the POST request body

    def update_food_goals(body)
      post("user/#{user_id}/foods/log/goal.json", body)
    end

    # Creates or updates a user's daily water consumption goal.
    #
    # @param body [Hash] the POST request body

    def update_water_goal(body)
      post("user/#{user_id}/foods/log/water/goal.json", body)
    end
  end
end
