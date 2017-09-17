require 'fitbyte/helpers/configuration'
require 'fitbyte/helpers/utils'
require 'fitbyte/helpers/exceptions'

module Fitbyte
  extend Configuration

  define_setting :client_id
  define_setting :client_secret
  define_setting :redirect_uri

  define_setting :site_url,       'https://api.fitbit.com'
  define_setting :authorize_url,  'https://www.fitbit.com/oauth2/authorize'
  define_setting :token_url,      'https://api.fitbit.com/oauth2/token'

  define_setting :unit_system,    'en_US'
  define_setting :locale,         'en_US'
  define_setting :scope,          'activity nutrition profile settings sleep social weight heartrate'

  define_setting :api_version,    '1'

  define_setting :snake_case,     false
  define_setting :symbolize_keys, false
end
