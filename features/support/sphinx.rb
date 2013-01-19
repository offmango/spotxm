# For Thinking Sphinx
require 'cucumber/thinking_sphinx/external_world'
Cucumber::ThinkingSphinx::ExternalWorld.new
ThinkingSphinx::Test.start_with_autostop


Before('@no-txn') do
	DatabaseCleaner.start
end

After('@no-txn') do
	DatabaseCleaner.clean
end