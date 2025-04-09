Feature: Searching and Filtering Items
  As a UTRGV student, faculty, or staff  
  I want to search and filter lost and found items  
  So that I can find my lost item quickly

  Scenario: Searching for a lost item by keyword
    Given I am on the lost and found page
    When I enter an item name in the search bar
    And I click search
    Then I should see relevant results

  Scenario: Filtering lost items by category
    Given I am on the lost and found page
    When I select a category from the filter options
    And I click apply filters
    Then I should see only items in that category

  Scenario: Filtering found items by date
    Given I am on the lost and found page
    When I select a date range from the filter options
    And I click apply filters
    Then I should see only items reported within that range