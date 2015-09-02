require "openweather2"

Openweather2.configure do |config|
  config.endpoint = 'http://api.openweathermap.org/data/2.5/weather'
  config.apikey = 'dd7073d18e3085d0300b6678615d904d'
end

if ARGV.empty?
  puts 'put some city names on the command line'
end

ARGV.each do |city|
  weather = Openweather2.get_weather(city: city, units: 'metric')
  puts "#{city}: #{weather.temperature} ℃"
end
