Feature: User Authentication
  As a UTRGV student, faculty, or staff
  I want to log in securely
  So that I can access lost and found features

  Scenario: Logging in with a UTRGV email
    Given I am on the login page
    When I enter my UTRGV email
    And I pass the random letter verification
    Then I should be logged in successfully

  Scenario: Logging in with an invalid email
    Given I am on the login page
    When I enter a non-UTRGV email
    Then I should see an error message

  Scenario: Logging in as a guest
    Given I am on the login page
    When I select guest login
    Then I should have limited access to the website