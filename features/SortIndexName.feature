Feature: User can sort film list by name

Scenario: Sort films by name
  Given I am on the RottenPotatoes home page
  When I follow "Movie Title"
  Then I should be on the Add New Movie page
	And I should see "Chicken Run" above "The Incredibles"
