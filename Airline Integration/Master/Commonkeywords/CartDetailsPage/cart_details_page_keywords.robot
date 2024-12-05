*** Settings ***
Library    SeleniumLibrary
Library     String
Library     re
Library    XML
Library    Collections
Library  DateTime
Library    ../../Commonkeywords/CustomKeywords/user_keywords.py
Library    OperatingSystem
Variables  ../../../Environment/environments.py
Variables   ../../PageObjects/PaxDetails/pax_details_locators.py
Variables   ../../PageObjects/SearchFlights/search_page_locators.py
Variables   ../../PageObjects/CartDetailsPage/cart_details_page_locators.py
Variables   ../../PageObjects/Payment/payment_locators.py
Variables    ../../PageObjects/Booking/booking_summary_locators.py
Resource    ../../Commonkeywords/PaxDetails/pax_details_keywords.robot
Resource    ../../Commonkeywords/BookingSummary/booking_summary_keywords.robot


*** Variables ***
${download_folder}   C:/Users/Sanket/Downloads

*** Keywords ***
Click On Booking Id From Booking Summary Page
    Execute JavaScript    window.scrollTo(0, -document.body.scrollHeight)
    Wait Until Element Is Visible    ${reference_booking_id}    timeout=30s
    Click Element    ${reference_booking_id}
    Wait Until Page Contains    Cart Information  timeout=30
    Wait Until Page Contains    Notes       timeout=30
    Wait Until Page Contains    Cart Amendments     timeout=30s
    Wait Until Page Contains    Booking Details     timeout=30s
    Wait Until Page Contains    Payment Process     timeout=30s
    Wait Until Page Contains    User Information    timeout=30

Verify Cart Details Option
    Wait Until Page Contains    Cart Information  timeout=30
    Wait Until Page Contains    Notes       timeout=30
    Wait Until Page Contains    Cart Amendments     timeout=30s
    Wait Until Page Contains    Booking Details     timeout=30s
    Wait Until Page Contains    Payment Process     timeout=30s
    Wait Until Page Contains    User Information    timeout=30


Get Booking Data From Booking Summary Page
    ${booking_summary}    Create Dictionary
    Wait Until Page Contains    Booking     timeout=100s
    Wait Until Element Is Visible    ${reference_booking_id}      timeout=30
    ${booking_id_text}   Get Text    ${reference_booking_id}
    ${splited_booking_id}   Split String    ${booking_id_text}
    ${booking_id}   Set Variable    ${splited_booking_id}[2]
    Set To Dictionary    ${booking_summary}       Booking_ID=${booking_id}
    ${total_fare_text}   Get Text    ${total_fare_amount}
    Set To Dictionary    ${booking_summary}    Amount=${total_fare_text}
    ${booking_status_text}      Get Text    ${summary_booking_status}
    Set To Dictionary    ${booking_summary}       Status=${booking_status_text}
    ${topbar_user_text}  Get Text    ${topbar_user}
    ${splited_topbar_user}    Split String    ${topbar_user_text}
    ${agency}   Set Variable    ${topbar_user_text}
    Set To Dictionary    ${booking_summary}       User=${topbar_user_text}
    Log    ${booking_summary}
    [Return]    ${booking_summary}
#    ${passenger_name_text}   Get Text    ${summary_page_passenger_name}
#    ${replaced_passenger_name}      Replace String    ${passenger_name_text}    (A)    ${EMPTY}
#    Log    ${replaced_passenger_name}
#    Set Test Variable    ${replaced_passenger_name}

Verify Cart Information On Cart Details Page
    [Arguments]     ${booking_summary}
    Sleep    3
    Wait Until Element Is Visible    ${cart_booking_id}     timeout=30s
    ${booking_id_text}     Get Text    ${cart_booking_id}
    ${splited_cart_booking_id}      Split String    ${booking_id_text}     :
    ${booking_id_without_space}     Replace String    ${splited_cart_booking_id[1]}    ${SPACE}    ${EMPTY}
    Should Be Equal    ${booking_summary['Booking_ID']}    ${booking_id_without_space}
    ${cart_details_booking_id_text}     Get Text    ${cart_details_booking_id}
    ${splited_cart_details_booking_id}      Split String    ${cart_details_booking_id_text}     :
    ${cart_details_booking_id_without_space}     Replace String    ${splited_cart_details_booking_id[0]}    ${SPACE}    ${EMPTY}
    Should Be Equal    ${booking_summary['Booking_ID']}    ${cart_details_booking_id_without_space}
    ${cart_details_amount_text}     Get Text    ${cart_details_amount}
    ${amount_without_space}     Replace String    ${cart_details_amount_text}    ${SPACE}    ${EMPTY}
    Should Be Equal    ${booking_summary['Amount']}    ${amount_without_space}
    ${cart_details_status_text}     Get Text    ${cart_details_status}
    Should Contain    ${booking_summary['Status']}     ${cart_details_status_text}
    ${loggedin_user_text_1}   Get Text    ${cart_details_loggedin_user_1}
    Should Contain    ${booking_summary['User']}    ${loggedin_user_text_1.upper()}
#    ${loggedin_user_text_2}   Get Text    ${cart_details_loggedin_user_2}
#    Should Contain    ${booking_summary['User']}    ${loggedin_user_text_2.upper()}
    ${booking_user_text_1}   Get Text    ${cart_details_booking_user_1}
    Should Contain    ${booking_summary['User']}    ${booking_user_text_1.upper()}
#    ${booking_user_text_2}   Get Text    ${cart_details_booking_user_2}
#    Should Contain    ${booking_summary['User']}    ${booking_user_text_2.upper()}

Click On Booking Summary Link
    Wait Until Element Is Visible    ${booking_summary_link}    timeout=30s
    Click Element    ${booking_summary_link}

Verify Redirection Of Booking Summary Link
    Switch Window  new
    Wait Until Element Is Visible    ${reference_booking_id}    timeout=50s

Click On History Link
    Wait Until Element Is Visible    ${history_link}    timeout=30s
    Click Element    ${history_link}

Verify Redirection Of History Link And Verify History
    [Arguments]     ${booking_summary}
    ${history_data}     Get History Data
    ${card_row_count}=    SeleniumLibrary.Get Element Count    xpath://thead[contains(@class,'theader table')]//following-sibling::tbody[contains(@class,"table__body")]/tr
    FOR    ${counter}    IN RANGE    1    ${card_row_count}+1
        Exit For Loop If    ${counter}==4
        Log    ${counter}
        Should Be Equal    ${history_data['Booking Id${counter}']}    ${booking_summary['Booking_ID']}
    END

Get History Data
    ${my_dict}=    Create Dictionary
    Wait Until Element Is Visible    xpath://thead[contains(@class,"theader")]/tr/td    30s
    ${card_column_count}=    SeleniumLibrary.Get Element Count    xpath://thead[contains(@class,"theader")]/tr/td
    Wait Until Element Is Visible    xpath://thead[contains(@class,'theader table')]//following-sibling::tbody[contains(@class,"table__body")]/tr    30s
    ${card_row_count}=    SeleniumLibrary.Get Element Count    xpath://thead[contains(@class,'theader table')]//following-sibling::tbody[contains(@class,"table__body")]/tr
    Log    ${card_row_count}
    ${const}=    Set Variable    1
    ${number}   Set Variable    1
    FOR    ${card_row_count}    IN RANGE    1    ${card_row_count}+1
        Log    ${number}
        Exit For Loop If    ${number}==7
        FOR    ${card_column_count}    IN RANGE    1    ${card_column_count}+1
        ${cnt}=     Convert To String    ${card_column_count}
        ${text_column_head}=      Get Text    //thead[contains(@class,'theader')]/tr/td[${cnt}]
        ${text_coloumn_data}=    Get Text    //thead[contains(@class,'theader table')]//following-sibling::tbody[contains(@class,"table__body")]/tr[${number}]/td[${cnt}]
        Set To Dictionary    ${my_dict}    ${text_column_head}${const}=${text_coloumn_data}
        END
        ${const}=    Evaluate    ${const}+1
        ${number}       Evaluate    ${number}+2
    END
    Log    ${my_dict}
    [Return]    ${my_dict}

Click On Booking Logs Links
    Wait Until Element Is Visible    ${booking_logs_link}   timeout=30s
    Click Element    ${booking_logs_link}
    Sleep    5

Click On LoggedIn User Link
    Wait Until Element Is Visible    ${cart_details_loggedin_user_1}    timeout=30s
    ${cart_details_loggedin_user_1_text}        Get Text    ${cart_details_loggedin_user_1}
    Set Test Variable    ${cart_details_loggedin_user_1_text}
    Click Element    ${cart_details_loggedin_user_1}
    Wait Until Page Contains    USER DETAILS     timeout=30s

Verify Redirection Of LoggedIn User Link And Verify LoggedIn User
    Wait Until Element Is Visible    ${user_name_field}     timeout=30s
    ${user_name_field_value}    Get Value    ${user_name_field}
    Should Contain    ${cart_details_loggedin_user_1_text}    ${user_name_field_value}

Click On Booking User Link
    Wait Until Element Is Visible    ${cart_details_booking_user_1}    timeout=30s
    ${cart_details_booking_user_1_text}        Get Text    ${cart_details_booking_user_1}
    Set Test Variable    ${cart_details_booking_user_1_text}
    Click Element    ${cart_details_booking_user_1}
    Wait Until Page Contains    USER DETAILS     timeout=30s

Verify Redirection Of Booking User Link And Verify Booking User
    Wait Until Element Is Visible    ${user_name_field}     timeout=30s
    ${user_name_field_value}    Get Value    ${user_name_field}
    Should Contain    ${cart_details_booking_user_1_text}    ${user_name_field_value}

Get And Return GST Details From Pax Page
    ${gst_details}      Create Dictionary
    Wait Until Element Is Visible    ${gst_no}      timeout=30s
    ${gst_no_value}     Get Value    ${gst_no}
    ${gst_name_value}    Get Value    ${gst_name}
    ${gst_email_value}      Get Value    ${gst_email}
    ${gst_phone_no_value}   Get Value    ${gst_phone_no}
    ${gst_address_value}    Get Value    ${gst_address}
    Set To Dictionary    ${gst_details}     GST_No=${gst_no_value}
    Set To Dictionary    ${gst_details}     GST_Name=${gst_name_value}
    Set To Dictionary    ${gst_details}     GST_Email=${gst_email_value}
    Set To Dictionary    ${gst_details}     GST_Phone_No=${gst_phone_no_value}
    Set To Dictionary    ${gst_details}     GST_Address=${gst_address_value}
    Log    ${gst_details}
    [Return]     ${gst_details}

Click On User Information Section
    Wait Until Element Is Visible    ${user_infomation_link}    timeout=30s
    Click Element    ${user_infomation_link}
    Wait Until Page Contains    Contact's Email     timeout=50s

Get User Information And Gst Details From Cart Details Page
    ${user_and_gst_getails}     Create Dictionary
    Wait Until Element Is Visible    ${cart_details_contact_email}      timeout=30s
    ${cart_details_contact_email_text}   Get Text    ${cart_details_contact_email}
    ${cart_details_pax_contact_text}    Get Text    ${cart_details_pax_contact}
    ${cart_details_gst_number_text}     Get Text    ${cart_details_gst_number}
    ${cart_details_gst_email_text}      Get Text    ${cart_details_gst_email}
    ${cart_details_agent_contact_text}      Get Text    ${cart_details_agent_contact}
    ${cart_details_gst_address_text}    Get Text    ${cart_details_gst_address}
    ${cart_details_gst_registered_name_text}    Get Text    ${cart_details_gst_registered_name}
    Set To Dictionary    ${user_and_gst_getails}    Contacts_Email=${cart_details_contact_email_text}
    Set To Dictionary    ${user_and_gst_getails}    Pax_Contact=${cart_details_pax_contact_text}
    Set To Dictionary    ${user_and_gst_getails}    GST_Number=${cart_details_gst_number_text}
    Set To Dictionary    ${user_and_gst_getails}    GST_Email=${cart_details_gst_email_text}
    Set To Dictionary    ${user_and_gst_getails}    Agent_Contact=${cart_details_agent_contact_text}
    Set To Dictionary    ${user_and_gst_getails}    GST_Address=${cart_details_gst_address_text}
    Set To Dictionary    ${user_and_gst_getails}    GST_Registered_Name=${cart_details_gst_registered_name_text}
    Log    ${user_and_gst_getails}
    [Return]    ${user_and_gst_getails}

Verify User Information And GST Details On Cart Details Page
    [Arguments]     ${contact_details}      ${gst_details}    ${user_and_gst_details}
    Log    ${contact_details}
    Log    ${gst_details}
    Log    ${user_and_gst_details}
    Should Be Equal    ${contact_details['mobile']}    ${user_and_gst_details['Pax_Contact']}
    Should Be Equal    ${contact_details['email']}    ${user_and_gst_details['Contacts_Email']}
    Should Be Equal    ${gst_details['GST_No']}    ${user_and_gst_details['GST_Number']}
    Should Be Equal    ${gst_details['GST_Name'].upper()}    ${user_and_gst_details['GST_Registered_Name']}
    Should Be Equal    ${gst_details['GST_Email']}    ${user_and_gst_details['GST_Email']}
    Should Be Equal    ${gst_details['GST_Phone_No']}    ${user_and_gst_details['Agent_Contact']}
    Should Be Equal    ${gst_details['GST_Address'].upper()}    ${user_and_gst_details['GST_Address']}

Click On Payment Details Section
    Wait Until Element Is Visible    ${payment_details_link}    timeout=30s
    Click Element    ${payment_details_link}
    Wait Until Page Contains    Created On      timeout=50s

Get Payment Details From Cart Details Page
    ${cart_payment_details}=    Create Dictionary
    Wait Until Element Is Visible    xpath://thead[contains(@class,'credit_info')]/tr/td    10s
    ${card_column_count}=    SeleniumLibrary.Get Element Count    xpath://thead[contains(@class,'credit_info')]/tr/td
    ${card_row_count}=    SeleniumLibrary.Get Element Count    xpath://tbody[contains(@class,'table__body')]/tr[1]
    Log    ${card_row_count}
    ${const}=    Set Variable    1
    FOR    ${card_row_count}    IN RANGE    1    ${card_row_count}+1
        Exit For Loop If    ${card_row_count}==10
        FOR    ${card_column_count}    IN RANGE    1    ${card_column_count}+1
        ${cnt}=     Convert To String    ${card_column_count}
        ${text_column_head}=      Get Text    xpath://thead[contains(@class,'credit_info')]/tr/td[${cnt}]
        ${text_coloumn_data}=    Get Text    xpath://tbody[contains(@class,'table__body')]/tr[1]/td[${cnt}]
        Set To Dictionary    ${cart_payment_details}    ${text_column_head}=${text_coloumn_data}
        END
    END
    Log    ${cart_payment_details}
    [Return]    ${cart_payment_details}

Navigate To Dashboard
    Wait Until Element Is Visible    ${dashboard_nav_btn}   timeout=30s
    Click Element    ${dashboard_nav_btn}
    Wait Until Page Contains    manage-user     timeout=50s

Navigate To Payment Passbook Section
    Wait Until Element Is Visible    ${payment_passbook_link}   timeout=30
    Click Element    ${payment_passbook_link}
    Wait Until Element Is Visible    ${show_more_option_button}     timeout=30s
    Click Element    ${show_more_option_button}
    Wait Until Element Is Visible    ${booking_id_field}    timeout=30s

Enter Booking ID
    [Arguments]     ${booking_summary}
    Wait Until Element Is Visible    ${booking_id_field}    timeout=30s
    Input Text    ${booking_id_field}    ${booking_summary['Booking_ID']}

Click On Search Button
    Sleep    2
    Wait Until Element Is Visible    ${payment_passbook_search_button}      timeout=30s
    Click Element    ${payment_passbook_search_button}
    Wait Until Page Contains    results shown !     timeout=50s

Get Payment Details From Payment Passbook Page
    ${passbook_payment_details}=    Create Dictionary
    Wait Until Element Is Visible    xpath://thead[contains(@class,'theader')]/tr/td    10s
    ${card_column_count}=    SeleniumLibrary.Get Element Count    xpath://thead[contains(@class,'theader')]/tr/td
    ${card_row_count}=    SeleniumLibrary.Get Element Count    xpath://tbody[contains(@class,'table__body')]/tr[1]
    Log    ${card_row_count}
    ${const}=    Set Variable    1
    FOR    ${card_row_count}    IN RANGE    1    ${card_row_count}+1
        Exit For Loop If    ${card_row_count}==10
        FOR    ${card_column_count}    IN RANGE    1    ${card_column_count}+1
        ${cnt}=     Convert To String    ${card_column_count}
        ${text_column_head}=      Get Text    xpath://thead[contains(@class,'theader')]/tr/td[${cnt}]
        ${text_coloumn_data}=    Get Text    xpath://tbody[contains(@class,'table__body')]/tr[1]/td[${cnt}]
        Set To Dictionary    ${passbook_payment_details}    ${text_column_head}=${text_coloumn_data}
        END
    END
    Log    ${passbook_payment_details}
    [Return]    ${passbook_payment_details}

Verify Payment Details
    [Arguments]     ${cart_payment_details}     ${passbook_payment_details}
    Log    ${cart_payment_details}
    Log    ${passbook_payment_details}
    Should Be Equal    ${cart_payment_details['Created On']}    ${passbook_payment_details['Created On']}
    Should Be Equal    ${cart_payment_details['Product']}    ${passbook_payment_details['Product']}
    Should Be Equal    ${cart_payment_details['Medium']}    ${passbook_payment_details['Medium']}
    Should Be Equal    ${cart_payment_details['Booking Id']}    ${passbook_payment_details['Booking Id']}
    Should Be Equal    ${cart_payment_details['Type']}    ${passbook_payment_details['Type']}
    Should Be Equal    ${cart_payment_details['Debit']}    ${passbook_payment_details['Debit']}
    Should Be Equal    ${cart_payment_details['Status']}    ${passbook_payment_details['Status']}
    Should Be Equal    ${cart_payment_details['Deposit Amount']}    ${passbook_payment_details['Deposit Amount']}
    Should Be Equal    ${cart_payment_details['Logged In userId']}    ${passbook_payment_details['Logged In userId'].upper()}
    Should Be Equal    ${cart_payment_details['Booking User Id']}    ${passbook_payment_details['Booking User Id'].upper()}
    Should Be Equal    ${cart_payment_details['Payment Reference']}    ${passbook_payment_details['Payment Reference']}
    Should Be Equal    ${cart_payment_details['Company Name']}    ${passbook_payment_details['Company Name']}

Get Fare Summary From Booking Summary Page
    ${fare_summary}     Create Dictionary
    #    Wait Until Element Is Visible    ${more_options_dropdown}      timeout=180
    Scroll Element Into View    ${important_information}
    ${base_fare_text}   Get Text    ${base_fare_price}
    Set Test Variable    ${base_fare_text}
    ${base_fare}    Extract Final Fare As String    ${base_fare_text}
    Set To Dictionary    ${fare_summary}    Base_Fare=${base_fare}
    ${taxes_and_fees_text}   Get Text    ${taxes_and_fees_price}
    ${taxes_and_fees}   Extract Final Fare As String    ${taxes_and_fees_text}
    Set To Dictionary    ${fare_summary}    Taxes_and_Fees=${taxes_and_fees}
    ${total_fare_text}   Get Text    ${total_fare_amount}
    Set Test Variable    ${total_fare_text}
    ${total_fare}   Extract Final Fare As String    ${total_fare_text}
    Set To Dictionary    ${fare_summary}    Total_Fare=${total_fare}
    Log    ${fare_summary}
    [Return]    ${fare_summary}

Click On Booking Details Section
    Wait Until Element Is Visible    ${booking_details_link}    timeout=30s
    Click Element    ${booking_details_link}
    Sleep    2

Get Flight Details From Booking Summary Page
    ${is_flilisting_page}=      Run Keyword And Return Status    Wait Until Page Contains Element    ${view_details_button}
    IF    ${is_flilisting_page}
        Wait Until Page Contains Element    ${view_details_button}    timeout=10
        Click Element    ${view_details_button}
        Wait Until Element Is Visible    ${fare_details_tab}
        Sleep    5
    END
    ${flight_details}    Create Dictionary
    ${flight_name_elements}=  Get WebElements    ${summary_flight_name}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_name_elements}
        ${flight_name}=  Get Text    ${element}
        IF    ${is_flilisting_page}
            ${split}=   Split String    ${flight_name}    \n
            ${temp1}=  Get From List    ${split}    0
            ${temp2}=   Get From List    ${split}    0
            ${flight_name}=  Catenate    ${temp1}${temp2}
        END
        ${splited_flight_name}      Split String    ${flight_name}
        ${flight_name_data}     Catenate    ${splited_flight_name}[0] ${splited_flight_name}[1][0:4]
        Set To Dictionary    ${flight_details}   FlightName${i}=${flight_name_data}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_departure_elements}=    Get WebElements    ${summary_flight_departure}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_departure_elements}
        ${departure_detail}=  Get Text    ${element}
        ${departure}    Split String    ${departure_detail}
        ${time1}     ${date1}     Extract Time And Date    ${departure_detail}
        ${departure_city}   Replace String    ${departure}[4]    ,    ${EMPTY}
        ${departure_data}   Catenate    ${departure_city} ${date1} ${time1}
        Set To Dictionary    ${flight_details}   FlightDeparture${i}=${departure_data}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_stops_elements}=    Get WebElements    ${summary_flight_stops}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_stops_elements}
        ${stops_detail}=  Get Text    ${element}
        Set To Dictionary    ${flight_details}   FlightStops${i}=${stops_detail}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_destination_element}=   Get WebElements    ${summary_flight_destination}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_destination_element}
        ${destination_detail}=  Get Text    ${element}
        ${destination}      Split String    ${destination_detail}
        ${destination_city}   Replace String    ${destination}[4]    ,    ${EMPTY}
        ${time2}     ${date2}     Extract Time And Date    ${destination_detail}
        ${departure_data}   Catenate    ${destination_city} ${date2} ${time2}
        Set To Dictionary    ${flight_details}    FlightDestination${i}=${departure_data}
        ${i}=   Evaluate   ${i}+1
    END
    IF    ${is_flilisting_page}
        Execute Javascript  window.scroll(0,-50)
        Click Element    ${view_details_button}
    END
    Execute Javascript  window.scroll(0,-50)
    [Return]  ${flight_details}

Get Flight Details From Cart Details Page
    ${cart_flight_details}      Create Dictionary
    ${flight_name_elements}=     Get WebElements    ${cart_flight_name}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_name_elements}
        ${flight_name}=     Get Text    ${element}
        ${splited_flight_name}      Split String    ${flight_name}
        ${flight_name_data}     Catenate    ${splited_flight_name}[0] ${splited_flight_name}[1][0:4]
        Set To Dictionary    ${cart_flight_details}   FlightName${i}=${flight_name_data}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_departure_elements}=    Get WebElements    ${cart_flight_departure}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_departure_elements}
        ${departure_detail}=  Get Text    ${element}
        ${departure}    Split String    ${departure_detail}
        ${time1}     ${date1}     Extract Time And Date    ${departure_detail}
        ${replaced_date1}    Replace String    ${date1}    -    ${SPACE}
        ${splited_date1}     Split String    ${replaced_date1}    ${SPACE}
        ${final_date1}   Catenate    ${splited_date1}[2] ${splited_date1}[1], ${splited_date1}[0]
        ${departure_data}   Catenate    ${departure}[0] ${final_date1} ${time1}
        Set To Dictionary    ${cart_flight_details}   FlightDeparture${i}=${departure_data}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_stops_elements}=    Get WebElements    ${cart_flight_stops}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_stops_elements}
        ${stops_detail}=  Get Text    ${element}
        Set To Dictionary    ${cart_flight_details}   FlightStops${i}=${stops_detail}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_destination_elements}=    Get WebElements    ${cart_flight_destination}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_destination_elements}
        ${destination_detail}=  Get Text    ${element}
        ${destination}      Split String    ${destination_detail}
        ${time2}     ${date2}     Extract Time And Date    ${destination_detail}
        ${replaced_date2}    Replace String    ${date2}    -    ${SPACE}
        ${splited_date2}     Split String    ${replaced_date2}    ${SPACE}
        ${final_date2}   Catenate    ${splited_date2}[2] ${splited_date2}[1], ${splited_date2}[0]
        ${destination_data}   Catenate    ${destination}[0] ${final_date2} ${time2}
        Set To Dictionary    ${cart_flight_details}   FlightDestination${i}=${destination_data}
        ${i}=   Evaluate   ${i}+1
    END
    Log    ${cart_flight_details}
    [Return]    ${cart_flight_details}

Get Fare Details From Cart Details Page
    ${cart_fare_details}      Create Dictionary
    ${base_fare_elements}=    Get WebElements    ${cart_base_fare}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{base_fare_elements}
        ${base_fare}=  Get Value    ${element}
        ${length}   Get Length    ${base_fare}
        Exit For Loop If    ${length}==0
        ${extracted_base_fare}      Run Keyword If    ${length} > 0      Extract Final Fare As String    ${base_fare}
        Set To Dictionary    ${cart_fare_details}   Base_Fare${i}=${extracted_base_fare}
        ${i}=   Evaluate   ${i}+1
    END
    ${taxes_elements}=    Get WebElements    ${cart_taxes}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{taxes_elements}
        ${taxes}=  Get Value    ${element}
        ${length}   Get Length    ${taxes}
        Exit For Loop If    ${length}==0
        ${extracted_taxes}      Run Keyword If    ${length} > 0     Extract Final Fare As String    ${taxes}
        Set To Dictionary    ${cart_fare_details}   Taxes${i}=${extracted_taxes}
        ${i}=   Evaluate   ${i}+1
    END
    Log    ${cart_fare_details}
    [Return]    ${cart_fare_details}

Get Pax Details From Booking Summary Page
    ${pax_details}      Create Dictionary
    ${pax_name}=    Get WebElements    ${summary_passenger_name}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{pax_name}
        ${pax_name_text}=  Get Text    ${element}
        Set To Dictionary    ${pax_details}   Pax_Name${i}=${pax_name_text}
        ${i}=   Evaluate   ${i}+1
    END
    ${pax_dob}=    Get WebElements    ${summary_passenger_dob}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{pax_dob}
        ${pax_dob_text}=  Get Text    ${element}
        ${dob}      Replace String    ${pax_dob_text}    ,    ${EMPTY}
        Set To Dictionary    ${pax_details}   Pax_DOB${i}=${dob}
        ${i}=   Evaluate   ${i}+1
    END
    ${pax_name_and_dob}=    Get WebElements    ${summary_pnr_ticket_no}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{pax_name_and_dob}
        ${pnr_ticket_no}=  Get Text    ${element}
        Set To Dictionary    ${pax_details}   Pnr_Ticket_No${i}=${pnr_ticket_no}
        ${i}=   Evaluate   ${i}+1
    END
    ${pax_name_and_dob}=    Get WebElements    ${summary_check_in_status}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{pax_name_and_dob}
        ${check_in_status}=  Get Text    ${element}
        Set To Dictionary    ${pax_details}   Check_In_Status${i}=${check_in_status}
        ${i}=   Evaluate   ${i}+1
    END
    Log    ${pax_details}
    [Return]    ${pax_details}

Get Pax Details From Cart Details Page
    ${cart_pax_details}    Create Dictionary
    ${passenger_names}    Get Webelements    ${cart_pax_name}
    ${i}    Set Variable    1
    FOR    ${current_passenger_name}  IN   @{passenger_names}
        ${passenger_text}    Get Text    ${current_passenger_name}
        ${updated_text}    Convert Name Format    ${passenger_text}
        ${cart_pax}     Replace String    ${updated_text}    .    ${EMPTY}
        Set To Dictionary    ${cart_pax_details}    Pax_Name${i}=${cart_pax}
        ${i}    Evaluate    ${i}+1
    END
    ${passenger_dob}    Get Webelements    ${cart_dob}
    ${i}    Set Variable    1
    FOR    ${current_passenger_dob}    IN    @{passenger_dob}
        ${dob_text}    Get Text    ${current_passenger_dob}
        Set To Dictionary    ${cart_pax_details}    Pax_DOB${i}=${dob_text}
        ${i}    Evaluate    ${i}+1
    END
    ${passenger_pnr}    Get Webelements    ${cart_pnr_ticket}
    ${i}    Set Variable    1
    FOR    ${current_passenger_pnr}    IN    @{passenger_pnr}
        ${pnr_text}    Get Value    ${current_passenger_pnr}
        Set To Dictionary    ${cart_pax_details}    Pnr_Ticket_No${i}=${pnr_text}
        ${i}    Evaluate    ${i}+1
    END
    ${passenger_web_status}    Get Webelements    ${cart_check_in_status}
    ${i}    Set Variable    1
    FOR    ${current_passenger_status}    IN    @{passenger_web_status}
        ${status_text}    Get Text    ${current_passenger_status}
        ${status}       Replace String    ${status_text}     Web Check-In Status :    ${EMPTY}
        ${status1}      Replace String    ${status}    -    ${SPACE}
        ${status2}      Replace String    ${status1}    ${SPACE}    ${EMPTY}     1
        Set To Dictionary    ${cart_pax_details}    Check_In_Status${i}=${status2}
        ${i}    Evaluate    ${i}+1
    END
    Log    ${cart_pax_details}
    [Return]    ${cart_pax_details}

Verify Flight Details On Cart Details Page
    [Arguments]     ${summary_flight_details}       ${cart_flight_details}
    Log    ${summary_flight_details}
    Log    ${cart_flight_details}
    Dictionaries Should Be Equal    ${summary_flight_details}    ${cart_flight_details}

Verify Fare Details On Cart Details Page
    [Arguments]     ${summary_fare_details}     ${cart_fare_details}
    Log    ${summary_fare_details}
    Log    ${cart_fare_details}
    ${total_fare_and_taxes}     Calculate Totals Of Fares And Taxes    ${cart_fare_details}
    ${integer_summary_base_fare}    Convert To Number    ${summary_fare_details['Base_Fare']}
    ${integer_summary_tax}    Convert To Number    ${summary_fare_details['Taxes_and_Fees']}
    Should Be Equal    ${integer_summary_base_fare}    ${total_fare_and_taxes['Total_Base_Fare']}
    Should Be Equal    ${integer_summary_tax}    ${total_fare_and_taxes['Total_Taxes']}

Verify Pax Details On Cart Details Page
    [Arguments]     ${pax_details}      ${cart_pax_details}
    Log    ${pax_details}
    Log    ${cart_pax_details}
    @{summary_pax_details_list}     Create List
    @{cart_pax_details_list}    Create List
    FOR    ${key}    IN    @{pax_details.keys()}
          ${value}      Get From Dictionary    ${pax_details}    ${key}
          Append To List    ${summary_pax_details_list}    ${value}
    END
    ${unique_summary_pax_details}     Remove Duplicates    ${summary_pax_details_list}
    FOR    ${key}    IN    @{cart_pax_details.keys()}
          ${value}      Get From Dictionary    ${cart_pax_details}    ${key}
          Append To List    ${cart_pax_details_list}    ${value}
    END
    ${unique_cart_pax_details}     Remove Duplicates    ${cart_pax_details_list}
    Log    ${unique_summary_pax_details}
    Log    ${unique_cart_pax_details}
    ${condition}=    Set Variable    ${TRUE}
    FOR    ${item}    IN    @{unique_cart_pax_details}
        Run Keyword If    '${item}' not in @{unique_summary_pax_details}    Set Variable    ${FALSE}
    END
    Should Be True    ${condition}
    #    Lists Should Be Equal    ${unique_summary_pax_details}    ${unique_cart_pax_details}
    #    FOR    ${key}    IN    @{pax_details.keys()}
    #        ${is_key_present}   Run Keyword And Return Status       Dictionary Should Contain Key     ${cart_pax_details}    ${key}
    #        IF    ${is_key_present}
    #            ${value}=    Get From Dictionary    ${pax_details}    ${key}
    #            Should Be Equal    ${pax_details['${key}']}    ${cart_pax_details['${key}']}
    #        END
    #    END

Verify Pending Status On Cart Details & Take Screenshot
    [Arguments]    ${booking_status}
    IF    "${booking_status}" != "Success"
       Capture Page Screenshot
    END

Verify Booking Status From Booking Summary
    Sleep    5
    ${booking_status}=    Get Text    ${booking_pending_text}
    Verify Status And Get Notes ScreenShot    ${booking_status}

Get Fare Details From Cart Details Page | i
    ${cart_fare_details}      Create Dictionary
    ${base_fare_elements}=    Get WebElements    ${cart_base_fare}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{base_fare_elements}
        ${base_fare}=  Get Value    ${element}
        ${length}   Get Length    ${base_fare}
        Exit For Loop If    ${length}==0
        ${extracted_base_fare}      Run Keyword If    ${length} > 0      Extract Final Fare As String    ${base_fare}
        Set To Dictionary    ${cart_fare_details}   Base_Fare${i}=${extracted_base_fare}
        ${i}=   Evaluate   ${i}+1
    END
    ${taxes_elements}=    Get WebElements    ${cart_taxes}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{taxes_elements}
        ${taxes}=  Get Value    ${element}
        ${length}   Get Length    ${taxes}
        Exit For Loop If    ${length}==0
        ${extracted_taxes}      Run Keyword If    ${length} > 0     Extract Final Fare As String    ${taxes}
        Set To Dictionary    ${cart_fare_details}   Taxes${i}=${extracted_taxes}
        ${i}=   Evaluate   ${i}+1
    END
    ${i_values}=    Get WebElements    (//i[@class="fa fa-info hover_icon"])[1]//parent::div//following-sibling::div
    #    ${cart_i_elements}      Create Dictionary
    @{cart_i_elements_list}     Create List
    ${element_count}    SeleniumLibrary.Get Element Count    (//i[@class="fa fa-info hover_icon"])[1]//parent::div//following-sibling::div
    ${second_i_icon}    Run Keyword And Return Status    Element Should Be Visible    (//i[@class="fa fa-info hover_icon"])[2]
    ${i_icon_count}     SeleniumLibrary.Get Element Count    //i[@class="fa fa-info hover_icon"]
    #    Run Keyword If    ${second_i_icon}      Mouse Over    (//i[@class="fa fa-info hover_icon"])[2]
    FOR    ${i_element}    IN RANGE    1    ${i_icon_count}+1
        Mouse Over    ${booking_details_link}
        ${element_count}    SeleniumLibrary.Get Element Count    (//i[@class="fa fa-info hover_icon"])[${i_element}]//parent::div//following-sibling::div
        FOR    ${counter}    IN RANGE    1      ${element_count}+1
            Mouse Over    (//i[@class="fa fa-info hover_icon"])[${i_element}]
            ${heading}      Get Text    (//div[@class="hoverInfo_content"])[${i_element}]/div[${counter}]/p[1]
            ${value}    Get Text    (//div[@class="hoverInfo_content"])[${i_element}]/div[${counter}]/p[2]
            ${value1}   Extract Final Fare As String    ${value}
            ${ele}      Set Variable    ${heading}=${value1}
            Append To List    ${cart_i_elements_list}   ${ele}
        END
    END
    ${i_icon_tax_and_fare}      Convert List To Dictionary    ${cart_i_elements_list}
    Log    ${i_icon_tax_and_fare}
    Log    ${cart_fare_details}
    [Return]    ${cart_fare_details}    ${i_icon_tax_and_fare}

Get Fare Summary From Booking Summary Page | i
    ${fare_summary}     Create Dictionary
    #    Wait Until Element Is Visible    ${more_options_dropdown}      timeout=180
    Scroll Element Into View    ${important_information}
    ${base_fare_text}   Get Text    ${base_fare_price}
    Set Test Variable    ${base_fare_text}
    ${base_fare}    Extract Final Fare As String    ${base_fare_text}
    Set To Dictionary    ${fare_summary}    Base_Fare=${base_fare}
    ${taxes_and_fees_text}   Get Text    ${taxes_and_fees_price}
    ${taxes_and_fees}   Extract Final Fare As String    ${taxes_and_fees_text}
    Set To Dictionary    ${fare_summary}    Taxes_and_Fees=${taxes_and_fees}
    ${total_fare_text}   Get Text    ${total_fare_amount}
    Set Test Variable    ${total_fare_text}
    ${total_fare}   Extract Final Fare As String    ${total_fare_text}
    Set To Dictionary    ${fare_summary}    Total_Fare=${total_fare}
    Click Element    //span[contains(text(),'Taxes and fees')]
    ${taxes}    Get WebElements    //div[contains(@class,'tax-dropdown')]/div
    ${tax_element_count}    SeleniumLibrary.Get Element Count    (//div[contains(@class,'tax-dropdown')])[1]/div/span[1]
    ${i}=   Set Variable    1
    ${j}=   Set Variable    2
    @{tax_list}     Create List
    ${tax_dictionary}       Create Dictionary
    FOR    ${counter}    IN RANGE    1    ${tax_element_count}+1
        ${heading}      Get Text    (//div[contains(@class,'tax-dropdown')])[1]/div[${counter}]/span[${i}]
        ${value}    Get Text    (//div[contains(@class,'tax-dropdown')])[1]/div[${counter}]/span[${j}]
        ${value1}       Extract Final Fare As String    ${value}
        ${value2}   Convert To Number    ${value1}
        Set To Dictionary    ${tax_dictionary}      ${heading}=${value2}
    #        ${ele}      Set Variable    ${heading}=${value1}
    #        Append To List    ${tax_list}   ${ele}
    END
    Click Element    (//span[contains(text(),'FARE SUMMARY')])/parent::span/following-sibling::div//div[contains(@class,"fareSummary")]/child::span[contains(text(),"Total")]
    ${taxes}    Get WebElements    //div[contains(@class,'tax-dropdown')]/div
    ${total_element_count}    SeleniumLibrary.Get Element Count    (//div[contains(@class,'tax-dropdown')])[2]/div/span[1]
    ${i}=   Set Variable    1
    ${j}=   Set Variable    2
    FOR    ${counter}    IN RANGE    1    ${total_element_count}+1
        ${heading}      Get Text    (//div[contains(@class,'tax-dropdown')])[2]/div[${counter}]/span[${i}]
        ${value}    Get Text    (//div[contains(@class,'tax-dropdown')])[2]/div[${counter}]/span[${j}]
        ${value1}       Extract Final Fare As String    ${value}
        Set To Dictionary    ${tax_dictionary}      ${heading}=${value1}
    #        ${ele}      Set Variable    ${heading}=${value1}
    #        Append To List    ${tax_list}   ${ele}
    END
    #    FOR    ${element}    IN    @{taxes}
    #        ${tax_details}=  Get Text    ${element}
    #        Append To List    ${tax_list}   ${tax_details}
    #        ${i}=   Evaluate   ${i}+1
    #    END
    Log    ${tax_dictionary}
    Log    ${fare_summary}
    [Return]    ${fare_summary}     ${tax_dictionary}

Verify Info Icon Details On Cart Details Page
    [Arguments]     ${fare_summary}     ${tax_dictionary}     ${i_icon_tax_and_fare}
    Log    ${fare_summary}
    Log    ${tax_dictionary}
    ${i_icon_tax_fare_dict}    Calculate Totals    ${i_icon_tax_and_fare}
    Log    ${i_icon_tax_fare_dict}
    ${Base_Fare}    Convert To Number    ${fare_summary['Base_Fare']}
    Should Be Equal    ${Base_Fare}    ${i_icon_tax_fare_dict['Base Fare']}
    ${Total_Fare}   Convert To Number    ${fare_summary['Total_Fare']}
    Should Be Equal    ${Total_Fare}    ${i_icon_tax_fare_dict['Net Fare']}
    Should Be Equal    ${Total_Fare}    ${i_icon_tax_fare_dict['T. Fare']}
    ${key_status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${tax_dictionary}    Airline GST
    IF    ${key_status}
        Should Be Equal    ${tax_dictionary['Airline GST']}    ${i_icon_tax_fare_dict['Air GST']}
        Should Be Equal    ${tax_dictionary['Total Airline Tax']}    ${i_icon_tax_fare_dict['Airline Taxes']}
    END

Verify Passport Details On Cart Details Page
    [Arguments]    ${passport_number_on_summary_page}    ${issue_date_on_summary_page}    ${expiry_date_on_summary_page}
    ${passport_number_on_cart_details_page}    Create List
    ${issue_date_on_cart_details_page}    Create List
    ${expiry_date_on_cart_details_page}    Create List
    Sleep    100s
    @{passport_number}=    Get Webelements     //span[@class="sm_font col-sm-6 padd-left-amendment"][text()="Passport"]
    FOR    ${element}    IN    @{passport_number}
        ${passport_number}    Get Text    ${element}
        Append To List    ${passport_number_on_cart_details_page}    ${passport_number}
        ${passport_number_output}    Set Variable    ${passport_number.split(":")[1].strip()}
        List Should Contain Value    ${passport_number_on_summary_page}    ${passport_number_output}
        Log    ${passport_number_on_cart_details_page}
    END

    @{issue_dates}=    Get Webelements     //span[@class="sm_font col-sm-6 padd-left-amendment"][text()="P.I. Date"]
    FOR    ${element}    IN    @{issue_dates}
        ${issue_date}    Get Text    ${element}
        Append To List    ${issue_date_on_cart_details_page}    ${issue_date}
        ${issue_date_output}    Set Variable    ${issue_date.split(":")[1].strip()}
        List Should Contain Value    ${issue_date_on_summary_page}    ${issue_date_output}
        Log    ${issue_date_on_cart_details_page}
    END

    @{expiry_dates}=    Get Webelements     //span[@class="sm_font col-sm-6 padd-left-amendment"][text()="P.E. Date"]
    FOR    ${element}    IN    @{expiry_dates}
        ${expiry_date}    Get Text    ${element}
        Append To List    ${expiry_date_on_cart_details_page}    ${expiry_date}
        ${expiry_date_output}    Set Variable    ${expiry_date.split(":")[1].strip()}
        List Should Contain Value    ${expiry_date_on_summary_page}    ${expiry_date_output}
        Log    ${expiry_date_on_cart_details_page}
    END

Verify Baggage,Meal And Seat Information On Cart Details Page
    [Arguments]    ${baggage_info_list}    ${meal_info_list}    ${formatted_list}    ${seat_availability_status}    ${baggage_is_present}
    Log    ${baggage_info_list}
    Log    ${meal_info_list}
    Log    ${formatted_list}
    Sleep    10s
    IF    "${seat_availability_status}"=="True"
        ${seat_formatted_list}    Create List
    #    FOR    ${element}    IN    @{formatted_list}
    #        ${index}    ${substring}    Get Substring    ${element}    0    20
    #        FOR    ${part}    IN    @{substring.split(",")}
    #        ${part}    Set Variable If    'A' in ${part}    ${part.strip()}    ${EMPTY}
    #        Run Keyword If    "${part}" != "${EMPTY}"    Append To List    ${seat_formatted_list}    ${part}
    #        END
    #    END
    #    Log    ${seat_formatted_list}
        ${seat_formatted_list}    Evaluate    [element.split(":")[1].strip() for element in ${formatted_list}]
        Log    ${seat_formatted_list}

        ${seat_info_on_cart_details_page}    Create List
        @{seat}    Get Webelements    //span[@class="sm_font col-sm-6 padd-left-amendment"][text()="Seat Code"]
        FOR    ${element}    IN    @{seat}
            ${seat_info}    Get Text    ${element}
            Append To List    ${seat_info_on_cart_details_page}    ${seat_info}
            ${seat_info_output}    Set Variable    ${seat_info.split(":")[1].strip()}
            List Should Contain Value    ${seat_formatted_list}    ${seat_info_output}
            Log    ${seat_info_on_cart_details_page}
        END
        Log    ${seat_info_on_cart_details_page}
    END

    IF    ${baggage_is_present}
        ${baggage_info_on_cart_details_page}    Create List
        @{baggage}    Get Webelements    //span[@class="sm_font col-sm-6 padd-left-amendment"][text()="Baggage"]
        FOR    ${element}    IN    @{baggage}
            ${baggage_info}    Get Text    ${element}
            Append To List    ${baggage_info_on_cart_details_page}    ${baggage_info}
            ${baggage_info_output}    Set Variable    ${baggage_info.split(":")[1].strip()}
            List Should Contain Value    ${baggage_info_list}    ${baggage_info_output}
            Log    ${baggage_info_on_cart_details_page}
        END
        Log    ${baggage_info_on_cart_details_page}

    ELSE IF    ${meal_info_list} != []
        ${meal_info_on_cart_details_page}    Create List
        @{meal}    Get Webelements    //span[@class="sm_font col-sm-6 padd-left-amendment"][text()="Meal"]
        FOR    ${element}    IN    @{meal}
            ${meal_info}    Get Text    ${element}
            Append To List    ${meal_info_on_cart_details_page}    ${meal_info}
            ${meal_info_output}    Set Variable    ${meal_info.split(":")[1].strip()}
            List Should Contain Value    ${meal_info_list}    ${meal_info_output}
            Log    ${meal_info_on_cart_details_page}
        END
        Log    ${meal_info_on_cart_details_page}
    END

Navigate To Cart Details Page
    Wait Until Element Is Visible    ${booking_id}
    Scroll Element Into View    ${booking_id}
    Click Element    ${booking_id}
    Wait Until Page Contains    Cart-detail    timeout=40s
