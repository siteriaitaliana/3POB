from lettuce import step
from lettuce.registry import world
from nose.tools import *

@step(u'When I choose to view my account details')
def when_i_choose_to_view_my_account_details(step):
    step.given('I press "   GO   "')
    
@step(u'Then a complete list of credits, debits and balance should be showed')
def then_a_complete_list_of_credits_debits_and_balance_should_be_showed(step):
    assert_equals(world.browser.find_element_by_xpath('//table/tbody/tr[1]/th').text, 'Balance Detail')
    assert_true(world.browser.find_element_by_id('_ctl0__ctl0_Content_Main_Balance1').text.isdigit)
    assert_true(world.browser.find_element_by_id('_ctl0__ctl0_Content_Main_Balance2').text.isdigit)
	try:
    	world.browser.find_element_by_css("select#listAccounts")
	except Exception, err:
		print "Select account drop down not found!"
	try:
    	world.browser.find_element_by_id("credits")
	except Exception, err:
		print "Select account drop down not found!"
	try:
    	world.browser.find_element_by_id("debits") #this fails cause the id selector here is wrong!
	except Exception, err:
		print "Select account drop down not found!"
 
    
  
	

