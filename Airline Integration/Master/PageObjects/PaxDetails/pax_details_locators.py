pax_detail_title = "//h3[@class= 'apt-heading']/span[text()='Passenger Details']"

# Airports
bengaluru_blr_airport = "//span[@class='at-topcity-names' and text()='BLR' ]"
delhi_del_airport = "//span[@class='at-topcity-names' and text()='DEL' ]"
mumbai_bom_airport = "//span[@class='at-topcity-names' and  text()='BOM']"
goa_goi_airport = "//span[@class='at-topcity-names' and  text()='GOI']"
hyderabad_hyd_airport = "//span[@class='at-topcity-names' and  text()='HYD']"
port_blair_airport = "//span[@class='at-topcity-names' and  text()='IXZ']"

# Search Page
where_from_field = "//div[@id='origin']//div[@class='react-select__input']/input"
where_to_field = "//div[@id='destination']//div[@class='react-select__input']/input"
direct_flight_checkbox = "//label[@for='stop-check']"

dashboard_nav_btn = "//a[@href='//qa-dashboard.technogramsolutions.com/manage-user']"
starts_from = "//div[@id = 'origin']"
search_btn = "//button[normalize-space()='Search']"
departure_date = "(//div[@aria-label='day-1'][normalize-space()='1'])[1]"
search_loader = "//div[@class='lds-ellipsis lds-ellipsis-positionHandle']"

departure_date_field = "//input[@placeholder='Departure Date']"
return_date_field = "//input[@placeholder='Return Date']"
next_month_arrow_btn = "//button[normalize-space()='Next month']"
book_btn = "(//button[contains(text(),'BOOK')])[1]"

fare_jump_continue_btn = "//button[@class = 'fareJumpPopup__continueButton']"
add_passengers_btn = "//button[@class= 'btn btn-warning asr-book asr-book-positionHandle']/i"
fare_have_changed_continue_button = "//button[normalize-space()='Continue']"
adult_title_dropdown = "//select[@class='main-select main-select-positionHandle' and contains(@name,'ADULT')]"
child_title_dropdown = "//select[contains(@name,'CHILD') and @class='main-select main-select-positionHandle']"
infant_title_dropdown = "//select[contains(@name,'INFANT') and @class='main-select main-select-positionHandle']"
adult_title_mr = "//select[contains(@name,'ADULT')]/option[@value='Mr']"
child_title_master = "//select[contains(@name,'CHILD')]/option[@value='Master']"
infant_title_ms = "//select[contains(@name,'INFANT')]/option[@value='Ms']"
adult_first_name_field = "//input[contains(@name,'ADULT') and @placeholder='First Name']"
child_first_name_field = "//input[contains(@name,'CHILD') and @placeholder='First Name']"
infant_first_name_field = "//input[contains(@name,'INFANT') and @placeholder='First Name']"
adult_last_name_field = "//label[text()='Last Name' or text()='Last Name*']/preceding-sibling::input[contains(@name,'ADULT')]"
child_last_name_field = "//label[text()='Last Name' or text()='Last Name*']/preceding-sibling::input[contains(@name,'CHILD')]"
infant_last_name_field = "//label[text()='Last Name' or text()='Last Name*']/preceding-sibling::input[contains(@name,'INFANT')]"
adult_dob_field = "//input[contains(@name,'ADULT') and (@placeholder = 'Date of Birth *' or @placeholder = 'Date of Birth' )]"
child_dob_field = "//input[contains(@name,'CHILD') and (@placeholder = 'Date of Birth *' or @placeholder = 'Date of Birth' )]"
infant_dob_field = "//input[contains(@name,'INFANT') and (@placeholder = 'Date of Birth *' or @placeholder = 'Date of Birth' )]"
refundable_booking_skip_btn = '''//span[normalize-space()="No, I'll skip."]'''
passenger_mobile_number_field = "//input[@id= 'mobile_feild']"
proceed_to_review_button = "//button[normalize-space()='PROCEED TO REVIEW']"
yes_make_refundable_btn = "//input[@id='protectGrp__yes']"
recommended_section = "//span[@class='protectGrp__recomend']"
proceed_to_pay_btn = '//button[@class = "btn btn-warning asr-book asr-book-positionHandle"]'
review_booking_header = '//div[@class = "booking-header"]'
accept_terms_checkbox = "//div[@class = 'termsConditionsLink__wrapper']/child::input"
pay_now_btn = "//button[@class='btn add_money-btn']"
consent_msg_continue_btn = "//button[normalize-space()='Continue']"
booking_status = "//span[@class='booking__status-successTrip']"
booking_status_success =  "//span[@class='booking__status-successTrip']/child::span[text()='Success']"
booking_status_cancelled = "//span[@class='booking__status-successTrip']/child::span[text()='Cancelled']"
booking_status_pending = "//span[@class='booking__status-successTrip']/child::span[text()='Pending']"
pay_now_btn_on_hold = "//div[text()='Pay Now']"
pax_search_field = '//input[@class="react-autosuggest__input"]'
first_passenger_from_search = '//div[@id="react-autowhatever-1"]/ul/li[@id="react-autowhatever-1--item-0"]'
passenger_email = '//input[@placeholder="Email ID *"]'

# Search Result Page
review_page_title = '//div[@class="booking-header"]/child::h3/span[text()="Review"]'
flight_types = "//span[@class= 'ars-arrowsun']"

# Passport Details
nationality_dropdown = "//select[@name='ADULT1_pNat']"
nationality_india = "//option[@value='IN']"
passport_number = "//input[@id='ADULT1_pNum_feild']"
passport_issue_date = "//input[@placeholder='Issue Date *' or @placeholder='Issue Date']"
passport_expiry_date = "//input[@placeholder='Expiry Date *']"
adult_dob = "//input[@placeholder='Date of Birth *' or @placeholder='Date of Birth']"
add_passenger_info_label = "//span[normalize-space()='ADD PASSPORT INFORMATION']"
passenger_dob = "//input[@placeholder='Date of Birth *' or @placeholder='Date of Birth']"

# Markup
markup_icon = '//i[@title="Change markup"]'
markup_text = '//input[@id="markupPrice_feild"]'
markup_update_btn = '//button[@class="markup__update-btn markup__update-btn-positionHandle"]'
back_btn = '//button[@class="btn btn-warning asr-book"]/i'
back_button_pax='//span[text()="Back"]//parent::button[@class="btn btn-warning asr-book"]'
radio_btn = '//label[@class="protectGrp__radio__label"]'
phone_no = '//input[@placeholder="Mobile Number *"]'
toggle_btn = '//div[@class="toggle__wrapper"]'
search_field_div = '//div[@id="react-autowhatever-1"]'
missing_box_div = '//div[@class="missingNameBox"]'
passenger_destination_address= '//input[contains(@placeholder,"Destination Address *")]'

# GST DETAILS
gst_no = '//input[@id="gstNumber_feild"]'
gst_name = '//input[@id="gstName_feild"]'
gst_email = '//input[@id="gstEmail_feild"]'
gst_phone_no = '//input[@id="gstPhone_feild"]'
gst_address = '//input[@id="gstAddress_feild"]'
gst_clear_btn = '//span[@class="gst-clear gst-clearButton-positionHandle"]'
gst_search_field = '//input[@list="gstCompanyNames"]'
save_gst_btn = '//span[text()="Save GST Details"]//preceding-sibling::div/i'

# locators of next page
payment_btn = '//button[@class="btn btn-warning asr-book asr-book-positionHandle"]'
terms_condition_checkbox = '//div[@class="termsConditionsLink__wrapper"]//descendant::input'
confirm_transaction = '//button[@class="fare-yesbutton"]'

# tj cash input field
tj_cash = '//input[@id="coinsBalance_feild"]'
voucher_code = '//input[@id="vcode_feild"]'
redeem_btn = '//button[text()="REDEEM"]'
apply_btn = '//button[text()="APPLY"]'

# Passport details x path
passport_no = '//input[@placeholder="Passport Number"]'
issue_date = '//input[@placeholder="Issue Date"]'
exp_date = 'placeholder="Issue Date"'
dob_passport = '//input[@placeholder="Date of Birth"]'
nationality = '//label[text()="Nationality"]//following-sibling::i[@class="fa fa-angle-down fonticon-caret fonticon-caret-positionHandle"]'
nationality_selector = 'class="main-select main-select-positionHandle"'

#Seat Map
show_seat_map_btn = '//button[@class="btn btn-warning asr-book"][text()="Show Seat Map"]'
seat_map_source_dest = '//div[@class="col-sm-4 seatmap-box--flight"]//descendant::b'
seat_map_date = '//div[@class="col-sm-4 seatmap-box--flight"]//span[@class="graycolor"]'

# Flight details
# flight_details_total_amt = "(//div[@class='bold-font btm-border fareSummary-boldFont-positionHandle']//child::span[@class='pull-right fareSummary-prices-positionHandle'])[1]"
flight_details_total_amt= "//div[contains(@class,'fareSummary')]//span[text()='Amount to Pay']/parent::div/child::span[contains(@class,'fareSummary')]"
refundable_btn = '//label[@class="protectGrp__radio__label protectGrp__radio__label--highlighted"]'

# View Details
stops_selector = "//div[@class='al-multifare mt-10']//descendant::li//descendant::a[text()=0]"
flight_details = "//p[@class='flight-details-top-list flight-details-top-list-positionHandle']"
view_details_button = "(//button[@class='btn btn-default asr-viewbtn'][text()='View Details'])[1]"
flight_date_name_from_first = '(//div[@class="col-sm-7 no-padding"]//descendant::li[@class="ars-lsprice ars-prclist"])[1]'
flight_date_name_to_first = '(//div[@class="col-sm-7 no-padding"]//descendant::li[@class="ars-lsprice ars-prclist"])[2]'
flight_date_name_from_second = '(//div[@class="col-sm-7 no-padding"]//descendant::li[@class="ars-lsprice ars-prclist"])[3]'
flight_date_name_to_second = '(//div[@class="col-sm-7 no-padding"]//descendant::li[@class="ars-lsprice ars-prclist"])[4]'
flight_source_destination_city ='//b[@class="cityContainer-positionHandle"]'
flight_source_destination_date = "//span[@class='graycolor flightDetails-dateDetails-positionHandle']"
book_button = "(//button[contains(text(),'BOOK')])[1]"
save_pax_details_btn = '//span[text()="Save Passenger Details"]//preceding-sibling::div/i'
arrow_for_toggle = "//div[@class='panel-heading pax-box-arrow']"
up_arrow_btn = "//span[contains(text(),'ADULT') or contains(text(),'CHILD') or contains(text(),'INFANT')]/following-sibling::span/i[@class='fa fa-angle-up']"
dashboard_tj_cash='//span[text()="TJ Cash"]//following-sibling::span'

# For getting passenger details
toggle_button_locator = "//div[@class='toggle__wrapper']"
first_passenger = "//span[@class='bold-font paxlabel_ADULT-1']"
child_passenger = "//span[@class='bold-font paxlabel_CHILD-1']"
infant_passenger = "//span[@class='bold-font paxlabel_INFANT-1']"
frequent_flier_field = "//h5[@class='apt-addpassport review-heading']"
ff_number_input_field = "//input[@placeholder='FF Number']"
add_baggage_meal_section = "//span[@class='bagmealsection-headingText-positionHandle']"
add_baggage_dropdown_field = "(//label[text()='Baggage Information']//following-sibling::select[@class='main-select main-select-positionHandle'])[1]"
add_meal_dropdown_field = "(//label[text()='Select Meal']//following-sibling::select[@class='main-select'])[1]"
selected_baggage = "(//label[text()='Baggage Information']//following-sibling::select/option[contains(@value,'ADULT1')])[2]"
selected_meal = "//select[@class='main-select']//child::option[2]"
baggage_meal_fare = "//span[text()='Meal, Baggage & Seat']"
baggage_fare_price = "(//div[@class='tax-dropdown airline-gst-print']//child::span[text()='Baggage']/following-sibling::span[contains(@class,'fareSummary')])"
meal_fare_price = "(//div[@class='tax-dropdown airline-gst-print']//child::span[text()='Meal']/following-sibling::span[contains(@class,'fareSummary')])"

# For getting fare summary details
base_fare_price = "(//span[@class='pull-right fareSummary-prices-positionHandle'])[1]"
taxes_fees_price = "(//span[@class='pull-right fareSummary-prices-positionHandle'])[2]"
amount_to_pay_price = "//div[contains(@class,'fareSummary')]//span[text()='Amount to Pay']/following-sibling::span[contains(@class,'pull-right fareSummary')]"
tj_flex_fee= "//div[contains(@class,'fareSummary')][text()='TJ Flex Fee']/child::span[contains(@class,'pull-right fareSummary')]"

# Review Page
passenger_review_page_field = "//div[@class='art-tdsecond']"
email_id_review_page_field = "//p[@class='reviewPage-apt-passdel-positionHandle'][1]//child::span[1]"
mobile_no_review_page_field = "//p[@class='reviewPage-apt-passdel-positionHandle'][2]//child::span"
save_pax_details = "//span[text()='Save Passenger Details']/preceding-sibling::div[@class='al-indiv']"
fare_jump_popup = '''//div[@class="fareJumpPopup__fareBox"]//child::span[normalize-space()='New Fare']'''
old_fare_amount = "//span[@class='fareJumpPopup--fareOldAmountText']"
new_fare_amount = "//span[@class='fareJumpPopup--fareNewAmountText']"
fare_jump_back_btn = "//button[@class = 'fareJumpPopup__backButton']"
fare_change_title = "//p[text()='Fare have changed' and @class= 'fareJumpPopup--subHeading']"
frequent_flier_number = "//h5[@class='apt-addpassport review-heading']//child::span"
deposit_link = '//li[@class="art-active art-active-positionHandle"]//a[text()="Deposit"]'
flight_btn= "//a[contains(@href,'flight')][text()='Flight']"
adult_search_field = '//input[@name="ADULT1-passengerName"]'
child_search_field = '//input[@name="CHILD1-passengerName"]'
infant_search_field = '//input[@name="INFANT1-passengerName"]'
first_adult_from_search = '(//input[@name="ADULT1-passengerName"]//following-sibling::div/ul/li)[1]'
first_child_from_search = '(//input[@name="CHILD1-passengerName"]//following-sibling::div/ul/li)[1]'
first_infant_from_search = '(//input[@name="INFANT1-passengerName"]//following-sibling::div/ul/li)[1]'
scroll_bar = '//span[@class="header-icons header-icons-positionHandle"]/i'
review_mobile_number = "(//div[@class='apt-btmborder pb-30']//span[@class='art-conemail'] )[2]"
review_email = "(//div[@class='apt-btmborder pb-30']//span[@class='art-conemail'] )[1]"

flight_with_tj_flex = '(//div[@class="row flight-rowmain flight-rowmain-positionHandle"]//span[@class="label label-violet ars-flightlabel ars-refunsleft ars-flightlabel-positionHandle"])[1]'
flight_without_tj_flex = '(//div[@class="row flight-rowmain flight-rowmain-positionHandle"]//span[@class="fare__amount"])[2]'
book_with_tj_flex_button = '//span[@class="tjFlex__radio--text" and contains(text(), "Book with TJ Flex")] '
tj_flex_radio_button_amount = '//div[@class="panel panel-default tjFlex"]//span[@class="tjFlex--amountText"]'
tj_cash_redeemed = "//div[text()='TJ Cash Redeemed']"
tj_cash_redeemed_amount = '//div[@class="bold-font btm-border fareSummary-boldFont-positionHandle" and contains(text(),"TJ Cash Redeemed")]//span'

#Tj Cash
tj_cash_field = "//input[@placeholder='Enter Cash']"
redeem_button = "//Button[text()='REDEEM']"
available_tj_cash = "//span//following-sibling::span[@class='topbar__list--coin']"
tj_cash_summary = "//div[contains(normalize-space(),'TJ Cash Redeemed')]/span[@class='pull-right fareSummary-prices-positionHandle']"

consent_message_popup = '//div[@class="react-confirm-alert-body "]//p[text()="Consent message "]'

total_passport_info_tab="//span[text()='ADD PASSPORT INFORMATION']"
select_nationality_dropdown="(//label[text()='Nationality']/following-sibling::select[@class='main-select main-select-positionHandle'])[index]"
select_india="(//label[text()='Nationality']/following-sibling::select[@class='main-select main-select-positionHandle'])[index]/option[text()='India']"
passport_number_in_pax_detail="(//input[@placeholder='Passport Number *'])[index]"
pass_issue_date="(//input[@placeholder='Issue Date *'])[1]"
