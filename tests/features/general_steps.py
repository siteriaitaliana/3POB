from lettuce import step
from lettuce.registry import world

pages = {
    "homepage"  : "http://demo.testfire.net/bank/login.aspx",
    "view_account_summary_page" : "http://demo.testfire.net/bank/main.aspx",
    "view_recent_transactions_page" : "http://demo.testfire.net/bank/transaction.aspx",
    "transfer_funds_page" : "http://demo.testfire.net/bank/transfer.aspx",
    "search_news_page" : "http://demo.testfire.net/bank/queryxpath.aspx",
    "customize_language_page" : "http://demo.testfire.net/bank/customize.aspx",
    "view_app_values_page" : "http://demo.testfire.net/admin/application.aspx",
    "edit_users_page" : "http://demo.testfire.net/admin/admin.aspx"
}

@step('I go to "(.*)"')
def given_i_go_to(step, page_name):
    url = pages[page_name]
    world.browser.get(url)

@step('I log into my account')
def when_i_log_into_my_account(step):
    step.given('I go to "homepage"')
    step.given('I fill in "uid" with "jsmith"')
    step.given('I fill in "passw" with "Demo1234"')
    world.browser.find_element_by_name("btnSubmit").click()

@step('I log into the admin account')
def when_i_log_into_the_admin_account(step):
    step.given('I fill in "uid" with "\' or \'1=1"')
    step.given('I fill in "passw" with "\' or \'1=1"')
    world.browser.find_element_by_name("btnSubmit").click()