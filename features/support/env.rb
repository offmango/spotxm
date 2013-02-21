require 'rubygems'
require 'spork'


Spork.prefork do
	require 'cucumber/rails'
	require 'capybara/rspec'
	Capybara.default_selector = :css
	ActionController::Base.allow_rescue = false

	# For Database Cleaner
	require 'database_cleaner'
	require 'database_cleaner/cucumber'
	DatabaseCleaner.strategy = :truncation

	# To fix an issue with Spork not releasing its connection to the test DB,
	# which causes rake to fail when Guard is running.
	# See https://github.com/sporkrb/spork/issues/188
	p "Done setting up. Closing DB connections in test"
	ActiveRecord::Base.remove_connection

	$original_sunspot_session = Sunspot.session

end

Spork.each_run do
	Before do
  		DatabaseCleaner.start
  		puts "Cleaning the ol' database!"
		DatabaseCleaner.clean
	end

	After do
  		#DatabaseCleaner.clean
	end

end





