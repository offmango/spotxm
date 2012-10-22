Feature: Search
	In order to find what is playing on Sirius XM
	As a user
	I should be able to search for what's playing

	Scenario: Search Sirius XM by channel number
		Given the following songs are playing on sirius xm:
			| song_name 	  | artist_name 		| channel_number |
			| "Atlantic City" | "Bruce Springsteen" | 20			 |
		When I view the homepage
		And I search for the channel number "20"
		Then I should see the now playing information for "20" for the following songs:
			| song_name 	  | artist_name 		| 
			| "Atlantic City" | "Bruce Springsteen" |