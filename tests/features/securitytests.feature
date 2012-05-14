Feature: Test security
  In order to avoid security flaws
  we need to trigger the most important sanity checks

  Scenario: Sql Injection
    Give I go to "http://demo.testfire.net/bank/login.aspx"
    When I try to most simple sql injection attack
    Then I should not be logged in and see a error message


