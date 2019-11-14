source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in enju_ndl.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.
gem "enju_question", github: "next-l/enju_question"
gem "enju_bookmark", github: "next-l/enju_bookmark"
gem "jquery-rails"
gem 'sprockets', '~> 3.7'
gem 'rails', '~> 5.2'
group :test do
  gem 'rails-controller-testing'
  gem 'rspec_junit_formatter'
end

# To use a debugger
# gem 'byebug', group: [:development, :test]
