# frozen_string_literal: true

module FitbitAPI
  class Client
    # Retrieves a paginated list of Irregular Rhythm Notifications (IRN) alerts,
    # as well as all of the alert tachograms.
    #
    #   irn_alerts_list(before_date: Date.parse('2021-05-24'), limit: 5)
    #
    # @param params [Hash] The request parameters
    #
    # @option params :before_date [Date] Specify when filtering entries that occured before the given date
    # @option params :after_date [Date] Specify when filtering entries that occured after the given date
    # @option params :sort [String] The Sort order of entries by date (asc or desc)
    # @option params :offset [Integer] The offset number of entries. Must always be 0
    # @option params :limit [Integer] The max of the number of entries returned (max: 10)

    def irn_alerts_list(params = {})
      default_params = { before_date: Date.today, sort: 'desc', limit: 10, offset: 0 }
      get("user/#{user_id}/irn/alerts/list.json", default_params.merge(params))
    end

    # Retrieves the user state for Irregular Rhythm Notifications (IRN).

    def irn_profile
      get("user/#{user_id}/irn/profile.json")
    end
  end
end
