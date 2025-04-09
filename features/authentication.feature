Feature: User Authentication
  As a UTRGV student, faculty, or staff
  I want to log in securely
  So that I can access lost and found features

Scenario: Logging in with a UTRGV email
  Given I visit the login page
  When I enter a valid UTRGV email
  And I complete the random letter verification
  Then I should be logged in and redirected to the homepage


  Scenario: Logging in as a guest
    Given I visit the login page
    When I choose to log in as a guest
    Then I should see the guest homepage with limited access