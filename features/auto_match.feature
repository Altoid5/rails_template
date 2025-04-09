Feature: Automatic Matching System
  As a UTRGV user
  I want the system to automatically match lost and found items
  So that I don’t have to manually search for my lost belongings

  Scenario: System suggests a match for a lost item
    Given a new found item is reported
    And its details match a lost item
    When the system runs an auto-match check
    Then the user who lost the item should receive a notification