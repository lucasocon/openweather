# Openweather

This gem is an abstraction to the OpenWeatherMap API.
This gem provide the weather from numerous regions around the world.

Also you can get some data on the gem response:
  City name
  Longitude
  Latitude
  Temperature
  Pressure
  Humidity
  Min temperature
  Max temperature
  Clouds
  Wind speed
  Wind angle

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openweather'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openweather

## Usage

Usage:

```ruby
require "openweather"

Openweather.configure do |config|
  config.endpoint = 'http://api.openweathermap.org/data/2.5/weather'
  config.apikey = 'dd7073d18e3085d0300b6678615d904d'
end

Openweather.wheater('london')

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Be free to report and send your pull request
Bug reports and pull requests are welcome on GitHub at https://github.com/lucasocon/openweather.

Contributors:

Lucas Ocon (lucasocon)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

