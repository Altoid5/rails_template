Feature: Managing Lost and Found Posts
  As a UTRGV user
  I want to edit or delete my posts
  So that I can manage my lost and found items

  Scenario: Editing a lost item post
Given I am logged in to manage my posts
    And I am viewing my lost item post
    When I click the edit button
    And I update the details
    Then my changes should be saved

  Scenario: Deleting a found item post
    Given I am logged in
    And I am viewing my found item post
    When I click the delete button
    Then my post should be removed from the system