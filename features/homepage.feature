Feature: visit the home page
  In order to access the service
  As a user
  I should be able to view the homepage

  Scenario: view the home page
    When I view the homepage
    Then I should be able to see details about the application

  Scenario: view the current playlist
  	Given the following tracks are playing on sirius xm:
 		| track_name 	  		 | artist_name 		   | channel_number | channel_name 			  | album_name  				   |
		| "Atlantic City" 		 | "Bruce Springsteen" | 20			    | "E Street Radio" 		  | "Darkness on the Edge of Town" |
		| "Don't Stop Believin'" | "Journey"		   | 8				| "Totally 80's"   		  | "Journey's Greatist Hits" 	   |
		| "Stupid Country Song"	 | "Billy Ray Cyrus"   | 33				| "Country Bumpkin Radio" | "Stupid Country Album"    	   |

 	When I view the homepage
  	Then I should see the following tracks on the current playlist:
  		| track_name 	  		 | artist_name 		   | channel_number | channel_name 			  | album_name  				   |
		| "Atlantic City" 		 | "Bruce Springsteen" | 20			    | "E Street Radio" 		  | "Darkness on the Edge of Town" |
		| "Don't Stop Believin'" | "Journey"		   | 8				| "Totally 80's"   		  | "Journey's Greatist Hits" 	   |
		| "Stupid Country Song"	 | "Billy Ray Cyrus"   | 33				| "Country Bumpkin Radio" | "Stupid Country Album"    	   |
