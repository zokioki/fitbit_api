# Fitbyte

Fitbyte is a gem that allows interaction with Fitbit's REST API, using the OAuth 2.0 protocol for user authorization.

**Please Note:** Fitbit's API is currently in beta, and is in active/rapid development.

## Installation

Add the following line to your application's Gemfile:

```ruby
gem "fitbyte"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fitbyte

## Usage

Create a client instance:

```ruby
client = Fitbyte::Client.new(client_id: my_client_id, client_secret: my_client_secret, redirect_uri: "http://example.com")
```

Generate a link for the Fitbit authorization page:

```ruby
client.auth_page_link
# => https://fitbit.com/oauth2/authorize?client_id=123XYZ&redirect_uri=...
```

Follow generated link to Fitbit's authorization page. Once the given permissions prompt has been approved, you're sent to the `redirect_uri`, along with an authorization `code` query param. This authorization code can be exchanged for an access token:

```ruby
client.get_token(auth_code)
```

You are now authenticated and can make calls to Fitbit's API:

```ruby
client.food_logs
# => returns JSON of today's food logs
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
