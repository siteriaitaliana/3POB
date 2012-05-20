from lettuce import step
from lettuce.registry import world
from nose.tools import *

@step('When I try the most simple sql injection attack')
def when_i_try_the_most_simple_sql_injection_attack(step):
  step.given('I log into the admin account')

@step('Then I should be logged in')
def when_i_try_the_most_simple_sql_injection_attack(step):  
  assert_equals(world.browser.find_element_by_css_selector('h1').text, 'Hello John Smith')

@step(u'When I enter "([^"]*)"')
def when_i_enter_group1(step, username):
    assert False, 'This step must be implemented'
    
@step(u'And "([^"]*)"')
def and_group1(step, password):
    assert False, 'This step must be implemented'
    
@step(u'Then the error message should be "([^"]*)"')
def then_the_error_message_should_be_group1(step, group1):
    assert False, 'This step must be implemented'
    


  
   
  
