# Candies
[![travis-ci](https://secure.travis-ci.org/martinciu/candies.png?branch=master)](http://travis-ci.org/martinciu/candies)
####Invisible image based tracing service with Redis backend

## Usage

### Standalone service

Candies can be deployed as a standalone service (for example to heroku). To do it create a simple `config.ru` file:

    require 'rubygems'
    require 'candies'

    # Candies.redis = ENV['REDISTOGO_URL'], read below about redis configuration

    run Candies::Server.new

and deploy it to any `rack` compatybile environment (passenger, thin, unicorn, etc.)

### Mounted to the Rails app

Mount Candies in your `config/routes.rb` file:

    mount Candies::Server.new => "candies", :as => "candies"

It will be available under `http://yourapproot.tld/candies` url

### Image tag

When you have Candies server deployed you can add tracking payload by including `img` tag in your HTML code:

    <a href="http://candies.tld/trackername.gif?id=tracing-id&foo=bar&baz=foo" />

or if you mounted candies in your rails app as `candies` then it will be:

    <a href="http://yourapproot.tld/candies/trackername.gif?id=tracing-id&foo=bar&baz=foo" />

Also in rails app you can use `candies_image_tag` helper. To do so you have to set `Candies.url` to point to the candies service url. The best way is to put in `config/initializers/candies.rb` file:
    
    Candies.host = "http://yourapproot.tld/candies"

Now you can use `candies_image_tag` helper in controller views and in mailer views. Example:

    <%= candies_image_tag(:id => "anyone@example.com", :tracker => "t", :email_type => "hello") %>

Note that `id` parameter is required. If `tracker` parameter is ommited it will be set "t" as default. Rest of parameters is a tracking payload. In this case redis key will be: `candies:tracker:anyone@example.com:2011-11-10T13:13:09+01:00` and value: `"{\"email_type\":\"hello\"}"`. If you don't specify `id` parameter not value will be stored. Invisible image will by served anyway.

## Requirements

Candies uses redis as a datastore.

Candies only supports redis 2.0 or greater.

If you're on OS X, Homebrew is the simplest way to install Redis:

    $ brew install redis
    $ redis-server /usr/local/etc/redis.conf

You now have a Redis daemon running on 6379.

## Setup

If you are using bundler add candies to your Gemfile:

    gem 'candies'

Then run:

    bundle install

Otherwise install the gem:

    gem install candies

and require it in your project:

    require 'candies'

## Configuration

### Redis

You may want to change the Redis host and port Candies connects to, or
set various other options at startup.

Candies has a `redis` setter which can be given a string or a Redis
object. This means if you're already using Redis in your app, Candies
can re-use the existing connection.

String: `Candies.redis = 'localhost:6379'`

Redis: `Candies.redis = $redis`

For our rails app we have a `config/initializers/candies.rb` file where
we load `config/candies.yml` by hand and set the Redis information
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
    Candies.redis = redis_config[rails_env]

## Namespaces

If you're running multiple, separate instances of candies you may want
to namespace the keyspaces so they do not overlap. This is not unlike
the approach taken by many memcached clients.

This feature is provided by the [redis-namespace][rs] library, which
candies uses by default to separate the keys it manages from other keys
in your Redis server.

Simply use the `Candies.redis.namespace` accessor:

    Candies.redis.namespace = "candies:blog"

We recommend sticking this in your initializer somewhere after Redis
is configured.

## Results

There isn't any dashboard for displaying values (yet). You cen review them by logging into `redis-cli`. Sorry.

## Development

Source hosted at [GitHub](http://github.com/martinciu/candies).
Report Issues/Feature requests on [GitHub Issues](http://github.com/martinciu/candies/issues).

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

Copyright (c) 2011 Marcin Ciunelis. See [LICENSE](https://github.com/martinciu/candies/blob/master/LICENSE) for details.
