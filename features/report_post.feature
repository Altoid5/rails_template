Feature: Reporting Suspicious Posts
  As a UTRGV user  
  I want to report false or suspicious lost and found posts  
  So that the website remains trustworthy

  Scenario: Reporting a false lost item post
    Given I am on a lost item page
    When I click the report button
    And I select "False Claim"
    Then the post should be flagged for admin review

  Scenario: Reporting inappropriate content
    Given I am on a found item page
    When I click the report button
    And I select "Inappropriate Content"
    Then the post should be flagged for admin review