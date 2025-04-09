Feature: Guest User Restrictions
  As a guest user
  I want to be able to report lost items with limitations
  So that I can participate while maintaining security

  Scenario: Guest reports a lost item
    Given I am logged in as a guest
    When I go to the report lost item page
    And I fill out the details
    Then my report should be submitted