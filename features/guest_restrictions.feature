Feature: Guest User Restrictions
  As a guest user
  I want to be able to report lost items with limitations
  So that I can participate while maintaining security

  Scenario: Guest reports a lost item
    Given I am logged in as a guest
    When I go to the report lost item page
    And I fill out the details
    Then my report should be submitted

  Scenario: Guest cannot report a found item
    Given I am logged in as a guest
    When I try to access the report found item page
    Then I should see an error message

  Scenario: Guest cannot edit or delete posts
    Given I am logged in as a guest
    When I try to edit or delete a post
    Then I should see an error message

  Scenario: Guest cannot claim found items
    Given I am logged in as a guest
    When I try to claim a found item
    Then I should see an error message