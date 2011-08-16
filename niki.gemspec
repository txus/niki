# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "niki/version"

Gem::Specification.new do |s|
  s.name        = "niki"
  s.version     = Niki::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Josep M. Bach"]
  s.email       = ["josep.m.bach@gmail.com"]
  s.homepage    = "http://github.com/txus/niki"
  s.summary     = %q{A DSL to describe and play structured musical pieces, i.e. songs}
  s.description = %q{A DSL to describe and play structured musical pieces, i.e. songs}

  s.rubyforge_project = "niki"

  s.add_runtime_dependency 'unimidi'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
