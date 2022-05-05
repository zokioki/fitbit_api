0.10.0
------
- Add `auto_refresh_token` config to make token auto-refreshing configurable (defaults to true).
- Add `on_token_refresh` config to specify callback to execute on token refresh (optional).
- Bump `bundler` development dependency
- Clean up documentation formatting

0.9.1
-----
- Fix `sleep_time_series` endpoint
- Tweak user-agent string in request headers

0.9.0
-----
- Rework client to accept existing access tokens.
- Fix argument parsing in `FitbitAPI::Client` to respect fallback values passed to `#configure`.
- Add `byebug` as development dependency.

0.8.3
-----
- Fix bug regarding optional `params` parsing for GET requests.

0.8.2
-----
- Fix `#activity_logs_list` to allow passing in expected URL params.

0.8.1
-----
- Post install cleanup

0.8.0
-----
- Gem renamed from `fitbyte` to `fitbit_api`
  - Make sure to change `Fitbyte::Client` to `FitbitAPI::Client` in your code, no other changes should be necessary.

0.7.1
-----
- Rename `#auth_page_link` to `#auth_url`
- Rename `snake_case` option to `snake_case_keys`
- Code cleanup

0.7.0
-----
- Add support for Activity and Heart Rate Intraday Time Series endpoints.
- Add support for weight and fat logging and deletion endpoints.
- Renamed `#weight_goals` and `#body_fat_goals` to `#weight_goal` and `#body_fat_goal`.

0.6.0
-----
- A `refresh_token` option can be passed in to retrieve an existing access token.
- A configuration block can now be passed in to FitbitAPI, to allow for the setting of default instance attributes.
- File/code reorganization.

0.5.0
-----
- Add Heart Rate endpoint support. Add support for Time Series endpoints.
- Minor improvements to some helper functions

0.4.1
-----
- Users can now provide either snake_cased or camelCased param attribute keys when POSTing data to Fitbit. Keys are automatically converted to camelCase before a request is sent to Fitbit's API.

0.4.0
-----
- Remove FitStruct objects
- The response's hash keys can now be transformed using the following options:
  - `snake_case` - if set to true, all keys are formatted to snake_case
  - `symbolize_keys` - if set to true, all keys are converted to symbols

0.3.0
-----
- API endpoint support for the following actions:
  - Add alarm
  - Update alarm
  - Delete alarm
- File reorganization

0.2.7
-----
- Set minimum required Ruby version
- Minor testing tweaks for Travis CI

0.2.6
-----
- Expand API endpoint support for the following actions:
  - Add activity to favorites
  - Retrieve list of activity log entries
  - Create/update daily/weekly goals
  - Delete activity
  - Remove activity from favorites

0.2.5
-----
- Responses now return FitStruct objects (inherit from OpenStruct).

- Ability to set default data return format by setting `raw_response` on FitbitAPI::Client instance (defaults to using FitStruct objects). Can be overridden on each API call by specifying the `raw` boolean option.

0.2.4
-----
- Default result format for `get` calls now return OpenStruct objects, allowing for more convenient method-like attribute access. Specifying `raw: true` returns original JSON.

0.2.3
-----
- Remove `require 'json'`

0.2.2
-----
- MultiJson used for parsing JSON (with symbolized keys)

0.2.1
-----
- `user_id` is interpolated into resource URLs, removing the hardcoded `-`.

0.2.0
-----
- API version in resource URLs is now user settable.
- Scope argument takes both String and Array types.
- Default init values moved to `defaults` hash.

0.1.0
-----
- Initial auth logic setup for Client class.
- Endpoint support added for retrieving Food, Sleep, Water, Activities, Alarms, Body, Devices, Friends, and Users.
