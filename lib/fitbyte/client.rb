require "fitbyte/helpers"
require "fitbyte/activities"
require "fitbyte/alarms"
require "fitbyte/body"
require "fitbyte/devices"
require "fitbyte/food"
require "fitbyte/friends"
require "fitbyte/sleep"
require "fitbyte/user"
require "fitbyte/water"

module Fitbyte
  class Client
    attr_accessor :api_version, :unit_system, :locale, :scope

    def initialize(options)
      missing_args = [:client_id, :client_secret] - options.keys

      raise ArgumentError, "Required arguments: #{missing.join(', ')}" if missing_args.size > 0

      @client_id = options[:client_id]
      @client_secret = options[:client_secret]

      @redirect_uri = options[:redirect_uri]
      @site_url = options[:site_url] || defaults[:site_url]
      @authorize_url = options[:authorize_url] || defaults[:authorize_url]
      @token_url = options[:token_url] defaults[:token_url]

      @scope = format_scope(options[:scope])
      @unit_system = options[:unit_system] || defaults[:unit_system]
      @locale = options[:locale] || defaults[:locale]
      @api_version = "1"

      @client = OAuth2::Client.new(@client_id, @client_secret, site: @site_url,
                                   authorize_url: @authorize_url, token_url: @token_url)
    end

    def auth_page_link
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

    def request_headers
      {
        "User-Agent" => "fitbyte-#{Fitbyte::VERSION} gem (#{Fitbyte::REPO_URL})",
        "Accept-Language" => @unit_system,
        "Accept-Locale" => @locale
      }
    end

    def defaults
      {
        site_url: "https://api.fitbit.com",
        authorize_url: "https://www.fitbit.com/oauth2/authorize",
        token_url: "https://api.fitbit.com/oauth2/token",
        unit_system: "en_US",
        locale: "en_US"
      }
    end

    def get(path)
      JSON.parse(token.get(("#{@api_version}/" + path), headers: request_headers).response.body)
    end
  end
end
