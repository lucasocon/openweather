require 'uri'
require 'net/http'
require 'json'

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
    check_configuration!
    uri      = set_request_params(city, units)
    response = send_request(uri)
    parse_json(response)
  end

  private

  def parse_json(response)
    case response
    when Net::HTTPSuccess
      json = JSON.parse(response.body)
      Openweather2::Weather.new(json)
    when Net::HTTPUnprocessableEntity
      raise UnprocessableError, 'Bad URI param!'
    else
      raise UnknownResponse, 'Something was wrong!'
    end
  end

  def send_request(uri)
    req = Net::HTTP::Get.new(uri.request_uri)
    http_params = [uri.hostname, uri.port, use_ssl: uri.scheme == 'https']
    Net::HTTP.start(*http_params) {|http| http.request(req)}
  end

  def set_request_params(city, units)
    uri = URI(Openweather2.configuration.endpoint)
    uri.query = URI.encode_www_form(default_params.merge(q: city, units: units))
    uri
  end

  def check_configuration!
    if Openweather2.configuration.instance_variables.size < 2
      raise ArgumentError, 'You must configure Openweather2'
    end
  end
  
  def default_params
    {APPID: Openweather2.configuration.apikey}
  end

end
