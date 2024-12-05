dashboard_link='//a[contains(text(),"Dashboard")]'
manage_cart_link='//a[contains(text(),"Manage Carts")]'
input_booking_id='//input[@name="bookingId"]'
from_date_input='//input[@name="createdOnAfterDateTime"]'
to_date_input='//input[@name="createdOnBeforeDateTime"]'
clear_payment_status='(//div[@class="css-gj4ymu react-select__indicator react-select__clear-indicator"])[2]'
search_btn='//button[normalize-space()="Search"]/i'

booking_status_input='//div[contains(text(),"Booking Status")]/following-sibling::div/descendant::input'
booking_status_container_selected='//label[contains(text(),"Booking")]/following-sibling::div/descendant::div[contains(@class,"react-select__value-container--has-value")]'
payment_status_input='//div[contains(text(),"Payment Status")]/following-sibling::div/descendant::input'

#Searchresult locators
booking_status_column_heading='//td[contains(text(),"Booking Status")]'
payment_status_column_heading='//td[contains(text(),"Payment Status")]'
generation_time_column_heading='//td[contains(text(),"Generation Time")]'
booking_id_column_heading='//td[contains(text(),"Booking Id")]'
booking_id_on_results='//td[contains(text(),"Booking Id")]/ancestor::thead/following-sibling::tbody/tr/td[4]/a'
date_to_be_replaced='//div[text()="replacemonth replaceyear"]/parent::div/following::div/div[not(contains(@class,"outside")) and @aria-label="day-replaceday"]'
back_month_btn='//button[text()="Previous Month"]'
calendar_container='//div[@class="react-datepicker__month-container"]'
data_rows='//tr[contains(@class,"table__row__container banklist__propper-header-class")]'
time_to_replace='//li[contains(@class,"datepicker__time") and text()="timetoreplace"]'
channel_type_field= '//input[@id="channels"]'
remove_all_booking_cancel_icon='//label[contains(text(),"Booking Status")]/following-sibling::div/descendant::div[@class="css-1alnv5e react-select__multi-value__remove"]'
remove_all_payment_cancel_icon='//label[contains(text(),"Payment Status")]/following-sibling::div/descendant::div[@class="css-1alnv5e react-select__multi-value__remove"]'
total_table_elements='//tbody/tr'
total_columns='//thead/tr/td'
total_rows='//tbody/tr'
checkbox_to_deselect_replace='//div[contains(text(),"replace")]/input'
save_btn='//button[normalize-space()="Save"]'
de_select_all_btn='//button[normalize-space()="De-select All"]'
reset_btn='//span[contains(normalize-space(),"Reset")]'
reset_btn2='//button[contains(text(),"Reset")]'
download_btn='(//span[contains(normalize-space(),"Download")])[1]'
dwonload_invoice_btn='//span[contains(normalize-space(),"Download Invoices")]'
customize_btn='//span[contains(normalize-space(),"Customize")]'
download_file_btn='//button[contains(text(),"Download File")]'
select_all_search_checkbox='//label[text()="Select All"]/preceding-sibling::input'
all_download_checkboxes='((//td[@class="table__row__container--downloadCheckbox"])/input)'
all_download_checkboxes_to_replace='((//td[@class="table__row__container--downloadCheckbox"])/input)[replace]'
results_shown='//span[contains(text(),"results shown")]'
airline_field= "//div[text()='Airline']"
airline_input_field= "//div[contains(text(),'Airline')]/following-sibling::div/descendant::input"
airline_dropdown= "//div[contains(@class,'select__menu-list')]"
manage_cart_first_name_field= "//input[@id='passengerFirstName']"
manage_cart_last_name_field= "//input[@id='passengerLastName']"
loggedIn_user_id_field= "//div[text()='LoggedIn User Id']"
loggedIn_user_id_input= "//div[contains(text(),'LoggedIn User Id')]/../descendant::input"
loggedIn_user_id_dropdown= "//div[contains(@class,'select__menu-list')]"
pnr_input_field= "//input[@id='pnr']"
channel_type_all_option= "//li[contains(@data-option-id,'ALL')]"
channel_type_desktop_option= "//li[contains(@data-option-id,'DESKTOP')]"
channel_type_api_option= "//li[contains(@data-option-id,'API')]"
channel_type_mobile_option= "//li[contains(@data-option-id,'MOBILE')]"
webelements_to_be_replaced= "//tbody/tr/td[replace]"
journey_type_field= "//div[@class='css-1kuy7z7 react-select__placeholder'][text()='Journey Type']"
journey_type_all_option= "//div[@role='option'][text()='All']"
journey_type_domestic_option= "//div[@role='option'][text()='Domestic']"
journey_type_international_option= "//div[@role='option'][text()='International']"
webelements_replaced= "//tbody/tr/td[replace]//div[@class='generic-td ']"
no_data_found_text= "//h2[text()='No Data Found!']"
search_button='//button[normalize-space()="Search"]/i'
show_more_less_button= '//span[contains(text(),"Show More")]'
first_name_field='//input[@id="passengerFirstName"]'
last_name_field= '//input[@id="passengerLastName"]'
error_for_booking_status= '//p[contains(@class,"error-message")][contains(text(),"booking status")]'
error_for_payment_status= '//p[contains(@class,"error-message")][contains(text(),"Payment Status")]'
raise_btn='//button[normalize-space()="Raise"]'
save_filter_checkbox='//input[@name="saveFiltter"]'
from_proceesed_on_input='//input[@name="processedOnAfterDateTime"]'
to_processed_on_input='//input[@name="processedOnBeforeDateTime"]'
from_travel_date_input='//input[@name="departedOnAfterDate"]'
to_travel_date_input='//input[@name="departedOnBeforeDate"]'
txt_of_assigned_user='//label[normalize-space()="Assigned User"]/following-sibling::div/descendant::div[@class="css-1izgmon react-select__multi-value__label"]'
assigned_user_field='//div[contains(text(),"Assigned User")]'
assigned_user_input_field='//div[contains(text(),"Assigned User")]/../descendant::input'
saved_filter_label='//button[contains(@class,"btn_filter")]'
total_filter_labels='//div[@class="quick_filter"]/div/button'
save_filter_as_tag_checkbox='//input[@name="showSaveFilterAsTag"]'
cant_create_more_thanfive_filters_popup='//span[contains(text(),"Can not save more then 5 search filter")]'
