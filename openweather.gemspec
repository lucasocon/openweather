# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openweather2/version'

Gem::Specification.new do |spec|
  spec.name          = "openweather2"
  spec.version       = Openweather2::VERSION
  spec.authors       = ["Lucas Ocon"]
  spec.email         = ["lucas_masterclas@hotmail.com"]

  spec.summary       = %q{Wrapper the OpenWeatherMap API}
  spec.description   = %q{A minimal Ruby Gem to wrap the OpenWeatherMap API http://openweathermap.org}
  spec.homepage      = "https://github.com/lucasocon/openweather"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "minitest", "~> 5.5.1"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "json"
end
