Feature: Login & security tests
  In order to avoid security flaws and be sure the login works
  I want to login, execute some sanity checks and input validations 
  
  Scenario: Account Login
    Given I go to "homepage"
    And I log into my account 
    Then I should be logged in
  
  Scenario Outline: Login form validations
    Given I go to "homepage"
    When I enter "<username>"
    And "<password>"
    Then the error message should be "<validation>"
  Examples:
    | username | password | validation                    |
    |          |          |You must enter a valid username|
    |          |Demo1234  |You must enter a valid username|
    |Jsmith    |          |You must enter a valid password|
    |invalid   |invalid   |Login Failed: We're sorry, but this username was not found in our system.  Please try again.|

  Scenario: Sql Injection
    Given I go to "homepage"
    When I try the most simple sql injection attack
    Then I should see "Login Failed: We're sorry, but this username was not found in our system.  Please try again." 
    And I should not see "MY ACCOUNT"
	# this fails cause the website is not secure!


