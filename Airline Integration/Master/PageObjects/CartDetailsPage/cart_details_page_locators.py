# More options dropdown menu
more_options_dropdown = "//span[text()='More Options']//parent::div"
download_as_pdf_option = "//span[text()=' Download as PDF']"
print_tickets_option = "//span[text()=' Print Tickets']"
email_ticket_option = "//span[text()=' Email Ticket']"
sms_ticket_option = "//span[text()=' SMS Ticket ']"
whatsapp_me_option = "//li[text()=' WhatsApp Me']"
invoice_for_agency_option = "//span[text()=' Invoice For Agency']"
invoice_for_customer_option = "//span[text()=' Invoice For Customer']"
go_to_cart_details_option = "//a[text()='Go to Cart Details']"
add_meal_seat_bag_option = "//a[text()=' Add Meal, Seat, Bag']"
reschedule_option = "//li[text()=' Reschedule']"
web_check_in_option = "//li[text()=' Web Check-In']"

# Checkboxes
with_price_checkbox = "//input[@id='price']//following-sibling::label[text()='With Price']"
with_agency_checkbox = "//input[@id='agency']//following-sibling::label[text()='With Agency']"
with_gst_checkbox = "//input[@id='gst']//following-sibling::label[text()='With GST']"
old_print_copy_checkbox = "//input[contains(@id,'oldPrint')]//following-sibling::label[text()='Old Print Copy']"
select_all_checkbox = "//input[@id='selectAll']"

# Buttons
submit_button = "//button[text()='Submit']"
download_button = "//button[text()='Download']"
view_button = "//button[text()='View']"
whatsapp_button = "//button[text()='WhatsApp']"
continue_button_popup = "//button[text()='Continue']"
back_button = "//a[text()='Back']"
payment_passbook_search_button = "//button[contains(text(),'Search')]"
show_more_option_button = "//span[contains(text(),'Show More')]"
booking_id_field = "//input[@id='refId']"

# Cart Information
cart_booking_id = "//h3[contains(text(),'Cart Information : ')]"
cart_details_amount = "//p[contains(text(),'Amount')]//following-sibling::span/span"
cart_details_booking_id = "//p[contains(text(),'Booking Id')]/span/span"
cart_details_status = "//p[contains(text(),'Status')]/span/span"
cart_details_loggedin_user_1 = "(//p[contains(text(),'LoggedIn User')]/span/span/a)[1]"
cart_details_loggedin_user_2 = "(//p[contains(text(),'LoggedIn User')]/span/span/a)[2]"
cart_details_booking_user_1 = "(//p[contains(text(),'Booking User')]/span/span/a)[1]"
cart_details_booking_user_2 = "(//p[contains(text(),'Booking User')]/span/span/a)[2]"
booking_summary_link = "//a[contains(text(),'Booking Summary')]"
history_link = "//a[contains(text(),'History')]"
booking_logs_link = "//a[contains(text(),'Booking Logs')]"
cart_flight_name = "//span[@class='airline-code']//parent::p"
cart_flight_departure = "//div[@class='segment_body-flight-info'][1]"
cart_flight_stops = "//div[@class='segment_body-flight-stop']"
cart_flight_destination = "//div[@class='segment_body-flight-info'][2]"
cart_pax_name = '//div[@class="amend_details-passengers--list"]//div[@class="amend_passenger_details"]//span[@class="pull-left"]'
cart_dob = '//div[@class="amend_passenger_details"]//span[text()="DOB"]/span'
cart_pnr_ticket = '//div[@class="col-sm-8 passenger_faredetail"]//fieldset/input[@placeholder="Airline PNR"]'
cart_check_in_status = '//span[contains(text(),"Web Check-In Status")]'
booking_pending_text = '//span[@class="booking__status-successTrip"]//child::span[text()="Booking"]//following-sibling::span'

cart_base_fare = "//input[@placeholder='Base Fare']"
cart_taxes = "//input[@placeholder='Taxes']"

# User details
user_name_field = "//input[@id='name']"

# Left Menu
user_infomation_link = "//a[text()='User Information']"
payment_details_link = "//a[text()='Payment Details']"
payment_passbook_link = "//a[text()='Payment Passbook']"
booking_details_link = "//a[text()='Booking Details']"

# User Information Section
cart_details_contact_email = "//p[contains(text(),'Contact')]//following-sibling::span/span"
cart_details_pax_contact = "//p[contains(text(),'Pax contact')]//following-sibling::span/span"
cart_details_gst_number = "//p[contains(text(),'GST Number')]//following-sibling::span/span"
cart_details_gst_email = "//p[text()='Email']//following-sibling::span/span"
cart_details_agent_contact = "//p[contains(text(),'Agent')]//following-sibling::span/span"
cart_details_gst_address = "//p[contains(text(),'Address')]//following-sibling::span/span"
cart_details_gst_registered_name = "//p[contains(text(),'Registered Name')]//following-sibling::span/span"

# Booking Summary Page
close_reference_id = "//i[@class='fa fa-close']"
reference_booking_id = "//a[contains(@href,'manage-carts/cart-detail/')]"
base_fare_price = "//span[text()='Base fare']//following-sibling::span[@class='pull-right fareSummary-prices-positionHandle']"
taxes_and_fees_price = "//span[text()='Taxes and fees']//parent::span//following-sibling::span[@class='pull-right fareSummary-prices-positionHandle']"
total_fare_amount = "//span[text()='Total']//following-sibling::span[@class='pull-right fareSummary-prices-positionHandle']"
topbar_user = "(//li[@class='topbar__list'])[1]"
summary_passenger_name = "//span[contains(@class,'pax-detailsAll')]"
summary_passenger_dob = "//span[contains(@class,'pax-detailsAll')]//following-sibling::span/span"

summary_pnr_ticket_no = "//div[@class='pax-tdthird']//following::span[contains(@class,'art-pnrstatus')]"
summary_check_in_status = "//div[@class='pax-tdfive']/div/span"

summary_booking_status = "//span[contains(@class,'booking__status-successTrip')]"
important_information = "//span[text()='IMPORTANT INFORMATION']"
summary_flight_name = "//span[contains(@class,'apt-gridspan')]//parent::li"
summary_flight_departure = "//li[@class='text-center']//preceding-sibling::li"
summary_flight_stops = "//li[@class='text-center']"
summary_flight_destination = "//li[@class='text-center']//following-sibling::li"
summary_flight_duration = "//p[@class='apt-lasthour']"
