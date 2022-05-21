module FitbitAPI
  class Client
    # Retrieves a summary and list of a user's water log entries for a given day
    #
    # @param date [Date] The date for which entries are to be returned

    def water_logs(date=Date.today)
      get("user/#{user_id}/foods/log/water/date/#{format_date(date)}.json")
    end

    # Create a user's water log entry
    #
    # @param body [Hash] The POST request body for creating the water log entry

    def log_water(body)
      post("user/#{user_id}/foods/log/water.json", body)
    end

    # Updates the quantity consumed for a user's water log entry with the given log ID
    #
    # @params water_log_id [Integer] The ID of the water log to be updated
    # @params body [Hash] The POST request body for updating the water log

    def update_water_log(water_log_id, body)
      post("user/#{user_id}/foods/log/water/#{water_log_id}.json", body)
    end

    # Deleted a user's water log entry using the given log ID
    #
    # @param water_log_id [Integer] The id of the water log entry

    def delete_water_log(water_log_id)
      delete("user/#{user_id}/foods/log/water/#{water_log_id}.json")
    end
  end
end
