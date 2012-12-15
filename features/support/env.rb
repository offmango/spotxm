require 'rubygems'
require 'spork'


Spork.prefork do
	require 'cucumber/rails'
	require 'capybara/rspec'
	Capybara.default_selector = :css
	ActionController::Base.allow_rescue = false

	# For Thinking Sphinx
	require 'cucumber/thinking_sphinx/external_world'
	Cucumber::ThinkingSphinx::ExternalWorld.new
	Cucumber::Rails::World.use_transactional_fixtures = false

	# For Database Cleaner
	require 'database_cleaner'
	require 'database_cleaner/cucumber'
	DatabaseCleaner.strategy = :transaction

	# To fix an issue with Spork not releasing its connection to the test DB,
	# which causes rake to fail when Guard is running.
	# See https://github.com/sporkrb/spork/issues/188
	p "Done setting up. Closing DB connections in test"
	ActiveRecord::Base.remove_connection
end

Spork.each_run do

end





