# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fitbit_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'fitbit_api'
  spec.version       = FitbitAPI::VERSION
  spec.authors       = ['Zoran']

  spec.summary       = %q{A Ruby interface to the Fitbit Web API.}
  spec.homepage      = 'https://github.com/zokioki/fitbit_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(bin|test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency     'oauth2', '~> 1.0'

  spec.add_development_dependency 'byebug', '~> 11.0'
  spec.add_development_dependency 'bundler', '~> 2.3'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.11'
  spec.add_development_dependency 'webmock', '~> 3.18'
end
