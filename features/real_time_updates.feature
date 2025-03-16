Feature: Real-Time Multi-User Support
  As a UTRGV user
  I want to see updates on lost and found items in real-time
  So that I can know when items are found or claimed

  Scenario: A new lost item appears in real-time
    Given I am viewing the lost and found page
    And another user reports a lost item
    Then I should see the new lost item appear without refreshing

  Scenario: A found item is claimed and disappears in real-time
    Given I am viewing the found items list
    And another user successfully claims an item
    Then the claimed item should disappear from my screen without refreshing

  Scenario: A notification is sent when a match is found
    Given I have reported a lost item
    And another user finds an item that matches my report
    When the system detects a match
    Then I should receive a real-time notification

  Scenario: Seeing how many users are viewing the same item
    Given I am viewing a lost item page
    When another user is also viewing the same page
    Then I should see a "Currently Viewing: 2 users" indicator