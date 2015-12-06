require "fitbyte/fitstruct"
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
    attr_accessor :api_version, :unit_system, :locale, :scope, :raw_response

    def initialize(opts)
      missing_args = [:client_id, :client_secret, :redirect_uri] - opts.keys
      raise ArgumentError, "Required arguments: #{missing.join(', ')}" if missing_args.size > 0

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
      @raw_response = opts[:raw_response]

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
      raw = opts[:raw].nil? ? @raw_response : opts[:raw]
      response = token.get(("#{@api_version}/" + path), headers: request_headers).response.body,
                            symbolize_keys: true, object_class: (FitStruct unless raw)
      MultiJson.load(response) unless response.status == 204
    end

    def post(path, opts={})
      raw = opts[:raw].nil? ? @raw_response : opts[:raw]
      response = token.post(("#{@api_version}/" + path), body: opts, headers: request_headers).response.body,
                             symbolize_keys: true, object_class: (FitStruct unless raw)
      MultiJson.load(response) unless response.status == 204
    end

    def delete(path, opts={})
      raw = opts[:raw].nil? ? @raw_response : opts[:raw]
      response = token.delete(("#{@api_version}/" + path), headers: request_headers).response.body,
                               symbolize_keys: true, object_class: (FitStruct unless raw)
      MultiJson.load(response) unless response.status == 204
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
        raw_response: false
      }
    end
  end
end
