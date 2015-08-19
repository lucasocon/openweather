require './test/test_helper'

class ClientTest < Minitest::Test

  def test_get_weather_client
    configure_openweather2
    stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?q=London&APPID=dd7073d18e3085d0300b6678615d904d")
    response = Openweather2.get_weather(city:'london')
    assert_equal response.city, 'London'
  end

  def test_get_nil_response
    configure_openweather2
    response = Openweather2.get_weather(city:'adsadsdadaad')
    assert_equal response, nil
  end

  def test_without_configuration
    if Openweather2.configuration.nil?
      assert_raises(ArgumentError) do
        Openweather2.get_weather(city:'london')
      end
    else
      Openweather2.configuration = nil
      assert_raises(ArgumentError) do
        Openweather2.get_weather(city:'london')
      end
    end
  end
end
