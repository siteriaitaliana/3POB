Feature: View account summary
  In order to review my last transactions
  I want to have a global view of my account's balance

  Scenario: View account details
    Given I log into my account
    When I choose to view my account details
    Then a complete list of credits, debits and balance should be showed
