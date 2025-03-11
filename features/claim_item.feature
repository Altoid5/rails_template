Feature: Claiming Found Items
  As a UTRGV student, faculty, or staff
  I want to claim a found item
  So that I can retrieve what belongs to me

  Scenario: Successfully claiming an item
    Given I am logged in as a UTRGV user
    And I am on a found item page
    When I click the claim button
    And I provide proof of ownership
    Then my claim should be submitted for approval

  Scenario: Attempting to claim an item without proof
    Given I am logged in as a UTRGV user
    And I am on a found item page
    When I click the claim button
    And I submit the claim without proof
    Then I should see an error message

  Scenario: Claim rejected due to insufficient verification
    Given I submitted a claim for a found item
    When my proof of ownership is not sufficient
    Then my claim should be rejected
    And I should receive a rejection notification