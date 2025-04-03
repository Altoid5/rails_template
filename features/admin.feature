Feature: Admin Management
  As an admin
  I want to monitor and manage lost and found posts
  So that I can maintain the integrity of the platform

    Scenario: Admin views reported posts
    Given I am logged in as an admin
    When I navigate to the admin dashboard
    Then I should see a list of reported posts

  Scenario: Admin bans a user for false claims
    Given I am logged in as an admin
    And a user has multiple false reports
    When I click the "Ban User" button
    Then the user should no longer be able to log in

    Scenario: Admin restores a mistakenly deleted post
    Given I am logged in as an admin
    When I navigate to the deleted posts section
    And I select a post to restore
    Then the post should be visible again

  Scenario: Admin manually approves a high-value claim
    Given I am logged in as an admin
    And a claim for a high-value item is pending
    When I verify the claim details
    And I approve the claim
    Then the claimant should receive a confirmation