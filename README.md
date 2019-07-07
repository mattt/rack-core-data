# Rack::Scaffold

**Automatically generate RESTful CRUD services**

## Installation

### Gemfile

```ruby
source :rubygems

gem 'rack-scaffold', require: 'rack/scaffold'

gem 'sequel'
gem 'core_data'

gem 'unicorn'
gem 'pg'
```

## Usage

An example web API using a Core Data model can be found the `/example` directory.

### config.ru

```ruby
require 'sequel'
require 'core_data'
require 'rack/scaffold'

DB = Sequel.connect(ENV['DATABASE_URL'])

run Rack::Scaffold model: './Example.xcdatamodeld', only: [:create, :read]
```

## Available Actions

By default, `Rack::Scaffold` will enable all of the actions described below. Actions can be whitelisted or blacklisted by passing either the `only` or `except` options, respectively.

- `create` (`POST /resources`): Creates a new resource with the fields in a `www-form-urlencoded` or `application/json` encoded HTTP request body.
- `read` (`GET /resources` & `GET /resources/123`): Reads a collection of resources or an individual resource at the specified URI. Supports pagination by passing either `page` & `per_page` or `limit` & `offset` parameters.
- `update` (`PUT` OR `PATCH /resources/123`): Updates the specified resource with the fields in a `www-form-urlencoded` or `application/json` encoded HTTP request body.
- `delete` (`DELETE /resources/123`): Deletes the specified resource.
- `susbscribe` (`SUBSCRIBE` or `GET /resources` with `Accept: text/event-stream`): Subscribes to create, update, and delete actions performed, streaming corresponding JSON Patch diffs. You can read more about the Rocket technique for streaming REST resources at http://rocket.github.io.

### Supported Data Models

- [Core Data Model](https://github.com/mattt/core_data/) (`.xcdatamodeld`)
- [Sequel](https://github.com/jeremyevans/sequel)
- [ActiveRecord](https://github.com/rails/rails)

## Contact

[Mattt](https://twitter.com/mattt)

## License

Rack::Scaffold is available under the MIT license.
See the LICENSE file for more info.
