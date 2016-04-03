require "fitbyte/fitstruct"
require "fitbyte/helpers"
require "fitbyte/activities"
require "fitbyte/goals"
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
    attr_accessor :api_version, :unit_system, :locale, :scope, :snake_case, :symbolize_keys

    def initialize(opts)
      missing_args = [:client_id, :client_secret, :redirect_uri] - opts.keys
      raise ArgumentError, "Required arguments: #{missing_args.join(', ')}" if missing_args.size > 0

      opts = defaults.merge(opts)

      @client_id = opts[:client_id]
      @client_secret = opts[:client_secret]

      @redirect_uri = opts[:redirect_uri]
      @site_url = opts[:site_url]
      @authorize_url = opts[:authorize_url]
      @token_url = opts[:token_url]

      @unit_system = opts[:unit_system]
      @locale = opts[:locale]
      @scope = format_scope(opts[:scope])

      @api_version = opts[:api_version]
      @snake_case = opts[:snake_case]
      @symbolize_keys = opts[:symbolize_keys]

      @client = OAuth2::Client.new(@client_id, @client_secret, site: @site_url,
                                   authorize_url: @authorize_url, token_url: @token_url)
    end

    def auth_page_link
      @client.auth_code.authorize_url(redirect_uri: @redirect_uri, scope: @scope)
    end

    def get_token(auth_code)
      @token = @client.auth_code.get_token(auth_code, redirect_uri: @redirect_uri, headers: auth_header)
      @user_id = @token.params["user_id"]
      return @token
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

    def get(path, opts={})
      response = token.get(("#{@api_version}/" + path), headers: request_headers).response
      result = MultiJson.load(response.body) unless response.status == 204
      process_keys!(result)
    end

    def post(path, opts={})
      response = token.post(("#{@api_version}/" + path), body: opts, headers: request_headers).response
      result = MultiJson.load(response.body) unless response.status == 204
      process_keys!(result)
    end

    def delete(path, opts={})
      response = token.delete(("#{@api_version}/" + path), headers: request_headers).response
      result = MultiJson.load(response.body) unless response.status == 204
      process_keys!(result)
    end

    def process_keys!(object)
      deep_keys_to_snake_case!(result) if (opts[:snake_case] || snake_case)
      deep_symbolize_keys!(result) if (opts[:symbolize_keys] || symbolize_keys)
    end

    def defaults
      {
        site_url: "https://api.fitbit.com",
        authorize_url: "https://www.fitbit.com/oauth2/authorize",
        token_url: "https://api.fitbit.com/oauth2/token",
        scope: "activity nutrition profile settings sleep social weight",
        unit_system: "en_US",
        locale: "en_US",
        api_version: "1",
        snake_case: false,
        symbolize_keys: false
      }
    end
  end
end
