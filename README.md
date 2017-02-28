# Fitbyte

[![Gem Version](https://badge.fury.io/rb/fitbyte.svg)](https://badge.fury.io/rb/fitbyte)
[![Build Status](https://travis-ci.org/zokioki/fitbyte.svg?branch=master)](https://travis-ci.org/zokioki/fitbyte)

**NOTE: This library is no longer being actively maintained. Check out [fitgem_oauth2](https://github.com/gupta-ankit/fitgem_oauth2) as an alternative option.**

Fitbyte allows interaction with [Fitbit's REST API](https://dev.fitbit.com/docs/basics/).

It was started as a small personal project to provide a Ruby API interface using OAuth2, after Fitbit announced the eventual drop of OAuth1 support for the developer API.

## Installation

To install the latest release:

    $ gem install fitbyte

To include in a Rails project, add it to the Gemfile:

```ruby
gem "fitbyte"
```

## Usage

To use the Fitbit API, you must register your application at [dev.fitbit.com](https://dev.fitbit.com/apps). After registering, you should have access to **CLIENT ID**, **CLIENT SECRET**, and **REDIRECT URI (Callback URL)** values for use in instantiating a *Fitbyte::Client* object.

### Rails

Please reference the [fitbyte-rails repo](https://github.com/zokioki/fitbyte-rails) as an example of how to use this gem within Rails.

### Standalone

- Create a client instance:

```ruby
client = Fitbyte::Client.new(client_id: my_client_id,
                             client_secret: my_client_secret,
                             redirect_uri: "http://example.com/handle/callback")
```

- Generate a link for the Fitbit authorization page:

```ruby
client.auth_page_link
# => https://fitbit.com/oauth2/authorize?client_id=123XYZ&redirect_uri=...
```

- Follow the generated link to Fitbit's authorization page. After approving your app, you're sent to the `redirect_uri`, with an appended authorization `code` param, which you'll exchange for an access token:

```ruby
client.get_token(auth_code)
```

You're now authenticated and can make calls to Fitbit's API:

```ruby
client.food_logs Date.today
# => { "foods" => [{ "isFavorite" => true, "logDate" => "2015-06-26", "logId" => 1820, "loggedFood" => { "accessLevel" => "PUBLIC", "amount" => 132.57, "brand" => "", "calories" => 752, ...}] }
```

To make the response more easily suited for attribute-assignment, it can be parsed to return a hash whose keys are in snake_case format. This can be done by setting the client's `snake_case` option to `true`, like so:

```ruby
client.snake_case = true
client.food_logs Date.today
# => { "foods" => [{ "is_favorite" => true, "log_date" => "2015-06-26", "log_id" => 1820, "logged_food" => { "access_level" => "PUBLIC", "amount" => 132.57, "brand" => "", "calories" => 752, ...}] }
```

Similarly, all arguments passed in through a POST request are automatically converted to camelCase before they hit Fitbit's API, making it easy to keep your codebase stylistically consistent. For example, all of the following would result in valid API calls:

```ruby
client.log_activity activity_id: 12345, duration_millis: "50000"
client.log_activity activityId: 54321, durationMillis: "44100"
# If for some reason you had to mix snake and camel case like below,
# Fitbyte would make sure the result is a validly formatted request
client.log_activity activity_id: 12345, durationMillis: "683300"
```

### Options

When initializing a `Fitbyte::Client` instance, you're given access to a handful of options:

- `:api_version` - API version to be used when making requests (default: "1")

- `:unit_system` - The measurement unit system to use for response values (default: "en_US" | available: "en_US", "en_GB", and "any" for metric)

- `:locale` - The locale to use for response values (default: "en_US" | available: "en_US", "fr_FR", "de_DE", "es_ES", "en_GB", "en_AU", "en_NZ" and "ja_JP")

- `:scope` - A space-delimited list of the permissions you are requesting (default: "activity nutrition profile settings sleep social weight heartrate" | available: "activity", "heartrate", "location", "nutrition", "profile", "settings" "sleep", "social" and "weight")

- `:snake_case` - Transform returned object's keys to snake case format (default: false)

- `:symbolize_keys` - Transform returned object's keys to symbols (default: false)


## License

This gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
