# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pingr-rails}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["github.com/bquilitz", "github.com/chris", "github.com/consti"]
  s.date = %q{2010-07-28}
  s.description = %q{pingr-rails is a rails plugin for accessing the Pingdom API using Pingr}
  s.email = %q{consti@tupalo.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.homepage = %q{http://github.com/consti/pingr-rails}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{pingr-rails is a rails plugin for accessing the Pingdom API using Pingr}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
