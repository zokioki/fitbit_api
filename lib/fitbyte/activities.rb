module Fitbyte
  class Client
    def daily_activity_summary(date=Date.today)
      get("1/user/-/activities/date/#{format_date(date)}.json")
    end

    def frequent_activities
      get("1/user/-/activities/frequent.json")
    end

    def favorite_activities
      get("1/user/-/activities/favorite.json")
    end

    def all_activities
      get("1/activities.json")
    end

    def lifetime_stats
      get("1/user/-/activities.json")
    end

    def daily_goals
      get("1/user/-/activities/goals/daily.json")
    end

    def weekly_goals
      get("1/user/-/activities/goals/weekly.json")
    end
  end
end
