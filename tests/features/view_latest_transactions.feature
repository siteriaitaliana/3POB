Feature: View Recent Transactions
  In order to have the situation under control
  I want to review my last recent transactions
  
  Scenario: View latest transactions
    Given I log into my account
    When I go to "view_recent_transactions_page"
    Then I should see all the latest transactions
  
  Scenario: Filter latest transactions by date
    Given I log into my account
    When I go to "view_recent_transactions_page"
    And I choose a date range
    Then the transactions showed should be within the selected range
  
  Scenario: Pagination test
    Given I log into my account
    When I go to "view_recent_transactions_page"
    And the table has a pagination
    And I select to go in the 2 table page
    Then the transactions table should show the 2nd page items