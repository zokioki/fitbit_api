# frozen_string_literal: true

require 'fitbit_api/helpers/configuration'
require 'fitbit_api/helpers/utils'
require 'fitbit_api/helpers/exceptions'

module FitbitAPI
  extend Configuration

  define_setting :client_id
  define_setting :client_secret
  define_setting :redirect_uri

  define_setting :site_url,        'https://api.fitbit.com'
  define_setting :authorize_url,   'https://www.fitbit.com/oauth2/authorize'
  define_setting :token_url,       'https://api.fitbit.com/oauth2/token'

  define_setting :unit_system,     'en_US'
  define_setting :locale,          'en_US'
  define_setting :scope,           %w[activity nutrition profile settings sleep social weight
                                      heartrate respiratory_rate oxygen_saturation cardio_fitness
                                      temperature electrocardiogram irregular_rhythm_notifications]

  define_setting :api_version,     '1'

  define_setting :snake_case_keys, false
  define_setting :symbolize_keys,  false

  define_setting :auto_refresh_token, true
  define_setting :on_token_refresh
end
