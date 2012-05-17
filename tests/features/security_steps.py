from lettuce import step

@step('When I try the most simple sql injection attack')
def when_i_try_the_most_simple_sql_injection_attack(step):
  step.given('I log into the admin account')

