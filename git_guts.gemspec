# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_guts/version'

Gem::Specification.new do |gem|
  gem.name          = "git_guts"
  gem.version       = GitGuts::VERSION
  gem.authors       = ["Shadab Ahmed"]
  gem.email         = ["shadab.ansari@gmail.com"]
  gem.description   = %q{Diving deep into git with ruby}
  gem.summary       = %q{Helper commands to see your way around git}
  gem.homepage      = "http://github.com/shadabahmed/git_guts"

  gem.add_dependency 'rack'
  gem.add_dependency 'thor'
  gem.add_dependency 'sinatra'
  gem.add_dependency 'haml'
  gem.add_dependency 'git'
  gem.add_dependency 'ptools'
  gem.add_dependency 'mimemagic'
  gem.add_dependency 'diffy'
  gem.add_dependency 'thin'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.post_install_message = <<-MSG

Thanks for installing
Please include this line in your bash profile:

export PATH=#{gem.gem_dir}/bin:$PATH

  MSG
end
