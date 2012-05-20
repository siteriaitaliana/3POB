Feature: Transfer fund
  In order to transfer money
  I want to move a sum between my accounts

  Scenario: Happy path
    Given I log into my account
    When I go to "transfer_funds_page"
    And I move "$100" from my checkings account to my savings account
    Then I should see the message "$100 was successfully transferred from Account 1001160140 into Account 1001160140"
    And the recent transaction table should display the transaction

  Scenario: Move money in same account
    Given I log into my account
    When I go to "transfer_funds_page"
    And I move "$100" from my checkings account to my checkings account
    Then I should not see the message "$100 was successfully transferred from Account 1001160140 into Account 1001160140"
    And the recent transaction table should not display the transaction
