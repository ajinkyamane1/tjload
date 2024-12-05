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

# Input fields
enter_email_field = "//label[text()='Enter Email']//preceding-sibling::input"
enter_mobile_field = "//label[text()='Enter Mobile']//preceding-sibling::input"
name_field = "//label[text()='Name']//preceding-sibling::input[@type='text']"
address_field = "//label[text()='Address']//preceding-sibling::input[@type='text']"
select_new_date_field = "//input[@type='text' and @placeholder='Select New Date']"

# Headings
print_ticket_title = "//h2[text()='Print Ticket']"
download_as_pdf_title = "//h2[text()='Download PDF']"
important_information = "//span[text()='IMPORTANT INFORMATION']"
email_ticket_title = "//label[text()='Enter Email']"
sms_ticket_title = "//label[text()='Enter Mobile']"
reschedule_title = "//span[text()='Reschedule Flight']"
web_check_in_title = "//span[text()='Web Check-In']"
ticket_important_information = "//p[normalize-space()='Important Information']"


# Ticket
ticket_booking_id = "//span[contains(normalize-space(),'Booking ID:')]"
ticket_base_fare_price = "(//td[contains(normalize-space(),'Base Price')]//following-sibling::td[contains(normalize-space(),'₹')])[2]"
ticket_taxes_and_fees_price = "(//td[contains(normalize-space(),'Airline Taxes and Fees')]//following-sibling::td[contains(normalize-space(),'₹')])[3]"
ticket_total_price = "(//td[contains(normalize-space(),'Total Price')]//following-sibling::td[contains(normalize-space(),'₹')])[7]"
important_info_heading = "//p[normalize-space()='Important Information']"
ticket_agency_name = "(//strong[@class='printSmTxt'])[1]"
ticket_gst_name = "//p[normalize-space()='GST Name']//parent::td//parent::tr//following-sibling::tr/td[1]"
ticket_gst_no = "//p[normalize-space()='GST No']//parent::td//parent::tr//following-sibling::tr/td[2]"
ticket_user_info = "//p[contains(text(),'Email:')]"

# Cart Details Page
cart_details_amount = "//p[contains(text(),'Amount')]//following-sibling::span/span"
cart_details_booking_id = "//h3[contains(text(),'Cart Information : ')]"

# Invoice Form
invoice_form_agency = "//div[contains(@class,'agent_details-left invoiceV2-senderDetails-positionHandle')]/h4"
invoice_form_name = "//strong[contains(text(),'Name :')]//parent::p"
invoice_form_address = "//strong[contains(text(),'Address :')]//parent::p"

# Booking Summary Page
close_reference_id = "//i[@class='fa fa-close']"
reference_booking_id = "//a[contains(@href,'/manage-carts/cart-detail/')]"
base_fare_price = "//span[text()='Base fare']//following-sibling::span[@class='pull-right fareSummary-prices-positionHandle']"
taxes_and_fees_price = "//span[text()='Taxes and fees']//parent::span//following-sibling::span[@class='pull-right fareSummary-prices-positionHandle']"
total_fare_amount = "//span[text()='Total']//following-sibling::span[@class='pull-right fareSummary-prices-positionHandle']"
topbar_agency = "(//li[@class='topbar__list'])[1]"
summary_page_passenger_name = "//span[@class='pax-detailsAll']"

# Heading
fare_summary_title = "//span[text()='FARE SUMMARY']"

# Invoice Form
invoice_agency = "//div[@class='agent_details-right invoiceV2-receiverDetails-positionHandle']/h4"




