Feature: User Profile Management
  As a UTRGV user
  I want to manage my profile and reports
  So that I can track my lost and found items

  Scenario: User updates contact information
    Given I am logged in
    When I navigate to my profile page
    And I update my contact details
    Then my changes should be saved

  Scenario: User views lost and found report history
    Given I am logged in
    When I go to my profile
    Then I should see a list of my previous lost and found reports

  Scenario: User deactivates their account
    Given I am logged in
    When I choose to deactivate my account
    And I confirm the action
    Then my account should be deactivated