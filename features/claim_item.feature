Feature: Claiming Found Items
  As a UTRGV student, faculty, or staff
  I want to claim a found item
  So that I can retrieve what belongs to me

  Scenario: Successfully claiming an item
  Given I am logged in to claim a found item
    And I am on a found item page
    When I click the claim button
    And I provide proof of ownership
    Then my claim should be submitted for approval