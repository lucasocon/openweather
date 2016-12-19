require 'uri'
require 'net/http'
require 'json'

module Openweather2

  class << self
    attr_accessor :configuration
  end

  class Configuration
    attr_accessor :endpoint, :apikey
  end

  class UnprocessableError < RuntimeError; end
  class ForbiddenError < RuntimeError; end
  class UnknownResponse < RuntimeError; end

  extend self

  def configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def get_weather(options={})
    check_configuration!
    uri = set_params(options)
    response = send_request(uri)
    parse_json(response)
  end

  private
  def parse_json(response)
    case response
    when Net::HTTPSuccess
      check_response(response)
    when Net::HTTPUnprocessableEntity
      raise UnprocessableError, 'Bad URI param!'
    else
      raise UnknownResponse, 'Something was wrong!'
    end
  end

  def check_response(response)
    json = JSON.parse(response.body)
    if json['cod'] == 200
      Openweather2::Weather.new(json)
    else
      nil
    end
  end

  def send_request(uri)
    req = Net::HTTP::Get.new(uri.request_uri)
    httpSession = Net::HTTP.new(uri.hostname, uri.port)
    httpSession.use_ssl = uri.scheme == 'https'
    httpSession.start() { |http| http.request(req) }
  end

  def set_params(options)
    uri = URI(Openweather2.configuration.endpoint)
    uri.query = URI.encode_www_form(default_params.merge(lat: options[:lat], lon: options[:lon], units: options[:units])) if options[:lat] && options[:lon]
    uri.query = URI.encode_www_form(default_params.merge(zip: options[:zip], units: options[:units])) if options[:zip]
    uri.query = URI.encode_www_form(default_params.merge(q: options[:city], units: options[:units])) if options[:city]
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
