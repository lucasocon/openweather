require "uri"
require "net/http"
require "json"

module Openweather2

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

  def weather(city, units = nil)
    configure_required!
    uri = URI(Openweather2.configuration.endpoint)
    uri.query = URI.encode_www_form(default_params.merge(:q => city, :units => units))
    req = Net::HTTP::Get.new(uri.request_uri)
    res = get_request(uri, req)
    get_response(res)
  end

  private

  def get_request(uri, req)
    http_params = [uri.hostname, uri.port, use_ssl: uri.scheme == 'https']
    res = Net::HTTP.start(*http_params) do |http|
      http.request(req)
    end
  end
  
  def get_response(res)
    case res
    when Net::HTTPSuccess
      json = JSON.parse(res.body)
      Openweather2::Weather.new(json)
    when Net::HTTPUnprocessableEntity
      raise UnprocessableError, 'Bad URI param!'
    else
      raise UnknownResponse, 'Something was wrong!'
    end
  end

  def configure_required!
    if Openweather2.configuration.instance_variables.size < 2
      raise ArgumentError, 'You must configure Openweather2'
    end
  end
  
  def default_params
    { APPID: Openweather2.configuration.apikey }
  end

end
