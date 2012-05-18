import os, sys
from lettuce import *
from selenium import webdriver
import lettuce_webdriver.webdriver

@before.all
def setup_browser():
  world.browser = webdriver.Firefox()
  world.path = os.path.join(os.getcwd(),'out')
  if not os.access(world.path, os.F_OK):
	os.makedirs(world.path)
  else:
    for file in os.listdir(world.path):
      os.unlink(os.path.join(world.path, file))
    			
@after.each_scenario
def get_screenshot(scenario):	
	if scenario.passed == False:
		world.browser.get_screenshot_as_file(world.path + '/' +scenario.name )
		print "Saved screenshot in '%s.jpg'" % (world.path + '/' +scenario.name )

@after.all
def teardown_browser(total):
  world.browser.quit()
  print "Firefox terminated"
