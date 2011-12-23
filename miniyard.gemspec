# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "miniyard/version"

Gem::Specification.new do |s|
  s.name        = "miniyard"
  s.version     = MiniYard::VERSION
  s.authors     = ["BJ Neilsen"]
  s.email       = ["bj.neilsen@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "miniyard"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_dependency "haml"
end
