manage_amendments_field = '//a[text()="Manage Amendments"]'
search_btn = '//button[normalize-space()="Search"]/i'
amendments_type = '//div[text()="Type"]'
amendments_status = '//div[text()="Status"]'
amendments_status_input = '//div[@class="search__form__section__wrapper"]//div[7]//input'
assigned_user_field = '//div[text()="Assigned User"]'
assigned_user_input = '//div[@class="search__form__section__wrapper"]//div[9]//input'
download_generation_checkbox = '//div[text()="Generation Time"]/input'
download_departure_checkbox = '//div[text()="Departure Date"]/input'
download_close_action_checkbox = '//div[text()="Closest Action Date"]/input'
generation_checkbox_text = '//div[@class="draggable"]//child::div[@class="drag_item" and contains(text(),"Generation Time")]'
departure_checkbox_text = '//div[@class="draggable"]//child::div[@class="drag_item" and contains(text(),"Departure Date")]'
close_action_checkbox_text = '//div[@class="draggable"]//child::div[@class="drag_item" and contains(text(),"Closest Action Date")]'
from_date_input = '//input[@name="createdOnAfterDateTime"]'
to_date_input = '//input[@name="createdOnBeforeDateTime"]'
to_close_icon = "//div[@class='react-datepicker__input-container']/following::button[@class='react-datepicker__close-icon']"
date_to_be_replaced = '//div[text()="replacemonth replaceyear"]/parent::div/following::div/div[not(contains(@class,"outside")) and @aria-label="day-replaceday"]'
calendar_container = '//div[@class="react-datepicker__month-container"]'
time_to_replace = '//li[contains(@class,"datepicker__time") and text()="timetoreplace"]'
table_columns = "//thead/tr/td"
user_id = '(//td[@class="generic-td "])[1]'
no_data_found_text = '//h2[@class="table__body-nodata"]'
save_btn = '//button[@class="btn sign_btn"][text()="Save"]'
after_deselect_rows_count = '//div[@class="col-sm-3"]//descendant::span'
deselect_all_btn = '//button[@class="btn sign_btn"][text()="De-select All"]'
download_button = "//span[@class='csv__download-button']"
save_preferences_button = "//button[text()='Save Preferences']"
back_month_btn = '//button[text()="Previous Month"]'
download_file_button = "//button[text()='Download File']"
customize_btn = '//div[@class="custom_btn-container"]//a[@class="btn_custom"]'
search_card_row_count = "//tbody[contains(@class,'table__body-border')]/tr"
search_card_thead_count = "//thead[contains(@class,'theader')]/tr/td"
search_card_tbody_count = "//tbody[contains(@class,'table')]/tr"
reset_btn = '//div[@class="custom_btn-container"]//a[@class="btn_reset"]'
popup_reset_btn = '//button[@class="btn sign_btn cancel-btn-generic"]//descendant::i'
user_id_field = "//div[text()='User ID']/../descendant::input[contains(@id,'react-select')]"
select_user_id = "//div[contains(@class,'css-1lhitd')][1]"
show_more_button = "//span[text()='Show More']"
dashboard_nav_btn = "//a[contains(@href,'dashboard')][text()='Dashboard']"
clear_date_field = "(//button[@class='react-datepicker__close-icon'])[1]"
clear_user_role_field = "//div[contains(@class,'react-select__clear-indicator')]"
customize_button = "//span[text()='Customize ']/i"
expand_button = '//span[@class="fullscreen-icos btn_custom"]'
save_filter_checkbox = '//div[@class="save_filter"]/input'
invoice_text = '//td[text()="Amendment Amount"]'
select_all_checkbox = '(//td[@class="table__row__container--downloadCheckbox"])[1]'
download_invoice = '//span[text()="Download Invoices"]'
toggle_button = '//label[@for="switch-orange" and text()="Off"]'
