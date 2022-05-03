# FitbitAPI

[![Gem Version](https://badge.fury.io/rb/fitbit_api.svg)](https://badge.fury.io/rb/fitbit_api)
[![Build Status](https://travis-ci.org/zokioki/fitbit_api.svg?branch=master)](https://travis-ci.org/zokioki/fitbit_api)

FitbitAPI provides a Ruby interface to the [Fitbit Web API](https://dev.fitbit.com/reference/web-api/quickstart).

## Installation

To install the latest release:

    $ gem install fitbit_api

To include in a Rails project, add it to the Gemfile:

```ruby
gem 'fitbit_api'
```

## Getting Started

To use the Fitbit API, you must register your application at [dev.fitbit.com](https://dev.fitbit.com/apps). After registering, you should have access to the **CLIENT ID** and **CLIENT SECRET** values for use in instantiating a *FitbitAPI::Client* object.

### Rails

You can reference the [fitbit_api_rails](https://github.com/zokioki/fitbit_api_rails) repo as a simple example of how to use this gem within a Rails project.

### Quickstart

If you already have a user's token data and Fitbit user_id:

```ruby
client = FitbitAPI::Client.new(client_id: 'XXXXXX',
                               client_secret: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                               access_token: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                               refresh_token: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                               expires_at: 1234567890,
                               user_id: 'XXXXXX')
```

### OAuth 2.0 Authorization Flow

- Create a client instance (ensure that `redirect_uri` is passed in):

```ruby
client = FitbitAPI::Client.new(client_id: 'XXXXXX',
                               client_secret: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                               redirect_uri: 'http://example.com/handle/callback')
```

- Generate a link for your app's Fitbit authorization page:

```ruby
client.auth_url
# => https://fitbit.com/oauth2/authorize?client_id=123XYZ&redirect_uri=...
```

- Follow the generated link to Fitbit's authorization page. After granting permission for your app, you're sent to the `redirect_uri`, with an appended authorization `code` param, which you'll exchange for an access token:

```ruby
client.get_token(auth_code)
```

You're now authorized and can make calls to Fitbit's API.

### Interacting with the API

Once a valid token has been generated, you're able to make API calls via the client object:

```ruby
client.food_logs Date.today
# => { "foods" => [{ "isFavorite" => true, "logDate" => "2015-06-26", "logId" => 1820, "loggedFood" => { "accessLevel" => "PUBLIC", "amount" => 132.57, "brand" => "", "calories" => 752, ...}] }
```

To make responses more easily suited for attribute-assignment, they can be parsed to return a hash whose keys are in snake_case format. This can be done by setting the client's `snake_case_keys` option to `true`:

```ruby
client.snake_case_keys = true
client.food_logs Date.today
# => { "foods" => [{ "is_favorite" => true, "log_date" => "2015-06-26", "log_id" => 1820, "logged_food" => { "access_level" => "PUBLIC", "amount" => 132.57, "brand" => "", "calories" => 752, ...}] }
```

Similarly, all arguments passed in through a POST request are automatically converted to camelCase before they hit Fitbit's API, making it easy to keep your codebase stylistically consistent. For example, all of the following would result in valid API calls:

```ruby
# options with snake_cased keys
client.log_activity activity_id: 12345, duration_millis: '50000'
# options with camelCased keys
client.log_activity activityId: 54321, durationMillis: '44100'
# options with mixed snake and camel cased keys
client.log_activity activity_id: 12345, durationMillis: '683300'
```

### Options

When initializing a `FitbitAPI::Client` instance, you're given access to a handful of options:

- `:api_version` - API version to be used when making requests (default: "1")

- `:unit_system` - The measurement unit system to use for response values (default: "en_US" | available: "en_US", "en_GB", and "any" for metric)

- `:locale` - The locale to use for response values (default: "en_US" | available: "en_US", "fr_FR", "de_DE", "es_ES", "en_GB", "en_AU", "en_NZ" and "ja_JP")

- `:scope` - A space-delimited list of the permissions you are requesting (default: "activity nutrition profile settings sleep social weight heartrate" | available: "activity", "heartrate", "location", "nutrition", "profile", "settings" "sleep", "social" and "weight")

- `:snake_case_keys` - Transform returned object's keys to snake case format (default: false)

- `:symbolize_keys` - Transform returned object's keys to symbols (default: false)

- `:auto_refresh_token` - Automatically refreshes the access token once expired (default: true).

- `:on_token_refresh` - A callback to be invoked whenever the access token is refreshed (default: nil).

If using this library in Rails, you can configure your options using an initializer:

```ruby
# config/initializers/fitbit_api.rb

FitbitAPI.configure do |config|
  config.client_id       = 'XXXX'
  config.client_secret   = 'xxxx'
  config.snake_case_keys = true
  config.symbolize_keys  = true
end
```

## License

This gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
