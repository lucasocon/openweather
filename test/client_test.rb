require './test/test_helper'

class ClientTest < Minitest::Test


  def test_get_weather_client
    configure_openweather2
    stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?q=London&APPID=dd7073d18e3085d0300b6678615d904d").to_return(body: fixture('london.json'), headers: {content_type: 'application/json; charset=utf-8'})

    response = Openweather2.weather('london')
    assert_equal response.city, 'London'
    assert_equal response.latitude, 51.51
    assert_equal response.longitude, -0.13
  end

end