require './test/test_helper'

class ClientTest < Minitest::Test


  def test_get_weather_client
    configure_openweather2
    stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?q=London&APPID=dd7073d18e3085d0300b6678615d904d")
    response = Openweather2.weather('london')
    assert_equal response.city, 'London'
  end

  def test_get_nil_response
    configure_openweather2
    response = Openweather2.weather('adsadsdadaad')
    assert_equal response, nil
  end

end