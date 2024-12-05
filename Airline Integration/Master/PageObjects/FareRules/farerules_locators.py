#Fare Rules Navigation
fare_rule_menu = '//a[text()="Fare Rule"]'
add_fare_rule_icon = '//i[@class="fa fa-plus"]'


#Fare Rule Form
fare_description_filed = "//input[@id='description_0']"
fare_priority_filed = "//input[@id='priority_0']"
air_type_dropdown = "//select[@id='airType_0']"
select_airline_dropdown = "//div[@class='css-10nd86i react-select-container']"
airline_dropdown_list = "//div[contains(@class,'css-1lhitdy')]"
airline_dropdown_option = "//div[contains(@class,'react-select__option')]"
fare_enabled_checkbox = "//input[@id='enabled_0']"
fare_user_ids = "//input[@name='Inclusion' and @id='userIds']"
select_meal_indicator = "//div[@id='isML']/div"
meal_indicator_input_field = "//div[@id='isML']//div[@class='Refundable Type__input']/input"
select_baggage_indicator = "//div[@id='isHB']"
baggage_indicator_input_field = "//div[@id='isHB']//div[@class='Refundable Type__input']/input"
fare_description = "//input[@id='description_0']"


# locators for fare rules dropdwon fileds
fare_rule_field = "//li[@class='aside-menubar-listAll ']//child::a[text()='Fare Rule']"
air_type_field = "//input[@id='airType']"
all_title_dropdown = "(//li[@class='select-box-list__item' and @data-option-id='ALL'])[1]"
domestic_title_dropdown = "//div[@class='form__field__content']//following-sibling::li[@data-option-id='DOMESTIC']"
international_title_dropdown = "//div[@class='form__field__content']//following-sibling::li[@data-option-id='INTERNATIONAL']"
soto_title_dropdown = "//div[@class='form__field__content']//following-sibling::li[@data-option-id='SOTO']"
fare_rule_table = "//div[@class='manage_user dash-borderRadius dash-padding dashboard__main__content']"
air_type_column = "//thead[@class='credit_info--header-container ']//descendant::td[text()='Air Type']"


# Fare Rules
select_refundable_type = "//div[@id='rT']/div"
refundable_type_input_field = "//div[@id='rT']//div[@class='Refundable Type__input']/input"
add_cancellation_button = "//td[@id='CANCELLATION']/parent::tr/descendant::i[@class='fa fa-plus']"
cancellation_amount = "//td[@id='CANCELLATION']/parent::tr/descendant::input[@id='amount']"
cancellation_additional_fee = "//td[@id='CANCELLATION']/parent::tr/descendant::input[@id='additionalFee']"
cancellation_from = "//td[@id='CANCELLATION']/parent::tr/descendant::input[@id='fromTime']"
cancellation_to = "//td[@id='CANCELLATION']/parent::tr/descendant::input[@id='toTime']"
cancellation_policy_info = "//td[@id='CANCELLATION']/parent::tr/descendant::input[@id='policyInfo']"
add_date_change_button = "//td[@id='DATECHANGE']/parent::tr/descendant::i[@class='fa fa-plus']"
date_change_amount = "//td[@id='DATECHANGE']/parent::tr/descendant::input[@id='amount']"
date_change_additional_fee = "//td[@id='DATECHANGE']/parent::tr/descendant::input[@id='additionalFee']"
date_change_from = "//td[@id='DATECHANGE']/parent::tr/descendant::input[@id='fromTime']"
date_change_to = "//td[@id='DATECHANGE']/parent::tr/descendant::input[@id='toTime']"
date_change_policy_info = "//td[@id='DATECHANGE']/parent::tr/descendant::input[@id='policyInfo']"
add_no_show_button = "//td[@id='NO_SHOW']/parent::tr/descendant::i[@class='fa fa-plus']"
no_show_amount = "//td[@id='NO_SHOW']/parent::tr/descendant::input[@id='amount']"
no_show_additional_fee = "//td[@id='NO_SHOW']/parent::tr/descendant::input[@id='additionalFee']"
no_show_from = "//td[@id='NO_SHOW']/parent::tr/descendant::input[@id='fromTime']"
no_show_to = "//td[@id='NO_SHOW']/parent::tr/descendant::input[@id='toTime']"
no_show_policy_info = "//td[@id='NO_SHOW']/parent::tr/descendant::input[@id='policyInfo']"
add_seat_chargeable_button = "//td[@id='SEAT_CHARGEABLE']/parent::tr/descendant::i[@class='fa fa-plus']"
seat_chargeable_amount = "//td[@id='SEAT_CHARGEABLE']/parent::tr/descendant::input[@id='amount']"
seat_chargeable_additional_fee = "//td[@id='SEAT_CHARGEABLE']/parent::tr/descendant::input[@id='additionalFee']"
seat_chargeable_from = "//td[@id='SEAT_CHARGEABLE']/parent::tr/descendant::input[@id='fromTime']"
seat_chargeable_to = "//td[@id='SEAT_CHARGEABLE']/parent::tr/descendant::input[@id='toTime']"
seat_chargeable_policy_info = "//td[@id='SEAT_CHARGEABLE']/parent::tr/descendant::input[@id='policyInfo']"
add_travel_period_button = "(//td[@id='tp']/parent::tr/descendant::i[@class='fa fa-plus'])[1]"
exclusion_travel_period_button = "(//td[@id='tp']/parent::tr/descendant::i[@class='fa fa-plus'])[2]"
travel_period_to = "(//td[@id='tp']/../td[2]/descendant::input)[2]"
travel_period_from = "(//td[@id='tp']/../td[2]/descendant::input)[1]"
travel_to_exclusion = "(//td[@id='tp']/../td[3]/descendant::input)[2]"
travel_from_exclusion = "(//td[@id='tp']/../td[3]/descendant::input)[1]"
add_booking_period_button = "(//td[@id='bp']/parent::tr/descendant::i[@class='fa fa-plus'])[1]"
exclusion_booking_period_button = "(//td[@id='bp']/parent::tr/descendant::i[@class='fa fa-plus'])[2]"
booking_period_to = "(//td[@id='bp']/../td[2]/descendant::input)[2]"
booking_period_from = "(//td[@id='bp']/../td[2]/descendant::input)[1]"
booking_to_exclusion = "(//td[@id='bp']/../td[3]/descendant::input)[2]"
booking_from_exclusion = "(//td[@id='bp']/../td[3]/descendant::input)[1]"
fare_rule_submit_button = "//button[text()='Submit ']"
search_air_type = "//div[@class='main_container']/descendant::div[@class='search__form__section__wrapper']//input[@id='airType']"
fare_rule_search_button = "//button[text()='Search']"
supplier_inclusion_id_select = "//td[@id='sid']/parent::tr/descendant::div[@class='css-vj8t7z'][1]"
supplier_inclusion_id_input = "//input[@id='react-select-2-input']"
supplier_exclusion_id_select = "//td[@id='sid']/parent::tr/descendant::div[@class='css-vj8t7z'][2]"
supplier_exclusion_id_input = "//td[@id='sid']/parent::tr/descendant::input[@id='react-select-3-input']"
cabin_class_inclusion_id_select = "//td[@id='cc']/parent::tr/descendant::div[@class='css-vj8t7z Cabin class__control'][1]"
cabin_class_inclusion_id_input = "//input[@id='react-select-4-input']"
cabin_class_exclusion_id_select = "//td[@id='cc']/parent::tr/descendant::div[@class='css-vj8t7z Cabin class__control'][2]"
cabin_class_exclusion_id_input = "//input[@id='react-select-5-input']"
source_inclusion_id_select = "//td[@id='sois']/parent::tr/descendant::div[@class='css-vj8t7z Source__control'][1]"
source_inclusion_id_input = "//input[@id='react-select-6-input']"
source_exclusion_id_select = "//td[@id='sois']/parent::tr/descendant::div[@class='css-vj8t7z Source__control'][2]"
source_exclusion_id_input = "//input[@id='react-select-7-input']"
fare_types_inclusion_select = "(//div[contains(@class,'Fare')])[1]"
fare_types_exclusion_select = "(//div[contains(@class,'Fare')])[2]"
fare_types_inclusion_id_input = "//input[@id='react-select-8-input']"
fare_types_exclusion_id_select = "//td[@id='ft']/parent::tr/descendant::div[@class='css-vj8t7z Fare Types__control'][2]"
fare_types_exclusion_id_input = "//input[@id='react-select-9-input']"
fare_type_inclusion_field = "(//div[@class='Fare Types__input']/input)[1]"
fare_type_exclusion_field = "(//div[@class='Fare Types__input']/input)[2]"
fare_type_option = "(//div[@role='option'])[1]"


#Admin Fare Rule Page
fare_priority = "//input[@id='priority_0']"
fare_select_air_type = "//select[@id='airType_0']"
select_airline = "//div[@class='css-10nd86i react-select-container']"
airline_input_field = "//div[@class='react-select__input']/input"


# locators for fare rule search page
status_field = "(//div[@class='form__field form__field--one-third'])[3]"
all_input_status = '(//ul[@class="select-box-list select-box-list--open"]//li[1])'
enabled_input_status = "(//ul[@class='select-box-list select-box-list--open']//li[2])"
disabled_input_status = "(//ul[@class='select-box-list select-box-list--open']//li[3])"
search_button = "//button[@type='submit' and text()='Search']"
delete_icon = "(//i[@class='fa fa-trash linkcontainer__delete__icon'])[1]"
delete_button = "//button[@class='btn sign_btn cancel-btn-generic' and text()='Delete']"
history_link = "(//span[@class='link_container-link' and text()='History'])[1]"
cross_icon = "//button[@class='styles_closeButton__20ID4']"
maximize_window = "(//span[@class='fullscreen-icos btn_custom'])[2]"
minimize_window = "(//span[@class='fullscreen-icos btn_custom'])[2]"
edit_fare_rule = "(//span[@class='link_container-link' and text()='Edit'])[2]"
hide_show_button = "//button[@class='hideShow-button-box']"
checked_checkbox = "//input[@type='checkbox'][@checked]"
unchecked_box = "//input[@type='checkbox' and not(@checked)]"
description_for_disabled = "//input[@type='checkbox' and not(@checked)]//ancestor::tr/td[4]"
description_for_enabled = "//input[@type='checkbox'][@checked]//ancestor::tr/td[4]"
display_table = "//table[@class='table credit-card__container-content-details']//tbody//tr"
display_rows_count = "//span[@class='table--count']"
full_screen_table = "//span[@class='fullscreen-icos btn_custom']/span"
fare_id = '//tbody//tr[3]//td[@class="ellipses"][8]'
description_count = "//table//tbody//ancestor::tr/td[4]"
create_rule_icon = "//a[@class='floating__icon-link']"
select_airline_input = "//div[@class='react-select__input']//input"
end_date = '(//input[@class="form-control"])[2]'
travel_period_icon = "(//td[@id='tp']/parent::tr/descendant::i[@class='fa fa-plus'])[1]"
second_date_picker_field = "(//div[@class='react-datepicker__input-container'])[2]"
successful_message = '//div[@id="notification-wrapper"]/div/span'
delete_icon_for_priority_value = "//td[text()='20000000000000']/following-sibling::td/descendant::i[contains(@class,'fa fa-trash')]"


#HandBaggage Filed
adult_handbaggage_field = "//h3[text()='Hand Baggage Details']/../descendant::input[@placeholder='Adult']"
child_handbaggage_field = "//h3[text()='Hand Baggage Details']/../descendant::input[@placeholder='Child']"
infant_handbaggage_field = "//h3[text()='Hand Baggage Details']/../descendant::input[@placeholder='Infant']"


#Checkin Field
adult_checkin_field = "//h3[text()='Check-In Baggage Details']/../descendant::input[@placeholder='Adult']"
child_checkin_field = "//h3[text()='Check-In Baggage Details']/../descendant::input[@placeholder='Child']"
infant_checkin_field = "//h3[text()='Check-In Baggage Details']/../descendant::input[@placeholder='Infant']"


input_airline = '//div[@class="css-1on8mmp react-select__single-value"]'
booking_date_icon = "(//button[@type='button']//i[@class='fa fa-plus'])[3]"
previous_month = "//button[text()='Previous Month']"
travel_date_icon = "(//button[@type='button']//i[@class='fa fa-plus'])[1]"
total_row_count = '//tr[@class="inc_exc-tr"]'
all_row_count = "//tbody[contains(@class,'table__body')]/tr"
# last_row = '//tr[@class="inc_exc-tr"][]'
row_count_until_last = '//tr[@class="inc_exc-tr"][]'
total_rows_found = '//div[@class="col-sm-3"]//span[@class="table--count"]'
fare_rule_adult_hand_baggage = '(//h3[@class="dash-borderRadius text-uppercase main-heading-content"]//following::input[@placeholder="Adult"])[1]'
fare_rule_adult_check_in_baggage = '(//h3[@class="dash-borderRadius text-uppercase main-heading-content"]//following::input[@placeholder="Adult"])[2]'
fare_rule_child_hand_baggage = '(//h3[@class="dash-borderRadius text-uppercase main-heading-content"]//following::input[@placeholder="Child"])[1]'
fare_rule_child_check_in_baggage = '(//h3[@class="dash-borderRadius text-uppercase main-heading-content"]//following::input[@placeholder="Child"])[2]'
fare_rule_infant_hand_baggage = '(//h3[@class="dash-borderRadius text-uppercase main-heading-content"]//following::input[@placeholder="Infant"])[1]'
fare_rule_infant_check_in_baggage = '(//h3[@class="dash-borderRadius text-uppercase main-heading-content"]//following::input[@placeholder="Infant"])[2]'
fare_rule_description = "(//td[text()='Air Type All'])"
exclusion_fare_user_id = "//input[@name='Exclusion' and @id='userIds']"
fare_rule_eye_icon = "//button[@class='hideShow-button-box']"


true_option = "//div[text()='True']"
false_option = "//div[text()='False']"
hand_baggage_indicator = "//div[@id='isHB']/div"
refundable_text = "//div[text()='Refundable']"
non_refundable_text = "//div[text()='Non-Refundable']"
partial_refundable_text = "//div[text()='Partial-Refundable']"
current_date_text = "//div[contains(@class,'react-datepicker__day--today')]"
next_month_button = "//button[text()='Next month']"
sector_inclusion_field = "//input[@id='routes' and @name='Inclusion']"
sector_exclusion_field = "//input[@id='routes' and @name='Exclusion']"
source_inclusion_select = "(//div[contains(@class,'css-1hwfws3 Source__value-container')])[1]"
source_exclusion_select = "(//div[contains(@class,'css-1hwfws3 Source__value-container')])[2]"
source_inclusion_field = "(//div[@class='Source__input']/input)[1]"
source_exclusion_field = "(//div[@class='Source__input']/input)[2]"
source_option = "//div[contains(@class,'Source__option ')]"
airline_info = "//button[@class='airlineInfo__headerButton']"
enable_checked_box = "(//input[@type='checkbox'][@checked]/parent::td/parent::tr)/td[16]"
enable_unchecked_box = "(//input[@type='checkbox' and not(@checked)]/parent::td/parent::tr)/td[16]"
farerule_airline_search = "//div[text()='Airline']/../descendant::input"
airline_option = "//div[@role='option']"
airline_code_text = "//div[contains(@class,'react-select__single-value')]"
farerule_airline_table = "//td[2][@class='ellipses']"
meal_indicator_text = "//div[contains(@class,'flight-rowmain')]/descendant::span[contains(@class,'ars-lastre')]"
hand_baggage_indicator_text = "//i[@class='fa fa-info-circle handbag-icons']/.."
refundable_indicator = "//span[@class='cursor-pointer']"
non_refundable_indicator = "//span[@class='nonrefund-type']"
