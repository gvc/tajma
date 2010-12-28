# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tajma/version"

Gem::Specification.new do |s|
  s.name        = "tajma"
  s.version     = Tajma::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Guilherme Carvalho"]
  s.email       = ["guilherme@guava.com.br"]
  s.homepage    = "http://www.github.com/gvc/tajma"
  s.summary     = %q{Time tracking/Ruby Learning}
  s.description = %q{Simple gem to track the time spent doing some tasks.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency 'sqlite3-ruby'
  s.add_dependency 'activerecord'
  
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'shoulda'
end
