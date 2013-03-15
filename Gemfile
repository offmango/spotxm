source 'http://rubygems.org'

gem 'rails', '3.2.12'

# Postgres
gem 'pg'

gem 'nokogiri'
gem 'jquery-rails'
gem "thin"

# gem 'open4'
# gem 'gelf'
# gem 'graylog2_exceptions', :git => 'git://github.com/wr0ngway/graylog2_exceptions.git'
# gem 'graylog2-resque'
# gem 'rubber'
gem 'sidekiq'
gem 'clockwork'

# You know, for search!
# gem "thinking-sphinx"#, '2.0.10'#'3.0.0', :git => 'git://github.com/pat/thinking-sphinx.git'
# gem 'mysql2' # Thinking Sphinx now requires it

gem 'sunspot_rails'
gem 'sunspot_solr'
gem 'progress_bar'
  
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'libv8', '~> 3.11.8' # for therubyracer
  gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
  gem "twitter-bootstrap-rails"
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby  # for Rubber
  gem 'uglifier', '>= 1.0.3'
end

#toolchain for testing
group :development, :test do
	gem 'rspec-rails', ">= 2.12.1"
end

group :development do
  gem 'guard-spork'
  gem 'rb-fsevent', '~> 0.9.1'
end

group :test do
	gem 'spork'
	gem 'cucumber-rails', '>= 1.3.0', require: false
	gem 'database_cleaner', ">= 0.7.1"
	gem 'shoulda-matchers'
	gem 'bourne'
	gem 'evergreen'
end