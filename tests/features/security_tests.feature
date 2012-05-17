Feature: Test security
  In order to avoid security flaws
  we need to trigger the most important sanity checks

  Scenario: Sql Injection
    Given I go to "homepage"
    When I try the most simple sql injection attack
    Then I should see "Login Failed: We're sorry, but this username was not found in our system.  Please try again." 
    And I should not see "MY ACCOUNT"
	# this fails cause the website is not secure!


