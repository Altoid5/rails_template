Feature: Reporting Lost Items
  As a UTRGV student, faculty, or staff
  I want to report a lost item
  So that I can increase the chances of finding it

  Scenario: Successfully reporting a lost item
    Given I am logged in to report a lost item
    And I am on the report lost item page
    When I fill in all required lost item details
    And I submit the lost item form
Then I should see a lost item confirmation message

Scenario: Uploading an image with a valid format
  Given I am logged in to report a lost item
  And I am on the report lost item page
  When I upload an image of the lost item
  And I submit the lost item form
Then I should see the lost item image preview in my post
