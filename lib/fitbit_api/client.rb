# frozen_string_literal: true

require 'fitbit_api/base'
require 'fitbit_api/activities'
require 'fitbit_api/breathing_rate'
require 'fitbit_api/cardio_score'
require 'fitbit_api/heart_rate'
require 'fitbit_api/heart_rate_variability'
require 'fitbit_api/goals'
require 'fitbit_api/alarms'
require 'fitbit_api/body'
require 'fitbit_api/devices'
require 'fitbit_api/food'
require 'fitbit_api/friends'
require 'fitbit_api/meals'
require 'fitbit_api/oxygen_saturation'
require 'fitbit_api/sleep'
require 'fitbit_api/subscriptions'
require 'fitbit_api/temperature'
require 'fitbit_api/user'
require 'fitbit_api/water'

module FitbitAPI
  class Client
    attr_accessor :api_version, :unit_system, :locale, :scope,
                  :snake_case_keys, :symbolize_keys, :auto_refresh_token, :on_token_refresh
    attr_reader   :token, :user_id

    def initialize(opts = {})
      validate_args(opts)
      assign_attrs(opts)
      set_client
      establish_token(opts)
    end

    # Returns the authorize endpoint URL of the OAuth2 provider.

    def auth_url
      @client.auth_code.authorize_url(redirect_uri: @redirect_uri, scope: format_scope(@scope))
    end

    # Returns an OAuth2::AccessToken instance obtained from the given authorization code.
    #
    # @param auth_code [String] An authorization code

    def get_token(auth_code)
      @token = @client.auth_code.get_token(
        auth_code,
        redirect_uri: @redirect_uri,
        headers: auth_headers
      )
      @user_id = @token.params['user_id']
      @token
    end

    # Refreshes the current Access Token.

    def refresh_token!
      @token = @token.refresh!(headers: auth_headers)
      @user_id ||= @token.params['user_id']
      on_token_refresh.call(@token) if on_token_refresh.respond_to?(:call)

      @token
    end

    # Revokes the user's authorizations and all associated tokens.

    def revoke_token!
      body = { token: token.token }
      headers = default_request_headers.merge(auth_headers)
      response = token.post('oauth2/revoke', { headers: headers, body: body }).response

      process_keys!(MultiJson.load(response.body))
    end

    # Performs an authorized GET request to the configured API namespace.
    #
    # @param path [String] The request path
    # @param params [Hash] The query parameters
    # @param opts [Hash] Additional request options (e.g. headers)

    def get(path, params = {}, opts = {}, &block)
      request(:get, path, opts.merge(params: params), &block)
    end

    # Performs an authorized POST request to the configured API namespace.
    #
    # @param path [String] The request path
    # @param body [Hash] The request body
    # @param opts [Hash] Additional request options (e.g. headers)

    def post(path, body = {}, opts = {}, &block)
      request(:post, path, opts.merge(body: body), &block)
    end

    # Performs an authorized DELETE request to the configured API namespace.
    #
    # @param path [String] The request path
    # @param params [Hash] The query parameters
    # @param opts [Hash] Additional request options (e.g. headers)

    def delete(path, params = {}, opts = {}, &block)
      request(:delete, path, opts.merge(params: params), &block)
    end

    private

    def validate_args(opts)
      required_args = %i[client_id client_secret].freeze
      missing_args = []

      required_args.each do |arg|
        missing_args << arg if (opts[arg] || FitbitAPI.send(arg)).nil?
      end

      return if missing_args.empty?

      raise FitbitAPI::InvalidArgumentError,
            "Required arguments: #{missing_args.join(', ')}"
    end

    def assign_attrs(opts)
      attrs = %i[client_id client_secret redirect_uri site_url
                 authorize_url token_url unit_system locale scope
                 api_version snake_case_keys symbolize_keys
                 auto_refresh_token on_token_refresh].freeze

      attrs.each do |attr|
        instance_variable_set("@#{attr}", (opts[attr] || FitbitAPI.send(attr)))
      end

      @user_id = opts[:user_id]
    end

    def set_client
      @client = OAuth2::Client.new(
        @client_id,
        @client_secret,
        site: @site_url,
        authorize_url: @authorize_url,
        token_url: @token_url
      )
    end

    def establish_token(opts)
      return unless opts[:access_token] || opts[:refresh_token]

      if opts[:access_token] && !opts[:user_id]
        raise FitbitAPI::InvalidArgumentError,
              'user_id is required if using existing access token'
      end

      @token = OAuth2::AccessToken.new(
        @client,
        opts[:access_token],
        refresh_token: opts[:refresh_token],
        expires_at: opts[:expires_at]
      )

      refresh_token! if @token.token.empty?
    end

    def request(verb, path, opts = {}, &block)
      request_path = "#{@api_version}/#{path}"
      request_headers = default_request_headers.merge(opts[:headers] || {})
      request_options = opts.merge(headers: request_headers)

      deep_keys_to_camel_case!(request_options[:params])
      deep_keys_to_camel_case!(request_options[:body])

      refresh_token! if auto_refresh_token && token.expired?

      response = token.public_send(verb, request_path, request_options, &block).response
      response_body = MultiJson.load(response.body) unless response.status == 204

      process_keys!(response_body)
    end

    def auth_headers
      { 'Authorization' => "Basic #{Base64.strict_encode64("#{@client_id}:#{@client_secret}")}" }
    end

    def default_request_headers
      {
        'User-Agent' => "fitbit_api gem (v#{FitbitAPI::VERSION})",
        'Accept-Language' => @unit_system,
        'Accept-Locale' => @locale
      }
    end

    def process_keys!(object)
      deep_keys_to_snake_case!(object) if snake_case_keys
      deep_symbolize_keys!(object) if symbolize_keys

      object
    end
  end
end
