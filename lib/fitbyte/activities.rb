module Fitbyte
  class Client
    def daily_activity_summary(date=Date.today, opts={})
      get("user/#{@user_id}/activities/date/#{format_date(date)}.json", opts)
    end

    def frequent_activities(opts={})
      get("user/#{@user_id}/activities/frequent.json", opts)
    end

    def favorite_activities(opts={})
      get("user/#{@user_id}/activities/favorite.json", opts)
    end

    def all_activities(opts={})
      get("activities.json", opts)
    end

    def lifetime_stats(opts={})
      get("user/#{@user_id}/activities.json", opts)
    end

    def daily_goals(opts={})
      get("user/#{@user_id}/activities/goals/daily.json", opts)
    end

    def weekly_goals(opts={})
      get("user/#{@user_id}/activities/goals/weekly.json", opts)
    end
  end
end
