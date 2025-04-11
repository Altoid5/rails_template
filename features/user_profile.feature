Feature: User Profile Management
  As a UTRGV user
  I want to manage my profile and reports
  So that I can track my lost and found items

  Scenario: User views their profile
    Given I am logged in
    When I go to my profile

  Scenario: User edits their profile
    Given I am logged in
    When I go to the edit profile page
    And I update my contact info
    Then I should see a success message

  Scenario: User logs out
    Given I am logged in
  When I click the logout button
    Then I should be signed out and redirected to the login page