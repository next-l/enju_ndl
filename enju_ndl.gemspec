$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "enju_ndl/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enju_ndl"
  s.version     = EnjuNdl::VERSION
  s.authors     = ["Kosuke Tanabe"]
  s.email       = ["tanabe@mwr.mediacom.keio.ac.jp"]
  s.homepage    = "https://github.com/next-l/enju_ndl"
  s.summary     = "enju_ndl plugin"
  s.description = "NDL WebAPI wrapper for Next-L Enju"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "nokogiri"
  s.add_dependency "lisbn"
  s.add_dependency "nori", "~> 1.1"
  s.add_dependency "library_stdnums"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "vcr"
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "enju_biblio", "~> 0.1.0.pre13"
  s.add_development_dependency "enju_subject", "~> 0.1.0.pre4"
  s.add_development_dependency "enju_question", "~> 0.1.0.pre4"
  s.add_development_dependency "enju_manifestation_viewer", "~> 0.1.0.pre2"
  s.add_development_dependency "sunspot_solr", "~> 2.0.0.pre.120925"
  s.add_development_dependency "simplecov"
end
