Feature: Track Pagination
	In order to browse the list of tracks played on a channel
	As a user
	I should be able to go through pages of tracks

	Scenario: See pagination links if there are multiple pages of tracks
		Given there are "30" tracks in the database for channel "7"
		When I view the page for channel "7"
		Then I should see pagination links

	Scenario: Do not see pagination links if there is only one page of results
		Given there are "25" tracks in the database for channel "7"
		When I view the page for channel "7"
		Then I should not see pagination links
