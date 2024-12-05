sidebar = "//nav[@class='navbar navbar-default sidebar__container']"

#links
download_report_link = "//a[@href='/download-report']"
bulk_update_link = "//a[@href='/cms']"

#locators with specific values
report_type_airline_sales = "//input[@value='Airline Sales']"

# buttons
search_button = "//button[text()='Search']"
submit_button = "//button[text()='Submit']"
save_for_later_button = "//button[normalize-space()='Save For Later']"
exclude_button = "//button[normalize-space()='Exclude']"

# fields
report_type_field = "//input[@class='form__field__select-box']"
booking_transaction_dropdown = "//span[@class='select-box-list__item__text' and text()='Booking Transaction']"
airline_transaction_dropdown = "//span[@class='select-box-list__item__text' and text()='Airline transaction']"
daily_sales_report_dropdown = "//span[@class='select-box-list__item__text' and text()='Daily sales report']"
report_type_dropdown = "//span[@class='select-box-list__item__text' and text()='Report_Type']"

from_departure= '//input[@name="departedOnAfterDate"]'
to_departure='//input[@name="departedOnBeforeDate"]'
from_booking='//input[@name="bookedOnAfterDateTime"]'
to_booking='//input[@name="bookedOnBeforeDateTime"]'

user_roles="//div[text()='User Roles']"
agent="//div[text()='AGENT']"
corporate="//div[text()='CORPORATE']"

# select_rows = "//label[text()='select Rows']"
select_rows= "//input[@id='airlineRows']"
all_rows= "//span[text()='All']"

# airline_codes = "//div[text()='Airline Codes']"
airline_codes="//div[contains(text(),'Airline Codes')]/following-sibling::div/descendant::input"

user_id_field = '//input[@name="userIds"]'
exclusion_fields = '//div[@class="inner_box exclusion"]/ul/li'
inclusion_fields = '//div[@class="inner_box inclusion"]/ul/li'
