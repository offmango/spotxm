Feature: visit the home page
  In order to access the service
  As a user
  I should be able to view the homepage

  Scenario: view the current playlist

 	  When I view the homepage
  	
    Then I should see details about the application
    
      And I should see be able to search for tracks and channels