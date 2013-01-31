# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ynuke_middleware/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brendon Murphy"]
  gem.email         = ["xternal1+github@gmail.com"]
  gem.summary       = %q{Rack middleware to block requests that appear to contain yaml attacks}
  gem.description   = gem.summary
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ynuke_middleware"
  gem.require_paths = ["lib"]
  gem.version       = YnukeMiddleware::VERSION

  gem.add_dependency "rack"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rack-test"
end
