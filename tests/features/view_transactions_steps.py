from lettuce import step
from lettuce.registry import world
from selenium.common.exceptions import NoSuchElementException
from nose.tools import *

@step('Then I should see all the latest transactions')
def then_i_should_see_all_the_latest_transactions(step):
    assert_true(world.browser.find_element_by_id("_ctl0__ctl0_Content_Main_MyTransactions").is_displayed())

@step('And I choose a date range')
def and_i_choose_a_date_range(step):
    step.given('I fill in "after" with "01/05/2005"')
    step.given('I fill in "before" with "01/06/2006"')
    step.given('I press "Submit"')

@step('Then the transactions showed should be within the selected range')
def then_the_transactions_showed_should_be_within_the_selected_range(step):
    try:
        world.browser.find_element_by_xpath("//table[@id='_ctl0__ctl0_Content_Main_MyTransactions']/tbody/tr/td/a[text()='6']")
    except NoSuchElementException:
        print ''
    else:
        raise StandardError

@step('And the table has a pagination')
def and_i_the_table_has_a_pagination(step):
    assert_equals(world.browser.find_element_by_xpath("//table[@id='_ctl0__ctl0_Content_Main_MyTransactions']/tbody/tr/td/a").text, '2')

@step('And I select to go in the 2 table page')
def and_i_select_to_go_in_the_2_table_page(step):
    world.browser.find_element_by_xpath("//table[@id='_ctl0__ctl0_Content_Main_MyTransactions']/tbody/tr/td/a[text()='2']").click()

@step('Then the transactions table should show the 2nd page items')
def then_the_transactions_table_should_show_the_2nd_page_items(step):
    assert_equals(world.browser.find_element_by_xpath("//table[@id='_ctl0__ctl0_Content_Main_MyTransactions']/tbody/tr[2]/td[1]").text, '1336')
    assert_true(world.browser.find_element_by_xpath("//span[text()='2']").is_displayed())
