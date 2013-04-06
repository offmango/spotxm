source 'http://rubygems.org'

gem 'rails', '3.2.12'

# Postgres
gem 'pg'

gem 'nokogiri'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem "thin"

gem 'sidekiq'
gem 'clockwork'
gem 'newrelic_rpm'

# You know, for search!
gem 'sunspot_rails', '~> 1.3.0'
gem 'sunspot_solr'
gem 'progress_bar'

# Pagination
gem 'kaminari'

# All the cool kids are doing it
gem 'slim'
  
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