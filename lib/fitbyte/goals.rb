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
    #   in the unit system which corresponds to the Accept-Language header provided.

    # ==== POST Parameters
    # * +:caloriesOut+ - calories output goal value; integer
    # * +:activeMinutes+ - active minutes goal value; integer
    # * +:floors+ - floor goal value; integer
    # * +:distance+ - distance goal value; X.XX or integer
    # * +:steps+ - steps goal value; integer

    def create_or_update_daily_goals(opts={})
      post("user/#{user_id}/activities/goals/daily.json", opts)
    end

    # Creates or updates a user's weekly activity goals and returns a response using units
    #   in the unit system which corresponds to the Accept-Language header provided.

    # ==== POST Parameters
    # * +:caloriesOut+ - calories output goal value; integer
    # * +:activeMinutes+ - active minutes goal value; integer
    # * +:floors+ - floor goal value; integer
    # * +:distance+ - distance goal value; X.XX or integer
    # * +:steps+ - steps goal value; integer

    def create_or_update_weekly_goals(opts={})
      post("user/#{user_id}/activities/goals/weekly.json", opts)
    end
  end
end
