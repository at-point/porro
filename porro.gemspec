# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'porro/version'

Gem::Specification.new do |spec|
  spec.name          = 'porro'
  spec.version       = Porro::VERSION
  spec.authors       = ['Loris Gavillet', 'Lukas Westermann', 'at-point ag']
  spec.email         = ['loris@at-point.ch', 'lukas@at-point.ch', 'kontakt@at-point.ch']

  spec.summary       = %q{Need help with form objects? Porro to the rescue.}
  spec.description   = %q{Allows to create type coerced form objects, batteries included.}
  spec.homepage      = 'https://github.com/at-point/porro'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  spec.metadata['allowed_push_host'] = 'https://rubygems.com'

  spec.files         = %w{Rakefile Gemfile .gitignore} + Dir['**/*.{md,rb,gemspec}'].reject { |f| f.match(%r{^spec/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w{lib}

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'timecop', '~> 0.8'
end
