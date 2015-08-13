module Openweather2
  class Weather

    attr_reader :city, :longitude, :latitude, :pressure, :humidity, :clouds,
      :temperature, :min_temperature, :max_temperature, :wind_speed, :wind_angle, :sunrise, :sunset

    def initialize(json)
      @city = json['name']
      @longitude = json['coord']['lon']
      @latitude = json['coord']['lat']
      @temperature = Openweather2::Temperature.new(json['main']['temp'])
      @pressure = json['main']['pressure']
      @humidity = json['main']['humidity']
      @min_temperature = Openweather2::Temperature.new(json['main']['temp_min'])
      @max_temperature = Openweather2::Temperature.new(json['main']['temp_max'])
      @clouds = json['clouds']['all']
      @wind_speed = json['wind']['speed']
      @wind_angle = json['wind']['deg']
    end
  end
end