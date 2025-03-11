Feature: Reporting Lost Items
  As a UTRGV student, faculty, or staff
  I want to report a lost item
  So that I can increase the chances of finding it

  Scenario: Successfully reporting a lost item
    Given I am logged in as a UTRGV user
    And I am on the report lost item page
    When I fill in all required lost item details
    And I submit the form
    Then I should see a confirmation message

  Scenario: Attempting to report a lost item with missing details
    Given I am logged in as a UTRGV user
    And I am on the report lost item page
    When I leave required fields blank
    And I submit the form
    Then I should see an error message

  Scenario: Uploading an image with a valid format
    Given I am logged in as a UTRGV user
    And I am on the report lost item page
    When I upload an image of the lost item
    And I submit the form
    Then I should see the image preview in my post

  Scenario: Uploading an image with an invalid format
    Given I am logged in as a UTRGV user
    And I am on the report lost item page
    When I upload a non-image file
    And I submit the form
    Then I should see an error message