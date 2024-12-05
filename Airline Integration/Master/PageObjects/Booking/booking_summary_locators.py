# Fare Handle Fare Jump Popupmary booking summary page
base_fare = "//div[@class = 'btm-border bold-font-bf fareSummary-boldFont-positionHandle']/span[2]"
taxes_and_fees = "//div[@class = 'clearfix btm-border bold-font fareSummary-boldFont-positionHandle']/span[2]"
total_amount = "//div[@class = 'bold-font btm-border fareSummary-boldFont-positionHandle']/span[2]"

# pax details
pax_names = "//div[@class = 'pax-tdsecond']"

# Booking details
booking_success_status = (
    "//span[@class ='booking__status-successTrip']/span[text()='Booking']/following-sibling::span[text()='Success']")
booking_status = "//span[@class='booking__status-successTrip']"
booking_id = "//p[@class = 'abt-succedspan']/child::a"
important_information_title = (
    "//div[@class = 'abt-mwsg mt-20 false']/descendant::span[text() = 'IMPORTANT INFORMATION']")
more_option_button = "//div[@class ='tgs-button tgs-button-variant-normal tgs-button-variant-normal-positionHandle']"
flight_segment_container = "//div[@class = 'segment__container-border-box']"

# Booking Notification
booking_notification = "//div[@class = 'toast-notification']/span[contains(text(),'Please note down reference id:')]"



book_button = "//button[text()='BOOK']"
passenger_name_dob_on_booking_summary = "//div[@class = 'pax-tdsecond']"
pnr_ticket_no_status_booking_summary_page = "//div[@class = 'pax-tdthird']"
meal_baggage_seat_booking_summary_page = "//div[@class = 'pax-tdfour']"
print_icon_class= "//div[@class='pax-tdfirstprint']"
print_icon = "//div[@class='pax-tdfirstprint']/i"
submit_button = "//button[text()='Submit']"
booking_id_link = '//p[@class="abt-succedspan"]//a'
pay_button = '//button[@class="btn add_money-btn"]'
un_hold_button = '''//div[@class="tgs-button tgs-button-variant-normal" and text()='UnHold']'''
booking_toast_close_button = "//i[@class='fa fa-close']"
booking_status_unconfirmed = "//span[@class ='booking__status-successTrip']/span[text() = 'Unconfirmed']"
confirm_to_proceed_checkbox = "//label[@for ='confirmUnhold']//child::i"
button_submit = "//button[@class = 'btn-login-success submit-btn-confirm']"
button_fare_rule_summary = "//button/span[text()='Fare Rules']"

#card details
booking_id_text_on_cart = '(//span[@class="cart_info-field--detail"])[1]'
booking_id_text_cart_details = '(//ol[@class="breadcrumb-arrow"]//li)[4]/span'
amount_text_on_cart = '(//span[@class="cart_info-field--detail"])[2]'
booking_status_text = '//span[@class="booking__status-successTrip"]//child::span[text()="Booking"]//following-sibling::span'
cart_detail_status_text = "(//p[@class='cart_info-field--title'])[3]"
cart_details_notes_tab = "//h3[text()='Notes']"

pay_now_btn_on_hold = "//div[text()='Pay Now']"
close_button_booking_summary_success_page = "//button[@class='styles_closeButton__20ID4']"
continue_button_booking_summary_success_page = "//button[text()='Continue']"


#baggage information
baggage_info_row_search_page = "//div[contains(@class, 'baggageData-row-positionHandle')]"
baggage_info_column_search_page = "//div[contains(@class, 'baggage__info-positionHandle')]/div"
checkin_column_search_page = "//div[contains(@class, 'baggage__info-positionHandle')]/div[2]"
# cabin_column_search_page = "//div[contains(@class, 'baggage__info-positionHandle')]/div[3]"
flight_itininary_review_page_bagaage_info = "//div[contains(@class, 'no-paddmobile')]/descendant::span[@class='graycolor']"
summary_page_baggage_info = "(//div[contains(@class, 'confirmationPage-baggageInfo-positionHandle')])"

round_trip_return_stop = "//span[text()='Stops']/following::li[2]"
fare_rule_segment_tabs = "//div[@class='fareRules__segmentChipContainer']//div[contains(@class, 'fareRules__segmentChip')]"
zero_stop_filter = "//span[text()='Stops']/following::a[text()='0']"


#booking summary page
total_passenger_count= '//div[@class="pax-tdfirst graycolor"]'
booking_id_on_booking_page= '//span[text()="Booking ID"]'
passenger_count_on_booking_page= '//div[@class="pax-tdsecond"]'
total_fare_amount= '//span[normalize-space()="Total"]//following-sibling::span[@class="pull-right fareSummary-prices-positionHandle"]'
markup_icpn= '//i[@title="Change markup"]'
markup_field= '//input[@name="markupPrice"]'
markup_update_button= '//button[text()="Update"]'
total_print_icon= "//div[contains(@class, 'print-checkboxs')]/input"
invoice_back_button= "//a[text()='Back']"
customer_invoice_option= '//span[text()=" Invoice For Customer"]'
cutomer_name_field= '(//input[@type="text"])[2]'
cutomer_address_field= '(//input[@type="text"])[3]'
cutomer_invoice_view_button= '//button[text()="View"]'
#total_amount_on_cutomer_invoice= '//tr/th[text()="Total Fare"]/following-sibling::th | //tr/th/strong[text()="Total Fare"]/following-sibling::th/strong'
total_amount_on_cutomer_invoice = '(//div[@class="bill_breakup"]//table[@class="bill_table invoice_table"]//th)[2]//strong'

agency_invoice_option= '//a[contains(@href,"type=AGENCY")]'
total_amount_on_agency_invoice= '//strong[text()="Net Amount"]/parent::td/following-sibling::td[@class="right_txt"]'

#search page filter
airlines_text= "//span[contains(text(),'Airlines')]/parent::p/child::i"
spicejet_airline_text= '//span[@class="flight__airline__name"][text()="Gulf Air"]'
emirates_airlines_checkbox= '//span[@class="flight__airline__name"][text()="Emirates Airlines"]/following-sibling::span[@class="pull-right"]/descendant::i[@class="fa fa-check"]'
markup_icon_on_search_page= '((//div[@class="row flight-rowmain flight-rowmain-positionHandle"])/div/following::div//ul[@class="ars-radiolist"]/descendant::span[@class="fare__amount"][1])[1]'
fare_amount_on_search_page= '((//div[@class="row flight-rowmain flight-rowmain-positionHandle"])/div/following::div//ul[@class="ars-radiolist"]/descendant::span[@class="fare__amount"][1])[1] '


#pax details page
indian_option= '//option[text()="India"]'
indian_option_for_child= "(//option[text()='India'])[2]"
indian_option_for_infant= "(//option[text()='India'])[last()]"

flight_count= '//div[@class="row seatMapSection-row-positionHandle"]'

#seat map window
journey_on_seat_map= '//div[@class="seat-map__flight-info"]'
total_seat_count= '//li[@class="graycolor"]/parent::ul/following-sibling::div/descendant::span[@class="art-spnlist"]'


#cart details page
cart_detail_text= '//span[text()="Cart-detail"]'
airline_PNR_field= '//input[@placeholder="Airline PNR"]'
GDS_number_field= '//input[@placeholder="GDS PNR"]'
ticket_number_field= '//input[@placeholder="Ticket Number"]'


fare_rule_segment_tabs_count= "//span[@class='fareRules__segmentInfo']"
pax_name_on_print_page = "(//td[@class='printPadd'])[1]"

flight_name_summary_print = "//tr[@class='airlineLogoInfo']/td/p"
departure_summary_print = "//td[@class='deptCityInfo']"
destination_summary_print = "//tr/td[@class='stopArrow']/following-sibling::td[1]"
flight_duration_flight_type_summary_print = "//td[@class='mealbagInfo']"
email_print_page = "//td[contains(text(),'Email')]"
contact_print_page = "//td[contains(text(),'Contact')]"

is_hand_baggage_popup='//p[@class="board__popup--msg"][text()="You have selected Hand baggage fare"]'
hand_baggage_continue_button= "//button[@class='fare-yesbutton'][text()='Continue']"


passport_field = '(//select[contains(@name,"pNat")])[1]'
is_fare_have_changed_baggage = "//p[contains(@class,'fareJumpPopup') and contains(text(),'Baggage')]"
continue_btn_fare = "//button[text()='Continue']"


ok_button_on_popup = "//div[@class='pendingPopup']/child::div[@class='pendingPopup__buttonContainer']/button"

