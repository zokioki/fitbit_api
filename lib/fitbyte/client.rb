require "fitbyte/helpers"
require "fitbyte/foods"

module Fitbyte
  class Client
    def initialize(options)
      missing_args = [:client_id, :client_secret] - options.keys
      if missing_args.size > 0
        raise ArgumentError, "Missing required options: #{missing.join(', ')}"
      end
      @client_id = options[:client_id]
      @client_secret = options[:client_secret]

      @redirect_uri = options[:redirect_uri]
      @site_url = options[:site_url] || "https://api.fitbit.com"
      @authorize_url = options[:authorize_url] || "https://www.fitbit.com/oauth2/authorize"
      @token_url = options[:token_url] || "https://api.fitbit.com/oauth2/token"

      @scope = options[:scope] || "profile weight nutrition sleep"
      @unit_system = options[:unit_system] || "en_US"
      @locale = options[:locale] || "en_US"

      @client = OAuth2::Client.new(@client_id, @client_secret, site: @site_url,
                                   authorize_url: @authorize_url, token_url: @token_url)
    end

    def authorization_link
      @client.auth_code.authorize_url(redirect_uri: @redirect_uri, scope: @scope)
    end

    def get_token(auth_code)
      @token = @client.auth_code.get_token(auth_code, redirect_uri: @redirect_uri, headers: auth_header)
    end

    def token
      @token.expired? ? refresh_token : @token
    end

    def refresh_token
      @token = @token.refresh!(headers: auth_header)
    end

    def auth_header
      {"Authorization" => ("Basic " + Base64.encode64(@client_id + ":" + @client_secret))}
    end

    def get(path)
      JSON.parse(token.get(path).response.body)
    end

    # Test API call - get signed in user's profile
    # JSON.parse(token.get('/1/user/-/profile.json').response.body)
  end
end
