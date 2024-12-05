# link
import_pnr_link = "//a[@href='/import-pnr']"
dashboard_link='//a[contains(text(),"Dashboard")]'
manage_cart_link='//a[contains(text(),"Manage Carts")]'
more_option_link = "//span[@class='cssCircle-plusdesign' and text()='More Option ' ]"
switch_back = "//li[@class='topbar__list' and text()='Switch Back']"

# input fields
supplier_field = "(//div[@class='react-select__input']//input)[1]"
user_id_field = "(//div[text()='User ID']//following-sibling::div//child::input)[1]"
user_id_field_old_pnr = "(//div[text()='User ID']//following-sibling::div//child::input)[2]"
supplier_field_old_pnr = "(//div[@class='react-select__input']//input)[3]"
input_pnr_new = "(//input[@name='pnr'])[1]"
input_pnr_old = "(//input[@name='pnr'])[2]"
user_id_dropdown = "//div[@class='css-1lhitdy react-select__option react-select__option--is-focused']"

# buttons
new_edit_import_button = "//button[text()='New Edit Import']"
save_button = "//button[text()='+ Save']"
search_button = "//button[contains(normalize-space(),'Search')]"
submit_button_ipnr = "//button[normalize-space()='Submit']"
pay_now_button_link = "//div[@class='tgs-button tgs-button-variant-normal' and text()='Pay Now']"
old_import_pnr_button = "//button[text()='Old Import Pnr']"
old_supplier_field_arrow = "(//div[@class='css-1s7wec9 react-select__indicator react-select__dropdown-indicator'])[3]"
import_pnr_button = "//button[contains(normalize-space(),'Import Pnr')]"

booking_summary_link="//a[text()='Booking Summary']"

# manage_cart
# first_booking_id = "(//td[contains(text(),'Booking Id')]/ancestor::thead/following-sibling::tbody/tr/td[5]/a)[1]"
first_booking_id = "(//a[contains(text(), 'TJS')])[1]"
get_supplier_name = "//label[text()='Supplier']//preceding-sibling::input"
get_airline_name = "//div[@class='segment_body-airlogo']/p"
get_segment_info = "//div[@class='segment_body-flight-info']"
get_base_fare = "//label[text()='Base Fare']//preceding-sibling::input"
get_taxes = "//label[text()='Taxes']//preceding-sibling::input"
get_pnr = "(//label[text()='Airline PNR']//preceding-sibling::input)[1]"
get_gds = "(//label[text()='GDS PNR']//preceding-sibling::input)[1]"
airline_field= "//div[text()='Airline']"
airline_input_field= "//div[@class='search__form__section__wrapper']//div[7]/descendant::input"
airline_dropdown= "//div[contains(@class,'select__menu-list')]"
date_close_button = "//button[@class='react-datepicker__close-icon']"
# date_close_button_to = "//button[@class='react-datepicker__close-icon']"
# get_user_id = "//span[@class="cart_info-field--detail"]"

segment_detail_heading = "(//h2[@class='search__form__section__title' and text()='Segment Details'])[1]"

# segment info import page
# get_source = "(//div[@class='css-1on8mmp react-select__single-value'])[1]"

# import pnr data section
get_source_ipnr = "//label[text()='Source']//following-sibling::div//child::div[@class='css-1on8mmp react-select__single-value']"
get_destination = "//label[text()='Destination']//following-sibling::div//child::div[@class='css-1on8mmp react-select__single-value']"
get_departure_time = "//label[@for='departureDateTime']//preceding-sibling::input"
get_arrival_time = "//label[@for='arrivalDateTime']//preceding-sibling::input"
mobile_number_field = "//label[text()='Mobile Phone']//preceding-sibling::input"
email_field_ipnr = "//label[text()='Email ID']//preceding-sibling::input"
fare_type = "//label[text()='Fare Type']//preceding-sibling::input"
select_economy_fare = "//ul[@class='select-box-list select-box-list--open']//li[@data-option-id='ECONOMY']"
select_corporate_lite = "//ul[@class='select-box-list select-box-list--open']//li[@data-option-id='CORPORATE_LITE']"
#import pnr booking generate popup
booking_generate_popup = "//div[@class='main_container trip-box__popup']"
on_hold_button = "//button[normalize-space()='Hold']"
generated_booking_id = "(//h2[@class='trip-box__heading'])[1]"
generated_total_fare = "(//h2[@class='trip-box__heading'])[2]"
generated_special_fare = "(//h2[@class='trip-box__heading'])[3]"

on_hold_status = "//span[text()='On Hold']"

# emulate user
emulate_link = "//a[text()='Emulate']"

status_success = "//span[@class='font-label-success' and contains(normalize-space(),'Success')]"


refundable_type_dropdown= "//label[text()='Refundable Type']//preceding-sibling::input"
pnr_dropdown = "//label[text()='PNR']//preceding-sibling::input"
cabin_class_dropdown = "(//label[text()='Cabin Class']//preceding-sibling::input)"
select_first_element_from_dropdown = '(//ul[@class="select-box-list select-box-list--open"]/li)[1]'
fare_basis_dropdown = "(//label[text()='Fare Basis']//preceding-sibling::input)"
expand_arrow = '(//div[@class="cssCircle minusSign"])[5]'
success_text = '//td//span[@style="color: green;" and text()="Success"]'
payment_medium_value = '//tbody[@class="table__body-list-font"]/tr/td[4]'
assignme_icon = '//i[@class="fa fa-address-book-o assignme-icon info-fa-icon"]'
generation_time = "//td[normalize-space()='Generation Time']"
booking_id_value = '//p[@class="abt-succedspan"]/a'
logout_button = "//li[normalize-space()='Logout']"



