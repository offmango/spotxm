Feature: Search
	In order to find what has played on Sirius XM
	As a user
	I should be able to search for channels and tracks by channel name, channel number, track name, album name, and artist name

	@search
	Scenario: Search Sirius XM channels and tracks by number

		Given the following channels are in the database:
			| channel_number | channel_name     		  | description 													|
      		| 20             | "E Street Radio" 		  | "Playing Bruce, because we love Bruce." 						|
      		| 22             | "All Country All the Time" | "Need a song to shoot your dog by?  You're in the right place." |
      		| 200			 | "Nascar Racing"			  | "Watch cars drive in circles REALLY FAST"						|

			And the following tracks are in the database:
 	    		| track_name 	  | artist_name 		| album_name           			 | channel_number |
		  		| "Atlantic City" | "Bruce Springsteen" | "Darkness on the Edge of Town" | 20             |
		  		| "Ramrod"		  | "Bruce Springsteen" | "The River"					 | 20 			  |
				| "My Dog"		  | "Garth Brooks"		| "Songs for My Dog"			 | 22			  |
				| "This is 20"	  | "The Tweenies"		| "What Am I Doing?"			 | 14			  |
				| "Some Song"     | "20 Degrees"    	| "Our New Album"				 | 33			  |
				| "It's a Hit"	  | "The Boy Band"		| "Our 20 Least Offensive Songs" | 13    		  |

		When I view the homepage

			And I search for "20"
		
		Then I should see a list of the following channels:
			| channel_number | channel_name     		  | description 							|
      		| 20             | "E Street Radio" 		  | "Playing Bruce, because we love Bruce."	|

			And I should see a list of the following tracks:
				| track_name 	  | artist_name 		| album_name 					 |
				| "This is 20"	  | "The Tweenies"		| "What Am I Doing?"			 |
				| "Some Song"     | "20 Degrees"    	| "Our New Album"				 | 
				| "It's a Hit"	  | "The Boy Band"		| "Our 20 Least Offensive Songs" |

	@search
	Scenario: Search channels and tracks by track name, album name, or artist name
		Given the following channels are in the database:
			| channel_number | channel_name     	  | description								|
      		| 20             | "E Street Radio" 	  | "Playing Bruce, because we love Bruce"	|
      		| 3				 | "Neil Diamond Radio"   | "You know you love Neil Diamond"		|
      		| 7				 | "Grungy Grunge Grunge" | "GRUNGE GRUNGE GRUNGE GRUNGE GRUNGE"	|
      		| 13			 | "Totally Country"      | "Yee-haw!  It's TOTALLY COUNTRY!"		|

			And the following tracks are in the database:
				| track_name 	  			  | artist_name 		| album_name           			 | channel_number |
		  		| "Atlantic City" 			  | "Bruce Springsteen" | "Darkness on the Edge of Town" | 20             |
		  		| "Rockin' (with Neil Young)" | "Bruce Springsteen" | 								 | 20 			  |
		  		| "Old Man"					  | "Neil Young"		| "Live at Massey Hall"			 | 7			  |
		  		| "Hey Hey (My My)"			  | "Crazy Horse"		| "Neil Young's Greatest Hits"   | 7              |
		  		| "Sweet Caroline"			  | "The White Stripes" | 								 | 3 			  |
 
		When I view the homepage

			And I search for "neil"

		Then I should see a list of the following tracks:
			| track_name 	  			  | artist_name 		| album_name           			 | channel_number |
		  	| "Rockin' (with Neil Young)" | "Bruce Springsteen" | 								 | 20 			  |
		  	| "Old Man"					  | "Neil Young"		| "Live at Massey Hall"			 | 7			  |
		  	| "Hey Hey (My My)"			  | "Crazy Horse"		| "Neil Young's Greatest Hits"   | 7              |

		  	And I should see a list of the following channels:
			| channel_number | channel_name     		  | description 					 |
			| 3				 | "Neil Diamond Radio"   	  | "You know you love Neil Diamond" |		

