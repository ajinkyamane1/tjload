no_skip_button = '''//span[normalize-space()="No, I'll skip."]'''
proceed_to_review_button = '//button[@class="btn btn-warning asr-book asr-book-positionHandle"]'
mobile_number_field = "//input[@placeholder='Mobile Number *']"
passenger_details_base_fare = "//div[@class='btm-border bold-font-bf fareSummary-boldFont-positionHandle']//child::span[@class='pull-right fareSummary-prices-positionHandle']"
passenger_details_taxes_and_fees = "(//div[@class='clearfix btm-border bold-font fareSummary-boldFont-positionHandle']//child::span[@class='pull-right fareSummary-prices-positionHandle'])[1]"
passenger_details_total_amount = "(//div[@class='bold-font btm-border fareSummary-boldFont-positionHandle']//child::span[@class='pull-right fareSummary-prices-positionHandle'])[1]"
flight_details_base_fare = "//div[@class='btm-border bold-font-bf fareSummary-boldFont-positionHandle']//child::span[@class='pull-right fareSummary-prices-positionHandle']"
flight_details_taxes_and_fees = "(//div[@class='clearfix btm-border bold-font fareSummary-boldFont-positionHandle']//child::span[@class='pull-right fareSummary-prices-positionHandle'])[1]"
flight_details_total_amount = "(//div[@class='bold-font btm-border fareSummary-boldFont-positionHandle']//child::span[@class='pull-right fareSummary-prices-positionHandle'])[1]"

review_base_fare = "//div[@class='btm-border bold-font-bf fareSummary-boldFont-positionHandle']//child::span[@class='pull-right fareSummary-prices-positionHandle']"
review_details_taxes_and_fees = "(//div[@class='clearfix btm-border bold-font fareSummary-boldFont-positionHandle']//child::span[@class='pull-right fareSummary-prices-positionHandle'])[1]"
review_total_amount = "(//div[@class='bold-font btm-border fareSummary-boldFont-positionHandle']//child::span[@class='pull-right fareSummary-prices-positionHandle'])[1]"
proceed_to_pay_button = "//button[@class='btn btn-warning asr-book asr-book-positionHandle']"

payment_base_fare = "//div[@class='btm-border bold-font-bf fareSummary-boldFont-positionHandle']//child::span[@class='pull-right fareSummary-prices-positionHandle']"
payments_details_taxes_and_fees = "(//div[@class='clearfix btm-border bold-font fareSummary-boldFont-positionHandle']//child::span[@class='pull-right fareSummary-prices-positionHandle'])[1]"
payments_total_amount = "//div[contains(@class,'fareSummary')]//span[text()='Amount to Pay']/parent::div/child::span[contains(@class,'fareSummary')]"
pay_now_checkbox = "//input[@type='checkbox']"
pay_now_button = "//button[text()='Pay Now']"
continue_button = "//button[@class='fare-yesbutton'][text()='Continue']"
ele_session_expire_time = '//span[@class="timer-content timer-content-positionHandle"]'
ele_session_expired_popup = '//div[@class="react-confirm-alert-body "]'
btn_back_to_flight_list = '''//div[@class="react-confirm-alert-button-group text-right  linkedUserAlert-buttonContainer-positionHandle"]//child::button[text()='Back to flight list']'''
btn_session_expired_continue = '''//div[@class="react-confirm-alert-button-group text-right  linkedUserAlert-buttonContainer-positionHandle"]//child::button[text()='Continue']'''
a_backToSearch = '//div[@class="iterinery-pageback"]'
btn_back = '''//span[text()='Back']//parent::button[@class="btn btn-warning asr-book"]'''
back_to_review_button = "//div[@class='col-sm-6']//span"
review_page_url = 'https://qa.technogramsolutions.com/flight/review/R31-6772435398_0DELBLRSG8536~13453894172599831'
confirm_box_amt = '//div[@class="alertbox-contentwrapper alertbox-aligncenter"]//descendant::h3'
confirm_trans_back_btn = '//div[@class="react-confirm-alert-button-group text-right  linkedUserAlert-buttonContainer-positionHandle"]//descendant::button[text()="Back"]'
fare_jump_continue_btn = "//button[@class = 'fareJumpPopup__continueButton']"
fare_jump_popup = "//div[@class= 'fareJumpPopup__container']"
add_passengers_btn = "//button[@class= 'btn btn-warning asr-book asr-book-positionHandle']"
cust_title = "//select[@name='ADULT1_ti']//child::option[@value='Mr']"

# cust_first_name = "//label[@class='select-lebel-class commonInputBox-label-positionHandle']//preceding-sibling::input[@class='input-floating-lebel  false false' and @name='ADULT1_fN']"
cust_first_name = '//input[@class="input-floating-lebel  false false" and @name="ADULT1_fN"]'
# cust_last_name = "//label[@class='select-lebel-class commonInputBox-label-positionHandle']//preceding-sibling::input[@class='input-floating-lebel  false false' and @name='ADULT1_lN']"
cust_last_name = '//input[@class="input-floating-lebel  false false" and @name="ADULT1_lN"]'
# radio_skip = '''//span[normalize-space()="No, I'll skip."]'''
radio_skip = '//span[@class="protectGrp__radio--text" and contains(text(),"Yes make the booking Refundable for")]'

cust_mobile_num = "//input[@class='input-floating-lebel  false false' and @name='mobile']"
reference_id = "//span[contains(text(),'Please note down reference id: ')]"
duplicate_booking_back_to_search_btn = '//button[@class="fare-yesbutton"][text()="Back to search"]'
duplicate_booking_view_summary_btn = '//button[@class="fare-yesbutton"][text()="View Summary"]'
duplicate_booking_continue_btn = '//button[@class="fare-yesbutton"][text()="Continue"]'
booking_status_confirmation_page = '//span[@class="booking__status-successTrip"]'
booking_status_id = '//p[@class="abt-succedspan"]'
