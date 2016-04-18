module Fitbyte
  class Client
    def devices(opts={})
      get("user/#{user_id}/devices.json", opts)
    end
  end
end
