0.2.5
-----
- Responses now return FitStruct objects (inherit from OpenStruct).

- Ability to set default data return format by setting `raw_response` on Fitbyte::Client instance (defaults to using FitStruct objects). Can be overridden on each API call by specifying the `raw` boolean option.

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
