Feature: Search
	In order to find what is playing on Sirius XM
	As a user
	I should be able to search for what's playing

	Scenario: Search Sirius XM by channel name
		When I search for the channel name "siriusxmu"
		Then I should see the now playing info for the channel "siriusxmu"