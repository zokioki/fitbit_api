module Fitbyte
  class Client
    def daily_activity_summary(date=Date.today)
      get("user/-/activities/date/#{format_date(date)}.json")
    end

    def frequent_activities
      get("user/-/activities/frequent.json")
    end

    def favorite_activities
      get("user/-/activities/favorite.json")
    end

    def all_activities
      get("activities.json")
    end

    def lifetime_stats
      get("user/-/activities.json")
    end

    def daily_goals
      get("user/-/activities/goals/daily.json")
    end

    def weekly_goals
      get("user/-/activities/goals/weekly.json")
    end
  end
end
