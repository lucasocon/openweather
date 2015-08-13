require './test/test_helper'

class WeatherTest < Minitest::Test

  configure_openweather2

  def test_get_weather_for_city
    stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?q=London&APPID=dd7073d18e3085d0300b6678615d904d").to_return(body: fixture('london.json'), headers: {content_type: 'application/json; charset=utf-8'})

    response = Openweather2.weather('london')
    assert response.city == 'London'
    assert response.latitude == 51.51
    assert response.longitude == -0.13
  end

  def test_fail_weather_for_city
    stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?q=London&APPID=dd7073d18e3085d0300b6678615d904d").to_return(body: fixture('london.json'), headers: {content_type: 'application/json; charset=utf-8'})

    response = Openweather2.weather('london')
    assert response.city != 'Manchester'
    assert response.latitude != 53.48
    assert response.longitude != -2.24
  end

end