from lettuce import step
from lettuce.registry import world
from nose.tools import *

@step('When I choose to view my account details')
def when_i_choose_to_view_my_account_details(step):
    step.given('I press "   GO   "')
    
@step('Then a complete list of credits, debits and balance should be showed')
def then_a_complete_list_of_credits_debits_and_balance_should_be_showed(step):
    assert_equals(world.browser.find_element_by_xpath('//table/tbody/tr[1]/th').text, 'Balance Detail')
    assert_true(world.browser.find_element_by_id('_ctl0__ctl0_Content_Main_Balance1').text.isdigit)
    assert_true(world.browser.find_element_by_id('_ctl0__ctl0_Content_Main_Balance2').text.isdigit)
    step.given('I should see an element with id of "listAccounts"')
    step.given('I should see an element with id of "credits"')
    step.given('I should see an element with id of "debits"') 
    #this fails 'cause the id selector here is wrong and furthermore allowed to discover that the table is not properly showed!
	
  
	

