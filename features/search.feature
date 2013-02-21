Feature: Search
	In order to find what is playing on Sirius XM
	As a user
	I should be able to search for what's playing

	Scenario: Search Sirius XM by channel number
		Given the following channels are in the database:
			| channel_number | channel_name     |
      		| 20             | "E Street Radio" |
			And the following tracks are in the database:
 	    		| track_name 	  | artist_name 		| album_name           			 | channel_number |
		  		| "Atlantic City" | "Bruce Springsteen" | "Darkness on the Edge of Town" | 20             |
		  		| "Ramrod"		  | "Bruce Springsteen" | "The River"					 | 20 			  |
		When I view the homepage
			And I search for the channel number "20"
		Then I should see a playlist for channel "20" with the following tracks:
			| track_name 	  | artist_name 		| album_name 					 |
			| "Atlantic City" | "Bruce Springsteen" | "Darkness on the Edge of Town" |
			| "Ramrod"		  | "Bruce Springsteen" | "The River"					 | 

	@search
	Scenario: Search tracks by track name, album name, or artist name
		Given the following channels are in the database:
			| channel_number | channel_name     	  |
      		| 20             | "E Street Radio" 	  |
      		| 3				 | "Neil Diamond Radio"   |
      		| 7				 | "Grungy Grunge Grunge" |
      		| 13			 | "Totally Country"      |
			And the following tracks are in the database:
				| track_name 	  			  | artist_name 		| album_name           			 | channel_number |
		  		| "Atlantic City" 			  | "Bruce Springsteen" | "Darkness on the Edge of Town" | 20             |
		  		| "Rockin' (with Neil Young)" | "Bruce Springsteen" | 								 | 20 			  |
		  		| "Old Man"					  | "Neil Young"		| "Live at Massey Hall"			 | 7			  |
		  		| "Hey Hey (My My)"			  | "Crazy Horse"		| "Neil Young's Greatest Hits"   | 7              |
		  		| "Sweet Caroline"			  | "The White Stripes" | 								 | 3 			  |
 
		When I view the homepage
			And I search tracks for "neil"

		Then I should see a list of the following tracks:
			| track_name 	  			  | artist_name 		| album_name           			 | channel_number |
		  	| "Rockin' (with Neil Young)" | "Bruce Springsteen" | 								 | 20 			  |
		  	| "Old Man"					  | "Neil Young"		| "Live at Massey Hall"			 | 7			  |
		  	| "Hey Hey (My My)"			  | "Crazy Horse"		| "Neil Young's Greatest Hits"   | 7              |
