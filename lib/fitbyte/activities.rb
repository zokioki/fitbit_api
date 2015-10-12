module Fitbyte
  class Client
    def daily_activity_summary(date=Date.today)
      get("user/#{@user_id}/activities/date/#{format_date(date)}.json")
    end

    def frequent_activities
      get("user/#{@user_id}/activities/frequent.json")
    end

    def favorite_activities
      get("user/#{@user_id}/activities/favorite.json")
    end

    def all_activities
      get("activities.json")
    end

    def lifetime_stats
      get("user/#{@user_id}/activities.json")
    end

    def daily_goals
      get("user/#{@user_id}/activities/goals/daily.json")
    end

    def weekly_goals
      get("user/#{@user_id}/activities/goals/weekly.json")
    end
  end
end
