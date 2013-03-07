# SpotXM

An app to pull the now-playing data from Sirius XM and provide Spotify links for the songs.  It uses a Postgres database with Sphinx for searching.


## Solr and Sunspot notes

To start Solr:

	bundle exec rake sunspot:solr:start

...and to stop it (obviously):

	bundle exec rake sunspot:solr:stop

To reindex all object (only needed if you changes to an object's 'searchable' schema):

	bundle exec rake sunspot:solr:reindex

## Development Notes

Thinking Sphinx must be running when running the app in development. 

If you add data to your database, reindex:

	rake ts:in

Or if you make structural changes, rebuild:

	rake ts:rebuild

To start Thinking Sphinx:

    rake ts:start

To stop TS (obviously):

    rake ts:stop

To get TS working properly with Cucumber, I created a sphinx.rb file in features/support and added the following:

	require 'cucumber/thinking_sphinx/external_world'
	Cucumber::ThinkingSphinx::ExternalWorld.new
	ThinkingSphinx::Test.start_with_autostop

	Before do
		DatabaseCleaner.start
	end

	After do |scenario|
		DatabaseCleaner.clean
	end

In this situation, Database cleaner is running before and after every scenario.  If you wanted to only clean the database for tagged scenarios, you could do:

	Before('@no-txn') do
		DatabaseCleaner.start
	end

	After('@no-txn') do
		DatabaseCleaner.clean
	end

Scenarios that use TS are tagged @no-txn to turns transactional features off FOR THOSE TESTS ONLY.  If you wanted to turn them off globally, you could add this to your features/support/env.rb

	Cucumber::Rails::World.use_transactional_fixtures = false

There's also a step , "Given the [model] indexes are processed" which needs to be run before a feature that uses TS to, well, process the indexes for that model (duh).  This could always be changed to just process all indexes like so:

	Given /^the indexes are processed$/ do
		puts "Processing indexes"
		ThinkingSphinx::Test.index
		sleep(1.00) # Wait for Sphinx to catch up
	end

But it's probably faster (by a tiny bit) to just process the index that you need to process.

Also, maybe because I'm using Postgres with Database Cleaner, I had to set this in env.rb:

	DatabaseCleaner.strategy = :truncation

Note that's *:truncation* and not *:transaction*.  It took me ages to figure out why my TS searches were returning no results, and that was apparently it.



## Outstanding Issues / To Dos

* The timestamp call is currently not working from Heroku (and occasionally from local).  Not sure why.  For better testing, create a test page for doing the timestamp to see what's coming back
* Links to Echo Nest?

* Fix timestamp call to account for daylight savings
