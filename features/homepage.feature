Feature: visit the home page
  In order to access the service
  As a user
  I should be able to view the homepage

 # Scenario: view the home page
 #   When I view the homepage
 #   Then I should be able to see details about the application

  Scenario: view the current playlist

    Given the following channels are in the database:
      | channel_number | channel_name            |
      | 8              | "Totally 80's"          |
      | 20             | "E Street Radio"        |
      | 33             | "Country Bumpkin Radio" |

  	And the following tracks are the most recently played on sirius xm:
 	    | track_name 	  		     | artist_name 		     | album_name           				  | channel_number |
		  | "Atlantic City" 		   | "Bruce Springsteen" | "Darkness on the Edge of Town" | 20             |
		  | "Don't Stop Believin'" | "Journey"		       | "Journey's Greatist Hits" 	    | 8              |
		  | "Stupid Country Song"	 | "Billy Ray Cyrus"   | "Stupid Country Album"    	    | 33             |

 	  When I view the homepage
  	
    Then I should see information on the following tracks:
      | track_name 	  		     | artist_name 		     | channel_number | channel_name 			      | album_name  				           | 
      | "Don't Stop Believin'" | "Journey"           | 8              | "Totally 80's"          | "Journey's Greatist Hits"      |
		  | "Atlantic City" 		   | "Bruce Springsteen" | 20			        | "E Street Radio" 		    | "Darkness on the Edge of Town" |
		  | "Stupid Country Song"	 | "Billy Ray Cyrus"   | 33				      | "Country Bumpkin Radio" | "Stupid Country Album"    	   |
