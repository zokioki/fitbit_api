# frozen_string_literal: true

module FitbitAPI
  class Client
    # This endpoint retrieves a list of the user's Electrocardiogram
    # (ECG) log entries before or after a given day.
    #
    #   ecg_logs_list(before_date: Date.parse('2021-05-24'), limit: 5)
    #
    # @param params [Hash] The request parameters
    #
    # @option params :before_date [Date] Specify when filtering entries that occured before the given date
    # @option params :after_date [Date] Specify when filtering entries that occured after the given date
    # @option params :sort [String] the Sort order of entries by date (asc or desc)
    # @option params :offset [Integer] The offset number of entries. Must always be 0
    # @option params :limit [Integer] The max of the number of entries returned (max: 10)

    def ecg_logs_list(params = {})
      default_params = { before_date: Date.today, after_date: nil, sort: 'desc', limit: 10, offset: 0 }
      get("user/#{user_id}/ecg/list.json", default_params.merge(params))
    end
  end
end
