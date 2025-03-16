Feature: User Flagging System
  As an admin
  I want to flag users who submit too many reports
  So that I can prevent abuse of the system

  Scenario: A user submits multiple false reports and gets flagged
    Given a user has submitted multiple false reports
    When they reach the report limit
    Then their account should be flagged
    And they should receive a warning notification

  Scenario: Admin reviews flagged users
    Given I am logged in as an admin
    And there are flagged users in the system
    When I navigate to the flagged users list
    Then I should see all flagged users

  Scenario: Admin bans a flagged user
    Given I am logged in as an admin
    And a flagged user has continued submitting false reports
    When I click "Ban User"
    Then their account should be disabled

  Scenario: User sees a warning after getting flagged
    Given I am logged in as a flagged user
    When I visit my profile page
    Then I should see a warning message about my flagged status