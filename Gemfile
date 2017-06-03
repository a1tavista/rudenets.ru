source "https://rubygems.org"

ruby "2.4.1"

gem "active_link_to"
gem "autoprefixer-rails"
gem "cancancan"
gem "clearance"
gem "jquery-rails"
gem "jbuilder"
gem "carrierwave"
gem "fog-aws"
gem "normalize-rails", "~> 3.0.0"
gem "pg"
gem "puma"
gem "rack-canonical-host"
gem "rails", "~> 5.1.0"
gem "redcarpet"
gem "recipient_interceptor"
gem "responders"
gem "rollbar"
gem "opengraph_parser"
gem "sass-rails", "~> 5.0"
gem "slim-rails"
gem "sprockets", ">= 3.0.0"
gem "webpacker"
gem "uglifier"

group :development do
  gem "listen"
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails"
end

group :development, :staging do
  gem "rack-mini-profiler", require: false
end

group :test do
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "rack-timeout"
  gem "rails_12factor"
  gem "rails_stdout_logging"
end

gem 'high_voltage'
gem 'bourbon', '~> 5.0.0.beta.7'
gem 'neat', '~> 2.0.0.beta.1'
gem 'refills', group: [:development, :test]
