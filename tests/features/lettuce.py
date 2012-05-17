import os
from lettuce import *
from selenium import webdriver
import lettuce_webdriver.webdriver

@before.all
def setup_browser():
  world.browser = webdriver.Firefox()

@after.each_scenario
def get_screenshot(scenario):
	path = os.path.join(os.path.dirname(__file__), '/out')
	"""makes a directory, does nothing if dir exists"""
	if not os.access(path, os.F_OK):
 		os.makedirs(path)
 		
	if scenario.passed == False:
		world.browser.get_screenshot_as_file(path + '/' +scenario.name )
		print "Saved screenshot in '%s.jpg'" % (path + '/' +scenario.name )

@after.all
def teardown_browser(total):
  world.browser.quit()
  print "Firefox terminated"
