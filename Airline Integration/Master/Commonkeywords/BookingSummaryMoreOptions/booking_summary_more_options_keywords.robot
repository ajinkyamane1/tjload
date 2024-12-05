*** Settings ***
Library    SeleniumLibrary
Library     String
Library    XML
Library    Collections
Library  DateTime
Library    ../../Commonkeywords/CustomKeywords/user_keywords.py
Library    OperatingSystem
Variables    ../../../Environment/environments.py
Variables   ../../PageObjects/PaxDetails/pax_details_locators.py
Variables   ../../PageObjects/SearchFlights/search_page_locators.py
Variables   ../../PageObjects/BookingSummaryMoreOptions/booking_summary_more_options_locators.py
Variables   ../../PageObjects/Payment/payment_locators.py
Variables    ../../PageObjects/Booking/booking_summary_locators.py

*** Keywords ***
Click On More Options
    Wait Until Element Is Visible    ${more_options_dropdown}  timeout=180
    ${status}       Run Keyword And Return Status    Element Should Be Visible    ${close_reference_id}
    IF    ${status}
        Click Element    ${close_reference_id}
    END
    Scroll Element Into View    ${more_options_dropdown}
    Click Element    ${more_options_dropdown}

Click On Download As Pdf Option
    Wait Until Element Is Visible    ${download_as_pdf_option}  timeout=30
    Click Element    ${download_as_pdf_option}

Verify Download As Pdf Option
    Wait Until Element Is Visible    ${submit_button}  timeout=30
    #    Page Should Contain    DOWNLOAD PDF
    Wait Until Element Is Visible    ${download_as_pdf_title}
    Wait Until Element Is Visible    ${with_price_checkbox}
    Wait Until Element Is Visible    ${with_agency_checkbox}
    Wait Until Element Is Visible    ${with_gst_checkbox}
    Wait Until Element Is Visible    ${old_print_copy_checkbox}

Select Old Print Copy Checkbox
    Wait Until Element Is Visible    ${old_print_copy_checkbox}   timeout=30
    Click Element    ${old_print_copy_checkbox}

Click On Submit Button
    Wait Until Element Is Visible    ${submit_button}   timeout=30
    Click Element    ${submit_button}
    ${back}  Run Keyword And Return Status    Element Should Be Visible    ${back_button}
    IF    ${back}
         Wait Until Element Is Visible    ${back_button}     timeout=30
    END

Verify Booking ID
    Wait Until Page Contains    ${booking_id}       timeout=50s
    Page Should Contain    ${booking_id}

Verify Price, Agency, GST, Old Print Copy
    [Arguments]     ${fare_summary}     ${gst_details}      ${search_data}
    ${my_dict}      Create Dictionary       &{search_data}
    Wait Until Element Is Visible    ${back_button}
    # Price
    ${ticket_fare_summary}      Create Dictionary
    ${base_fare}    Get Text    xpath://span[text()='Base Fare']//parent::td//following-sibling::td/span
    ${ticket_base_fare}    Extract Final Fare As String    ${base_fare}
    Set To Dictionary    ${ticket_fare_summary}     Base_Fare=${ticket_base_fare}
    #    ${taxes_and_fees}    Get Text    ${ticket_taxes_and_fees_price}
    #    ${splited_taxes_and_fees}   Split String    ${taxes_and_fees}
    #    Log    ${splited_taxes_and_fees}[5]
    #    ${ticket_taxes_and_fees}    Extract Final Fare As String    ${splited_taxes_and_fees}[5]
    #    Set To Dictionary    ${ticket_fare_summary}     Taxes_and_Fees=${ticket_taxes_and_fees}
    ${total_fare}    Get Text    xpath://span[text()='Total']//parent::td//following-sibling::td/span
    ${ticket_total_fare}    Extract Final Fare As String    ${total_fare}
    Set To Dictionary    ${ticket_fare_summary}     Total_Fare=${ticket_total_fare}
    Should Be Equal    ${fare_summary}    ${ticket_fare_summary}
    # Agency
    ${agency_name}      Get Text    xpath://td[@class='bookingConfirm-header-positionHandle']/p
    Log    ${agency_name}
    Should Contain    ${agency}    ${agency_name.upper()}
    ${agent_email_text}     Get Text    ${ticket_user_info}
    Should Contain    ${agent_email_text}    ${my_dict.Username}
    # GST
    ${ticket_gst_details}      Create Dictionary
    ${ticket_gst_name_text}     Get Text    xpath:(//td[contains(normalize-space(),'Company Name :')])[2]
    ${ticket_gst_no_text}   Get Text    xpath:(//td[contains(normalize-space(),'GST Number:')])[2]
    Set To Dictionary    ${ticket_gst_details}     gst_no=${ticket_gst_no_text}
    Set To Dictionary    ${ticket_gst_details}     name=${ticket_gst_name_text}
    Should Contain    ${ticket_gst_details.gst_no}    ${gst_details.gst_no}
    Should Contain    ${ticket_gst_details.name}    ${gst_details.name.upper()}

Verify Downloaded Ticket Under Download Folder
    File Should Exist       ${download_folder}/${replaced_passenger_name}x1.pdf

Click On Print Ticket Option
    Wait Until Element Is Visible    ${print_tickets_option}  timeout=30
    Click Element    ${print_tickets_option}

Verify Print Tickets Option
    Wait Until Element Is Visible    ${submit_button}  timeout=30
    Wait Until Element Is Visible    ${print_ticket_title}
    Wait Until Element Is Visible    ${with_price_checkbox}
    Wait Until Element Is Visible    ${with_agency_checkbox}
    Wait Until Element Is Visible    ${with_gst_checkbox}
    Wait Until Element Is Visible    ${old_print_copy_checkbox}

Click On Email Ticket Option
    Wait Until Element Is Visible    ${email_ticket_option}  timeout=30
    Click Element    ${email_ticket_option}

Verify Email Ticket Option
    Wait Until Element Is Visible    ${submit_button}  timeout=30
    Wait Until Element Is Visible    ${email_ticket_title}
    Wait Until Element Is Visible    ${with_price_checkbox}
    Wait Until Element Is Visible    ${with_gst_checkbox}

Enter Email Id
    [Arguments]     ${search_data}
    ${my_dict}      Create Dictionary       &{search_data}
    Wait Until Element Is Visible    ${enter_email_field}
    Click Element    ${enter_email_field}
    Clear Element Text    ${enter_email_field}
    Input Text    ${enter_email_field}    ${my_dict.Email_Id}

Verify Email Sending Message
    Wait Until Page Contains    Email Sent Successfully     timeout=50s

Click On SMS Ticket Option
    Wait Until Element Is Visible    ${sms_ticket_option}  timeout=30
    Click Element    ${sms_ticket_option}

Verify SMS Ticket Option
    Wait Until Element Is Visible    ${submit_button}  timeout=30
    Wait Until Element Is Visible    ${sms_ticket_title}
    Wait Until Element Is Visible    ${enter_mobile_field}

Enter Mobile Number
    [Arguments]     ${search_data}
    ${my_dict}      Create Dictionary       &{search_data}
    Wait Until Element Is Visible    ${enter_mobile_field}
    Click Element    ${enter_mobile_field}
    Clear Element Text    ${enter_mobile_field}
    Input Text    ${enter_mobile_field}    ${my_dict.Mobile_Number}

Verify SMS Sending Message
    Wait Until Page Contains    Message Sent Successfully       timeout=50s

Click On WhatsApp Me Option
    Reload Page
    Click On More Options
    Wait Until Element Is Visible    ${whatsapp_me_option}  timeout=30
    Click Element    ${whatsapp_me_option}

Verify WhatsApp Me Option
    Wait Until Element Is Visible    ${submit_button}  timeout=30
    Wait Until Element Is Visible    ${sms_ticket_title}
    Wait Until Element Is Visible    ${enter_mobile_field}
    Wait Until Element Is Visible    ${with_price_checkbox}
    Wait Until Element Is Visible    ${with_agency_checkbox}
    Wait Until Element Is Visible    ${with_gst_checkbox}
    Wait Until Element Is Visible    ${old_print_copy_checkbox}

Verify Sending Message For WhatsApp
    Wait Until Page Contains    Message Sent Successfully       timeout=50s

Click On Invoice For Agency Option
    Wait Until Element Is Visible    ${invoice_for_agency_option}  timeout=30
    Click Element    ${invoice_for_agency_option}

Verify Invoice For Agency Option
    Wait Until Page Contains    Invoice No
    Wait Until Page Contains    Invoice Date

Verify Invoive For Agency Form
    [Arguments]     ${fare_summary}     ${gst_details}
    Wait Until Page Contains    Invoice No      timeout=50s
    Wait Until Page Contains    Invoice Date    timeout=50s
#    Wait Until Page Contains    Booking No      timeout=50s
    verify Booking ID
#    ${invoice_agency_text}  Get Text    ${invoice_agency}
#    Should Contain    ${agency}    ${invoice_agency_text.upper()}
    Page Should Contain    ${total_fare_text}
    Page Should Contain    ${gst_details.gst_no}
    Page Should Contain    ${gst_details.name.upper()}

Click On Invoice For Customer Option
    Wait Until Element Is Visible    ${invoice_for_customer_option}  timeout=30
    Click Element    ${invoice_for_customer_option}

Verify Invoice For Customer Option
    Wait Until Page Contains Element    ${download_button}  timeout=30
    Wait Until Page Contains Element    ${view_button}
    Wait Until Page Contains Element    ${whatsapp_button}
    Wait Until Page Contains Element    ${name_field}
    Wait Until Page Contains Element    ${address_field}

Enter Name And Address
    [Arguments]     ${search_data}
    ${my_dict}      Create Dictionary       &{search_data}
    Wait Until Element Is Visible    ${name_field}
    Input Text    ${name_field}    ${my_dict.Name}
    Input Text    ${address_field}    ${my_dict.Address}

Click On Download Button
    Wait Until Element Is Visible    ${download_button}     timeout=30s
    Click Element    ${download_button}

Verify Invoive For Customer Form
    [Arguments]     ${fare_summary}     ${gst_details}      ${search_data}
    ${my_dict}      Create Dictionary       &{search_data}
    Wait Until Page Contains    Invoice No      timeout=50s
    Wait Until Page Contains    Invoice Date    timeout=50s
#    Wait Until Page Contains    Booking No      timeout=50s
    verify Booking ID
#    ${invoice_agency_text}  Get Text    ${invoice_form_agency}
#    Should Contain    ${agency}    ${invoice_agency_text.upper()}
    ${total_amount}     Replace String    ${total_fare_text}    ₹    ${EMPTY}
    Page Should Contain    ${total_amount}
    Page Should Contain    ${gst_details.gst_no}
    Page Should Contain    ${gst_details.name.upper()}
#    ${customer_name}    Get Text    ${invoice_form_name}
#    ${customer_address}     Get Text    ${invoice_form_address}
    Page Should Contain    ${my_dict.Name}
    Page Should Contain    ${my_dict.Address}

Verify Downloaded Invoice
    File Should Exist       ${download_folder}/download.pdf

Click On View Button
    Wait Until Element Is Visible    ${view_button}     timeout=30s
    Click Element    ${view_button}

Click On WhatsApp Button
    Wait Until Element Is Visible    ${whatsapp_button}     timeout=30s
    Click Element    ${whatsapp_button}

Verify Invoice Send Message
    Wait Until Page Contains    Invoice sent successfully       timeout=50s

Click On Cart Details Option
    Wait Until Element Is Visible    ${go_to_cart_details_option}  timeout=30
    Click Element    ${go_to_cart_details_option}

Verify Cart Details Option
    Wait Until Page Contains    Cart Information  timeout=30
    Wait Until Page Contains    Notes
    Wait Until Page Contains    Cart Amendments
    Wait Until Page Contains    Booking Details
    Wait Until Page Contains    Payment Process
    Wait Until Page Contains    User Information
    Wait Until Element Is Visible    ${cart_details_amount}
    ${cart_detail_amount}       Get Text    ${cart_details_amount}
    Log    ${cart_detail_amount}
    ${total_amount}     Replace String    ${cart_detail_amount}    ${SPACE}    ${EMPTY}
    ${cart_detail_booking_id}   Get Text    ${cart_details_booking_id}
    Log    ${cart_detail_booking_id}
    Should Be Equal    ${total_amount}    ${total_fare_text}
    Should Contain    ${cart_detail_booking_id}    ${booking_id}

Click On Add Meal Seat Bag Option
    Wait Until Element Is Visible    ${add_meal_seat_bag_option}  timeout=30
    Click Element    ${add_meal_seat_bag_option}

Verify Add Meal Seat Bag Details Option
    Switch Window  new
    Wait Until Page Contains    Modify Booking    timeout=30
    Wait Until Page Contains Element    ${add_baggage_meal_section}

Click On Reschedule Option
    Wait Until Element Is Visible    ${reschedule_option}  timeout=30
    Click Element    ${reschedule_option}

Verify Reschedule Option
    Wait Until Element Is Visible   ${reschedule_title}    timeout=30
    Wait Until Element Is Visible    ${select_new_date_field}
    Wait Until Element Is Visible    ${continue_button_popup}

Get Booking Id From Booking Summary Page
    Wait Until Element Is Visible    ${reference_booking_id}      timeout=30
    ${booking_id_text}   Get Text    ${reference_booking_id}
    ${splited_booking_id}   Split String    ${booking_id_text}
    ${booking_id}   Set Variable    ${splited_booking_id}[2]
    Set Test Variable    ${booking_id}
    ${topbar_agency}  Get Text    ${topbar_agency}
    ${splited_topbar_agency}    Split String    ${topbar_agency}
    ${agency}   Set Variable    ${topbar_agency}
    Set Test Variable    ${agency}
    ${passenger_name_text}   Get Text    ${summary_page_passenger_name}
    ${replaced_passenger_name}      Replace String    ${passenger_name_text}    (A)    ${EMPTY}
    Log    ${replaced_passenger_name}
    Set Test Variable    ${replaced_passenger_name}

Get Fare Summary From Booking Summary Page
    ${fare_summary}     Create Dictionary
    Wait Until Element Is Visible    ${more_options_dropdown}      timeout=180
    Scroll Element Into View    ${important_information}
    ${base_fare_text}   Get Text    ${base_fare_price}
    Set Test Variable    ${base_fare_text}
    ${base_fare}    Extract Final Fare As String    ${base_fare_text}
    Set To Dictionary    ${fare_summary}    Base_Fare=${base_fare}
#    ${taxes_and_fees_text}   Get Text    ${taxes_and_fees_price}
#    ${taxes_and_fees}   Extract Final Fare As String    ${taxes_and_fees_text}
#    Set To Dictionary    ${fare_summary}    Taxes_and_Fees=${taxes_and_fees}
    ${total_fare_text}   Get Text    ${total_fare_amount}
    Set Test Variable    ${total_fare_text}
    ${total_fare}   Extract Final Fare As String    ${total_fare_text}
    Set To Dictionary    ${fare_summary}    Total_Fare=${total_fare}
    Log    ${fare_summary}
    [Return]    ${fare_summary}
