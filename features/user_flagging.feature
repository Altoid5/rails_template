Feature: User Flagging System  
  As an admin  
  I want to flag users who submit too many reports  
  So that I can prevent abuse of the system  

Scenario: A user gets flagged after submitting many reports
  Given a user has submitted many reports
  When the report count exceeds the limit
  Then their account should be flagged
  And they should receive a warning notification
  
  Scenario: Admin views flagged users  
    Given I am logged in as an admin  
    And flagged users exist  
    When I go to the flagged users list  
    Then I should see a list of all flagged users  

  Scenario: Admin disables a flagged user account  
    Given I am logged in as an admin  
    And a user is flagged for excessive reports  
    When I choose to ban the user  
    Then the user’s account should be disabled  

  Scenario: Flagged user sees warning on profile  
    Given I am logged in as a flagged user  
    When I go to my profile  
    Then I should see a flagged warning message  
