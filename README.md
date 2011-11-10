# Tracker[![travis-ci](https://secure.travis-ci.org/martinciu/tracker.png?branch=master)](http://travis-ci.org/martinciu/tracker)
Invisible image based tracing service with Redis backend

## Requirements

Tracker uses redis as a datastore.

Tracker only supports redis 2.0 or greater.

If you're on OS X, Homebrew is the simplest way to install Redis:

    $ brew install redis
    $ redis-server /usr/local/etc/redis.conf

You now have a Redis daemon running on 6379.

## Setup

If you are using bundler add tracker to your Gemfile:

    gem 'tracker'

Then run:

    bundle install

Otherwise install the gem:

    gem install tracker

and require it in your project:

    require 'tracker'

## Usage

TODO

## Configuration

### Redis

You may want to change the Redis host and port Tracker connects to, or
set various other options at startup.

Tracker has a `redis` setter which can be given a string or a Redis
object. This means if you're already using Redis in your app, Tracker
can re-use the existing connection.

String: `Tracker.redis = 'localhost:6379'`

Redis: `Tracker.redis = $redis`

For our rails app we have a `config/initializers/tracker.rb` file where
we load `config/tracker.yml` by hand and set the Redis information
appropriately.

Here's our `config/redis.yml`:

    development: localhost:6379
    test: localhost:6379
    staging: redis1.example.com:6379
    fi: localhost:6379
    production: redis1.example.com:6379

And our initializer:

    rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
    rails_env = ENV['RAILS_ENV'] || 'development'

    redis_config = YAML.load_file(rails_root + '/config/redis.yml')
    Tracker.redis = redis_config[rails_env]

## Namespaces

If you're running multiple, separate instances of tracker you may want
to namespace the keyspaces so they do not overlap. This is not unlike
the approach taken by many memcached clients.

This feature is provided by the [redis-namespace][rs] library, which
tracker uses by default to separate the keys it manages from other keys
in your Redis server.

Simply use the `Tracker.redis.namespace` accessor:

    Tracker.redis.namespace = "tracker:blog"

We recommend sticking this in your initializer somewhere after Redis
is configured.

## Development

Source hosted at [GitHub](http://github.com/martinciu/tracker).
Report Issues/Feature requests on [GitHub Issues](http://github.com/martinciu/tracker/issues).

Tests can be ran with `rake test`

### Note on Patches/Pull Requests

 * Fork the project.
 * Make your feature addition or bug fix.
 * Add tests for it. This is important so I don't break it in a
   future version unintentionally.
 * Commit, do not mess with rakefile, version, or history.
   (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
 * Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Marcin Ciunelis. See [LICENSE](https://github.com/martinciu/tracker/blob/master/LICENSE) for details.
