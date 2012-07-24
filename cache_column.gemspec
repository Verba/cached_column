# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["John Firebaugh"]
  gem.email         = ["john.firebaugh@verbasoftware.com"]
  gem.description   = %q{cache_column}
  gem.summary       = %q{cache_column}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cache_column"
  gem.require_paths = ["lib"]
  gem.version       = "0.1"

  gem.add_dependency "activerecord", "~> 3.0"
end
