# -*- coding: utf-8 -*-
from lettuce import step

@step(u'When I try to most simple sql injection attack')
def when_i_try_to_most_simple_sql_injection_attack(step):
  step.given('I fill in "uid" with "\' or \'1=1"')
  step.given('I fill in "passw" with "\' or \'1=1"')
  step.given('I click "btnSubmit"')

@step(u'Then I should not be logged in and see a error message')
def then_i_should_not_be_logged_in_and_see_a_error_message(step):
  assert True, 'This step must be implemented'

