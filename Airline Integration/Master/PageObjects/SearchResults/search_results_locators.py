#Search Results Page Locators
source_city_text = "//div[@class='col-sm-2 no-padding'][1]//p[@class='ars-city']"
destination_city = "//div[@class='col-sm-2 no-padding'][2]//p[@class='ars-city']"
passenger_class = "//span[@class='ars-refunsleft ars-lastre ars-last-positionHandle']"
book_button = "(//button[contains(text(),'BOOK')])[1]"
session_expire_text= "//span[text()='Your Session will expire in']"
fare_info_changed= "//h1[text()='Fare Info Changed']"
continue_btn= "//button[@class='fare-yesbutton']"
add_passengers_button = "//button[@class= 'btn btn-warning asr-book asr-book-positionHandle']"
stops_flight_text= "//div[@class='atls-holdid']/child::span[@class='ars-arrowsun']"
expand_arrow_button= "//span[@class='flight__dropdown__icon']"
layover_1stop="//p[@class='apt-laypverdesktop layover-apt-positionHandle']"
search_processing_icon= "//div[@class='lds-ellipsis lds-ellipsis-positionHandle']"
passenger_class_text = "//span[@class='ars-refunsleft ars-lastre ars-last-positionHandle']"
no_flight_text= "//div[@class='no_flight-content']/child::p[contains(text(),'no flights found')]"
total_flights= "//div[@class='col-sm-6']/node()/li[contains(@class,'multiair-lines-list ars-positionHandle')]"
parentlist_flightsearch='(//div[@class="row flight-rowmain flight-rowmain-positionHandle"])'
fare_price_to_be_replaced1= '((//div[@class="row flight-rowmain flight-rowmain-positionHandle"])/div/following::div//ul[@class="ars-radiolist"]/descendant::span[@class="fare__amount"])'
elemfirstoccurence='((//div[@class="row flight-rowmain flight-rowmain-positionHandle"])/div/following::div//ul[@class="ars-radiolist"]/descendant::span[@class="fare__amount"][1])[1]'
airport_list= "//span[@class='at-topcity-names']"
departure_time_text= "//span[@class='dep-timefont'][1]"
search_page_retry_button = "//button[text()='Please, Modify your search and try again.']"
fare_id_i_button = "//span[@class='fa fa-info-circle edit-icon-tiles']"
fare_rule_id_text = "//span[text()='Fare Rule Id']/../../descendant::a"
fare_amounts = "//ul[@class='ars-radiolist']/descendant::li[@class='mb-15 main-radiolist tile__element'][1]/descendant::span[@class='fare__amount']"
fare_amounts_searchpage = "//span[@class='fare__amount']"


#Markup Locator
markup_price_field = "//input[@id='markupPrice_feild']"
markup_update_btn = "//button[@class='markup__update-btn markup__update-btn-positionHandle']"
markup_update_all_btn = "//button[@class='markup__update-btn']"


#Modify Search Locators
source_city_modify = "//li[@class='whitecolor'][1]"
destination_city_modify= "//li[@class='whitecolor'][2]"
departure_date_modify = "//p[text()='Departure Date']/following-sibling::span"
modify_class_text= "(//span[@class='atls-hdcontent whitecolor atls-hdcontent-positionHandle'])[2]"
modify_passenger_text= "(//span[@class='atls-hdcontent whitecolor atls-hdcontent-positionHandle'])[1]"
modify_adults_text="(//span[@class='atls-hdcontent whitecolor atls-hdcontent-positionHandle'])[1]//span[1]"
modify_children_text="(//span[@class='atls-hdcontent whitecolor atls-hdcontent-positionHandle'])[1]//span[2]"
modify_infants_text="(//span[@class='atls-hdcontent whitecolor atls-hdcontent-positionHandle'])[1]//span[3]"
modify_prefered_airlines_text= "//p[text()='Preferred Airline']/following-sibling::span[@class='al-none']"
modify_clear_button = "//div[contains(@class,'react-select__clear-indicator')]"
source_city_one_modify = "//div[@class='multicity-scrollplace']/*[1]/node()/*/li[@class='whitecolor'][1]"
destination_city_one_modify= "//div[@class='multicity-scrollplace']/*[1]/node()/*/li[@class='whitecolor'][2]"
source_city_two_modify = "//div[@class='multicity-scrollplace']/*[2]/node()/*/li[@class='whitecolor'][1]"
destination_city_two_modify= "//div[@class='multicity-scrollplace']/*[2]/node()/*/li[@class='whitecolor'][2]"
source_city_three_modify = "//div[@class='multicity-scrollplace']/*[3]/node()/*/li[@class='whitecolor'][1]"
destination_city_three_modify= "//div[@class='multicity-scrollplace']/*[3]/node()/*/li[@class='whitecolor'][2]"
source_city_four_modify = "//div[@class='multicity-scrollplace']/*[4]/node()/*/li[@class='whitecolor'][1]"
destination_city_four_modify= "//div[@class='multicity-scrollplace']/*[4]/node()/*/li[@class='whitecolor'][2]"
source_city_five_modify = "//div[@class='multicity-scrollplace']/*[5]/node()/*/li[@class='whitecolor'][1]"
destination_city_five_modify= "//div[@class='multicity-scrollplace']/*[5]/node()/*/li[@class='whitecolor'][2]"
modify_button= "//button[@class='btn btn-default al-modibtn']"


#View Details Tab Locators
flight_details_tab="//b[@class='cityContainer-positionHandle']"
fare_details_tab = "//a[text()='Fare Details']"
fare_details_text = "//span[text()='Fare']"
fare_rules_tab = "//a[text()='Fare Rules']"
detailed_rule_button = "//button[text()='Detailed Rules']"
baggage_allowance_tab = "//a[text()='Baggage Information']"
baggage_allowance_text = "//h5[text()='CheckIn']"
baggage_data_div = '//div[@class="row baggageData-row-positionHandle"]'
ailine_searched_text = "//li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']"
view_details_button = "//button[text()='View Details']"
view_details_button_right_section = "((//div[@class='col-sm-6 domestic_tiles_view'])[2]//child::button[text()='View Details'])[1]"
flight_duration_text = "//li[@class='ars-lsprice']"
arrival_details_text = "//li[@class='ars-lsprice ars-prclist']"
layover_time_text = "//span[contains(text(),'Layover Time')]"
fare_type_search_page = "//span[contains(@class,'label-canvas')]"
flight_name_text = '//div[@class="atls-holdid atls-holdid-positionHandle"]'


#View Details Element
view_details_source_text = "//b[@class='cityContainer-positionHandle']/span[1]"
view_details_destination_text = "//b[@class='cityContainer-positionHandle']/span[3]"
view_details_date_text = "//span[@class='graycolor flightDetails-dateDetails-positionHandle']"
view_details_source_airport = "(//li[@class='ars-lsprice ars-prclist' or @class='ars-lsprice ars-prclist round-flighttime flight-timedata-font10'])[1]"
non_stop_text = "//li[contains(@class,'stop-arrowlin')]"
view_details_destination_airport = "(//li[@class='ars-lsprice ars-prclist' or @class='ars-lsprice ars-prclist round-flighttime flight-timedata-font10'])[last()-0]"
view_details_departure_time = "//span[text()='Non-Stop']/parent::li/preceding-sibling::li[@class='ars-lsprice ars-prclist' or @class='ars-lsprice ars-prclist round-flighttime flight-timedata-font10']"
view_details_arrival_time = "//span[text()='Non-Stop']/parent::li/following-sibling::li[@class='ars-lsprice ars-prclist' or @class='ars-lsprice ars-prclist round-flighttime flight-timedata-font10']"
view_details_flight_duration = "//li[@class='ars-lsprice' or @class='ars-lsprice round-flighttime flight-timedata-font10']"
view_details_airline_text = "//span[@class='at-fontweight arct-idcode']"
view_details_airline_hover = "//p[@class='at-fontweight cancellation-details']"
view_details_adult_checkin = "(//span[@class='baggage__data--checkIn' and contains(text(),'Adult')])[1]"
view_details_child_checkin = "(//span[@class='baggage__data--checkIn' and contains(normalize-space(.), 'Child')])[1]"
view_details_infant_checkin = "(//span[@class='baggage__data--checkIn' and contains(normalize-space(.), 'Infant')])[1]"
view_details_adult_handbaggage = "(//span[@class='baggage__data--checkIn' and contains(text(),'Adult')])[2]"
view_details_child_handbaggage = "(//span[@class='baggage__data--checkIn' and contains(normalize-space(.), 'Child')])[2]"
view_details_infant_handbaggage = "(//span[@class='baggage__data--checkIn' and contains(normalize-space(.), 'Infant')])[2]"
view_details_total_text = "(//span[text()='Total'])[2]"
fare_details_i_button = "//i[contains(@class,'info-fa-icon-positionHandle')]"
taxes_and_fees_hover = "//div[@class='tooltip-hover']"
airline_gst_text = "//span[@class='pull-right fareDetails-tooltip-positionHandle']"
search_results_scroll_button = "//i[contains(@class,'fa fa-angle-double-up') or contains(@class,'fa fa-angle-double-down')]"


#View Details Fare Rule
view_details_cancellation_fees = "//span[text()='Cancellation Fee']"
view_details_time_frame = "//div[contains(@class,'fareRules__timeFrameContainer ')]"
view_details_different_amounts = "(//div[contains(@class,'fareRules__ruleInfoContainer')]/span)[1]"
view_details_fare_policy = "//span[contains(@class,'fareRules__policyInfo ')]"
view_date_change_tab = "//span[text()='Date Change Fee']"
view_no_show_tab = "//span[text()='No Show Fee']"
view_seat_chargeable_tab = "//span[text()='Seat Chargeable Fee']"
total_fare_price = "//span[text()='Total']/ancestor::div/following-sibling::div[@class='col-sm-5']"


#Fare Details Under View Details Locators
pax_details_fare_details = "(//span[@class='atls-hdcontent whitecolor atls-hdcontent-positionHandle'])[1]"
pax_details_tooltip_text_fare_details = "(//p[@class='cancellation-details atlscont'])[3]"
no_of_adults_fare_details = "//span[contains(normalize-space(.),'Adult')]/following-sibling::div/div[@class='col-sm-4']/descendant::li"
no_of_child_fare_details = "//span[contains(normalize-space(.),'Child')]/following-sibling::div/div[@class='col-sm-4']/descendant::li"
no_of_infant_fare_details = "//span[contains(normalize-space(.),'Infant')]/following-sibling::div/div[@class='col-sm-4']/descendant::li"
all_fare_amounts_to_be_replaced= "(//ul[@class='ars-radiolist'])[replace]/descendant::span[not(contains(text(),'Tj Flex'))]/preceding-sibling::label/descendant::span[contains(@id,'price')]"
fare_price_to_be_replaced='((//div[@class="row flight-rowmain flight-rowmain-positionHandle"])/div/following::div//ul[@class="ars-radiolist"]/descendant::span[@class="fare__amount"][1])[replace]'


#Round Trip Locators
fare_radio_button = "(//span[@class='fare__amount'])[1]"
return_date_departure_text = "//i[@class='fa fa-share-alt']/following::div[contains(@class,'arrow')]/preceding-sibling::div/descendant::span[@class='dep-timefont']"
return_fare_radio_button = "//span[text()='date']/ancestor::div[contains(@class,'flight-rowmain')]/descendant::span[@class='fare__amount']"


#Filter Page Locator
zero_stop_filter = "//span[text()='Stops']/following::a[text()='0']"
one_stop_filter = "//span[text()='Stops']/following::a[text()='1']"
two_stop_filter = "//span[text()='Stops']/following::a[text()='2']"


#Adult Fare Details Locators
adult_base_fare = "(//span[contains(normalize-space(.),'Fare Details for Adult')]/following-sibling::div/div[@class='col-sm-4']/ul/li)[1]"
adult_tj_flex_fee = "(//span[contains(normalize-space(.),'Fare Details for Adult')]/following-sibling::div/div[@class='col-sm-4']/ul/li)[last()-1]"
adult_taxes = "(//span[contains(normalize-space(.),'Fare Details for Adult')]/following-sibling::div/div[@class='col-sm-4']/ul/li)[last()-0]"
adult_total_base_price = "(//span[contains(normalize-space(.),'Fare Details for Adult')]/following-sibling::div/div[@class='col-sm-5']/ul/li)[1]"
adult_total_taxes_price = "(//span[contains(normalize-space(.),'Fare Details for Adult')]/following-sibling::div/div[@class='col-sm-5']/ul/li)[last()-0]"
adult_total_tj_flex_fee = "(//span[contains(normalize-space(.),'Fare Details for Adult')]/following-sibling::div/div[@class='col-sm-5']/ul/li)[last()-1]"


#Child Fare Details
child_base_fare = "(//span[contains(normalize-space(.),'Fare Details for Child')]/following-sibling::div/div[@class='col-sm-4']/ul/li)[1]"
child_taxes = "(//span[contains(normalize-space(.),'Fare Details for Child')]/following-sibling::div/div[@class='col-sm-4']/ul/li)[last()-0]"
child_tj_flex_fee = "(//span[contains(normalize-space(.),'Fare Details for Child')]/following-sibling::div/div[@class='col-sm-4']/ul/li)[last()-1]"
child_total_base_price = "(//span[contains(normalize-space(.),'Fare Details for Child')]/following-sibling::div/div[@class='col-sm-5']/ul/li)[1]"
child_total_taxes_price = "(//span[contains(normalize-space(.),'Fare Details for Child')]/following-sibling::div/div[@class='col-sm-5']/ul/li)[last()-0]"
child_total_tj_flex_fee = "(//span[contains(normalize-space(.),'Fare Details for Child')]/following-sibling::div/div[@class='col-sm-5']/ul/li)[last()-1]"
tj_flex_label = "//span[text()='Tj flex fee']"


#Infant
infant_base_fare = "(//span[contains(normalize-space(.),'Fare Details for Infant')]/following-sibling::div/div[@class='col-sm-4']/ul/li)[1]"
infant_taxes = "(//span[contains(normalize-space(.),'Fare Details for Infant')]/following-sibling::div/div[@class='col-sm-4']/ul/li)[last()-0]"
infant_total_base_price = "(//span[contains(normalize-space(.),'Fare Details for Infant')]/following-sibling::div/div[@class='col-sm-5']/ul/li)[1]"
infant_total_taxes_price = "(//span[contains(normalize-space(.),'Fare Details for Infant')]/following-sibling::div/div[@class='col-sm-5']/ul/li)[last()-0]"


#Multicity
multicity_flight_tabs = "//span[contains(@class,'flightTiles__container-wrapper-positionHandle')]/descendant::span[@class='amt-multicity-cityNames-positionHandle']"
multicity_text = "//p[@class='ars-city']"
connecting_flight_filter = "//span[text()='Stops']//ancestor::div[@class='al-listbtm pb-10 mt-10']//descendant::a[text()='1']"


#Manage User Locator
manage_user_menu = "//a[text()='Manage User']"
user_id_field = "//div[text()='User ID']/../descendant::input[contains(@id,'react-select')]"
user_id_option = "//div[contains(@class,'react-select__option')]"
user_search_button = "//button[text()='Search']"
emulate_button = "//a[text()='Emulate']"
switch_back_button = "//li[text()='Switch Back']"
View_round_source_text = "//i[@class='fa fa-share-alt']/following::b[@class='cityContainer-positionHandle']/span[1]"
view_round_destination_text = "//i[@class='fa fa-share-alt']/following::b[@class='cityContainer-positionHandle']/span[3]"
View_round_airline_text = "//i[@class='fa fa-share-alt']/following::span[@class='at-fontweight arct-idcode']"
view_round_airline_hover = "//i[@class='fa fa-share-alt']/following::p[@class='at-fontweight cancellation-details']"

source_cities= "//div[@class='flight-leftresult flight-leftresult-positionHandle'][1]/child::*[2]//p[@class='ars-city']"
destination_cities= "//div[@class='flight-leftresult flight-leftresult-positionHandle'][1]/child::*[4]//p[@class='ars-city']"
multicity_first_source_city = "//span/div[@class='asr-albtm']/descendant::p[@class='ars-city'][1]"
multicity_first_destination_city = "//span/div[@class='asr-albtm']/descendant::p[@class='ars-city'][2]"
multicity_second_source_city = "//span/div[@class='asr-albtm']/descendant::p[@class='ars-city'][3]"
multicity_second_destination_city = "//span/div[@class='asr-albtm']/descendant::p[@class='ars-city'][4]"
multicity_third_source_city = "//span/div[@class='asr-albtm']/descendant::p[@class='ars-city'][5]"
multicity_third_destination_city = "//span/div[@class='asr-albtm']/descendant::p[@class='ars-city'][6]"
multicity_fourth_source_city = "//span/div[@class='asr-albtm']/descendant::p[@class='ars-city'][7]"
multicity_fourth_destination_city = "//span/div[@class='asr-albtm']/descendant::p[@class='ars-city'][8]"
multicity_fifth_source_city = "//span/div[@class='asr-albtm']/descendant::p[@class='ars-city'][9]"
multicity_fifth_destination_city = "//span/div[@class='asr-albtm']/descendant::p[@class='ars-city'][10]"
multicity_sixth_source_city = "//span/div[@class='asr-albtm']/descendant::p[@class='ars-city'][11]"
multicity_sixth_destination_city = "//span/div[@class='asr-albtm']/descendant::p[@class='ars-city'][12]"


multicity_first_departure_date = "//span/div[@class='asr-albtm']/descendant::span[@class='at-fontweight dur-timefont'][1]"
multicity_second_departure_date = "//span/div[@class='asr-albtm']/descendant::span[@class='at-fontweight dur-timefont'][3]"
multicity_third_departure_date = "//span/div[@class='asr-albtm']/descendant::span[@class='at-fontweight dur-timefont'][5]"
multicity_fourth_departure_date = "//span/div[@class='asr-albtm']/descendant::span[@class='at-fontweight dur-timefont'][7]"
multicity_fifth_departure_date = "//span/div[@class='asr-albtm']/descendant::span[@class='at-fontweight dur-timefont'][9]"
multicity_sixth_departure_date = "//span/div[@class='asr-albtm']/descendant::span[@class='at-fontweight dur-timefont'][11]"




roundtrip_split_flights_toggle_button="//div[@id='toggle__wrapper--checkboxid']"
select_onward_flight_for_stops_filter="//li[contains(@class,'multic')][1]"


select_return_flight_for_stops_filter="//li[contains(@class,'multic')][2]"
onward_flight_fare_type_text="(//span[contains(@class,'label label-warning ars')])[1]"
return_flight_fare_count="//i[@class='fa fa-share-alt']/following::span[contains(@class,'label')]"
return_flight_fare_type_text="//i[@class='fa fa-share-alt']/following::span[contains(@class,'label')][index]"
select_fare_for_return_flight="//i[@class='fa fa-share-alt']/following::label[contains(@class,'sort-labelfi')][index]"
select_fare_for_onward_flight="(//label[contains(@class,'sort-labelfill sor')])[1]"


first_airline_searched_text = "//li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle'][1]"
first_airline_searched_text_right_side="//i[@class='fa fa-share-alt']/following::li[contains(@class,'ars-mobcss sort-detailist')]"
select_onward_airline="(//p[text()='Onward']/span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::span[contains(text(),'airlinetxt')]//following-sibling::span)[2]/label"
select_return_airline="//p[text()='Return']/span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::span[@class='flight__airline__name' and not(contains(text(),'airlinetxt'))]/../descendant::i[@class='fa fa-check']"
change_class_onward_adult_tax="(//span[contains(normalize-space(.),'Fare Details for Adult')]/following-sibling::div/div[@class='col-sm-4']/ul/li)[2]"
change_class_onwards_child_tax="(//span[contains(normalize-space(.),'Fare Details for Child')]/following-sibling::div/div[@class='col-sm-4']/ul/li)[2]"
change_class_onward_adult_base_fare="(//span[contains(normalize-space(.),'Fare Details for Adult')]/following-sibling::div/div[@class='col-sm-4']/ul/li)[1]"
change_class_onwards_total_base_fare="(//span[contains(normalize-space(.),'Fare Details for Adult')]/following-sibling::div/div[@class='col-sm-5']/ul/li)[1]"
change_class_onwards_child_base_fare = "(//span[contains(normalize-space(.),'Fare Details for Child')]/following-sibling::div/div[@class='col-sm-4']/ul/li)[1]"
change_class_onwards_child_total_taxes_price = "(//span[contains(normalize-space(.),'Fare Details for Child')]/following-sibling::div/div[@class='col-sm-5']/ul/li)[1]"
change_class_onwards_infants_taxes="(//span[contains(normalize-space(.),'Fare Details for Infant')]/following-sibling::div/div[@class='col-sm-4']/ul/li)[2]"
change_class_onwards_infants_all_taxes="(//span[contains(normalize-space(.),'Fare Details for Infant')]/following-sibling::div/div[@class='col-sm-5']/ul/li)[2]"
change_class_onwards_total_fare="//span[text()='Total']/ancestor::div/following-sibling::div[@class='col-sm-5'][1]"
change_class_onwards_adult_total_taxes="(//span[contains(normalize-space(.),'Fare Details for Adult')]/following-sibling::div/div[@class='col-sm-5']/ul/li)[2]"


# Cross Fare Verification Locators on flight Itinerary Page
onward_fare_type_text="(//span[contains(@class,'ars-flightlabel')])[1]"
return_fare_type_text="(//p[@class='apt-firstpr apt-firstpr-positionHandle'])[2]/following::span[contains(@class,'label l')]"


arrival_button="//button[text()='Arrival']"
book_button_on_change_class="(//button[text()='BOOK'])[last()]"


onward_airlines_text = '//div[@class="al-priceac pt-10"]//p[text()="Onward"]//span[text()="Airlines"]'
ai_express_checkbox = '(//div[@class="al-multifare mt-10"]//span[@class="pull-right"]//i[@class="fa fa-check"])[2]'
first_onward_airline = "//p[text()='Onward']/span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::i[@class='fa fa-check']"
akasa_air_checkbox = '(//div[@class="al-multifare mt-10"]//span[@class="pull-right"]//i[@class="fa fa-check"])[2]'
return_airlines_ai_express = '(//div[@class="al-multifare mt-10"]//span[@class="pull-right"]//i[@class="fa fa-check"])[8]'
onward_terminal_text = '(//p[@class="al-prresets pb-10"])[5]'
return_airlines_air_asia = '(//div[@class="al-multifare mt-10"]//span[@class="pull-right"]//i[@class="fa fa-check"])[10]'
onward_airlines_text_code_flight_details_page = "(//div[@class='row mt-10 media-print-flightview ']//li[@class='apt-listspan apt-listspan-positionHandle'])[1]"
return_airlines_text_code_flight_details_page = '(//div[@class="apt-btmborder"]//p[@class="apt-firstpr apt-firstpr-positionHandle"])[2]//following::li[@class="apt-listspan apt-listspan-positionHandle"]'
flight_details_back_button = '//button[@class="btn btn-warning asr-book"]'
to_fare_id_i_button = "//div[@class='asr-albtmround']//span[@class='fa fa-info-circle edit-icon-tiles']"
fare_id_i_cross_button = '(//div[@class="asr-roundbtm"])[2]//div[@class="popup_inner-content popup_inner-content-positionHandle"]//button[@class="airlineInfo__headerButton"]'


from_supplier_id_text = "(//span[text()='Supplier Id']/../../descendant::a)[1]"
to_supplier_id_text = "(//span[text()='Supplier Id']/../../descendant::a)[2]"


view_details_button2 = "(//span[contains(@class,'flightTiles__container-wrapper-positionHandle')]/descendant::span[@class='amt-multicity-cityNames-positionHandle'])[2]/following::button[text()='View Details'][1]"
view_details_button3 = "(//span[contains(@class,'flightTiles__container-wrapper-positionHandle')]/descendant::span[@class='amt-multicity-cityNames-positionHandle'])[2]/following::button[text()='View Details'][1]"




to_price_button = '(//div[@class="ars-listbtrow"])[2]//button[text()="Price"]'
to_arrival_button = '(//div[@class="ars-listbtrow"])[2]//button[text()="Arrival"]'
# select_class_radiobutton="//label[text()='classname']//ancestor::ul/li"    #If we want to give class name from excel sheet#//label[text()='C9']//ancestor::ul/li/input
select_class_radiobutton="//li[@class='changeclass__wrapper--classlist'][2]"
get_fare_button="//button[text()='Get Fare']"
total_segment_count="//ul[@class='ars-listair flightDetails-listair-positionHandle']"


# Third Flight
fare_details_tab_for_third_trip="(//a[text()='Fare Details'])[3]"
adult_base_fare_for_third_trip="((//span[contains(normalize-space(.),'Fare Details for Adult')])[3]/following-sibling::div/div[@class='col-sm-5']/ul/li)[1]"
child_base_fare_for_third_trip="((//span[contains(normalize-space(.),'Fare Details for Child')])[3]/following-sibling::div/div[@class='col-sm-5']/ul/li)[1]"
infant_base_fare_for_third_trip="((//span[contains(normalize-space(.),'Fare Details for Infant')])[3]/following-sibling::div/div[@class='col-sm-5']/ul/li)[1]"
adult_taxes_third_trip="((//span[contains(normalize-space(.),'Fare Details for Adult')])[3]/following-sibling::div/div[@class='col-sm-5']/ul/li)[last()-0]"
adult_total_base_price_third_trip="((//span[contains(normalize-space(.),'Fare Details for Adult')])[3]/following-sibling::div/div[@class='col-sm-5']/ul/li)[1]"
adult_total_tax_price_third_trip="((//span[contains(normalize-space(.),'Fare Details for Adult')])[3]/following-sibling::div/div[@class='col-sm-5']/ul/li)[last()-0]"
child_taxes_for_third_trip="(//span[contains(normalize-space(.),'Fare Details for Child')])[3]/following-sibling::div/div[@class='col-sm-5']/ul/li[2]"
child_total_base_price_third_trip="((//span[contains(normalize-space(.),'Fare Details for Child')])[3]/following-sibling::div/div[@class='col-sm-5']/ul/li)[1]"
child_total_taxes_price_third_trip= "((//span[contains(normalize-space(.),'Fare Details for Child')])[3]/following-sibling::div/div[@class='col-sm-5']/ul/li)[last()-0]"
infant_taxes_third_trip = "((//span[contains(normalize-space(.),'Fare Details for Infant')])[3]/following-sibling::div/div[@class='col-sm-5']/ul/li)[2]"
infant_total_base_price_third_trip = "((//span[contains(normalize-space(.),'Fare Details for Infant')])[3]/following-sibling::div/div[@class='col-sm-5']/ul/li)[1]"
infant_total_taxes_price_third_trip = "((//span[contains(normalize-space(.),'Fare Details for Infant')])[3]/following-sibling::div/div[@class='col-sm-5']/ul/li)[2]"
select_return_flight = '//i[@class="fa fa-share-alt"]//following::span[@class="fare__amount"]'


