# Review page flight details
review_page_title = "//div[@class='booking-header']//span[text()='Review']"
departure_flight_details = "//li[@class = 'text-center']//preceding-sibling::li"
destination_flight_details = "//li[@class = 'text-center']//following-sibling::li"
flight_time_class = "//p[@class = 'apt-lasthour']"
passenger_count = "//h4[@class = 'apt-passdel']//span[2]"
passenger_name = "//div[@class = 'art-tdsecond']"
passenger_contact_email = "//p[@class= 'reviewPage-apt-passdel-positionHandle'][1]//span[@class = 'art-conemail']"
passenger_contact_mobile = "//p[@class= 'reviewPage-apt-passdel-positionHandle'][2]//span[@class = 'art-conemail']"
seat_details = "//span[@class = 'art-spnlist']"
selected_meal_baggage = "//div[@class = 'art-tdfour']"
down_arrow = '//span[@class = "show-review-details"]'
flight_duration_flight_type_review = '//p[@class="apt-lasthour"]'

# Fare summary
base_fare_summary = ("//div[@class = 'btm-border bold-font-bf fareSummary-boldFont-positionHandle']/child::span["
                     "@class= 'pull-right fareSummary-prices-positionHandle']")
taxes_fees_summary = ("//div[@class = 'clearfix btm-border bold-font "
                      "fareSummary-boldFont-positionHandle']/child::span[@class= 'pull-right "
                      "fareSummary-prices-positionHandle']")
amount_to_pay = ("//div[@class = 'bold-font btm-border fareSummary-boldFont-positionHandle']/child::span[@class= "
                 "'pull-right fareSummary-prices-positionHandle']")
edit_taxes_btn = "//i[@class = 'fa fa-edit fareSummary-markupEditIcon-positionHandle']"
markup_price_field = "//input[@id='markupPrice_feild']"
markup_update_btn = "//button[@class = 'markup__update-btn markup__update-btn-positionHandle']"

# GST Details
gst_number = "//p[@class = 'reviewPage-apt-passdel-positionHandle' and text()= 'Reg. Number']/span"
gst_company_name = "//p[@class = 'reviewPage-apt-passdel-positionHandle' and text()= 'Reg. Company']/span"

# all buttons and links
back_btn = "//i[@class= 'fa fa-angle-double-left back-button-positionHandle']"
terms_and_conditions_link = "//a[@class = 'termsConditionsLink']"
proceed_to_pay_button = "//button/span[contains(text(),'PROCEED TO PAY')]"
block_btn = "//button [@class = 'btn btn-warning asr-book' and text()='BLOCK']"

# Payment Page
payment_page_title = "//h3[@class = 'apt-heading']/span[text() = 'Payments']"
paynow_btn = "//button[@class ='btn add_money-btn']"
i_accept_checkbox = "//div[@class= 'termsConditionsLink__wrapper']/child::input"

# Hold Booking
booking_hold_status = "//span[@class = 'booking__status-successTrip']/child::span[text()='On Hold']"
unhold_btn = "//div[@class = 'tgs-button tgs-button-variant-normal' and text()= 'UnHold']"
pay_hold_flight_btn = "//div[@class = 'tgs-button tgs-button-variant-normal' and text()= 'Pay Now']"
