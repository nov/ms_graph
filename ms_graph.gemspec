Gem::Specification.new do |gem|
  gem.name          = 'ms_graph'
  gem.version       = File.read('VERSION').delete("\n\r")
  gem.authors       = ['nov']
  gem.email         = ['nov@matake.jp']

  gem.summary       = %q{Microsoft Graph API Ruby Client}
  gem.description   = %q{Microsoft Graph API Ruby Client}
  gem.homepage      = 'https://github.com/nov/ms_graph'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|gem|features)/}) }
  gem.bindir        = 'exe'
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.11'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'rgem', '~> 3.0'
end
