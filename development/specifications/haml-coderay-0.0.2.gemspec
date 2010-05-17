# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{haml-coderay}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["\303\230rjan Blom"]
  s.date = %q{2010-04-15}
  s.description = %q{Adds a CodeRay syntax highlighting filter to Haml}
  s.email = %q{blom@blom.tv}
  s.files = ["lib/haml-coderay.rb", "LICENSE", "README.md"]
  s.homepage = %q{http://github.com/blom/haml-coderay}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{CodeRay filter for Haml}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<coderay>, [">= 0"])
      s.add_runtime_dependency(%q<haml>, [">= 0"])
      s.add_development_dependency(%q<bluecloth>, [">= 0"])
      s.add_development_dependency(%q<mg>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<coderay>, [">= 0"])
      s.add_dependency(%q<haml>, [">= 0"])
      s.add_dependency(%q<bluecloth>, [">= 0"])
      s.add_dependency(%q<mg>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<coderay>, [">= 0"])
    s.add_dependency(%q<haml>, [">= 0"])
    s.add_dependency(%q<bluecloth>, [">= 0"])
    s.add_dependency(%q<mg>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end
