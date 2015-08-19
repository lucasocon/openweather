require './test/test_helper'

class ClientTest < Minitest::Test

  def test_get_weather_by_city
    configure_openweather2
    stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?q=London&APPID=dd7073d18e3085d0300b6678615d904d")
    response = Openweather2.get_weather(city:'london')
    assert_equal response.city, 'London'
  end

  def test_get_weather_by_coordinates
    configure_openweather2
    stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?q=London&APPID=dd7073d18e3085d0300b6678615d904d")
    response = Openweather2.get_weather(lat: 35, lon: 139)
    assert_equal response.city, 'Shuzenji'
  end

  def test_get_weather_by_zip
    configure_openweather2
    stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?q=London&APPID=dd7073d18e3085d0300b6678615d904d")
    response = Openweather2.get_weather(zip: 94040)
    assert_equal response.city, 'Mountain View'
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
