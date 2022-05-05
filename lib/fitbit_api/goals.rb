module FitbitAPI
  class Client
    # GET Goals
    # =========

    # Retrieves a user's current weight goal.

    def weight_goal(opts={})
      get("user/-/body/log/weight/goal.json", opts)
    end

    # Retrieves a user's current body fat percentage goal.

    def body_fat_goal(opts={})
      get("user/-/body/log/fat/goal.json", opts)
    end

    # Retrieves a user's current daily activity goals.

    def daily_goals(opts={})
      get("user/#{user_id}/activities/goals/daily.json", opts)
    end

    # Retrieves a user's current weekly activity goals.

    def weekly_goals(opts={})
      get("user/#{user_id}/activities/goals/weekly.json", opts)
    end

    # POST Goals
    # ==========

    # Creates or updates a user's daily activity goals and returns a response using units
    # in the unit system which corresponds to the Accept-Language header provided.
    #
    #   create_or_update_daily_goals(body: {calories_out: 2000, active_minutes: 90, floors: 5})
    #
    # @option calories_out [Integer] Calories output goal value
    # @option active_minutes [Integer] Active minutes goal value
    # @option floors [Integer] Floor goal value
    # @option distance [Integer, Float] Distance goal value
    # @option steps [Integer] Steps goal value

    def create_or_update_daily_goals(opts={})
      post("user/#{user_id}/activities/goals/daily.json", opts)
    end

    # Creates or updates a user's weekly activity goals and returns a response using units
    # in the unit system which corresponds to the Accept-Language header provided.
    #
    #   create_or_update_weekly_goals(body: { active_minutes: 300, floors: 20 })
    #
    # @option calories_out [Integer] Calories output goal value
    # @option active_minutes [Integer] Active minutes goal value
    # @option floors [Integer] Floor goal value
    # @option distance [Integer, Float] Distance goal value
    # @option steps [Integer] Steps goal value

    def create_or_update_weekly_goals(opts={})
      post("user/#{user_id}/activities/goals/weekly.json", opts)
    end
  end
end
