Feature: User can sort film list by Release Date

Scenario: Sort by Release Date
  Given I am on the RottenPotatoes home page
  When I follow "Release Date"
  Then I should be on the RottenPotatoes home page
