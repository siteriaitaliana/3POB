3POB 
====
Task #1
====
#Installation instructions (tested on MacOsX):
1. sudo easy_install pip
2. pip install lettuce
3. pip install lettuce_webdriver
4. pip install selenium
5. pip install nose
6. git clone git@github.com:siteriaitaliana/3POB.git 3pob

#How to run the tests:
* cd 3pob/tests && lettuce

#Logging, report facilities:
* For every failed test a screenshot is taken in the tests/out folder
* A complete log file is generated in the tests/out folder

#Improvement suggestions:
* Switch the test framework from lettuce to behave, for these reasons http://packages.python.org/behave/comparison.html

Bugs report
=== 
https://docs.google.com/spreadsheet/ccc?key=0An68HjlWm9fedEdqSHhTM0ZZaE9GdlgzdFFoZ0xqZlE

Task #2
====
* username: "bamboo83"

Task #3
====
#Usage instructions:
* Detailed instruction on how execute the rake tasks can be found in the tests/Rakefile.rb block comment.

#Improvement suggestions:
* Refactor the code by creating the classic activerecord model layout with 3 model classes for each table eventually containing some custom methods.
With those classes in place all the active record helper methods can be used on their corresponding AR objects making a lot simpler to query the table in various ways.

Bugs & Improvements report
=== 
https://docs.google.com/spreadsheet/ccc?key=0An68HjlWm9fedEdqSHhTM0ZZaE9GdlgzdFFoZ0xqZlE




