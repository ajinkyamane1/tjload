#Seach Flight Field's Locators
where_from_field = "//div[text()='Where From ?']/../descendant::input"
where_to_field = "//div[text()='Where To ?']/../descendant::input"
search_button = ("//button[contains(@class,'search--button')]")
departure_date_field = "//input[@placeholder='Departure Date']"
return_date_field = "//input[@placeholder='Return Date']"
next_month_arrow_button = "//button[normalize-space()='Next month']"
passenger_and_class = "//input[@class = 'form-control form-control-positionHandle false']"
select_airport = "//i[@class='fa fa-map-marker at-topcity-icon']"
departure_date = "(//div[@aria-label='day-1'][normalize-space()='1'])[1]"
done_button = "//li[@class= 'at-lsdone']"
departure_date_text = "//div[contains(@class,'arrow')]/preceding-sibling::div/descendant::span[@class='at-fontweight dur-timefont']"
cheapest_flight_filter = "//p[text()='Cheapest']"
final_date_locator_to_replace= "//div[text()='replacemonth replaceyear']/parent::div/../div[@class='react-datepicker__month']/div/div[not(contains(@class,'react-datepicker__day--disabled')) and not(contains(@class,'react-datepicker__day--outside-month')) and text()='replaceday']"
departure_date_selected_text = "//input[@placeholder='Departure Date']"
return_date_selected_text = "//input[@name='returnRef']"

#Classes Locators
first_class = "//b[text()='First']/following-sibling::span"
business_class = "//b[text()='Business']/following-sibling::span"
premium_economy_class = "//b[text()='Premium Economy']/following-sibling::span"
economy_class = "//b[text()='Economy']/following-sibling::span"

#Flight Types Locators
oneway_button = "//span[text()='ONE WAY']"
roundtrip_button = "//span[text()='ROUND TRIP']"
multicity_button = "//span[text()='MULTI CITY']"

#Preferred Airline Locators
select_preferred_airline_dropdown = "//span[@class='preffered-more-options prefered-airline-options']/child::i"
search_dropdown = "//div[@class = 'css-1pcexqc-container react-select-container selectbox-positionHandle']"
search_dropdown1 = '//div[@class="css-ievs3x react-select__value-container react-select__value-container--is-multi"]//input'
select_preferred_airline = '//div[@class="css-kj6f9i-menu react-select__menu"]//div[@class="css-1my07s3-option react-select__option react-select__option--is-focused"]'
indigo_airline = "//div[contains(@id, 'react-select-') and contains(@id, '-option-0')]"
spicejet_airline = "//div[contains(@id, 'react-select-') and contains(@id, '-option-1')]"
vistara_airline = "//div[contains(@id, 'react-select-') and contains(@id, '-option-2')]"
air_india_airline = "//div[contains(@id, 'react-select-') and contains(@id, '-option-3')]"
go_first_airline = "//div[contains(@id, 'react-select-') and contains(@id, '-option-4')]"
akasa_air_airline = "//div[contains(@id, 'react-select-') and contains(@id, '-option-5')]"
air_asia_india_airline = "//div[contains(@id, 'react-select-') and contains(@id, '-option-6')]"

#Search Page Filter Locators
direct_flight_checkbox = "//span[text()='Direct Flight']/preceding-sibling::div/i[@class='fa fa-check'] "
regular_fares_checkbox = "//span[text()='Regular Fares']/preceding-sibling::div/i[@class='fa fa-check'] "
credit_shell_checkbox = "//span[text()='Credit Shell']/preceding-sibling::div/i[@class='fa fa-check'] "
student_fares_checkbox = "//span[text()='Student Fares']/preceding-sibling::div/i[@class='fa fa-check'] "
student_fares_text = "//span[text()='Student Fares']"
senior_citizen_fares = "//span[text()='Senior Citizen Fares']/preceding-sibling::div/i[@class='fa fa-check']"
senior_citizen_text = "//span[text()='Senior Citizen Fares']"

#Search Flight Multicity Fields Locators
from_first_field = "//div[@id='origin']//div[@class='react-select__input']/input"  # 1
to_first_field = "//div[@id='destination']//div[@class='react-select__input']/input"  # 1
departure_first_date_field = "//div[@class='at-returndep at-returndep-positionHandle']//input[@placeholder='Departure Date']"  # 1
from_second_field = "//div[@id='origin_1']//div[@class='react-select__input']/input"  # 2
to_second_field = "//div[@id='destination_1']//div[@class='react-select__input']/input"  # 2
departure_second_date_field = "//div[@id='depDate_1']//input[@placeholder='Departure Date']"  # 2
from_third_field = "//div[@id='origin_2']//div[@class='react-select__input']/input"  # 3
to_third_field = "//div[@id='destination_2']//div[@class='react-select__input']/input"  # 3
departure_third_date_field = "//div[@id='depDate_2']//input[@placeholder='Departure Date']"  # 3
from_four_field = "//div[@id='origin_3']//div[@class='react-select__input']/input"  # 4
to_four_field = "//div[@id='destination_3']//div[@class='react-select__input']/input"  # 4
departure_four_date_field = "//div[@id='depDate_3']//input[@placeholder='Departure Date']"  # 4
from_five_field = "//div[@id='origin_4']//div[@class='react-select__input']/input"  # 5
to_five_field = "//div[@id='destination_4']//div[@class='react-select__input']/input"  # 5
departure_five_date_field = "//div[@id='depDate_4']//input[@placeholder='Departure Date']"  # 5
from_six_field = "//div[@id='origin_5']//div[@class='react-select__input']/input"  # 6
to_six_field = "//div[@id='destination_5']//div[@class='react-select__input']/input"  # 6
departure_six_date_field = "//div[@id='depDate_5']//input[@placeholder='Departure Date']"  # 6
add_one_more_button = "//button[text()='ADD ONE MORE']"

#Flight Search History
view_last_search = "//p[text()='View your last search']/span[@class='fa fa-angle-down']"
last_source_city_text = "(//h4[@class='at-mnlbt'])[1]"
last_destination_city_text = "(//h4[@class='at-mnlbt'])[2]"
last_search_date_text = "(//span[@class='pull-left'])[1]"
last_search_button = "//div[@class='at-viewlastbg']"

#Dashboard Text
dashboard_flight_text = "//a[text()='Flight']"

# Filter Page Locator
zero_stop_filter = "//span[text()='Stops']/following::a[text()='0']"
one_stop_filter = "//span[text()='Stops']/following::a[text()='1']"
two_stop_filter = "//span[text()='Stops']/following::a[text()='2']"
three_stop_filter = "//span[text()='Stops']/following::a[text()='3']"

unselected_trip_text = "//li[@class='multicity__wrapper--cityname ']"

# Cross Fare locators
roundtrip_split_flights_toggle_button = "//div[@id='toggle__wrapper--checkboxid']"
select_onward_flight_for_stops_filter = "//li[contains(@class,'multic')][1]"
select_return_flight_for_stops_filter = "//li[contains(@class,'multic')][2]"
onward_flight_fare_type_text = "//span[contains(@class,'label label-warning ars')][1]"
return_flight_fare_count = "//i[@class='fa fa-share-alt']/following::span[contains(@class,'label')]"
return_flight_fare_type_text = "//i[@class='fa fa-share-alt']/following::span[contains(@class,'label')][index]"
select_fare_for_return_flight = "//i[@class='fa fa-share-alt']//following::span[@class='fare__amount'][index]"
select_fare_for_onward_flight = '(//label[@class="sort-labelfill sort-labelfill-positionHandle"]//span[@class="fare__amount"])[1]'
# //i[@class='fa fa-share-alt']/following::input[contains(@class,'sort-field')][index]


# Mutlicity Fare Details
mutlicity_flight_to1 = "(//span[@class='amt-multicity-cityNames-positionHandle'])[2]"


change_class_link="//a[text()='Change Class']"
# select_class_radiobutton="//label[text()='classname']//ancestor::ul/li"    #If we want to give class name from excel sheet#//label[text()='C9']//ancestor::ul/li/input
select_class_radiobutton="//li[@class='changeclass__wrapper--classlist'][1]"
index_select_class_radiobutton="(//ul[@class='changeclass__wrapper--className'])[index]/li[@class='changeclass__wrapper--classlist'][1]"
get_fare_button="//button[text()='Get Fare']"
arrival_button="//button[text()='Arrival']"
book_button_on_change_class="(//button[text()='BOOK'])[last()]"
select_first_class_radiobutton_for_roundtrip="(//div/ul[@class='changeclass__wrapper--className'])[2]/li[1]"
fare_details_tab_for_roundtrip="(//a[text()='Fare Details'])[2]"
adult_base_fare_for_roundtrip="((//span[contains(normalize-space(.),'Fare Details for Adult')])[2]/following-sibling::div/div[@class='col-sm-4']/ul/li)[1]"
infant_base_fare_for_roundtrip="((//span[contains(normalize-space(.),'Fare Details for Infant')])[2]/following-sibling::div/div[@class='col-sm-4']/ul/li)[1]"
adult_taxes_roundtrip="((//span[contains(normalize-space(.),'Fare Details for Adult')])[2]/following-sibling::div/div[@class='col-sm-4']/ul/li)[last()-0]"
adult_total_base_price_roundtrip="((//span[contains(normalize-space(.),'Fare Details for Adult')])[2]/following-sibling::div/div[@class='col-sm-5']/ul/li)[1]"
adult_total_tax_price_roundtrip="((//span[contains(normalize-space(.),'Fare Details for Adult')])[2]/following-sibling::div/div[@class='col-sm-5']/ul/li)[last()-0]"
child_base_fare_for_roundtrip="((//span[contains(normalize-space(.),'Fare Details for Child')])[2]/following-sibling::div/div[@class='col-sm-4']/ul/li)[1]"
child_taxes_for_roundtrip="(//span[contains(normalize-space(.),'Fare Details for Child')]/following-sibling::div/div[@class='col-sm-4']/ul/li)[last()-0]"
child_total_base_price_roundtrip="((//span[contains(normalize-space(.),'Fare Details for Child')])[2]/following-sibling::div/div[@class='col-sm-5']/ul/li)[1]"
child_total_taxes_price_roundtrip= "((//span[contains(normalize-space(.),'Fare Details for Child')])[2]/following-sibling::div/div[@class='col-sm-5']/ul/li)[last()-0]"
infant_taxes_roundtrip = "((//span[contains(normalize-space(.),'Fare Details for Infant')])[2]/following-sibling::div/div[@class='col-sm-4']/ul/li)[last()-0]"
infant_total_base_price_roundtrip = "((//span[contains(normalize-space(.),'Fare Details for Infant')])[2]/following-sibling::div/div[@class='col-sm-5']/ul/li)[1]"
infant_total_taxes_price_roundtrip = "((//span[contains(normalize-space(.),'Fare Details for Infant')])[2]/following-sibling::div/div[@class='col-sm-5']/ul/li)[last()-0]"
total_fare_price_roundtrip="(//span[text()='Total']/ancestor::div/following-sibling::div[@class='col-sm-5'])[2]"

#
total_segment_count="//ul[@class='ars-listair flightDetails-listair-positionHandle']"
select_onward_fare="(//div[contains(@class,'asr-albtmround ')])[index]//descendant::ul[4]/li/li[1]"
select_return_fare="//i[@class='fa fa-share-alt']/following::div[@class='asr-albtmround'][index]//descendant::ul[4]/li/li[1]"
total_number_of_class_fleet="//ul[@class='changeclass__wrapper--className']"
no_class_text="(//ul[@class='changeclass__wrapper--className'])[index]/span"
change_class_cross_link="//button[@class='styles_closeButton__20ID4']"

#
email_icon = "//button[text()='Email']"
send_icon = "//button[text()='Send']"
send_with_price_button = "//button[text()='With Price']"
email_input_field = "//div[@class='form_content']//descendant::input"
total_fare_checkbox = "((//div[@class='row flight-rowmain flight-rowmain-positionHandle'])/div/following::div//ul[@class='ars-radiolist']/descendant::label[@class='al-label'][1])"
select_fare_checkbox = "((//div[@class='row flight-rowmain flight-rowmain-positionHandle'])/div/following::div//ul[@class='ars-radiolist']/descendant::label[@class='al-label'][1])[index]"
total_fare_count = "//div[@class='ar-sortby']//descendant::label"
departure_city_text = "(//span[@class='at-fontweight atb-airport graycolor'][1])[1]"
arrival_city_text = "(//span[@class='at-fontweight atb-airport graycolor'][1])[2]"
view_details_email="(//button[text()='View Details'])[index]"
first_fare_price='((//div[@class="row flight-rowmain flight-rowmain-positionHandle"])/div/following::div//ul[@class="ars-radiolist"]/descendant::span[@class="fare__amount"][1])[1]'
