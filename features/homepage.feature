Feature: visit the home page
  In order to access the service
  As a user
  I should be able to view the homepage

  Scenario: view the home page
    When I view the homepage
    Then I should be able to see details about the application

  Scenario: view the current playlist
  	Given the following tracks are playing on sirius xm:
  		| track_name 	  		 | artist_name 		   | channel_number |
		| "Atlantic City" 		 | "Bruce Springsteen" | 20			    |
		| "Don't Stop Believin'" | "Journey"		   | 8				|
		| "Stupid Country Song"	 | "Billy Ray Cyrus"   | 33				|
  	When I view the homepage
  	Then I should see the following tracks on the current playlist:
  		| track_name 	  		 | artist_name 		   | channel_number |
		| "Atlantic City" 		 | "Bruce Springsteen" | 20			    |
		| "Don't Stop Believin'" | "Journey"		   | 8				|
		| "Stupid Country Song"	 | "Billy Ray Cyrus"   | 33				|
