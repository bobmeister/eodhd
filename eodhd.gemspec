# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eodhd/version'

Gem::Specification.new do |gem|
  gem.name        = 'eodhd'
  gem.version     = Eodhd::VERSION
  gem.homepage    = 'https://github.com/bobmeister/eodhd'

  gem.author      = ["Bob Haupt"]
  gem.email       = ['bob.haupt77@gmail.com']
  gem.description = "Rubygem for interacting with the EODHD API."
  gem.summary     = "The EODHD API lets you obtain market data from 60+ exchanges worldwide"

  gem.license     = 'MIT'

  gem.add_dependency 'faraday', '~> 1'
  gem.add_dependency 'faraday_middleware', '~> 1.2'
  gem.add_dependency 'celluloid', '~> 0.18'
  gem.add_dependency 'multi_json', '~> 1.15'
  gem.add_development_dependency 'bundler', '~> 2'

  gem.files = %w(LICENSE README.md Rakefile eodhd.gemspec)
  gem.files += Dir.glob("lib/**/*.rb")
  gem.files += Dir.glob("spec/**/*")

  gem.test_files = Dir.glob("spec/**/*")

  gem.require_paths = ['lib']
end