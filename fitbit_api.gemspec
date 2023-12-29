# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'fitbit_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'fitbit_api'
  spec.version       = FitbitAPI::VERSION
  spec.authors       = ['Zoran']

  spec.summary       = 'A Ruby interface to the Fitbit Web API.'
  spec.homepage      = 'https://github.com/zokioki/fitbit_api'
  spec.license       = 'MIT'

  spec.metadata      = {
    'source_code_uri' => spec.homepage,
    'changelog_uri' => "#{spec.homepage}/blob/v#{FitbitAPI::VERSION}/CHANGELOG.md",
    'documentation_uri' => "https://www.rubydoc.info/gems/fitbit_api/#{FitbitAPI::VERSION}",
    'rubygems_mfa_required' => 'true'
  }

  spec.files         = Dir['*.{md,txt}', 'lib/**/*']
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_runtime_dependency     'oauth2', '~> 2.0'

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.12'
  spec.add_development_dependency 'rubocop', '~> 1.54.2'
  spec.add_development_dependency 'webmock', '~> 3.18'
end
