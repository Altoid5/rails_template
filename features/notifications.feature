Feature: Notifications for Lost and Found Items
  As a UTRGV user
  I want to receive notifications about my lost or found items
  So that I stay updated on my item's status

  Scenario: Receiving a notification for a matching found item
    Given I have reported a lost item
    When a similar item is found
    Then I should receive a notification

  Scenario: Receiving a notification for a claim approval
    Given I have submitted a claim for a found item
    When my claim is approved
    Then I should receive a notification