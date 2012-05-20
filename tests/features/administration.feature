Feature: Manage users & view application values
  In order to administrate the website
  As an admin
  I want to edit the users & review some application values

  Scenario: Add user account
    Given I log into the admin account
    When I go to "view_app_values_page"
    Then I should be able to add an user account

  Scenario: Change user password
      Given I log into the admin account
      When I go to "view_app_values_page"
      Then I should be able to change the user password

  Scenario: Add user
      Given I log into the admin account
      When I go to "view_app_values_page"
      Then I should be able to add an user

  Scenario: View application value
    Given I log into the admin account
    When I go to "edit_users_page"
    Then I should be able to view some important application values