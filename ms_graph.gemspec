Gem::Specification.new do |gem|
  gem.name          = 'ms_graph'
  gem.version       = File.read('VERSION').strip
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

  gem.add_runtime_dependency 'httpclient'
  gem.add_runtime_dependency 'rack-oauth2'
  gem.add_runtime_dependency 'multi_json'
  gem.add_runtime_dependency 'activesupport'
  gem.add_development_dependency 'rake'
end
