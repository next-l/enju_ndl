$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "enju_ndl/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enju_ndl"
  s.version     = EnjuNdl::VERSION
  s.authors     = ["Kosuke Tanabe"]
  s.email       = ["nabeta@fastmail.fm"]
  s.homepage    = "https://github.com/next-l/enju_ndl"
  s.summary     = "enju_ndl plugin"
  s.description = "NDL WebAPI wrapper for Next-L Enju"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"] - Dir["spec/dummy/log/*"] - Dir["spec/dummy/solr/{data,pids}/*"]

  s.add_dependency "enju_seed", "~> 0.1.1.pre11"
  s.add_dependency "nokogiri"
  s.add_dependency "lisbn"
  s.add_dependency "library_stdnums"
  s.add_dependency "faraday"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 3.0.2"
  s.add_development_dependency "vcr"
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "enju_leaf", "~> 1.1.0.rc14"
  s.add_development_dependency "enju_question", "~> 0.1.0.pre12"
  s.add_development_dependency "sunspot_solr", "~> 2.1"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "enju_subject", "~> 0.1.0.pre27"
end
