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
  s.test_files = Dir["spec/**/*"] - Dir["spec/dummy/log/*"] - Dir["spec/dummy/solr/{data,pids,default,development,test}/*"] - Dir["spec/dummy/tmp/*"]

  s.add_dependency "nokogiri", "~> 1.6.7"
  s.add_dependency "lisbn"
  s.add_dependency "library_stdnums"
  s.add_dependency "faraday"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "mysql2"
  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails", "~> 3.4"
  s.add_development_dependency "vcr", "~> 3.0"
  s.add_development_dependency "webmock"
  #s.add_development_dependency "enju_leaf", "~> 1.2.0.beta.1"
  #s.add_development_dependency "enju_question", "~> 0.2.0.beta.1"
  #s.add_development_dependency "enju_subject", "~> 0.2.0.beta.1"
  s.add_development_dependency "redis-rails"
  s.add_development_dependency "resque-scheduler", "~> 4.0"
  s.add_development_dependency "sunspot_solr", "2.2.0"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "appraisal"
end
