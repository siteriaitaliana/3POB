Feature: Search news
  In order to search a news
  As an account holder
  I want to find some corresponding news articles

  Scenario: Simple search
    Given I log into my account
    And I go to "search_news_page"
    When I fill in "_ctl0__ctl0_Content_Main_TextBox1" with "Deposit Products"
    And I press "_ctl0__ctl0_Content_Main_Button1"
    Then I should not see "News title not found, try again" 
    #this fail cause the functionality is not implemente yet or the article ibm was not found!


