# -*- encoding: utf-8 -*-
require File.expand_path('../lib/tracker/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Marcin Ciunelis"]
  gem.email         = ["marcin.ciunelis@gmail.com"]
  gem.description   = %q{Invisible image based tracing service with Redis backend}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "tracker"
  gem.require_paths = ["lib"]
  gem.version       = Tracker::VERSION

  gem.add_dependency "rack", "~> 1.3.5"
  gem.add_dependency 'redis', '~> 2.2.2'
  gem.add_dependency 'redis-namespace', '~> 1.1.0'

  gem.add_development_dependency "rake", "~> 0.9.2"
  gem.add_development_dependency "minitest", "~> 2.7.0"
  gem.add_development_dependency "rack-test", "~> 0.6"
  gem.add_development_dependency "turn", "~> 0.8.3"
  gem.add_development_dependency "mocha", "~> 0.10.0"

end
