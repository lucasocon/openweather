require './test/test_helper'

class WeatherTest < Minitest::Test

  def setup
    json = JSON.parse(fixture('london.json').read)
    @weather = Openweather2::Weather.new(json)
  end

  def test_get_weather_from_json
    assert_equal @weather.city, "London"
    assert_equal @weather.longitude, -0.13
    assert_equal @weather.latitude, 51.51
    assert_equal @weather.temperature, 289.04
    assert_equal @weather.pressure, 1019
    assert_equal @weather.humidity, 87
    assert_equal @weather.min_temperature, 287.15
    assert_equal @weather.max_temperature, 291.25
    assert_equal @weather.clouds, 75
    assert_equal @weather.wind_speed, 3.6
    assert_equal @weather.wind_angle, 70
  end

end