Feature: Reporting Found Items  
  As a UTRGV student, faculty, or staff  
  I want to report a found item  
  So that the rightful owner can reclaim it

  Scenario: Successfully reporting a found item  
    Given I am logged in to report a found item  
    And I am on the report found item page  
    When I fill in all required found item details  
    And I submit the form  
    Then I should see a confirmation message

Scenario: Uploading an image with a valid format
  Given I am logged in to report a found item
  And I am on the report found item page
  When I upload an image of the found item
  And I submit the form
  Then I should see the image preview in my post