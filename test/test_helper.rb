require './lib/openweather2'
require 'minitest/autorun'
require 'webmock/minitest'
include WebMock::API
WebMock.allow_net_connect!

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(File.join(fixture_path, file))
end

def configure_openweather2
  Openweather2.configure do |config|
    config.endpoint = 'http://api.openweathermap.org/data/2.5/weather'
    config.apikey = 'dd7073d18e3085d0300b6678615d904d'
  end
end
