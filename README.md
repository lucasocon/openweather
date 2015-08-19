# Openweather2 [![Gem Version](https://badge.fury.io/rb/openweather2.svg)](http://badge.fury.io/rb/openweather2)

This gem is an abstraction to the OpenWeatherMap API.

This gem provide the weather from numerous regions around the world.

Also you can get some data on the gem response:
* City name
* Longitude
* Latitude
* Temperature
* Pressure
* Humidity
* Min temperature
* Max temperature
* Clouds
* Wind speed
* Wind angle

You can get your APP ID from the OpenWeatherMap website.

http://openweathermap.org/appid#get

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openweather2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openweather2

## Usage

Usage:

You can search the current weather on a location providing a hash with the following parameters:
* city
* lat, lon
* zip

```ruby
require "openweather2"

Openweather2.configure do |config|
  config.endpoint = 'http://api.openweathermap.org/data/2.5/weather'
  config.apikey = YOUR APP ID
end

#Search by city
Openweather2.get_weather(city: 'london')

#Search by coordinates
Openweather2.get_weather(lat: 35, lon: 139)

#Search by ZIP code
Openweather2.get_weather(zip: 94040)

```

Also you can provide a parameter for the units to convert the temperature to 'metric' or 'imperial'

```ruby

Openweather2.get_weather(city: 'london', units: 'metric')
Openweather2.get_weather(city: 'london', units: 'imperial')

```

## Contributing

1. Fork it ( https://github.com/lucasocon/openweather )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Be free to report and send your pull request.

Contributors:
* Lucas Ocon (lucasocon)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

