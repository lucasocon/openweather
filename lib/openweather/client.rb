require "uri"
require "net/http"
require "json"

module Openweather

  class << self
    attr_accessor :configuration
  end

  class Configuration
    attr_accessor :endpoint
    attr_accessor :apikey
  end

  class UnprocessableError < RuntimeError; end
  class ForbiddenError < RuntimeError; end
  class UnknownResponse < RuntimeError; end

  extend self

  def configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def weather(city)
    configure_required!

    uri = URI(Openweather.configuration.endpoint)
    uri.query = URI.encode_www_form(default_params.merge(:q => city))
    req = Net::HTTP::Get.new(uri.request_uri)

    http_params = [uri.hostname, uri.port, use_ssl: uri.scheme == 'https']
    res = Net::HTTP.start(*http_params) do |http|
      http.request(req)
    end

    case res
    when Net::HTTPSuccess
      JSON.parse(res.body)
    when Net::HTTPUnprocessableEntity
      raise UnprocessableError, "Bad URI param!"
    else
      raise UnknownResponse, "Something was wrong!"
    end
  end

  private

  def configure_required!
    if Openweather.configuration.instance_variables.size < 2
      raise ArgumentError, "You must configure Openweather"
    end
  end
  
  def default_params
    {:APPID => Openweather.configuration.apikey }
  end
  
  def do_request(req)
    configure_required!

    endpoint_uri = URI(Openweather.configuration.endpoint)
    
    
    http_params = [
      endpoint_uri.hostname, 
      endpoint_uri.port, 
      use_ssl: uri.scheme == 'https'
    ]
    
    res = Net::HTTP.start(*http_params) do |http|
      http.request(req)
    end

    case res
    when Net::HTTPSuccess
      JSON.parse(res.body)
    when Net::HTTPUnprocessableEntity
      raise UnprocessableError, "Bad URI param!"
    else
      raise UnknownResponse, "Something was wrong!"
    end
  end

end
