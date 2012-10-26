source 'https://rubygems.org'

gem 'rails', '3.2.6'
#gem 'mongo_mapper', :git => 'git://github.com/jnunemaker/mongomapper.git', :ref => '4d35c6704a9'
#gem "bson_ext"

gem 'pg'

# CRON!
gem 'whenever', :require => false


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

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
