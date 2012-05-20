import os, sys
from lettuce import *
from selenium import webdriver
import lettuce_webdriver.webdriver
import logging

failed_scenarios = []
scenarios_and_its_fails = {}
scenarios_and_its_failing_step= {}

def wrt(string):
  world.log.info(string.encode('utf-8'))

@before.all
def setup_browser():
  #create/clean folder for test's screenshot and logger
  world.path = os.path.join(os.getcwd(),'out')  
  if not os.access(world.path, os.F_OK):
	os.makedirs(world.path)
  else:
    for file in os.listdir(world.path):
      os.unlink(os.path.join(world.path, file))                  
  
  #instantiate logger for debug, test info, lettuce results and webdriver logging   
  logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(name)-12s %(levelname)-8s %(message)s',
                    datefmt='%m-%d %H:%M:%S',
                    filename=world.path+'/myapp.log',
                    filemode='w')  
  world.log = logging.getLogger('*** LETTUCE-TESTS ***')
  world.log.info('Test framework initialization')
  #instantiate webdriver firefox browser client   
  world.browser = webdriver.Firefox()
  world.log.info('Firefox started')
    
@after.each_step
def save_step_failed(step):
    if step.failed and step.scenario not in failed_scenarios:
        scenarios_and_its_failing_step[step.scenario] =  step.scenario.name + '\' in step: \'' + step.sentence
        scenarios_and_its_fails[step.scenario] = step.why
       
        failed_scenarios.append(step.scenario)
    			
@after.each_scenario
def get_screenshot(scenario):
  #take screenshot	
  if scenario.passed == False:
    world.browser.get_screenshot_as_file(world.path + '/' +scenario.name )
    world.log.info("Saved screenshot in '%s'" % (world.path + '/' +scenario.name + '.jpg'))
    reason = scenarios_and_its_fails[scenario] 

@after.all
def print_end(total):
    if total.scenarios_passed < total.scenarios_ran:
        print  # just a line to separate things here
        for scenario in failed_scenarios:
            reason = scenarios_and_its_fails[scenario]
            step = scenarios_and_its_failing_step[scenario]
            wrt("Scenario failed: '" + step +'\' for the following reason:')
            wrt(reason.traceback)

    wrt("\n")
    word = total.features_ran > 1 and "features" or "feature"
    wrt("%d %s (%d passed)\n" % (
        total.features_ran,
        word,
        total.features_passed))

    word = total.scenarios_ran > 1 and "scenarios" or "scenario"
    wrt("%d %s (%d passed)\n" % (
        total.scenarios_ran,
        word,
        total.scenarios_passed))

    steps_details = []
    for kind in "failed", "skipped", "undefined":
        attr = 'steps_%s' % kind
        stotal = getattr(total, attr)
        if stotal:
            steps_details.append("%d %s" % (stotal, kind))

    steps_details.append("%d passed" % total.steps_passed)
    word = total.steps > 1 and "steps" or "step"
    wrt("%d %s (%s)\n" % (total.steps, word, ", ".join(steps_details)))
    
    world.browser.quit() 
    world.log.info('Firefox Terminated.')

def print_no_features_found(where):
    where = core.fs.relpath(where)
    if not where.startswith(os.sep):
        where = '.%s%s' % (os.sep, where)

    wrt('Oops!\n')
    wrt('could not find features at %s\n' % where)
    
  
