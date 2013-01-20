source 'http://rubygems.org'

gem 'rails', '3.2.11'

# Postgres
gem 'pg'

gem 'nokogiri'
#gem 'httparty'
#gem 'typhoeus'

gem "thin"

# You know, for search!
#gem 'mysql2',          '0.3.12b4'
gem "thinking-sphinx", '2.0.10'#'3.0.0', :git => 'git://github.com/pat/thinking-sphinx.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem "therubyracer"
  gem 'libv8', '~> 3.11.8' # for therubyracer
  gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
  gem "twitter-bootstrap-rails"


  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  # for Rubber
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

#toolchain for testing
group :development, :test do
	gem 'rspec-rails'
end

group :development do
  gem 'guard-spork'
end

group :test do
	gem 'spork'
	gem 'cucumber-rails', require: false
	gem 'database_cleaner'
	gem 'shoulda-matchers'
	gem 'bourne'
	gem 'evergreen'
end
gem 'rubber'
gem 'open4'
gem 'gelf'
gem 'graylog2_exceptions', :git => 'git://github.com/wr0ngway/graylog2_exceptions.git'
gem 'graylog2-resque'
