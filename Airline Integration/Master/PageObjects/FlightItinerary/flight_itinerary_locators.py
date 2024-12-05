# fare jump pop-up
fare_jump_popup = "//div[@class= 'fareJumpPopup__container']"
old_fare_amount = "//span[@class='fareJumpPopup--fareOldAmountText']"
new_fare_amount = "//span[@class='fareJumpPopup--fareNewAmountText']"
fare_jump_continue_btn = "//button[@class = 'fareJumpPopup__continueButton']"
fare_jump_back_btn = "//button[@class = 'fareJumpPopup__backButton']"
fare_change_title = "//p[text()='Fare have changed' and @class= 'fareJumpPopup--subHeading']"

# Fare summary
base_fare_summary = '''//span[normalize-space()='Base fare']//following-sibling::span[@class="pull-right fareSummary-prices-positionHandle"]'''
taxes_fees_summary = '''//span[normalize-space()='Taxes and fees']//following-sibling::span[@class="pull-right fareSummary-prices-positionHandle"]'''
amount_to_pay = '''//span[normalize-space()='Amount to Pay']//following-sibling::span[@class="pull-right fareSummary-prices-positionHandle"]'''
a_backToSearch = '//div[@class="iterinery-pageback"]'
back_btn = '''//span[text()='Back']//parent::button[@class="btn btn-warning asr-book"]'''

# Fare summary
edit_taxes_btn = "//i[@class = 'fa fa-edit fareSummary-markupEditIcon-positionHandle']"
markup_price_field = "//input[@id='markupPrice_feild']"
markup_update_btn = "//button[@class = 'markup__update-btn markup__update-btn-positionHandle']"

#flight detail Locators
flight_name_itinerary = '//span[@class="apt-gridspan at-fontweight graycolor"]'
departure_itinerary = '//li[@class="text-center"]//preceding-sibling::li'
destination_itinerary='//li[@class="text-center"]//following-sibling::li'
add_passengers_btn = '//button[@class="btn btn-warning asr-book asr-book-positionHandle"]'
fare_rule_segment_info_element="//span[@class='fareRules__segmentInfo']"
fare_rule_cancellation_fee_element = '''//div[@class="fareRules__headers"]//child::span[text()='Cancellation Fee']'''
fare_rule_cancellation_fee = '//div[@class="fareRules__ruleInfoContainer"]'
fare_rule_date_change_element = '''//div[@class="fareRules__headers"]//child::span[text()='Date Change Fee']'''
fare_rule_date_change_fee= '//div[@class="fareRules__ruleInfoContainer"]'
fare_detail_no_show_fee_element = '''//div[@class="fareRules__headers"]//span[text()='No Show Fee']'''
fare_detail_no_show_fee='//div[@class="fareRules__ruleInfoContainer"]'
fare_detail_seat_chargeable_element = '''//div[@class="fareRules__headers"]//span[text()='Seat Chargeable Fee']'''
fare_detail_chargeable_fee = '//div[@class="fareRules__ruleInfoContainer"]'
fare_detail_btn_itinerary = "//button//span[text()='Fare Rules']"
no_rules = '//span[@class="fareRules__noRule"]'

#baggage_locators
baggage_info_itinerary = '//div[@class="mt-10 farerules-mobhide no-paddmobile"]//child::span[@class="graycolor"]'
flight_duration_flight_type_itinerary = '//p[@class="apt-lasthour"]'

#popups
sold_out_popup = '//div[@class="react-confirm-alert-body soldout-modal"]'
sold_out_back_to_search_btn = '//button[@class="back__button"]'
sold_out_booking_logs_btn = '//button[@class="soldOutLogBtn sendetails-button-ornage"]'
fare_jump_popup_new = '''//div[@class="fareJumpPopup__fareBox"]//child::span[normalize-space()='New Fare']'''
fare_type_change_popup= '''//p[@class="fareJumpPopup__element fareJumpPopup--headerValues" and text()='Fare Type']'''

# baggage locators
baggage_information_btn = '''//a[text()='Baggage Information']'''
baggage_data_div = '//div[@class="row baggageData-row-positionHandle"]'
fare_rules_btn = '''//a[text()='Fare Rules']'''

# flight detail locators
flight_Name_locator = '//div[@class="atls-holdid atls-holdid-positionHandle"]'
flight_departure_detail = ('//li[@class="ars-lsprice ars-prclist atb-iconclass abt-nnstop '
                           'stop-arrowline"]//preceding-sibling::li')
flight_destination_detail = ('//li[@class="ars-lsprice ars-prclist atb-iconclass abt-nnstop '
                             'stop-arrowline"]//following-sibling::li')
flight_duration_flight_type_search_result = '//ul[@class="ars-listair"]/li'
view_details_button_right_section = '''((//div[@class="col-sm-6 domestic_tiles_view"])[2]//child::button[text()='View Details'])[1]'''
flight_time_data = '//span[@class="graycolor flight-timedata-font10"]'
flight_seatleft_data = '//span[@class="ars-seatleft flight-timedata-font10"]'
passenger_details_text="(//span[text()='Passenger Details'])[2]"

# markup
fare_prices = "//ul[@class='ars-radiolist']/descendant::span[@class='fare__amount']"
markup_update_all_btn = "//button[@class='markup__update-btn']"

flight_name_src_and_destination = "//p[contains(@class,'apt-firstpr') or @class='flight-details-top-list flight-details-top-list-positionHandle']"
#layover
layover_text = "//p[@class='apt-laypverdesktop layover-apt-positionHandle']"

#Tj Cash
tj_cash_field = "//input[contains(@placeholder,'Cash')]"
redeem_button = "//Button[text()='REDEEM']"
available_tj_cash = "//span//following-sibling::span[@class='topbar__list--coin']"
tj_cash_summary = "//div[contains(normalize-space(),'TJ Cash Redeemed')]/span[@class='pull-right fareSummary-prices-positionHandle']"

#search filter
multiple_stop_filter = "//span[text()='Stops']/following::a[text()='2']"

#session expire
ele_session_expired_popup = '//div[@class="react-confirm-alert-body "]'
ele_session_expire_time = '//span[@class="timer-content timer-content-positionHandle"]'
back_to_flight_list_button = '''//div[@class="react-confirm-alert-button-group text-right  linkedUserAlert-buttonContainer-positionHandle"]//child::button[text()='Back to flight list']'''
session_expired_continue_button = '''//div[@class="react-confirm-alert-button-group text-right  linkedUserAlert-buttonContainer-positionHandle"]//child::button[text()='Continue']'''

hand_baggage_popup_continue_button = "//button[@class='fare-yesbutton']"
