Feature: View account summary
  In order to review my last transactions
  I want to have a global view of my account's balance

  Scenario: View account details
    Given I log into my account
    When I choose to view my account details
    Then a complete list of credits, debits and balance should be showed
 
 ### TODO: repeat the above scenario for the other available account
 
  Scenario: Altoro Gold Visa
    Given I log into my account
    When I chose to view my account details
    And I apply for an Altoro Gold Visa
    Then a message "Your new Altoro Mutual Gold VISA with a $10000 and 7.9% APR will be sent in the mail." pops out
    And an email is sent to me
    #the email sending can be tested using a support script that read email from the gmail ui
    #or reading the email sent db table

   Scenario: Change language
      Given I log into my account
      When I go to "customize_language_page"
      And I choose a different language from english
      Then the corresponding language should be applied to the pages

    
       