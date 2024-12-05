*** Settings ***
Library    SeleniumLibrary
#Library    CustomLibrary.py
Library    Collections
Library    BuiltIn
Library    String
Library    ../../CommonKeywords/CustomKeywords/user_keywords.py
Variables    ../../PageObjects/Booking/booking_summary_locators.py
Variables    ../../PageObjects/FlightItinerary/flight_itinerary_locators.py
Variables    ../../PageObjects/SeatMapWindow/seat_map_window_locators.py
Resource    ../../CommonKeywords/Review/review_keywords.robot
Resource    ../../CommonKeywords/SeatMapWindow/seat_map_window_keywords.robot
Variables    ../../PageObjects/SearchPageFilter/search_page_filter_locators.py

*** Keywords ***
Verify Passenger Details On booking Summary Page
    [Arguments]        ${passenger_list}
    Execute Javascript   window.scroll(0,500)
    ${passenger_names}    Get Webelements    ${pax_names}
    ${booking_summary_list}  Create List
    FOR    ${current_passenger_name}  IN   @{passenger_names}
      ${passenger_text}    Get Text    ${current_passenger_name}
      ${passenger_text}   Remove Newline        ${passenger_text}
      Append To List    ${booking_summary_list}    ${passenger_text}
    END
    ${passenger_list}   Evaluate    "${passenger_list}".upper()
    ${booking_summary_list}  Evaluate     "${booking_summary_list}".upper()
    Should Be Equal    ${passenger_list}    ${booking_summary_list}

Verify Success Booking Status On Booking Summary Page
    Wait Until Element Is Visible    ${booking_status}    timeout=30
#    Wait Until Page Contains Element    ${booking_success_status}    timeout=40
#    Page Should Contain Element    ${booking_success_status}
#    Page Should Contain Element    ${booking_notification}

Get Flight Details From Search Page
    ${no_flights_available}    Run Keyword And Return Status    Page Should Contain    Sorry, There were no flights found for this route Please, Modify your search and try again.
    IF    ${no_flights_available}
      Log    Sorry, There were no flights found for this route Please, Modify your search and try again.
      Fail
    END
    ${flight_details_from_search}    Get Flight Details    ${flight_Name_locator}  ${flight_departure_detail}   ${flight_destination_detail}    ${flight_duration_flight_type_search_result}
    Log To Console    ${flight_details_from_search}
    Sleep    5s
    RETURN    ${flight_details_from_search}

Verify Flight Details From Search Page On Flight Itinerary Page
    [Arguments]    ${flight_details_from_search}
    ${flight_details_from_itinerary}   Get Flight Details    ${flight_name_itinerary}  ${departure_itinerary}   ${destination_itinerary}    ${flight_duration_flight_type_itinerary}
    Log To Console    ${flight_details_from_itinerary}
    Sleep    5s
    Verify Flight Details    ${flight_details_from_search}    ${flight_details_from_itinerary}
    RETURN    ${flight_details_from_itinerary}

Verify Flight Details On Review Page
    [Arguments]    ${flight_detail_itinerary_page}
    Wait Until Element Is Visible    ${review_page_title}   timeout=60
    Page Should Contain Element    ${review_page_title}
    ${element_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${down_arrow}
    Run Keyword If   '${element_visible}' == 'True'    Click Element   ${down_arrow}
    ${flight_detail_review_page}    Get Flight Details     ${flight_name_itinerary}  ${departure_itinerary}   ${destination_itinerary}    ${flight_duration_flight_type_review}
    Log To Console    ${flight_detail_review_page}
    Verify Flight Details    ${flight_detail_review_page}    ${flight_detail_itinerary_page}
    RETURN    ${flight_detail_review_page}

Enter Details On Pax Details Page And Proceed To Review Page
    Add Passenger
    Skip Refundable Booking
    Enter Contact Details
    Click Proceed To Review Button

Make Payment
    Proceed To Pay
    Verify Terms And Conditions Check Box On Payment Page
    Click Pay Now Button
    Click Continue Button To View Booking Status

Make Payment After Verifying Fare Summary
    [Arguments]    ${fare_summary_review_page}
    Proceed To Pay
    ${fare_summary_payment_page}    Get Fare Details on flight itinerary | pax details | review page | payment page
    Log To Console    ${fare_summary_payment_page}
    Lists Should Be Equal    ${fare_summary_payment_page}    ${fare_summary_review_page}
    ${fare_summary_payment_page}    Convert Fare Summary From Payment Page To Match Values On Booking Summary Page    ${fare_summary_payment_page}
    Verify Terms And Conditions Check Box On Payment Page
    Click Pay Now Button
    Click Continue Button To View Booking Status
    RETURN    ${fare_summary_payment_page}

Convert Fare Summary From Payment Page To Match Values On Booking Summary Page
    [Arguments]    ${fare_summary_payment_page}
    &{fare_summary_payment_page}    Create Dictionary    base_fare=${fare_summary_payment_page.base_fare}    taxes=${fare_summary_payment_page.taxes}    total=${fare_summary_payment_page.total_amount_to_pay}
    Log To Console    ${fare_summary_payment_page}
    RETURN    ${fare_summary_payment_page}

Verify Flight Details On Booking Summary Page
    [Arguments]    ${flight_details_from_review}    ${layover_details}
    Success TJ Popup Handle
    ${booking_status}    ${id}    Get Booking Status And Id From Booking Summary Page
    ${flight_detail_booking_page}    Get Flight Details     ${flight_name_itinerary}  ${departure_itinerary}   ${destination_itinerary}    ${flight_duration_flight_type_review}
    Log To Console    ${flight_detail_booking_page}
    Verify Flight Details    ${flight_details_from_review}    ${flight_detail_booking_page}
    Verify Layover Details For Booking Summary      ${layover_details}

Enter Supplier ID Into Current URL
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Sleep    3s
    Log    ${my_dict}
    IF    "${my_dict.sId}" != "Null"
      ${current_url}=    Get Location
      ${new_url}=    Set Variable    ${current_url}&sId=${my_dict.sId}
      Go To    ${new_url}
    END

Get PNR and Ticket Number On Booking Summary Page
    ${booking_status}    ${id}    Get Booking Status And Id From Booking Summary Page
    Sleep    10s
    ${all_flight_name}    SeleniumLibrary.Get Element Count    ${flight_name_itinerary}
    ${total_passenger_number}    SeleniumLibrary.Get Element Count    ${total_passenger_count}
    ${count}    Set Variable    1
    ${element}    Set Variable    1
    @{all_PNR_Number}    Create List
    @{all_Ticket_Number}    Create List
    @{GDS_PNR}    Create List
    Sleep    20s
    Execute JavaScript    window.scrollBy(0,700);
    Verify Booking Status For PNR and Ticket Number    ${booking_status}
    Sleep    10s
    Execute JavaScript    window.scrollBy(0,700);
    FOR    ${element_count}    IN RANGE    1    ${all_flight_name}+1
       FOR    ${count}    IN RANGE    1    ${total_passenger_number}+1
           ${flight_for_passenger}    SeleniumLibrary.Get Element Count    //div[text()=${count}]/parent::li/child::div[@class="pax-tdthird"]/child::div
           FOR    ${counter}    IN RANGE    1    ${flight_for_passenger}+1
               ${PNR_with_source_destination}    Get Text    //div[text()=${count}]/parent::li/child::div[@class="pax-tdthird"]/child::div[${counter}]
               ${splitted_string}    Split String    ${PNR_with_source_destination}    :
               ${second_string}    Get From List    ${splitted_string}    1
               ${stripped_second_string}    Strip String    ${second_string}
               ${splitted_string_with_pnr}    Split String    ${stripped_second_string}    ${space}
               ${length}    Get Length    ${splitted_string_with_pnr}
               ${air_pnr}    Get From List    ${splitted_string_with_pnr}    0
               IF    ${length}<3
                   ${ticket_no}    Get From List    ${splitted_string_with_pnr}    1
               ELSE IF    ${length}==3
                   ${GDS_pnr}    Get From List    ${splitted_string_with_pnr}    1
                   ${ticket_no}    Get From List    ${splitted_string_with_pnr}    2
                   Append To List    ${GDS_PNR}    ${GDS_pnr}
               END
               ${string_with_parentheses}=    Set Variable    ${ticket_no}
               ${string_without_parentheses}=    Replace String    ${string_with_parentheses}    (    ${EMPTY}
               ${ticket_without_parentheses}=    Replace String    ${string_without_parentheses}    )    ${EMPTY}
           END
       END
       Append To List    ${all_PNR_Number}    ${air_pnr}
       Append To List    ${all_Ticket_Number}    ${ticket_without_parentheses}
    END
    Verify User Is Able To Redirect On Cart Details Page For PNR and Ticket Number    ${booking_status}    ${id}
    RETURN    ${all_PNR_Number}    ${all_Ticket_Number}    ${GDS_PNR}

Verify PNR and Ticket Number On Cart Details Page
    [Arguments]    ${all_PNR_Number}    ${all_Ticket_Number}    ${GDS_PNR}
    Wait Until Element Is Visible    ${cart_detail_text}
    Sleep    10s
    @{airline_list}    Create List
    @{GDS_list}    Create List
    @{Ticket_No_list}    Create List
    Execute Javascript    window.scrollBy(0,600);
    @{all_Airline_PNR}    Get Webelements    ${airline_PNR_field}
    FOR    ${element}    IN    @{all_Airline_PNR}
      ${Airline_PNR}    Get Value    ${element}
      Append To List    ${airline_list}    ${Airline_PNR}
    END
    Log    ${airline_list}
    @{all_GDS_PNR}    Get Webelements    ${GDS_number_field}
    FOR    ${element}    IN    @{all_GDS_PNR}
      ${GDS_PNR}    Get Value    ${element}
      Append To List    ${GDS_list}    ${GDS_PNR}
    END
    Log    ${GDS_list}
    @{all_Ticket_No_PNR}    Get Webelements    ${ticket_number_field}
    FOR    ${element}    IN    @{all_Ticket_No_PNR}
      ${Ticket_No}    Get Value    ${element}
      Append To List    ${Ticket_No_list}    ${Ticket_No}
    END
    Log    ${Ticket_No_list}
    Lists Should Be Equal    ${airline_list}    ${all_PNR_Number}
    Lists Should Be Equal    ${Ticket_No_list}    ${all_Ticket_Number}
    IF    '${GDS_PNR}' != '${Empty}'
        Lists Should Be Equal    ${GDS_list}    ${GDS_PNR}
    END

Verify Passenger Details Till Booking Page
    [Arguments]    ${booking_data}
    ${flight_details}    ${Fare_summary}    ${False}    Handle All Popups    ${False}   ${False}    ${False}    ${False}
    ${add_passenger_details}    ${contact_number}    Add Passenger Details And Proceed To Review Page
    ${review_details}    ${review_contact_number}    Verify Passenger Details And Proceed To Pay    ${add_passenger_details}    ${contact_number}
    Select The Payment Mode    ${booking_data}
    Verify Terms And Conditions Check Box On Payment Page
    Click Pay Now Button
    Click Continue Button To View Booking Status
    Success TJ Popup Handle
    Sleep    30s
    Success Booking With TripJack Popup Handle
    RETURN    ${review_details}    ${review_contact_number}

Verify Passport Details Entered On Pax Details Page
    ${passenger_list}    Add Passenger
    Execute Javascript    window.scrollBy(0,300);
    ${passport_detail_list}    Add Passport Details On Pax Details Page From Booking Summary
    Log To Console    ${passport_detail_list}
    Skip Refundable Booking
    ${Contact_details}    Enter Contact Details
    Sleep    20s
    Click proceed to Review button
    ${passport_details_on_review}    Verify Passport Details On Review Page    ${passport_detail_list}
    Sleep    10s
    RETURN    ${passport_details_on_review}

Add Passport Details On Pax Details Page From Booking Summary
    ${passport_field_status}    Run Keyword And Return Status    Page Should Contain Element    ${passport_field}
    IF    ${passport_field_status}
        ${passport_detail_list}=     Create List
        ${indexing}=    Set Variable    1
        ${total_adult_passenger_count}    SeleniumLibrary.Get Element Count    ${adult_first_name_field}
        WHILE      ${indexing} <= ${total_adult_passenger_count}
          Scroll Element Into View    (//select[contains(@name,"pNat")])[${indexing}]
          Execute Javascript    window.scrollBy(0,200);
          Wait Until Page Contains Element    (//select[contains(@name,"pNat")])[${indexing}]
          Click Element    (//select[contains(@name,"pNat")])[${indexing}]
          Sleep    10s
          Click Element    (//select[contains(@name,"pNat")])[${indexing}]/option[text()="India"]
          ${Nationality}    Get Text    (//select[contains(@name,"pNat")])[${indexing}]/option[text()="India"]
          ${adult_passport_number}    Generate Passport Number
          Log To Console    ${adult_passport_number}
          Input Text    //input[@name="ADULT${indexing}_pNum"]    ${adult_passport_number}
          ${adult_passport_issue_date}    Generate Passport Issue Date
          Wait Until Element Is Visible    //select[@name="ADULT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]
          Input Text    //select[@name="ADULT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]    ${adult_passport_issue_date}
          ${adult_passport_expiry_date}    Get Value    //select[@name="ADULT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Expiry Date *"]
          Log    ${adult_passport_expiry_date}
          Sleep    20s
          ${dob_field_additionally_present}    Run Keyword And Return Status    Page Should Contain Element    //input[@name="ADULT1_dob"]
          IF    ${dob_field_additionally_present}
              ${dob}    Get Value    //input[@name="ADULT${indexing}_dob"]
              log    ${dob}
              Sleep    5s
              Click Element    //input[@name="ADULT${indexing}_dobPassport"]
              Input Text    //input[@name="ADULT${indexing}_dobPassport"]    ${dob}
              Sleep    3s
          END
          ${dob}    Get Value    //input[@name="ADULT1_dobPassport"]
          Log    ${dob}
          ${full_passport_detail}=     Set Variable  ${Nationality} ${adult_passport_number} ${adult_passport_issue_date} ${adult_passport_expiry_date}
          Append To List    ${passport_detail_list}    ${full_passport_detail}
          ${indexing}=  Evaluate   ${indexing} + 1
        END
        ${indexing}=    Set Variable    1
        ${total_child_passenger_count}    SeleniumLibrary.Get Element Count    ${child_first_name_field}
        WHILE      ${indexing} <= ${total_child_passenger_count}
#          Scroll Element Into View    //select[@name="CHILD${indexing}_pNat"]
#          Execute Javascript    window.scrollBy(0,200);
#          Click Element    //select[@name="CHILD${indexing}_pNat"]
#          Wait Until Element Is Visible    //select[@name="CHILD${indexing}_pNat"]
#          Sleep    5s
#          Click Element    ${indian_option}
#          ${Nationality}    Get Value    ${indian_option}
#          ${child_passport_number}    Generate Passport Number
#          Log To Console    ${child_passport_number}
#          Input Text    //input[@name="CHILD${indexing}_pNum"]    ${child_passport_number}
#          ${child_passport_issue_date}    Generate Passport Issue Date
#          Wait Until Element Is Visible    //select[@name="CHILD${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]
#          Input Text    //select[@name="CHILD${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]    ${child_passport_issue_date}
#          ${child_passport_expiry_date}    Get Value    //select[@name="CHILD${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Expiry Date *"]
#          ${child_dob}    Generate Child Birth Date
#          ${dob}=  Run Keyword And Return Status     Page Should Contain Element    (${child_dob_field})[${indexing}]
#          Input Text    //input[@name="CHILD${indexing}_dobPassport"]    ${child_passport_number}
#          ${full_passport_detail}=     Set Variable  ${Nationality} ${child_passport_number} ${child_passport_issue_date} ${child_passport_expiry_date}
#          Append To List    ${passport_detail_list}    ${full_passport_detail}
#          ${indexing}=  Evaluate   ${indexing} + 1

          Scroll Element Into View    //select[@name="CHILD${indexing}_pNat"]
          Execute Javascript    window.scrollBy(0,200);
          Click Element    //select[@name="CHILD${indexing}_pNat"]
          Wait Until Element Is Visible    //select[@name="CHILD${indexing}_pNat"]
          Sleep    6s
          Wait Until Element Is Visible    ${indian_option_for_child}
          Click Element    ${indian_option_for_child}
          Run Keyword And Ignore Error        Click Element    ${indian_option_for_child}
          ${Nationality}    Get Value    ${indian_option_for_child}
          ${child_passport_number}    Generate Passport Number
          Log To Console    ${child_passport_number}
          Input Text    //input[@name="CHILD${indexing}_pNum"]    ${child_passport_number}
          ${child_passport_issue_date}    Generate Passport Issue Date
          Wait Until Element Is Visible    //select[@name="CHILD${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]
          Input Text    //select[@name="CHILD${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]    ${child_passport_issue_date}
          ${child_passport_expiry_date}    Get Value    //select[@name="CHILD${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Expiry Date *"]
          Log    ${child_passport_expiry_date}
          Sleep    20s
          ${dob_field_additionally_present}    Run Keyword And Return Status    Page Should Contain Element    //input[@name="CHILD1_dob"]
          IF    ${dob_field_additionally_present}
              ${dob}    Get Value    //input[@name="CHILD${indexing}_dob"]
              log    ${dob}
              Sleep    5s
              Click Element    //input[@name="CHILD${indexing}_dobPassport"]
              Input Text    //input[@name="CHILD${indexing}_dobPassport"]    ${dob}
              Sleep    3s
          END
          ${dob}    Get Value    //input[@name="CHILD1_dobPassport"]
          Log    ${dob}
          ${full_passport_detail}=     Set Variable  ${Nationality} ${child_passport_number} ${child_passport_issue_date} ${child_passport_expiry_date}
          Append To List    ${passport_detail_list}    ${full_passport_detail}
          ${indexing}=  Evaluate   ${indexing} + 1
        END
        ${indexing}=    Set Variable    1
        ${total_infant_passenger_count}    SeleniumLibrary.Get Element Count    ${infant_first_name_field}
        WHILE      ${indexing} <= ${total_infant_passenger_count}
           ${indexing}    Convert To String    ${indexing}
#          Scroll Element Into View    //select[@name="INFANT${indexing}_pNat"]
#          Execute Javascript    window.scrollBy(0,200);
#          Click Element    //select[@name="INFANT${indexing}_pNat"]
#          Wait Until Element Is Visible    //select[@name="INFANT${indexing}_pNat"]
#          Sleep    5s
#          Click Element    ${indian_option}
#          ${Nationality}    Get Value    ${indian_option}
#          ${infant_passport_number}    Generate Passport Number
#          Log To Console    ${infant_passport_number}
#          Input Text    //input[@name="INFANT${indexing}_pNum"]    ${infant_passport_number}
#          ${infant_passport_issue_date}    Generate Passport Issue Date
#          Wait Until Element Is Visible    //select[@name="INFANT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]
#          Input Text    //select[@name="INFANT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]    ${infant_passport_issue_date}
#          ${infant_passport_expiry_date}    Get Value    //select[@name="INFANT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Expiry Date *"]
#          ${full_passport_detail}=     Set Variable  ${Nationality} ${infant_passport_number} ${infant_passport_issue_date} ${infant_passport_expiry_date}
#          Append To List    ${passport_detail_list}    ${full_passport_detail}
#          ${indexing}=  Evaluate   ${indexing} + 1

          Scroll Element Into View    //select[@name="INFANT${indexing}_pNat"]
          Execute Javascript    window.scrollBy(0,200);
          Click Element    //select[@name="INFANT${indexing}_pNat"]
          Wait Until Element Is Visible    //select[@name="INFANT${indexing}_pNat"]
          Sleep    5s
          Click Element    ${indian_option_for_infant}
          ${Nationality}    Get Value    ${indian_option_for_infant}
          ${infant_passport_number}    Generate Passport Number
          Log To Console    ${infant_passport_number}
          Input Text    //input[@name="INFANT${indexing}_pNum"]    ${infant_passport_number}
          ${infant_passport_issue_date}    Generate Passport Issue Date
          Wait Until Element Is Visible    //select[@name="INFANT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]
          Input Text    //select[@name="INFANT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]    ${infant_passport_issue_date}
          ${infant_passport_expiry_date}    Get Value    //select[@name="INFANT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Expiry Date *"]
          Log    ${infant_passport_expiry_date}
          Sleep    20s
          ${dob_field_additionally_present}    Run Keyword And Return Status    Page Should Contain Element    //input[@name="INFANT1_dob"]
          IF    ${dob_field_additionally_present}
              ${dob}    Get Value    //input[@name="INFANT${indexing}_dob"]
              log    ${dob}
              Sleep    5s
              Click Element    //input[@name="INFANT${indexing}_dobPassport"]
              Input Text    //input[@name="INFANT${indexing}_dobPassport"]    ${dob}
              Sleep    3s
          END
          ${dob}    Get Value    //input[@name="INFANT1_dobPassport"]
          Log    ${dob}
          ${full_passport_detail}=     Set Variable  ${Nationality} ${infant_passport_number} ${infant_passport_issue_date} ${infant_passport_expiry_date}
          Append To List    ${passport_detail_list}    ${full_passport_detail}
          ${indexing}=  Evaluate   ${indexing} + 1
        END
        RETURN    ${passport_detail_list}
    END

Verify Passport Details On Review Page
    [Arguments]    ${passport_detail_list}
    Log    ${passport_detail_list}
    Capture Page Screenshot
    Wait Until Element Is Visible    ${review_page_title}    timeout=30s
    ${passport_details_from_pax}    Create List
    ${passport_details_on_review}    Create List
    ${passenger_names}    SeleniumLibrary.Get Element Count    ${passenger_name}
    FOR    ${indexing}  IN RANGE    1    ${passenger_names}+1
      ${passport_detail}    Get Text    (//span[@class="pax-passportSize"])[${indexing}]
      Log    ${passport_detail}
      Append To List    ${passport_details_on_review}    ${passport_detail}
      ${passport_details_on_review}    Remove Date Before Pp    ${passport_details_on_review}
    END
    ${count}=    Get Length    ${passport_detail_list}
    Log    ${count}
    FOR    ${element}    IN RANGE    0   ${count}
      Log    ${element}
      ${index}    Set Variable    ${passport_detail_list}[${element}]
      ${key} =    Set Variable    ${index}
      ${value} =    Set Variable    PP :${index.split(' ')[1]} N :${index.split(' ')[0]} ID :${index.split(' ')[2]} ED :${index.split(' ')[3]}
      Append To List    ${passport_details_from_pax}    ${value}
    END
    Log    ${passport_details_from_pax}
    Lists Should Be Equal    ${passport_details_from_pax}    ${passport_details_on_review}
    RETURN    ${passport_details_on_review}

Verify Passport Details On Booking Summary Page
    [Arguments]    ${passport_detail_list}
    Log    ${passport_detail_list}
    Get Booking Status And Id From Booking Summary Page
    ${passport_details_from_review}    Create List
    ${passport_number_on_summary_page}    Create List
    ${issue_date_on_summary_page}    Create List
    ${expiry_date_on_summary_page}    Create List
    ${passenger_names}    SeleniumLibrary.Get Element Count    ${passenger_count_on_booking_page}
    FOR    ${indexing}  IN RANGE    1    ${passenger_names}+1
      ${passport_detail}    Get Text    (//span[@class="pax-passportSize confirmationPage-pax-passportSize-positionHandle"])[${indexing}]
      Log To Console    ${passport_detail}
      ${modified_list}    Extract Passport Details    ${passport_detail}
      ${passport_number}    Extract Passport Number From Booking Summary    ${modified_list}
      ${issue_date}    Extract Issue Date From Booking Summary    ${modified_list}
      ${expiry_date}    Extract Expiry Date From Booking Summary    ${modified_list}
      Append To List    ${passport_details_from_review}    ${modified_list}
      Append To List    ${passport_number_on_summary_page}    ${passport_number}
      Append To List    ${issue_date_on_summary_page}    ${issue_date}
      Append To List    ${expiry_date_on_summary_page}    ${expiry_date}
    END
    Lists Should Be Equal    ${passport_details_from_review}    ${passport_detail_list}
    RETURN    ${passport_number_on_summary_page}    ${issue_date_on_summary_page}    ${expiry_date_on_summary_page}

Select The Payment Mode
    [Arguments]    ${booking_data}
    ${my_dict}    Create Dictionary    &{booking_data}
    Wait Until Element Is Visible    //a[text()="${my_dict.PaymentMode}"]
    Click Element    //a[text()="${my_dict.PaymentMode}"]

Verify Passengers DOB
    [Arguments]    ${review_details}    ${review_contact_number}
    Get Booking Status And Id From Booking Summary Page
    Sleep    30s
    ${passenger_details}    Get Webelements    ${passenger_name_dob_on_booking_summary}
    Log   ${passenger_details}
    ${booking_summay_passenger_list}    Create List
    FOR    ${current_passenger_name_dob}  IN   @{passenger_details}
      ${passenger_name_dob}    Get Text    ${current_passenger_name_dob}
      Log    ${passenger_name_dob}
      ${passenger_name_dob}   Remove Newline    ${passenger_name_dob}
      Log    ${passenger_name_dob}
      Append To List    ${booking_summay_passenger_list}    ${passenger_name_dob}
    END
    ${review_details_list} =    Evaluate    [item.lower() for item in ${review_details}]
    ${booking_summay_passenger_list} =    Evaluate    [item.lower() for item in ${booking_summay_passenger_list}]
    Lists Should Be Equal    ${review_details_list}    ${booking_summay_passenger_list}

Add Passenger Details And Proceed To Review Page
    ${passenger_list}    Add Passenger
    Skip Refundable Booking
    ${Contact_details}    Enter Contact Details
    Click proceed to Review button
    RETURN    ${passenger_list}    ${Contact_details}
    Sleep    30s

Verify Passenger Details And Proceed To Pay
    [Arguments]    ${passenger_details}    ${contact_number}
    Wait Until Element Is Visible    ${review_page_title}    timeout=60s
    ${review_passenger_list}    ${Contact_details_review}    Verify Passenger Details And Contact Details On Review Page    ${passenger_details}    ${contact_number}
    Proceed To Pay
    RETURN    ${review_passenger_list}    ${Contact_details_review}

Get Fare Details on flight itinerary | pax details | review page | payment page
    Wait Until Element Is Visible    ${base_fare_summary}
    ${base}=    Get Text  ${base_fare_summary}
    ${taxes}=    Get Text    ${taxes_fees_summary}
    ${total}=    Get Text    ${amount_to_pay}
    ${total_base_fare}=    Extract Final Fare As String    ${base}
    ${total_taxes}=   Extract Final Fare As String   ${taxes}
    ${total}=   Extract Final Fare As String    ${total}
    &{fare_summary}=    Create Dictionary    base_fare=${total_base_fare}    taxes=${total_taxes}    total_amount_to_pay=${total}    is_fare_jump=${False}
    Log To Console    ${fare_summary}
    RETURN    &{fare_summary}

Get Fare Details On Booking Summary Page
    Success TJ Popup Handle
    Success Booking With TripJack Popup Handle
    Get Booking Status And Id From Booking Summary Page
    Wait Until Element Is Visible    ${base_fare_summary}    timeout=30s
    ${base}=    Get Text  ${base_fare_summary}
    ${taxes}=    Get Text    ${taxes_fees_summary}
    ${total}=    Get Text    ${total_fare_amount}
    ${total_base_fare}=    Extract Final Fare As String    ${base}
    ${total_taxes}=   Extract Final Fare As String   ${taxes}
    ${total}=   Extract Final Fare As String    ${total}
    ${fare_summary}=    Create Dictionary    base_fare=${total_base_fare}    taxes=${total_taxes}    total=${total}
    Log To Console    ${fare_summary}
    RETURN    ${fare_summary}    ${total_taxes}

Verify Updated Markup On Booking Summary Page
    [Arguments]    ${fare_summary}    ${total_taxes_before_adding_markup}    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Click Element    ${markup_icpn}
    Input Text    ${markup_field}    ${my_dict.MarkupAmount}
    Click Element    ${markup_update_button}
    ${value}    Get Text    ${taxes_fees_summary}
    ${fare_summary}    ${total_taxes_after_adding_markup}    Get Fare Details On Booking Summary Page
    ${calculate_markup_amount_taxes}    Calculate Added Markup Amount    ${total_taxes_before_adding_markup}    ${search_data}
    Log To Console    ${fare_summary}
    Should Be Equal As Numbers    ${calculate_markup_amount_taxes}    ${total_taxes_after_adding_markup}
    ${expected_total_amount_paid}    Evaluate    ${fare_summary.base_fare}+${calculate_markup_amount_taxes}
    Should Be Equal As Numbers    ${expected_total_amount_paid}    ${fare_summary.total}
    RETURN    ${expected_total_amount_paid}

Calculate Added Markup Amount
    [Arguments]    ${total_taxes_before_adding_markup}    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    ${calculate_markup_amount_taxes}    Added Markup Price    ${total_taxes_before_adding_markup}    ${my_dict.MarkupAmount}
    Log    ${calculate_markup_amount_taxes}
    RETURN    ${calculate_markup_amount_taxes}

Add Markup
    [Arguments]    ${my_dict}
    Click Element    ${markup_icon}
    Input Text    ${markup_field}    ${my_dict.MarkupAmount}
    Click Element    ${markup_update_button}

Add Markup On Search Page
    [Arguments]    ${my_dict}
    ${fare_amount_before_adding_markup}    Get Text    ${fare_amount_on_search_page}
    ${fare_amount_before_adding_markup_extracted}    Extract Final Fare As String    ${fare_amount_before_adding_markup}
    Click Element    ${markup_icon_on_search_page}
    Input Text    ${markup_field}    ${my_dict.MarkupAmount}
    Click Element    ${markup_update_button}
    RETURN    ${fare_amount_before_adding_markup_extracted}

Verify Updated Markup On Search Result Page
    [Arguments]    ${fare_amount_before_adding_markup_extracted}    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    ${fare_amount_before_adding_markup_extracted}    Add Markup On Search Page    ${my_dict}
    Sleep    5
    ${calculate_markup_amount}    Calculate Added Markup Amount    ${fare_amount_before_adding_markup_extracted}    ${search_data}
    ${fare_amount_after_adding_markup}    Get Text    ${fare_amount_on_search_page}
    ${fare_amount_after_adding_markup_extracted}    Extract Final Fare As String    ${fare_amount_after_adding_markup}
    Should Be Equal As Numbers    ${calculate_markup_amount}    ${fare_amount_after_adding_markup_extracted}
    RETURN    ${fare_amount_after_adding_markup_extracted}

Verify Print Icon
    [Arguments]    ${review_contact_number}
    Sleep    5s
    Wait Until Element Is Visible    ${print_icon}
    Scroll Element Into View    ${print_icon}
    Execute Javascript  window.scroll(0,500)
    ${count}    SeleniumLibrary.Get Element Count      ${print_icon}
    ${x}    Set Variable    1
    ${y}    Set Variable    1
    FOR    ${x}    IN RANGE    1    ${count}+1
      ${pax_name}    Get Text    (//div[@class = 'pax-tdsecond'])[${x}]
      Wait Until Element Is Visible    ${print_icon}
      Sleep    5s
      Click Element    (//div[@class='pax-tdfirstprint']/i)[${x}]
      Wait Until Page Contains    Print Ticket
      ${checkbox_count}    SeleniumLibrary.Get Element Count    ${total_print_icon}
      Sleep    2s
      FOR    ${y}    IN RANGE    1    ${checkbox_count}+1
          ${status}    Run Keyword And Return Status    Checkbox Should Be Selected    //div[contains(@class, 'print-checkboxs')][${y}]/input
          IF    ${status} == False
              Click Element    //div[contains(@class, 'print-checkboxs')][${y}]/label
              Sleep    2s
          END
      END
      Wait Until Element Is Visible    ${submit_button}
      Click Element    ${submit_button}
      Sleep    10s
      Capture Page Screenshot
      Handle Print Window
      Verify Details On Print Page    ${pax_name}    ${review_contact_number}
      Wait Until Element Is Visible    ${invoice_back_button}
      Click Element    ${invoice_back_button}
      Wait Until Page Contains Element    ${booking_status}
      Wait Until Element Is Visible    ${print_icon}
      Scroll Element Into View    ${print_icon}
      Execute Javascript  window.scroll(0,500)
      Sleep    2s
    END

Verify Details On Print Page
    [Arguments]    ${pax_name}    ${review_contact_number}
    ${print_pax_name}    Get Text    ${pax_name_on_print_page}
    ${pax_name}    Strip String    ${pax_name}
    ${pax_name}    Replace String    ${pax_name}    \n    ${SPACE}
    ${print_pax_name}    Strip String    ${print_pax_name}
    ${print_pax_name}    Evaluate    "${print_pax_name}".replace('( ', '(').replace(' )', ')')
    ${email}    Get Text    ${email_print_page}
    ${email_address}    Split String    ${email}    ${SPACE}
    ${email_address}    Get From List    ${email_address}    2
    ${contact}    Get Text    ${contact_print_page}
    ${contact_number}    Split String    ${contact}    ${SPACE}
    ${contact_number}    Get From List    ${contact_number}    2
    Page Should Contain    Passenger Details
    Should Be Equal As Numbers    ${review_contact_number.mobile}    ${contact_number}
    Should Be Equal As Strings    ${review_contact_number.email}    ${email_address}
    Should Be Equal  ${pax_name}    ${print_pax_name}

Handle Print Window
    ${handles}=    Get Window Handles
    #   ${handles_identifier}=    Get Window Identifiers
    ${main_window}=    Set Variable    ${handles}[1]
    switch window   ${handles}[0]
    ${back_button_present}    Run Keyword And Return Status    Page Should Contain Element    ${invoice_back_button}
    IF    "${back_button_present}"=="False"
      Handle Print Dialog
      Switch Window    ${main_window}
    ELSE
      Switch Window    ${handles}[1]
      Handle Print Dialog
      switch window   ${handles}[0]
    END

Handle All Popups
    [Arguments]  ${flight_details}  ${Fare_summary}    ${flag}    ${layover_details}
    Log    ${flag}
    Sleep    20s
    Handle Consent Message Popup
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${amount_to_pay}    timeout=30
    ${is_fare_jump}    Run Keyword And Return Status    Element Should Be Visible    ${fare_jump_popup_new}
    Capture Page Screenshot
    ${is_fare_type_change}    Run Keyword And Return Status    Element Should Be Visible    ${fare_type_change_popup}
    ${is_hand_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_hand_baggage_popup}
    ${is_sold_out}    Run Keyword And Return Status    Element Should Be Visible    ${sold_out_popup}
    ${is_fare_changed_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_fare_have_changed_baggage}
    IF    ${is_fare_type_change}
      ${flight_details}  Handle Fare Type Change Popup    ${flight_details}
    ELSE IF   ${is_fare_jump}
      ${Fare_summary}  Handle Fare Jump  ${Fare_summary}
    ELSE IF    ${is_hand_baggage}
      Click Element    ${hand_baggage_continue_button}
    ELSE IF   ${is_sold_out}
       IF    ${flag}
          Skip
      ELSE
          ${flight_details}  ${Fare_summary}   Handle Sold Out Popup From Booking Summary
      END
    ELSE IF    ${is_fare_changed_baggage}
        Click Element    ${continue_btn_fare}
    END
    ${total_fare_on_itinerary}=    Get Text    (//span[text()='Amount to Pay']/following::span[@class='pull-right fareSummary-prices-positionHandle'])[1]
    Log    ${total_fare_on_itinerary}
    Log    ${flight_details}
    RETURN  ${flight_details}  ${Fare_summary}    ${layover_details}

Handle Sold Out Popup From Booking Summary
    Click Element    ${sold_out_back_to_search_btn}
    Wait Until Element Is Visible    ${cheapest_flight_filter}    timeout=180
    Check Flights Are Available On Search Page
    ${Fare_summary}    Verify Fare Details And Get Fare Summary    (//button[@class='btn btn-default asr-viewbtn'][text()='View Details'])
    ${flight_details_from_search}    Get Flight Details    ${flight_Name_locator}  ${flight_departure_detail}   ${flight_destination_detail}    ${flight_duration_flight_type_search_result}
    ${layover_details}  Get Layover Details For Booking Summary
    Execute Javascript   window.scroll(0,-50)
    #    ${next_book_button}=  Replace String    ${book_button}
    #    Click Element    ${next_book_button}
    Click Element    ${book_button}
    Handle Consent Message Popup
    ${flag}    Set Variable    True
    Handle All Popups    ${flight_details_from_search}  ${Fare_summary}    ${flag}    ${layover_details}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${amount_to_pay}    timeout=30
    RETURN  ${flight_details_from_search}  ${Fare_summary}

Handle Fare Jump
    [Arguments]    ${Fare_summary}
    IF    ${Fare_summary}
      ${old_total_amount}=    Get Text    ${old_fare_amount}
      ${old_total_amount}=    Extract Final Fare As String    ${old_total_amount}
      Should Be Equal As Numbers    ${old_total_amount}    ${Fare_summary.total_fare_price}
          # fare price updated
      ${new_total_amount}=    Get Text    ${new_fare_amount}
      ${new_total_amount}=    Extract Final Fare As String    ${new_total_amount}
      ${Fare_summary.total_fare_price}=    Evaluate    ${new_total_amount}
      ${Fare_summary.is_fare_jump} =   Set Variable    ${True}
      Click Element  ${fare_jump_continue_btn}
      ${total}=    Get Text    ${amount_to_pay}
      ${total}=    Extract Final Fare As String    ${total}
      Should Be Equal As Numbers      ${total}      ${Fare_summary.total_fare_price}
    ELSE
      ${new_total_amount}=    Get Text    ${new_fare_amount}
      ${new_total_amount}=    Extract Final Fare As String    ${new_total_amount}
      ${Fare_summary.total_fare_price}=    Evaluate    ${new_total_amount}
      ${Fare_summary.is_fare_jump} =   Set Variable    ${True}
      Click Element  ${fare_jump_continue_btn}
      ${total}=    Get Text    ${amount_to_pay}
      ${total}=    Extract Final Fare As String    ${total}
      Should Be Equal As Numbers      ${total}      ${Fare_summary.total_fare_price}
    END

Block Process
    Wait Until Page Contains    Review
    Sleep    3s
    Execute Javascript  window.scroll(0,500)
    Wait Until Page Contains Element    ${proceed_to_pay_button}    timeout=20
    ${block_status}    Run Keyword And Return Status     Wait Until Page Contains Element    ${i_accept_checkbox}
    Sleep    5s
    IF    ${block_status}
      Scroll Element Into View    ${i_accept_checkbox}
      Execute Javascript  window.scroll(0,1000)
      Wait Until Element Is Visible    ${i_accept_checkbox}    timeout=20s
      Scroll Element Into View    ${i_accept_checkbox}
      Click Element    ${i_accept_checkbox}
      Click Element    ${block_btn}
      Wait Until Element Is Visible    ${booking_id_link}    timeout=40s
      Wait Until Page Contains    Booking On Hold    timeout=180s
    ELSE
      Log    Not able block this flight as block button is not visible
      Fail
    END

Verify Hold To Confirm Flow
    [Arguments]    ${flight_details_from_review}    ${layover_details}
    Wait Until Element Is Visible    ${pay_now_btn_on_hold}
    Click Element    ${pay_now_btn_on_hold}
    Wait Until Element Is Visible    ${payment_page_title}    timeout=30s
    Wait Until Element Is Visible    ${i_accept_checkbox}
    Click Element    ${i_accept_checkbox}
    Wait Until Element Is Visible   ${pay_button}
    Click Pay Now Button
    Click Continue Button To View Booking Status
    ${booking_status}    ${booking_id_text}    Get Booking Status And Id From Booking Summary Page
    IF    "${booking_status}" != "Success"
      Capture Screenshot From Notes    ${booking_status}
    ELSE
      Success TJ Popup Handle
      Success Booking With TripJack Popup Handle
      Verify Flight Details On Booking Summary Page    ${flight_details_from_review}    ${layover_details}
    END

Click Unhold Button
    Wait Until Element Is Visible    ${un_hold_button}
    Click Element    ${un_hold_button}

Click On Submit Button
    Wait Until Element Is Visible    ${button_submit}
    Click Element    ${button_submit}

Select Confirm To Proceed Checkbox
    Wait Until Page Contains Element    ${confirm_to_proceed_checkbox}
    Click Element    ${confirm_to_proceed_checkbox}

Verify Unhold flight
    [Arguments]    ${flight_details_from_review}    ${layover_details}
    ${booking_hold_status}    Run Keyword And Return Status    Page Should Contain    Booking On Hold
    Verify Flight Details On Booking Summary Page    ${flight_details_from_review}    ${layover_details}
    IF    ${booking_hold_status}
      Wait Until Page Contains Element    ${un_hold_button}   timeout=35
      Wait Until Page Contains Element    ${booking_toast_close_button}   timeout=10
      Click Element    ${booking_toast_close_button}
      Click Unhold Button
      Sleep    5s
      Select Confirm To Proceed Checkbox
      Click On Submit Button
      Wait Until Page Contains    Unhold Successful   timeout=15
      ${is_unconfirmed}    Run Keyword And Return Status    Wait Until Page Contains Element    ${booking_status_unconfirmed}  timeout=25
      IF    ${is_unconfirmed} == False
          Capture Screenshot From Notes    ${booking_status}
      END
    ELSE
      Log    Not able block/Unblock this flight as block button is not visible
    END

Click On Fare Rule
    [Arguments]    ${view_element}
    Click Element    ${view_element}
    Wait Until Element Is Visible    ${fare_rules_btn}    20s
    Click Element    ${fare_rules_btn}

Get Fare Rule Details
    ${is_no_rule}=  Run Keyword And Return Status    Wait Until Element Is Visible    ${no_rules}
    IF  ${is_no_rule}!=True
      Wait Until Element Is Visible    ${fare_rule_segment_info_element}  20s
      ${fare_rules_segment_info}  Get Text   ${fare_rule_segment_info_element}
      Scroll Element Into View    (//div[@class="star-text"])[1]
      Click Element    ${fare_rule_cancellation_fee_element}
      ${cancellation_fee}     Get Text     ${fare_rule_cancellation_fee}
      Click Element    ${fare_rule_date_change_element}
      ${date_change_fee}   Get Text     ${fare_rule_date_change_fee}
      Click Element    ${fare_detail_no_show_fee_element}
      ${no_show_fee}    Get Text    ${fare_detail_no_show_fee}
      Click Element     ${fare_detail_seat_chargeable_element}
      ${seat_chargeable_fee}    Get Text    ${fare_detail_chargeable_fee}
      ${fare_rules}   Create Dictionary   FareRuleSegmentInfo=${fare_rules_segment_info}  CancellationFee=${cancellation_fee}  DateChangeFee=${date_change_fee}   NoShowFee=${no_show_fee}   SeatChargeableFee=${seat_chargeable_fee}
      RETURN  ${fare_rules}
    ELSE
      ${ele_text}     Get Text    ${no_rules}
      ${fare_rules}   Create Dictionary   NoRules=${ele_text}
      RETURN  ${fare_rules}
    END

Get Fare Rule Details From Search Page
    ${status}    Run Keyword And Return Status    Page Should Contain Element    //button[text()='Please, Modify your search and try again.']
    IF    ${status} == False
      ${fare_rules_search_Results}    Get Fare Rules
      Log    ${fare_rules_search_Results}
      RETURN    ${fare_rules_search_Results}
    ELSE
      Log    No Flights available
    END

Verify Fare Rule Details From Search Page
    [Arguments]    ${fare_rules_search_Results}
    ${fare_rules_itinerary}   Get Fare Rules
    Log    ${fare_rules_itinerary}
    Verify Fare Rules   ${fare_rules_search_Results}    ${fare_rules_itinerary}
    RETURN    ${fare_rules_itinerary}

Click On Fare Rule Button On Booking Summary
    Wait Until Element Is Visible    ${button_fare_rule_summary}    20s
    Click Element    ${button_fare_rule_summary}

Get Booking Status And Id From Booking Summary Page
    Sleep    30s
    ${booking_status}    Get Text    ${booking_status_text}
    ${booking_id_text}    Get Text    ${booking_id}
    Log    ${booking_id_text}
    ${split_text}=   Split String   ${booking_id_text}    ${SPACE}
    ${id}=   Get From List   ${split_text}    2
    RETURN    ${booking_status}    ${id}

Verify Status And Get Notes ScreenShot
    [Arguments]    ${booking_status}
    IF    "${booking_status}" != "Success"
      Capture Screenshot From Notes    ${booking_status}
    END

Verify Booking Status For PNR and Ticket Number
    [Arguments]    ${booking_status}
    IF    "${booking_status}" != "Success"
      Verify User Is Able To Redirect On Cart Details Page
      Wait Until Page Contains Element    ${cart_details_notes_tab}
      Click Element    ${cart_details_notes_tab}
      Capture Page Screenshot
      Log    Failed due to booking status is "${booking_status}"
      Fail
    END

Capture Screenshot From Notes
  [Arguments]    ${booking_status}
  Verify User Is Able To Redirect On Cart Details Page
  Wait Until Page Contains Element    ${cart_details_notes_tab}
  Click Element    ${cart_details_notes_tab}
  Capture Page Screenshot
  Log    Failed due to booking status is "${booking_status}"

Verify User Is Able To Redirect On Cart Details Page
    Sleep    10s
    ${booking_status}    ${booking_id_text}    Get Booking Status And Id From Booking Summary Page
    ${booking_id_text}    Convert To String    ${booking_id_text}
    Wait Until Element Is Visible    ${booking_id}
    Scroll Element Into View    ${booking_id}
    Click Element    ${booking_id}
    Wait Until Page Contains    Cart-detail
    Wait Until Element Is Visible    ${booking_id_text_cart_details}
    ${nav_id}    Get Text    ${booking_id_text_cart_details}
    ${nav_id}    Convert To String    ${nav_id}
    ${trimmed_nav_id}=    Strip String    ${nav_id}
    Wait Until Element Is Visible    ${booking_id_text_on_cart}
    ${id}    Get Text    ${booking_id_text_on_cart}
    ${id}    Convert To String    ${id}
    ${trimmed_id}=    Strip String    ${nav_id}
    Wait Until Element Is Visible    ${cart_detail_status_text}
    ${status}    Get Text    ${cart_detail_status_text}
    Element Should Contain    ${cart_detail_status_text}    ${booking_status}
    Should Be Equal As Strings    ${booking_id_text}    ${trimmed_id}
    Should Be Equal As Strings    ${booking_id_text}    ${trimmed_nav_id}

Success TJ Popup Handle
    Sleep    10s
    ${status}    Run Keyword And Return Status    Wait Until Page Contains Element    ${continue_button_booking_summary_success_page}
    IF    ${status}
      Click Element    ${continue_button_booking_summary_success_page}
    END

Generate Baggage Details Format For Flight Itinerary | Review Page
    [Arguments]    ${checkin_list}    ${cabin_list}
    ${checkin_list_length}    Get Length    ${checkin_list}
    ${cabin_list_length}    Get Length    ${cabin_list}
    ${updated_format_list}    Create List
    ${adult_string}    Set Variable    ${EMPTY}
    IF    ${checkin_list_length} != 0
      FOR    ${cnt}    IN RANGE    0    ${checkin_list_length}
          ${checkin_ele}    Get From List    ${checkin_list}    ${cnt}
          ${cabin_ele}    Get From List    ${cabin_list}    ${cnt}
          ${adult_checkin}    Set Variable    ${EMPTY}
          ${adult_cabin}    Set Variable    ${EMPTY}
          ${checkin_ele_status}    Run Keyword And Return Status    Should Not Be Empty    ${checkin_ele}
          IF   ${checkin_ele_status}
              ${split_checkin_ele}    Split String    ${checkin_ele}    ,
              ${updated_checkin}    Get From List    ${split_checkin_ele}    0
              ${split_checkin_ele_adult}    Split String    ${updated_checkin}    :
              ${adult_checkin}    Get From List    ${split_checkin_ele_adult}    1
              ${adult_checkin}    Strip String    ${adult_checkin}
          END
          ${cabin_ele_status}    Run Keyword And Return Status    Should Not Be Empty    ${cabin_ele}
          IF   ${cabin_ele_status}
              ${split_cabin_ele}    Split String    ${cabin_ele}    ,
              ${updated_cabin}    Get From List    ${split_cabin_ele}    0
              ${split_cabin_ele_adult}    Split String    ${updated_cabin}    :
              ${adult_cabin}    Get From List    ${split_cabin_ele_adult}    1
              ${adult_cabin}    Strip String    ${adult_cabin}
          END
          IF    '${adult_checkin}' != '${EMPTY}' and '${adult_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    (Adult) Check-in : ${adult_checkin}, Cabin : ${adult_cabin}
          END
          IF    '${adult_checkin}' != '${EMPTY}' and '${adult_cabin}' == '${EMPTY}'
              ${adult_string}    Set Variable    (Adult) Check-in : ${adult_checkin}
          END
          IF    '${adult_checkin}' == '${EMPTY}' and '${adult_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Cabin : ${adult_cabin}
          END
          Append To List    ${updated_format_list}    ${adult_string}
      END
    END
    RETURN    ${updated_format_list}

All Elements Are Empty
    [Arguments]    @{elements}
    ${is_empty}=    Set Variable    True
    FOR    ${element}    IN    @{elements}
      Run Keyword If    '${element}' != ''    Set Variable    ${is_empty}    False
    END
    RETURN    ${is_empty}

Get And Verify Baggage Details From Flight Itinerary | Review Page
    [Arguments]    ${adult_data}
    Log    ${adult_data}
    Sleep    10s
    ${is_empty}=    Run Keyword And Return Status    All Elements Are Empty    ${adult_data}
    Log    ${is_empty}
    IF    "${is_empty}" == "False"
      ${flight_itinerary_review_page_list}    Create List
      ${adults_length}    Get Length    ${adult_data}
      ${element_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${down_arrow}
      Run Keyword If   '${element_visible}' == 'True'    Click Element   ${down_arrow}
      FOR    ${cnt}    IN RANGE    1    ${adults_length}+1
          ${baggage_detail}    Get Text    (//div[contains(@class, 'no-paddmobile')]/descendant::span[@class='graycolor'])[${cnt}]
          ${is_ending_with_comma}=    Run Keyword And Return Status    Should End With    ${baggage_detail}    ,
          IF    ${is_ending_with_comma}
              ${baggage_detail}=    Set Variable    ${baggage_detail}[:-1]
          END
          Append To List    ${flight_itinerary_review_page_list}    ${baggage_detail}
      END
      Log    ${adult_data}
      Log    ${flight_itinerary_review_page_list}
      Lists Should Be Equal    ${adult_data}    ${flight_itinerary_review_page_list}
    END

Generate Baggage Details Format For Summary Page
    [Arguments]    ${checkin_list}    ${cabin_list}
    ${checkin_list_length}    Get Length    ${checkin_list}
    ${cabin_list_length}    Get Length    ${cabin_list}
    ${updated_format_list}    Create List
    ${adult_string}    Set Variable    ${EMPTY}
    ${adult_checkin}    Set Variable    ${EMPTY}
    ${child_checkin}    Set Variable    ${EMPTY}
    ${infant_checkin}    Set Variable    ${EMPTY}
    ${adult_cabin}    Set Variable    ${EMPTY}
    ${child_cabin}    Set Variable    ${EMPTY}
    ${infant_cabin}    Set Variable    ${EMPTY}
    IF    ${checkin_list_length} != 0
      FOR    ${cnt}    IN RANGE    0    ${checkin_list_length}
          ${checkin_ele}    Get From List    ${checkin_list}    ${cnt}
          ${cabin_ele}    Get From List    ${cabin_list}    ${cnt}
          ${checkin_ele_status}    Run Keyword And Return Status    Should Not Be Empty    ${checkin_ele}
          ${cabin_ele_status}    Run Keyword And Return Status    Should Not Be Empty    ${cabin_ele}
          IF   ${checkin_ele_status}
              ${is_checkin_adult}   Run Keyword And Return Status    Should Contain    ${checkin_ele}    Adult
              ${is_checkin_child}   Run Keyword And Return Status    Should Contain    ${checkin_ele}    Child
              ${is_checkin_infant}   Run Keyword And Return Status    Should Contain    ${checkin_ele}    Infant
              ${split_checkin_ele}    Split String    ${checkin_ele}    ,
              IF    ${is_checkin_adult}
                  ${updated_checkin_adult}    Get From List    ${split_checkin_ele}    0
                  ${split_checkin_ele_adult}    Split String    ${updated_checkin_adult}    :
                  ${adult_checkin}    Get From List    ${split_checkin_ele_adult}    1
                  ${adult_checkin}    Strip String    ${adult_checkin}
              END
              IF    ${is_checkin_child}
                  ${updated_checkin_child}    Get From List    ${split_checkin_ele}    1
                  ${split_checkin_ele_child}    Split String    ${updated_checkin_child}    :
                  ${child_checkin}    Get From List    ${split_checkin_ele_child}    1
                  ${child_checkin}    Strip String    ${child_checkin}
                  Log    ${child_checkin}
              END
              IF    ${is_checkin_infant}
                  IF    ${is_checkin_child}
                      ${counter}    Set Variable    2
                  ELSE
                      ${counter}    Set Variable    1
                  END
                  ${updated_checkin_infant}    Get From List    ${split_checkin_ele}    ${counter}
                  ${split_checkin_ele_infant}    Split String    ${updated_checkin_infant}    :
                  ${infant_checkin}    Get From List    ${split_checkin_ele_infant}    1
                  ${infant_checkin}    Strip String    ${infant_checkin}
                  Log    ${infant_checkin}
              END
          END
          IF   ${cabin_ele_status}
              ${is_cabin_adult}   Run Keyword And Return Status    Should Contain    ${cabin_ele}    Adult
              ${is_cabin_child}   Run Keyword And Return Status    Should Contain    ${cabin_ele}    Child
              ${is_cabin_infant}   Run Keyword And Return Status    Should Contain    ${cabin_ele}    Infant
              ${split_cabin_ele}    Split String    ${cabin_ele}    ,
              IF    ${is_cabin_adult}
                  ${updated_cabin_adult}    Get From List    ${split_cabin_ele}    0
                  ${split_cabin_ele_adult}    Split String    ${updated_cabin_adult}    :
                  ${adult_cabin}    Get From List    ${split_cabin_ele_adult}    1
                  ${adult_cabin}    Strip String    ${adult_cabin}
              END
              IF    ${is_cabin_child}
                  ${updated_cabin_child}    Get From List    ${split_cabin_ele}    1
                  ${split_cabin_ele_child}    Split String    ${updated_cabin_child}    :
                  ${child_cabin}    Get From List    ${split_cabin_ele_child}    1
                  ${child_cabin}    Strip String    ${child_cabin}
              END
              IF    ${is_cabin_infant}
                  IF    ${is_cabin_child}
                      ${counter}    Set Variable    2
                  ELSE
                      ${counter}    Set Variable    1
                  END
                  ${updated_cabin_infant}    Get From List    ${split_cabin_ele}    ${counter}
                  ${split_cabin_ele_infant}    Split String    ${updated_cabin_infant}    :
                  ${infant_cabin}    Get From List    ${split_cabin_ele_infant}    1
                  ${infant_cabin}    Strip String    ${infant_cabin}
              END
          END
      END
    END
    IF    '${adult_checkin}' != '${EMPTY}' and '${adult_cabin}' != '${EMPTY}'
      IF    '${child_checkin}' != '${EMPTY}' and '${child_cabin}' != '${EMPTY}'
          IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Child - Check-in : ${child_checkin}, Cabin : ${child_cabin} Infant - Check-in : ${infant_checkin}, Cabin : ${infant_cabin}
          ELSE IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' == '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Child - Check-in : ${child_checkin}, Cabin : ${child_cabin} Infant - Check-in : ${infant_checkin}
          ELSE IF    '${infant_checkin}' == '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Child - Check-in : ${child_checkin}, Cabin : ${child_cabin} Infant - Cabin : ${infant_cabin}
          ELSE
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Child - Check-in : ${child_checkin}, Cabin : ${child_cabin}
          END
      ELSE IF    '${child_checkin}' != '${EMPTY}' and '${child_cabin}' == '${EMPTY}'
          IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Child - Check-in : ${child_checkin} Infant - Check-in : ${infant_checkin}, Cabin : ${infant_cabin}
          ELSE IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' == '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Child - Check-in : ${child_checkin} Infant - Check-in : ${infant_checkin}
          ELSE IF    '${infant_checkin}' == '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Child - Check-in : ${child_checkin} Infant - Cabin : ${infant_cabin}
          ELSE
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Child - Check-in : ${child_checkin}
          END
      ELSE IF    '${child_checkin}' == '${EMPTY}' and '${child_cabin}' != '${EMPTY}'
          IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Child - Cabin : ${child_cabin} Infant - Check-in : ${infant_checkin}, Cabin : ${infant_cabin}
          ELSE IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' == '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Child - Cabin : ${child_cabin} Infant - Check-in : ${infant_checkin}
          ELSE IF    '${infant_checkin}' == '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Child - Cabin : ${child_cabin} Infant - Cabin : ${infant_cabin}
          ELSE
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Child - Cabin : ${child_cabin}
          END
      ELSE
          IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Infant - Check-in : ${infant_checkin}, Cabin : ${infant_cabin}
          ELSE IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' == '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Infant - Check-in : ${infant_checkin}
          ELSE IF    '${infant_checkin}' == '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin} Infant - Cabin : ${infant_cabin}
          ELSE
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}, Cabin : ${adult_cabin}
          END
      END
    END
    IF    '${adult_checkin}' != '${EMPTY}' and '${adult_cabin}' == '${EMPTY}'
      IF    '${child_checkin}' != '${EMPTY}' and '${child_cabin}' != '${EMPTY}'
          IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Child - Check-in : ${child_checkin}, Cabin : ${child_cabin} Infant - Check-in : ${infant_checkin}, Cabin : ${infant_cabin}
          ELSE IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' == '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Child - Check-in : ${child_checkin}, Cabin : ${child_cabin} Infant - Check-in : ${infant_checkin}
          ELSE IF    '${infant_checkin}' == '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Child - Check-in : ${child_checkin}, Cabin : ${child_cabin} Infant - Cabin : ${infant_cabin}
          ELSE
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Child - Check-in : ${child_checkin}, Cabin : ${child_cabin}
          END
      ELSE IF    '${child_checkin}' != '${EMPTY}' and '${child_cabin}' == '${EMPTY}'
          IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Child - Check-in : ${child_checkin} Infant - Check-in : ${infant_checkin}, Cabin : ${infant_cabin}
          ELSE IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' == '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Child - Check-in : ${child_checkin} Infant - Check-in : ${infant_checkin}
          ELSE IF    '${infant_checkin}' == '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Child - Check-in : ${child_checkin} Infant - Cabin : ${infant_cabin}
          ELSE
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Child - Check-in : ${child_checkin}
          END
      ELSE IF    '${child_checkin}' == '${EMPTY}' and '${child_cabin}' != '${EMPTY}'
          IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Child - Cabin : ${child_cabin} Infant - Check-in : ${infant_checkin}, Cabin : ${infant_cabin}
          ELSE IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' == '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Child - Cabin : ${child_cabin} Infant - Check-in : ${infant_checkin}
          ELSE IF    '${infant_checkin}' == '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Child - Cabin : ${child_cabin} Infant - Cabin : ${infant_cabin}
          ELSE
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Child - Cabin : ${child_cabin}
          END
      ELSE
          IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Infant - Check-in : ${infant_checkin}, Cabin : ${infant_cabin}
          ELSE IF    '${infant_checkin}' != '${EMPTY}' and '${infant_cabin}' == '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Infant - Check-in : ${infant_checkin}
          ELSE IF    '${infant_checkin}' == '${EMPTY}' and '${infant_cabin}' != '${EMPTY}'
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin} Infant - Cabin : ${infant_cabin}
          ELSE
              ${adult_string}    Set Variable    Adult - Check-in : ${adult_checkin}
          END
      END
    END
    Append To List    ${updated_format_list}    ${adult_string}
    RETURN    ${updated_format_list}

Verify Baggage Details From Summary Page
    [Arguments]    ${data}
    Get Booking Status And Id From Booking Summary Page
    ${is_empty}=    Run Keyword And Return Status    All Elements Are Empty    ${data}
    Log    ${is_empty}
    IF    "${is_empty}" == "False"
      ${summary_page_list}    Create List
      ${baggage_details_count}    Get Length    ${data}
      ${element_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${down_arrow}
      Run Keyword If   '${element_visible}' == 'True'    Click Element   ${down_arrow}
      FOR    ${cnt}    IN RANGE    1    ${baggage_details_count}+1
          ${baggage_detail}    Get Text    (//div[contains(@class, 'confirmationPage-baggageInfo-positionHandle')])[${cnt}]
          ${updated_baggage_detail}    Replace String    ${baggage_detail}    Baggage Information    ${SPACE}
          ${updated_baggage_detail}    Strip String    ${updated_baggage_detail}
          ${is_ending_with_comma}=    Run Keyword And Return Status    Should End With    ${updated_baggage_detail}    ,
          IF    ${is_ending_with_comma}
              ${updated_baggage_detail}=    Set Variable    ${updated_baggage_detail}[:-1]
          END
          Append To List    ${summary_page_list}    ${updated_baggage_detail}
      END
      Lists Should Be Equal    ${data}    ${summary_page_list}
    END

Get Baggage Information From Search Results
    Click On View Details
    Wait Until Element Is Visible    ${baggage_allowance_tab}
    Click Element    ${baggage_allowance_tab}
    Sleep    30s
    Wait Until Element Is Visible    ${baggage_allowance_text}
    @{checkin_list}    Create List
    @{cabin_list}    Create List
    ${rows_count}    SeleniumLibrary.Get Element Count    ${baggage_info_row_search_page}
    FOR    ${cnt}    IN RANGE  1    ${rows_count}+1
      ${check_in_element}    Get Text    //div[contains(@class, 'baggageData-row-positionHandle')][${cnt}]/div[2]
      ${cab_in_element}    Get Text    //div[contains(@class, 'baggageData-row-positionHandle')][${cnt}]/div[3]
      Log    ${check_in_element}
      Log    ${cab_in_element}
      Append To List    ${checkin_list}    ${check_in_element}
      Append To List    ${cabin_list}    ${cab_in_element}
    END
    RETURN    ${checkin_list}    ${cabin_list}

Verify Invoice For Customer
    [Arguments]     ${expected_total_amount_paid}    ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Execute Javascript    window.scrollBy(0,-document.body.scrollHeight);
    ${booking_status}    ${booking_id_text}    Get Booking Status And Id From Booking Summary Page
    ${multiple_booking_status}    Create List    Success    On Hold
    ${status}    Run Keyword And Return Status    Should Contain    ${multiple_booking_status}    ${booking_status}
    IF    "${status}" != "True"
      Verify User Is Able To Redirect On Cart Details Page For Markup
    ELSE
      Wait Until Element Is Visible    ${more_option_button}    timeout=30s
      Click Element    ${more_option_button}
      Click Element    ${customer_invoice_option}
      Wait Until Element Is Visible    //input[@type="text"]/parent::div//following-sibling::label[text()="Name"]
      Click Element    ${cutomer_name_field}
      Input Text    ${cutomer_name_field}    ${my_dict.CustomerName}
      Input Text    ${cutomer_address_field}    ${my_dict.CustomerAddress}
      Click Element    ${cutomer_invoice_view_button}
      Wait Until Page Contains    Invoice No      timeout=50s
      Wait Until Page Contains    Invoice Date    timeout=50s
      Wait Until Element Is Visible    ${total_amount_on_cutomer_invoice}     timeout=40s
      ${total_amount_on_invoice}    Get Text    ${total_amount_on_cutomer_invoice}
      ${total_amount_on_invoice}    Extract Final Fare As String    ${total_amount_on_invoice}
      Should Be Equal As Numbers    ${expected_total_amount_paid}    ${total_amount_on_invoice}
    END

Verify Invoice for Agency
    [Arguments]     ${expected_total_amount_paid}    ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Execute Javascript    window.scrollBy(0,-document.body.scrollHeight);
    ${booking_status}    ${booking_id_text}    Get Booking Status And Id From Booking Summary Page
    ${multiple_booking_status}    Create List    Success    On Hold
    ${status}    Run Keyword And Return Status    Should Contain    ${multiple_booking_status}    ${booking_status}
    IF    "${status}" != "True"
      Verify User Is Able To Redirect On Cart Details Page For Markup
    ELSE
      Wait Until Element Is Visible    ${more_option_button}    timeout=30s
      Click Element    ${more_option_button}
      Click Element    ${agency_invoice_option}
      Wait Until Page Contains    Invoice No      timeout=50s
      Wait Until Page Contains    Invoice Date    timeout=50s
      ${total_amount_on_invoice}    Get Text    ${total_amount_on_agency_invoice}
      ${total_amount_on_invoice}    Extract Final Fare As String    ${total_amount_on_invoice}
      ${calculated_total_amount_for_agency}    Evaluate    ${expected_total_amount_paid} - ${my_dict.MarkupAmount}
      Should Be Equal As Numbers    ${calculated_total_amount_for_agency}    ${total_amount_on_invoice}
    END

Verify Baggage Details On Review Page
    [Arguments]    ${baggage_info_list}    ${search_data}    ${baggage_is_present}
    ${my_dict}    Create Dictionary    &{search_data}
    ${passenger_count}    Evaluate    ${my_dict.NoOfAdults}+${my_dict.NoOfChildren}
    ${baggage_info_on_review}    Create List
    Wait Until Element Is Visible    ${review_page_title}    timeout=30s
    IF    ${baggage_is_present}
      FOR    ${count}    IN RANGE    1    ${passenger_count}+1
          ${passenger_baggage_details}    Get Text    //li[@class="reviewPage-art-tabody-positionHandle"][${count}]//div[@class="art-tdsecond"]/following-sibling::div[@class="art-tdfour"]/descendant::span[@class="bag-meal-display"][1]
          ${splitted_passenger_baggage_details}=    Split String    ${passenger_baggage_details}      :
          ${splitted_passenger_baggage_details}     Get From List    ${splitted_passenger_baggage_details}    1
          ${splitted_passenger_baggage_details}    Strip String    ${splitted_passenger_baggage_details}
          Append To List    ${baggage_info_on_review}    ${splitted_passenger_baggage_details}
      END
      Log To Console    ${baggage_info_on_review}
      Lists Should Be Equal    ${baggage_info_on_review}    ${baggage_info_list}
      RETURN    ${baggage_info_on_review}
    END

Verify Meal Details On Review Page
    [Arguments]    ${meal_info_list}    ${search_data}    ${baggage_is_present}
    ${my_dict}    Create Dictionary    &{search_data}
    ${passenger_count}    Evaluate    ${my_dict.NoOfAdults}+${my_dict.NoOfChildren}
    ${meal_info_on_review}    Create List
    IF    ${baggage_is_present}
        IF    ${meal_info_list} != []
              FOR    ${count}    IN RANGE    1    ${passenger_count}+1
                  ${passenger_meal_details}    Get Text    //li[@class="reviewPage-art-tabody-positionHandle"][${count}]//div[@class="art-tdsecond"]/following-sibling::div[@class="art-tdfour"]/descendant::span[@class="bag-meal-display"][2]
                  ${splitted_passenger_meal_details}=    Split String    ${passenger_meal_details}      :
                  ${splitted_passenger_meal_details}     Get From List    ${splitted_passenger_meal_details}    1
                  ${splitted_passenger_meal_details}    Strip String    ${splitted_passenger_meal_details}
                  Append To List    ${meal_info_on_review}    ${splitted_passenger_meal_details}
              END
              Log To Console    ${meal_info_on_review}
        END
        Lists Should Be Equal    ${meal_info_on_review}    ${meal_info_list}
        RETURN    ${meal_info_on_review}
    ELSE IF    ${meal_info_list} != []
          FOR    ${count}    IN RANGE    1    ${passenger_count}+1
              ${passenger_meal_details}    Get Text    //li[@class="reviewPage-art-tabody-positionHandle"][${count}]//div[@class="art-tdsecond"]/following-sibling::div[@class="art-tdfour"]/descendant::span[@class="bag-meal-display"][1]
              ${splitted_passenger_meal_details}=    Split String    ${passenger_meal_details}      :
              ${splitted_passenger_meal_details}     Get From List    ${splitted_passenger_meal_details}    1
              ${splitted_passenger_meal_details}    Strip String    ${splitted_passenger_meal_details}
              Append To List    ${meal_info_on_review}    ${splitted_passenger_meal_details}
          END
          Log    ${meal_info_on_review}
          Lists Should Be Equal    ${meal_info_on_review}    ${meal_info_list}
          RETURN    ${meal_info_on_review}
    END

#Verify SSR Details On Booking Summary Page For Baggage And Meal For One Way
#    [Arguments]    ${baggage_info_on_review}    ${meal_info_on_review}    ${search_data}    ${seats_list}
##    Log    ${seats_list}
#    ${my_dict}    Create Dictionary    &{search_data}
#    ${passenger_count}    Evaluate    ${my_dict.NoOfAdults}+${my_dict.NoOfChildren}
#    FOR    ${count}    IN RANGE    1    ${passenger_count}+1
#        Log    ${count}
#        ${Baggage_detail_per_pax}    Get Text    //li[contains(@class,"paxDetails")][${count}]/child::div[@class="pax-tdfour"]
#        ${Meal_detail_per_pax}    Get Text    //li[contains(@class,"paxDetails")][${count}]//span[@class='graycolor'][2]
##        ${Seat_per_pax}    Get Text    //li[contains(@class,"paxDetails")][${count}]//span[@class='graycolor'][3]
#        FOR    ${element_baggage}    IN    @{baggage_info_on_review}
#            FOR    ${element_meal}    IN    @{meal_info_on_review}
##                FOR    ${element_seat}    IN    @{seats_list}
#                    Element Should Contain    //li[contains(@class,"paxDetails")][${count}]/child::div[@class="pax-tdfour"]    ${element_baggage}
#                    Element Should Contain    //li[contains(@class,"paxDetails")][${count}]//span[@class='graycolor'][2]    ${element_meal}
##                    Element Should Contain    //li[contains(@class,"paxDetails")][${count}]//span[@class='graycolor'][3]    ${element_seat}
##                END
#            END
#        END
#    END

Verify SSR Details On Booking Summary Page For Baggage And Meal For One Way | Round Trip
    [Arguments]    ${baggage_info_on_review}    ${meal_info_on_review}    ${search_data}    ${baggage_is_present}    ${meal_info_list}
    ${my_dict}    Create Dictionary    &{search_data}
    ${passenger_count}    Evaluate    ${my_dict.NoOfAdults}+${my_dict.NoOfChildren}
    IF    ${baggage_is_present}
      Execute Javascript    window.scrollBy(0,600);
      FOR    ${count}    IN RANGE    1    ${passenger_count}+1
          ${Baggage_detail_per_pax}    Get Text    //li[contains(@class,"paxDetails")][${count}]/child::div[@class="pax-tdfour"]
          ${Meal_detail_per_pax}    Get Text    //li[contains(@class,"paxDetails")][${count}]//span[@class='graycolor'][2]
          Log    ${Baggage_detail_per_pax}
          Log    ${Meal_detail_per_pax}
          FOR    ${element_baggage}    IN    @{baggage_info_on_review}
              FOR    ${element_meal}    IN    @{meal_info_on_review}
                  Element Should Contain    //li[contains(@class,"paxDetails")][${count}]/child::div[@class="pax-tdfour"]    ${element_baggage}
                  Element Should Contain    //li[contains(@class,"paxDetails")][${count}]//span[@class='graycolor'][2]    ${element_meal}
              END
          END
      END
    ELSE IF    ${meal_info_list} != []
      Execute Javascript    window.scrollBy(0,600);
      FOR    ${count}    IN RANGE    1    ${passenger_count}+1
          ${Meal_detail_per_pax}    Get Text    //li[contains(@class,"paxDetails")][${count}]//span[@class='graycolor'][1]
          Log    ${Meal_detail_per_pax}
          FOR    ${element_meal}    IN    @{meal_info_on_review}
              Element Should Contain    //li[contains(@class,"paxDetails")][${count}]//span[@class='graycolor'][1]    ${element_meal}
          END
      END
    END


Verify SSR Details On Booking Summary Page For Seats For One Way | Round Trip
    [Arguments]    ${search_data}    ${seats_list}    ${seat_availability_status}
    IF    "${seat_availability_status}"=="True"
      Log    ${seats_list}
      Success TJ Popup Handle
      Success Booking With TripJack Popup Handle
      ${my_dict}    Create Dictionary    &{search_data}
      ${passenger_count}    Evaluate    ${my_dict.NoOfAdults}+${my_dict.NoOfChildren}
      ${increment}    Set Variable    1
      FOR    ${count}    IN RANGE    0    ${passenger_count}
          FOR    ${element_seat}    IN    ${seats_list}[${count}]
              ${Seat_per_pax}    Get Text    //li[contains(@class,"paxDetails")][${increment}]//div[@class="pax-tdfour"]
              Log    ${Seat_per_pax}
              ${split_string}    Split String    ${element_seat}    ,
              ${element_count}    Get Length    ${split_string}
              FOR    ${counter}    IN RANGE    0    ${element_count}
                  @{seats}    Create List
                  ${split_string}    Split String    ${element_seat}    ,
                  ${split_string}    Get From List    ${split_string}    ${counter}
                  ${split_string}    Split String    ${split_string}    :
                  ${journey}    Get From List    ${split_string}    0
                  Log    ${journey}
                  ${seat_number}    Get From List    ${split_string}    1
                  ${seat_number}    Strip String    ${seat_number}
                  Log    ${seat_number}
                  Append To List    ${seats}    ${journey} ${seat_number}
                  Log    ${seats}
                  FOR    ${value}    IN    @{seats}
                      ${split_value}    Split String    ${value}    ${space}
                      FOR    ${value}    IN    @{split_value}
                          Should Contain    ${Seat_per_pax}    ${value}
                      END
                  END
              END
          END
          ${increment}=    Evaluate    ${increment} + 1
          Exit For Loop If    '${passenger_count}' == '${count}'
      END
    END

Add Seats For All Available Flights For One Way | Round Trip
    Sleep    5s
    ${seat_availability_status}    Run Keyword And Return Status    Page Should Contain Element    ${show_seat_map_button}
    Sleep    5s
    IF    "${seat_availability_status}"=="True"
      Scroll Element Into View    ${show_seat_map_button}
      Click Element   ${baggage_seat_locator_pax}
      Scroll Element Into View    ${show_seat_map_button}
      ${flight_length}    SeleniumLibrary.Get Element Count    ${flight_count}
      @{total_seat_price_list}    Create List
      @{total_seats_selected}    Create List
      @{journey_for_selected_seat}    Create List
      @{list1}    Create List
      FOR    ${count}    IN RANGE    1    ${flight_length}+1
          Execute Javascript   window.scrollBy(0, 500);
          Wait Until Page Contains Element    ${show_seat_map_button}    timeout=15
          ${journey_on_pax}    Get Text    (//b[@class="seatMapSection-cityInfo-positionHandle"])[${count}]
          Click Element    (${show_seat_map_button})[${count}]
          ${no_seats_available}    Run Keyword And Return Status    Page Should Contain    No seats available for the requested flight
          ${same_seat_selected_is_applicable}    Run Keyword And Return Status    Page Should Contain    Seat Selected on ${journey} will be applicable
          IF    ${no_seats_available}
              Log    No seats available for ${journey_on_pax} flight
              Wait Until Page Does Not Contain    No seats available for the requested flight    timeout=50s
              Exit For Loop
          ELSE IF    ${same_seat_selected_is_applicable}
              Log    Seat Selected on ${journey} will be applicable to ${journey_on_pax} leg also as its stop over airport
              Wait Until Page Does Not Contain    Seat Selected on ${journey} will be applicable    timeout=50s
              Exit For Loop
          ELSE
              ${available_seats}=  Get Available Seats
              ${seat_price1}   ${seat_price2}   ${seat_price3}   Select Seat For Three Passangers and Verify Selection   ${available_seats}
              ${total_seat_price}    Verify Total Fee of Selected Seats on Seat Map Window For Three Passanger   ${seat_price1}   ${seat_price2}   ${seat_price3}
              ${journey}    Get Text    ${journey_on_seat_map}
              ${journey}=    Replace String    ${journey}    \n    -
              Append To List    ${journey_for_selected_seat}    ${journey}
              Click Element   ${proceed_button}
              ${ui_seat_1}    ${ui_seat_2}    ${ui_seat_3}    Verify Selected Seat On Pax Detail Page For Three Passanger For One Way | Round Trip    ${available_seats}    ${available_seats}[0]    ${available_seats}[1]    ${available_seats}[2]    ${count}
              ${seat_numbers}    Create List    ${ui_seat_1}    ${ui_seat_2}    ${ui_seat_3}
              @{list2}    Create List
              FOR    ${element}    IN    @{seat_numbers}
                  Append To List    ${list2}    ${journey}: ${element}
              END
              Append To List    ${list1}    ${list2}
              Log List    ${list1}
              Append To List    ${total_seat_price_list}    ${total_seat_price}
              Append To List    ${total_seats_selected}    ${seat_numbers}
              Log To Console    ${total_seat_price}
          END
      END
      Log To Console    ${total_seat_price_list}
      Log To Console    ${total_seats_selected}
      Log To Console    ${journey_for_selected_seat}
      ${total_seat_price}    Evaluate    sum(${total_seat_price_list})
      Log  ${list1}
      ${transposed_data}=    Transpose List    ${list1}
      Log    ${transposed_data}
      ${formatted_list}    Format Output For Transposed String    ${transposed_data}
      Log    ${formatted_list}
      RETURN    ${total_seat_price}    ${total_seats_selected}    ${formatted_list}    ${seat_availability_status}
    END
    RETURN    ${False}    ${False}    ${False}    ${seat_availability_status}

Verify Total Seat Fee on Pax Details Page
    [Arguments]   ${seat_price1}   ${seat_price2}   ${seat_price3}   ${total_fare_before}
    ${seat_price1}=   Extract Final Fare As String   ${seat_price1}
    ${seat_price2}=   Extract Final Fare As String   ${seat_price2}
    ${seat_price3}=   Extract Final Fare As String   ${seat_price3}
    ${total_seat_fee}=   Evaluate   ${seat_price1}+${seat_price2}+${seat_price3}
    ${total_seat_fee}=   Convert To String   ${total_seat_fee}
    ${selected_seat_price}    Verify added Seat Fee On Pax Details Page   ${total_seat_fee}   ${total_fare_before}
    RETURN    ${selected_seat_price}

Verify added Seat Fee On Pax Details Page
    [Arguments]   ${total_seat_fee}   ${total_fare_before}    ${seat_availability_status}
    IF    "${seat_availability_status}"== "True"
      Wait Until Element Is Visible   ${baggage_seat_locator_pax}   timeout=10
      Click Element   ${baggage_seat_locator_pax}
      Wait Until Element Is Visible   ${seat_fare_pax}
      ${total_seat_price_on_pax_details}=   Get Text   ${seat_fare_pax}
      ${total_seat_price_on_pax_details}=   Extract Final Fare As String   ${total_seat_price_on_pax_details}
    #    ${selected_seat_price}=   Extract Final Fare As String   ${total_seat_fee}
      Log To Console       ${total_seat_fee}
      Should Be Equal As Numbers   ${total_seat_fee}   ${total_seat_price_on_pax_details}
      RETURN    ${total_seat_fee}
    END

Validate The Totol Baggage,Meal,Seat Price With Fare Summary Price
    [Arguments]    ${total_baggage}    ${total_meal}    ${selected_seat_price}    ${seat_availability_status}    ${baggage_is_present}
    IF    "${seat_availability_status}"=="True"
      IF    ${baggage_is_present}
          Wait Until Element Is Visible    ${baggage_fare_price}    timeout=10
          ${fare_baggege}    Get Text    ${baggage_fare_price}
          ${fare_baggege}    Extract Final Fare As String    ${fare_baggege}
          Should Be Equal As Numbers    ${fare_baggege}    ${total_baggage}
          Sleep    10s
          IF    ${total_meal}!=0
              ${fare_meal}    Get Text    ${meal_fare_price}
              ${fare_meal}    Extract Final Fare As String    ${fare_meal}
              Should Be Equal As Numbers    ${fare_meal}    ${total_meal}
              ${calculated_total_baggage_meal_seat_fare}    Evaluate    ${fare_baggege}+${fare_meal}+${selected_seat_price}
          END
          ${calculated_total_baggage_meal_seat_fare}    Evaluate    ${fare_baggege}+${selected_seat_price}
          Log To Console    ${calculated_total_baggage_meal_seat_fare}
          ${total_baggage_meal_seat_fare}    Get Text    //span[text()='Meal, Baggage & Seat']/parent::div//i/following-sibling::span[@class='pull-right fareSummary-prices-positionHandle']
          ${total_baggage_meal_seat_fare}    Extract Final Fare As String    ${total_baggage_meal_seat_fare}
          Should Be Equal As Numbers    ${total_baggage_meal_seat_fare}    ${calculated_total_baggage_meal_seat_fare}
          RETURN    ${calculated_total_baggage_meal_seat_fare}
      ELSE
          ${fare_meal}    Get Text    ${meal_fare_price}
          ${fare_meal}    Extract Final Fare As String    ${fare_meal}
          Should Be Equal As Numbers    ${fare_meal}    ${total_meal}
          ${calculated_total_baggage_meal_seat_fare}    Evaluate    ${fare_meal}+${selected_seat_price}
          Log To Console    ${calculated_total_baggage_meal_seat_fare}
          ${total_baggage_meal_seat_fare}    Get Text    //span[text()='Meal, Baggage & Seat']/parent::div//i/following-sibling::span[@class='pull-right fareSummary-prices-positionHandle']
          ${total_baggage_meal_seat_fare}    Extract Final Fare As String    ${total_baggage_meal_seat_fare}
          Should Be Equal As Numbers    ${total_baggage_meal_seat_fare}    ${calculated_total_baggage_meal_seat_fare}
          RETURN    ${calculated_total_baggage_meal_seat_fare}
      END
    END

Validate Total Fare After Adding Seat
    [Arguments]    ${calculated_total_baggage_meal_seat_fare}    ${total_fare_before}    ${seat_availability_status}
    IF    "${seat_availability_status}"=="True"
      ${updated_total_fare_on_ui}=   Get Text   ${total_fare_locator_pax_details}
      ${updated_total_fare_on_ui}=   Extract Final Fare As String   ${updated_total_fare_on_ui}
      ${expected_total_fare}    Evaluate    ${calculated_total_baggage_meal_seat_fare}+${total_fare_before}
      Should Be Equal As Numbers    ${expected_total_fare}    ${updated_total_fare_on_ui}
    END

Verify Added Seats On Review Page
    [Arguments]    ${ui_seat_1}    ${ui_seat_2}    ${ui_seat_3}
    ${seats}    Create List    ${ui_seat_1}    ${ui_seat_2}    ${ui_seat_3}
    Log To Console    ${seats}
    ${seats_list}    Create List
    ${seat_length}    SeleniumLibrary.Get Element Count    ${total_seat_count}
    FOR    ${count}    IN RANGE    1    ${seat_length}+1
      ${selected_seat_number}    Get Text    //li[@class="graycolor"]/parent::ul/following-sibling::div/descendant::span[@class="art-spnlist"][${count}]
      ${split_seat}    Split String    ${selected_seat_number}    :
      ${split_seat}    Get From List    ${split_seat}    1
      ${seat_number}    Strip String    ${split_seat}
      Append To List    ${seats_list}    ${seat_number}
    END
    Log To Console    ${seats_list}
    Lists Should Be Equal    ${seats_list}    ${seats}
    RETURN    ${seats_list}

Verify Added Seats On Review Page For Round Trip
    [Arguments]    ${transposed_data}    ${seat_availability_status}
    IF    "${seat_availability_status}"=="True"
      @{seats_list}    Create List
      ${seat_length}    SeleniumLibrary.Get Element Count    ${total_seat_count}
      FOR    ${count}    IN RANGE    1    ${seat_length}+1
          ${selected_seat_number}    Get Text    //li[@class="graycolor"]/parent::ul/following-sibling::div/descendant::span[@class="art-spnlist"][${count}]
          Log    ${selected_seat_number}
          ${selected_seat_number}    Convert To String    ${selected_seat_number}
          Log    ${selected_seat_number}
          Append To List    ${seats_list}    ${selected_seat_number}
      END
      Lists Should Be Equal    ${seats_list}    ${transposed_data}
      RETURN    ${seats_list}
    END

Select One Stop Filter For Round Trip Search
    Select One Stop Filter
    Wait Until Element Is Visible    ${round_trip_return_stop}
    Click Element    ${round_trip_return_stop}
    Select One Stop Filter

Verify Fare Summary On Booking Summary Page
    [Arguments]    ${Fare_summary}
    Execute Javascript   window.scroll(0,600)
    IF    ${Fare_summary.is_fare_jump}
      ${total}=    Get Text    ${total_amount}
      ${total}=    Evaluate    ${total}
       Should Be Equal As Numbers      ${total}      ${Fare_summary.total_fare_price}
    ELSE
      Wait Until Page Contains Element    ${base_fare}    30s
      ${base}=    Get Text  ${base_fare}
      ${taxes}=    Get Text    ${taxes_and_fees}
      ${total}=    Get Text    ${total_amount}
      ${base}=    Evaluate    ${base}
      ${taxes}=    Evaluate   ${taxes}
      ${total}=    Evaluate    ${total}
      Should Be Equal As Numbers      ${base}        ${Fare_summary.base_fare}
      Should Be Equal As Numbers      ${taxes}       ${Fare_summary.taxes}
      Should Be Equal As Numbers      ${total}      ${Fare_summary.total_fare_price}
    END

Click On Book Button For Booking Summary
    Wait Until Element Is Visible    ${book_button}    20s
    Execute Javascript  window.scroll(0,-100)
    Click Element    ${book_button}

Click on zero stops
    Wait Until Element Is Visible    ${zero_stop_filter}    30s
    Click Element    ${zero_stop_filter}

Verify Fare Details On Pax Details Page
    [Arguments]    ${fare_summary_flight_itinerary}    ${fare_summary_pax_details}
    Lists Should Be Equal    ${fare_summary_flight_itinerary}    ${fare_summary_pax_details}

Verify Fare Details On Review Page
    [Arguments]    ${fare_summary_review_page}    ${fare_summary_pax_details}
    Lists Should Be Equal    ${fare_summary_review_page}    ${fare_summary_pax_details}

Verify Fare Details On Booking Summary Page
    [Arguments]    ${fare_summary_payment_page}     ${fare_summary_booking_summary_page}
    Lists Should Be Equal    ${fare_summary_payment_page}     ${fare_summary_booking_summary_page}

Click On Seat Map Button
    Click Element   ${baggage_seat_locator_pax}
    Scroll Element Into View    ${show_seat_map_button}
    Click on Show Seat Map Button

Click On Proceed Button On Seat Map Window Button
    Click Element   ${proceed_button}

Verify Markup Added On Search Page
    [Arguments]    ${fare_amount_after_adding_markup_extracted}    ${fare_summary_flight_itinerary.total_amount_to_pay}
    Should Be Equal As Numbers    ${fare_amount_after_adding_markup_extracted}    ${fare_summary_flight_itinerary.total_amount_to_pay}

Click View Details For Right Panel
    ${fare_type}    Run Keyword And Return Status    Element Should Contain    //div[@class="asr-tbcell"]/child::div[1]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][1]    Instant Offer Return Fare
    IF    ${fare_type}
      ${count_fare_type}    SeleniumLibrary.Get Element Count    //div[@class="asr-tbcell"]/child::div[1]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")]
      FOR    ${count}    IN RANGE    1    ${count_fare_type}+1
          ${fare_type_text}    Get Text    //div[@class="asr-tbcell"]/child::div[1]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]
          IF    "${fare_type_text}"!= "Instant Offer Return Fare"
              Wait Until Element Is Visible    //div[@class="asr-tbcell"]/child::div[1]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]/preceding-sibling::label
              Click Element    //div[@class="asr-tbcell"]/child::div[1]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]/preceding-sibling::label
              ${view_element}    Set Variable    //div[@class="asr-tbcell"]/child::div[1]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]/preceding-sibling::label/ancestor::div[contains(@class,"flightrightview ")]/preceding-sibling::div/descendant::button[contains(@class,"viewbtn")]
              Exit For Loop If    "${fare_type_text}"!= "Instant Offer Return Fare"
          END
      END
    ELSE
      ${view_element}    Set Variable    ${view_details_button}
    END
    RETURN    ${view_element}

Click View Details For Left Panel
    ${fare_type}    Run Keyword And Return Status    Element Should Contain    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][1]    Instant Offer Return Fare
    IF    ${fare_type}
      ${count_fare_type}    SeleniumLibrary.Get Element Count    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")]
      FOR    ${count}    IN RANGE    1    ${count_fare_type}+1
          ${fare_type_text}    Get Text    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]
          IF    "${fare_type_text}"!= "Instant Offer Return Fare"
              Wait Until Element Is Visible    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]/preceding-sibling::label
              Sleep    10s
              Click Element    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]/preceding-sibling::label
              Sleep    5s
              ${view_element}    Set Variable    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]/preceding-sibling::label/ancestor::div[contains(@class,"flightrightview ")]/preceding-sibling::div/descendant::button[contains(@class,"viewbtn")]
    #                Click Element    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]/preceding-sibling::label/ancestor::div[contains(@class,"flightrightview ")]/preceding-sibling::div/descendant::button[contains(@class,"viewbtn")]
              Exit For Loop If    "${fare_type_text}"!= "Instant Offer Return Fare"
          END
      END
    ELSE
      ${view_element}    Set Variable    ${view_details_button_right_section}
    END
    RETURN    ${view_element}

Verify Fare Details At Bottom Of Screen For Round Trip
    [Arguments]    ${Fare_summary}    ${fare_summary_2}
    Log    ${Fare_summary}
    Log    ${fare_summary_2}
    Log     ${Fare_summary.total_fare_price}
    Log    ${fare_summary_2.total_fare_price}
    ${expected_fare_summary}    Create List
    ${actual_fare_summary}    Create List
    Append To List    ${expected_fare_summary}    ${Fare_summary.total_fare_price}
    Append To List    ${expected_fare_summary}    ${fare_summary_2.total_fare_price}
    Log    ${expected_fare_summary}
    ${expected_sum}=    Set Variable    0
    FOR    ${element}    IN    @{expected_fare_summary}
      ${expected_sum}=    Evaluate    ${expected_sum} + ${element}
    END
    ${fare_count}    SeleniumLibrary.Get Element Count    //h5[@class="whitecolor"]
    FOR    ${cnt}    IN RANGE    1    ${fare_count}+1
      ${fare_amount}    Get Text      (//h5[@class="whitecolor"])[${cnt}]
      ${fare_amount}    Extract Final Fare As String    ${fare_amount}
      Append To List    ${actual_fare_summary}    ${fare_amount}
    END
    Log    ${actual_fare_summary}
    ${actual_sum}    Get Text    //h4[@class='whitecolor asr-tlhead']
    ${actual_sum}    Extract Final Fare As String    ${actual_sum}
    Should Be Equal As Numbers   ${expected_sum}    ${actual_sum}
    Lists Should Be Equal   ${expected_fare_summary}    ${actual_fare_summary}

Verify Selected Seat On Pax Detail Page For Three Passanger For One Way | Round Trip
    [Arguments]   ${available_seats}   ${seat1}   ${seat2}   ${seat3}    ${count}
    Wait Until Element Is Visible   (//div[@class="col-sm-4 seatmap-box--seat"]/p[@class="p-20"])[${count}]
    ${selected_seat_on_ui}=   Get Text   (//div[@class="col-sm-4 seatmap-box--seat"]/p[@class="p-20"])[${count}]
    ${split_text}=   Split String   ${selected_seat_on_ui}    ,
    ${ui_seat_1}=   Get From List   ${split_text}    0
    ${ui_seat_1}=   Split String   ${ui_seat_1}    :
    ${ui_seat_1}=  Strip String   ${ui_seat_1}[1]
    ${ui_seat_2}=   Get From List   ${split_text}    1
    ${ui_seat_2}=   Split String   ${ui_seat_2}    :
    ${ui_seat_2}=   Strip String   ${ui_seat_2}[1]
    ${ui_seat_3}=   Get From List   ${split_text}    2
    ${ui_seat_3}=   Split String   ${ui_seat_3}    :
    ${ui_seat_3}=   Strip String   ${ui_seat_3}[1]
    Should Be Equal   ${ui_seat_1}   ${seat1}
    Should Be Equal   ${ui_seat_2}   ${seat2}
    Should Be Equal   ${ui_seat_3}   ${seat3}
    RETURN    ${ui_seat_1}    ${ui_seat_2}    ${ui_seat_3}

Close Fare View Button
    [Arguments]    ${view_element}
    Execute Javascript  window.scroll(0,-50)
    Click Element    ${view_element}

Verify Fare Rule Details For Round Trip On FLight Itinerary | Booking Summary Page
    [Arguments]    ${search_page_fare_details_right}    ${search_page_fare_details_left}
    Click On Fare Rules Button On Flight Itinerary
    Sleep    5s
    ${itenerary_tabs}    SeleniumLibrary.Get Element Count    //span[@class='fareRules__segmentInfo']
    IF    ${itenerary_tabs} != 0
      FOR    ${cnt}    IN RANGE    1    ${itenerary_tabs}+1
          ${element}    Get Text    (//span[@class='fareRules__segmentInfo'])[${cnt}]
          Wait Until Element Is Visible    (//span[@class='fareRules__segmentInfo'])[${cnt}]
          IF    "${element}" == "${search_page_fare_details_right.FareRuleSegmentInfo}"
              Log    ${element}
              ${itinerary_fare_details_right}    Get Fare Rule Details On Flight Itinerary    ${cnt}
          END
          IF    "${element}" == "${search_page_fare_details_left.FareRuleSegmentInfo}"
              Log    ${element}
              Sleep    5s
              Click Element    (//span[@class='fareRules__segmentInfo'])[${cnt}]
              ${text}    Get Text    (//span[@class='fareRules__segmentInfo'])[${cnt}]
              Log    ${text}
              ${itinerary_fare_details_left}    Get Fare Rule Details On Flight Itinerary    ${cnt}
          END
      END
      Verify Fare Rules      ${search_page_fare_details_right}    ${itinerary_fare_details_right}
      Verify Fare Rules      ${search_page_fare_details_left}    ${itinerary_fare_details_left}
      RETURN    ${itinerary_fare_details_right}    ${itinerary_fare_details_left}
    ELSE
      ${itinerary_fare_details_right}    Get Fare Rule Details
      Log  ${itinerary_fare_details_right}
      Verify Fare Rules      ${search_page_fare_details_right}    ${itinerary_fare_details_right}
      ${ele_text}     Get Text    ${no_rules}
      ${itinerary_fare_details_left}   Create Dictionary   NoRules=${ele_text}
      Log    ${itinerary_fare_details_left}
      RETURN    ${itinerary_fare_details_right}    ${itinerary_fare_details_left}
    END

Click On Fare Rules Button On Flight Itinerary
    Execute Javascript  window.scrollTo(0,document.body.scrollHeight);
    Scroll Element Into View    ${fare_detail_btn_itinerary}
    Wait Until Element Is Visible    ${fare_detail_btn_itinerary}    20s
    Click Element    ${fare_detail_btn_itinerary}

Get Fare Rule Details On Flight Itinerary
    [Arguments]    ${cnt}
    ${is_no_rule}=  Run Keyword And Return Status    Wait Until Element Is Visible    ${no_rules}
    IF  ${is_no_rule}!=True
      Wait Until Element Is Visible    ${fare_rule_segment_info_element}  20s
      ${fare_rules_segment_info}  Get Text   (//span[@class='fareRules__segmentInfo'])[${cnt}]
      Scroll Element Into View    (//div[@class="star-text"])[1]
      Click Element    ${fare_rule_cancellation_fee_element}
      ${cancellation_fee}     Get Text     ${fare_rule_cancellation_fee}
      Click Element    ${fare_rule_date_change_element}
      ${date_change_fee}   Get Text     ${fare_rule_date_change_fee}
      Click Element    ${fare_detail_no_show_fee_element}
      ${no_show_fee}    Get Text    ${fare_detail_no_show_fee}
      Click Element     ${fare_detail_seat_chargeable_element}
      ${seat_chargeable_fee}    Get Text    ${fare_detail_chargeable_fee}
      ${fare_rules}   Create Dictionary   FareRuleSegmentInfo=${fare_rules_segment_info}  CancellationFee=${cancellation_fee}  DateChangeFee=${date_change_fee}   NoShowFee=${no_show_fee}   SeatChargeableFee=${seat_chargeable_fee}
      RETURN  ${fare_rules}
    ELSE
      ${ele_text}     Get Text    ${no_rules}
      ${fare_rules}   Create Dictionary   NoRules=${ele_text}
      RETURN  ${fare_rules}
    END

Verify Fare Rule Details On FLight Itinerary For Round Trip
    [Arguments]    ${search_page_fare_details_right}    ${search_page_fare_details_left}
    Click On Fare Rules Button On Flight Itinerary
    Sleep    5s
    ${itenerary_tabs}    SeleniumLibrary.Get Element Count    //span[@class='fareRules__segmentInfo']
    IF    ${itenerary_tabs} != 0
      FOR    ${cnt}    IN RANGE    1    ${itenerary_tabs}+1
          ${element}    Get Text    (//span[@class='fareRules__segmentInfo'])[${cnt}]
          Wait Until Element Is Visible    (//span[@class='fareRules__segmentInfo'])[${cnt}]
          IF    "${element}" == "${search_page_fare_details_right.FareRuleSegmentInfo}"
              Log    ${element}
              ${itinerary_fare_details_right}    Get Fare Rule Details On Flight Itinerary    ${cnt}
          END
          IF    "${element}" == "${search_page_fare_details_left.FareRuleSegmentInfo}"
              Log    ${element}
              Sleep    5s
              Click Element    (//span[@class='fareRules__segmentInfo'])[${cnt}]
              ${text}    Get Text    (//span[@class='fareRules__segmentInfo'])[${cnt}]
              Log    ${text}
              ${itinerary_fare_details_left}    Get Fare Rule Details On Flight Itinerary    ${cnt}
          END
      END
      Log    ${itinerary_fare_details_right}
      Log    ${itinerary_fare_details_left}
      Log    ${search_page_fare_details_right}
      Log    ${search_page_fare_details_left}
      Verify Fare Rules      ${search_page_fare_details_right}    ${itinerary_fare_details_right}
      Verify Fare Rules      ${search_page_fare_details_left}    ${itinerary_fare_details_left}
      RETURN    ${itinerary_fare_details_right}    ${itinerary_fare_details_left}
    ELSE
      ${itinerary_fare_details_right}    Get Fare Rule Details
      Log  ${itinerary_fare_details_right}
      Verify Fare Rules      ${search_page_fare_details_right}    ${itinerary_fare_details_right}
      ${ele_text}     Get Text    ${no_rules}
      ${itinerary_fare_details_left}   Create Dictionary   NoRules=${ele_text}
      Log    ${itinerary_fare_details_left}
      RETURN    ${itinerary_fare_details_right}    ${itinerary_fare_details_left}
    END

Close Fare View Button Left Section
    Execute Javascript  window.scroll(0,-50)
    Click Element    ${view_details_button_right_section}

Combine Two Lists
    [Arguments]    ${list1}    ${list2}
    ${combined_list}    Create List
    Append To List    ${combined_list}    @{list1}
    Append To List    ${combined_list}    @{list2}
    RETURN    ${combined_list}

Click On View Details On Left Section For Round Trip
    Click Element    ${search_results_scroll_button}
    Wait Until Element Is Visible   ${view_details_button_right_section}
    Click Element    ${view_details_button_right_section}
    Wait Until Element Is Visible       ${flight_details_tab}

Handle Sold Out Popup | Round Trip
    [Arguments]  ${button_number}    ${booking_data}
    Click Element    ${sold_out_back_to_search_btn}
    Enter Supplier ID Into Current URL    ${booking_data}
    Wait Until Element Is Visible    ${cheapest_flight_filter}    timeout=180
    Check Flights Are Available On Search Page
    ${btn}    Click View Details For Right Panel
    ${Fare_summary}    Verify Fare Details And Get Fare Summary    ${btn}
    ${btn1}    Click View Details For Left Panel
    ${fare_summary_2}    Verify Fare Details And Get Fare Summary    ${btn1}
    Verify Fare Details At Bottom Of Screen For Round Trip    ${Fare_summary}    ${fare_summary_2}
    ${fare_summary}     Add Fare Dictionary      ${fare_summary}   ${fare_summary_2}
    ${flight_details_from_search_page}    ${layover_details}    Get Flight Details And Layover Details For Round Trip        ${flight_Name_locator}  ${flight_departure_detail}   ${flight_destination_detail}    ${flight_duration_flight_type_search_result}
    Execute Javascript    window.scroll(0,-50)
    Click On Book Button
    Handle Consent Message Popup
    ${flag}    Set Variable    True
    Handle All Popups And Update Data | Round Trip For Booking Summary    ${flight_details_from_search_page}  ${Fare_summary}    ${booking_data}    ${flag}    ${layover_details}
    Wait Until Element Is Visible    ${amount_to_pay}    timeout=30s
    RETURN  ${flight_details_from_search_page}  ${fare_summary}    ${layover_details}

Handle All Popups And Update Data | Round Trip For Booking Summary
    [Arguments]  ${flight_details}  ${Fare_summary}    ${booking_data}    ${flag}    ${layover_details}
    Handle Consent Message Popup
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${amount_to_pay}    timeout=30
    ${is_fare_jump}    Run Keyword And Return Status    Element Should Be Visible    ${fare_jump_popup_new}
    Capture Page Screenshot
    ${is_fare_type_change}    Run Keyword And Return Status    Element Should Be Visible    ${fare_type_change_popup}
    ${is_hand_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_hand_baggage_popup}
    ${is_sold_out}    Run Keyword And Return Status    Element Should Be Visible    ${sold_out_popup}
    ${is_fare_changed_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_fare_have_changed_baggage}
    IF    ${is_fare_type_change}
      ${flight_details}  Handle Fare Type Change Popup    ${flight_details}
    ELSE IF   ${is_fare_jump}
      ${Fare_summary}  Handle Fare Jump Popup  ${Fare_summary}
    ELSE IF    ${is_hand_baggage}
      Click Element    ${hand_baggage_continue_button}
    ELSE IF   ${is_sold_out}
      IF    ${flag}
          Skip
      ELSE
          ${flight_details_from_search_page}    ${fare_summary}    ${layover_details}    Handle Sold Out Popup | Round Trip  1    ${booking_data}
          Log    ${flight_details_from_search_page}
          log    ${fare_summary}
      END
    ELSE IF    ${is_fare_changed_baggage}
        Click Element    ${continue_btn_fare}
    END
    RETURN  ${flight_details}  ${Fare_summary}    ${layover_details}  # Return updated values

Handle All Popups And Update Data For Fare Rule | Round Trip
    [Arguments]    ${search_page_fare_details_right}    ${search_page_fare_details_left}    ${booking_data}    ${flag}    ${flight_details}=False    ${Fare_summary}=False
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${amount_to_pay}    timeout=30
    Handle Consent Message Popup
    Sleep    10s
    ${is_fare_jump}    Run Keyword And Return Status    Element Should Be Visible    ${fare_jump_popup_new}
    Capture Page Screenshot
    ${is_fare_type_change}    Run Keyword And Return Status    Element Should Be Visible    ${fare_type_change_popup}
    ${is_hand_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_hand_baggage_popup}
    ${is_sold_out}    Run Keyword And Return Status    Element Should Be Visible    ${sold_out_popup}
    ${is_fare_changed_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_fare_have_changed_baggage}
    IF    ${is_fare_type_change}
      ${flight_details}    Handle Fare Type Change Popup    ${flight_details}
    ELSE IF   ${is_fare_jump}
      ${Fare_summary}    Handle Fare Jump Popup  ${Fare_summary}
    ELSE IF    ${is_hand_baggage}
      Click Element    ${hand_baggage_continue_button}
    ELSE IF   ${is_sold_out}
      IF    ${flag}
          Skip
      ELSE
          ${search_page_fare_details_right}    ${search_page_fare_details_left}   Handle Sold Out Popup For Fare Rule | Round Trip  1    ${booking_data}
      END
    ELSE IF    ${is_fare_changed_baggage}
        Click Element    ${continue_btn_fare}
    END
    RETURN    ${search_page_fare_details_right}    ${search_page_fare_details_left}

Handle Sold Out Popup For Fare Rule | Round Trip
    [Arguments]  ${button_number}    ${booking_data}
    Click Element    ${sold_out_back_to_search_btn}
    Enter Supplier ID Into Current URL    ${booking_data}
    Wait Until Element Is Visible    ${cheapest_flight_filter}    timeout=180
    Check Flights Are Available On Search Page
    ${view_element}    Click View Details For Right Panel
    Click On Fare Rule    ${view_element}
    ${search_page_fare_details_right}    Get Fare Rule Details
    Close Fare View Button    ${view_element}
    ${view_element}    Click View Details For Left Panel
    Click On Fare Rule    ${view_element}
    ${search_page_fare_details_left}    Get Fare Rule Details
    Close Fare View Button    ${view_element}
    Click On Book Button
    Handle Consent Message Popup
    ${flag}    Set Variable    True
    Handle All Popups And Update Data For Fare Rule | Round Trip    ${search_page_fare_details_right}    ${search_page_fare_details_left}    ${booking_data}    ${flag}
    RETURN    ${search_page_fare_details_right}    ${search_page_fare_details_left}

Handle All Popups And Update Data For Fare Rule | One Way
    [Arguments]    ${search_page_fare_rule_details}    ${booking_data}    ${flight_details}    ${flag}    ${layover_details}    ${Fare_summary}=False
    Handle Consent Message Popup
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${amount_to_pay}    timeout=30
    ${is_fare_jump}    Run Keyword And Return Status    Element Should Be Visible    ${fare_jump_popup_new}
    Capture Page Screenshot
    ${is_fare_type_change}    Run Keyword And Return Status    Element Should Be Visible    ${fare_type_change_popup}
    ${is_hand_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_hand_baggage_popup}
    ${is_sold_out}    Run Keyword And Return Status    Element Should Be Visible    ${sold_out_popup}
    ${is_fare_changed_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_fare_have_changed_baggage}
    IF    ${is_fare_type_change}
      ${flight_details}    Handle Fare Type Change Popup    ${flight_details}
    ELSE IF   ${is_fare_jump}
      ${Fare_summary}    Handle Fare Jump Popup  ${Fare_summary}
    ELSE IF    ${is_hand_baggage}
      Click Element    ${hand_baggage_continue_button}
    ELSE IF   ${is_sold_out}
      IF    ${flag}
          Skip
      ELSE
          ${flight_details}    ${search_page_fare_rule_details}    ${layover_details}    Handle Sold Out Popup For Fare Rule | One Way  1    ${booking_data}    ${layover_details}
      END
    ELSE IF    ${is_fare_changed_baggage}
        Click Element    ${continue_btn_fare}
    END
    RETURN    ${flight_details}    ${search_page_fare_rule_details}    ${layover_details}

Handle Sold Out Popup For Fare Rule | One Way
    [Arguments]  ${button_number}    ${booking_data}    ${layover_details}
    Click Element    ${sold_out_back_to_search_btn}
    Wait Until Element Is Visible    ${cheapest_flight_filter}    timeout=180
    Check Flights Are Available On Search Page
    ${search_page_flight_details}    Get Flight Details From Search Page
    #   ${layover_details}  Get Layover Details For Booking Summary
    ${search_page_fare_rule_details}    Get Fare Rule Details From Search Page
    Close Fare And Click Book Button
    ${flag}    Set Variable    True
    Handle All Popups And Update Data For Fare Rule | One Way    ${search_page_fare_rule_details}    ${booking_data}    ${search_page_flight_details}    ${flag}    ${layover_details}
    RETURN    ${search_page_flight_details}    ${search_page_fare_rule_details}    ${layover_details}

Handle All Popups And Update Data For Baggage Allowance | One Way
    [Arguments]    ${baggage_details}    ${booking_data}    ${flag}    ${flight_details}=False    ${Fare_summary}=False
    Handle Consent Message Popup
    Sleep    200s
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${amount_to_pay}    timeout=30
    ${is_fare_jump}    Run Keyword And Return Status    Element Should Be Visible    ${fare_jump_popup_new}
    Capture Page Screenshot
    ${is_fare_type_change}    Run Keyword And Return Status    Element Should Be Visible    ${fare_type_change_popup}
    ${is_hand_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_hand_baggage_popup}
    ${is_sold_out}    Run Keyword And Return Status    Element Should Be Visible    ${sold_out_popup}
    ${is_fare_changed_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_fare_have_changed_baggage}
    IF    ${is_fare_type_change}
      ${flight_details}    Handle Fare Type Change Popup    ${flight_details}
    ELSE IF   ${is_fare_jump}
      ${Fare_summary}    Handle Fare Jump Popup  ${Fare_summary}
    ELSE IF    ${is_hand_baggage}
      Click Element    ${hand_baggage_continue_button}
    ELSE IF   ${is_sold_out}
      IF    ${flag}
          Skip
      ELSE
          ${baggage_details}    Handle Sold Out Popup For Baggage Allowance | One Way  1    ${booking_data}
          RETURN    ${baggage_details}
      END
    ELSE IF    ${is_fare_changed_baggage}
        ${changed_data}    Get Text    //p[contains(@class, 'fareJumpPopup--newValText')]
        Click Element    ${continue_btn_fare}
        RETURN    ${changed_data}
    END

Handle Sold Out Popup For Baggage Allowance | One Way
    [Arguments]  ${button_number}    ${booking_data}
    Click Element    ${sold_out_back_to_search_btn}
    Wait Until Element Is Visible    ${cheapest_flight_filter}    timeout=180
    Enter Supplier ID Into Current URL    ${booking_data}
    Check Flights Are Available On Search Page
    ${checkin_list}    ${cabin_list}    Get Baggage Information From Search Results
    ${baggage_details}    Generate Baggage Details Format For Flight Itinerary | Review Page    ${checkin_list}    ${cabin_list}
    Click On Book Button On Search Page
    Handle Consent Message Popup
    ${flag}    Set Variable    True
    Handle All Popups And Update Data For Baggage Allowance | One Way    ${baggage_details}    ${booking_data}    ${flag}
    RETURN    ${baggage_details}

Handle All Popups And Update Data For Baggage Allowance | Round Trip
    [Arguments]    ${flight_itinerary_list}    ${flag}    ${flight_details}=False    ${Fare_summary}=False
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${amount_to_pay}    timeout=30
    Handle Consent Message Popup
    ${is_fare_jump}    Run Keyword And Return Status    Element Should Be Visible    ${fare_jump_popup_new}
    Capture Page Screenshot
    ${is_fare_type_change}    Run Keyword And Return Status    Element Should Be Visible    ${fare_type_change_popup}
    ${is_hand_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_hand_baggage_popup}
    ${is_sold_out}    Run Keyword And Return Status    Element Should Be Visible    ${sold_out_popup}
    ${is_fare_changed_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_fare_have_changed_baggage}
    IF    ${is_fare_type_change}
      ${flight_details}    Handle Fare Type Change Popup    ${flight_details}
    ELSE IF   ${is_fare_jump}
      ${Fare_summary}    Handle Fare Jump Popup  ${Fare_summary}
    ELSE IF    ${is_hand_baggage}
      Click Element    ${hand_baggage_continue_button}
    ELSE IF   ${is_sold_out}
      IF    ${flag}
          Skip
      ELSE
          ${flight_itinerary_list}   Handle Sold Out Popup For Baggage Allowance | Round Trip  1
          RETURN    ${flight_itinerary_list}
      END
    ELSE IF    ${is_fare_changed_baggage}
        ${changed_data}    Get Text    //p[contains(@class, 'fareJumpPopup--newValText')]
        Click Element    ${continue_btn_fare}
        RETURN    ${changed_data}
    END

Handle Sold Out Popup For Baggage Allowance | Round Trip
    [Arguments]  ${button_number}
    Click Element    ${sold_out_back_to_search_btn}
    Wait Until Element Is Visible    ${cheapest_flight_filter}    timeout=180
    Check Flights Are Available On Search Page
    ${view_element_right}    Click View Details For Right Panel
    Click Element    ${view_element_right}
    ${checkin_list}    ${cabin_list}    Get Baggage Information From Search Results
    Close Fare View Button    ${view_element_right}
    ${view_element_left}    Click View Details For Left Panel
    Click Element    ${view_element_left}
    ${right_checkin_list}    ${right_cabin_list}    Get Baggage Information From Search Results
    Close Fare View Button Left Section
    ${data}    Generate Baggage Details Format For Flight Itinerary | Review Page    ${checkin_list}    ${cabin_list}
    ${right_data}    Generate Baggage Details Format For Flight Itinerary | Review Page    ${right_checkin_list}    ${right_cabin_list}
    ${flight_itinerary_list}    Combine Two Lists    ${data}    ${right_data}
    Click On Book Button
    Handle Consent Message Popup
    ${flag}    Set Variable    True
    Handle All Popups And Update Data For Baggage Allowance | Round Trip    ${flight_itinerary_list}    ${flag}
    RETURN    ${flight_itinerary_list}

Get Layover Details For Booking Summary
    ${is_search_result_page}  Run Keyword And Return Status    Element Should Be Visible    ${cheapest_flight_filter}
    ${layover_list}  Create List
    IF    ${is_search_result_page}
      Execute Javascript  window.scrollTo(0,-50)
      Click Element    ${view_details_button}
      ${indexing}  Set Variable    2
      ${loop_count}     Set Variable    1
      ${no_of_stops}     SeleniumLibrary.Get Element Count    ${flight_duration_text}
      WHILE   ${loop_count} < ${no_of_stops}
           ${arrival_time_first}   Get Text    (${arrival_details_text})[${indexing}]
           ${arrival_time_first}    Extract Time    ${arrival_time_first}
           ${indexing}=  Evaluate   ${indexing} + 1
           ${departure_time_secound}   Get Text    (${arrival_details_text})[${indexing}]
           ${departure_time_secound}    Extract Time   ${departure_time_secound}
           ${indexing}=  Evaluate   ${indexing} + 1
           ${calculated_layover_time}   Calculate Time Difference    ${arrival_time_first}   ${departure_time_secound}
           ${layover_time}     Get Text  (${layover_time_text})[${loop_count}]
           Should Contain    ${layover_time}  ${calculated_layover_time}
           Append To List    ${layover_list}  ${calculated_layover_time}
           ${loop_count}=  Evaluate   ${loop_count} + 1
      END
      Close Fare View Button    ${view_details_button}
    ELSE
      ${layover_elements}  Get WebElements    ${layover_text}
      FOR    ${layover_element}    IN    @{layover_elements}
          ${layover_value}  Get Text    ${layover_element}
          ${layover_value}    Get Layover Time   ${layover_value}
          Log    ${layover_value}
          Append To List    ${layover_list}  ${layover_value}
      END
    END
    RETURN  ${layover_list}

Verify Layover Details For Booking Summary
    [Arguments]    ${layover_details}
    ${layover_details_from_itinerary}  Get Layover Details For Booking Summary
    Lists Should Be Equal    ${layover_details}    ${layover_details_from_itinerary}

Get Flight Details And Layover Details For Round Trip
    [Arguments]     ${flightNameLocator}    ${flightDepartureLocator}    ${flightDestinationLocator}    ${flight_duration_flight_type_locator}
    ${is_flilisting_page}=      Run Keyword And Return Status    Element Should Be Visible    ${view_details_button}
    IF    ${is_flilisting_page}
      Wait Until Page Contains Element    ${view_details_button}    timeout=10
      Click Element    ${view_details_button}
      Click Element    ${view_details_button_right_section}
      Wait Until Element Is Visible    ${fare_details_tab}
    END
    ${flight_details}    Create Dictionary
    ${flight_name_elements}=  Get WebElements    ${flightNameLocator}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_name_elements}
      ${flight_name}=  Get Text    ${element}
      IF    ${is_flilisting_page}
          ${split}=   Split String    ${flight_name}    \n
          ${temp1}=  Get From List    ${split}    0
          ${temp2}=   Get From List    ${split}    1
          ${flight_name}=  Catenate    ${temp1}${temp2}
      END
      Set To Dictionary    ${flight_details}   FlightName${i}=${flight_name}
      ${i}=   Evaluate   ${i}+1
    END
    ${flight_departure_elements}=    Get WebElements    ${flightDepartureLocator}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_departure_elements}
      ${departure_detail}=  Get Text    ${element}
      Set To Dictionary    ${flight_details}   FlightDeparture${i}=${departure_detail}
      ${i}=   Evaluate   ${i}+1
    END
    ${flight_destination_element}=   Get WebElements    ${flightDestinationLocator}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_destination_element}
      ${destination_detail}=  Get Text    ${element}
      Set To Dictionary    ${flight_details}    FlightDestination${i}=${destination_detail}
      ${i}=   Evaluate   ${i}+1
    END
    ${flight_duration_flight_type_element}=   Get WebElements    ${flight_duration_flight_type_locator}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_duration_flight_type_element}
      ${duration_type_detail}=  Get Text    ${element}
      ${split_string}=  Split String    ${duration_type_detail}   \n
      ${duration_type_detail1}=  Get From List    ${split_string}  0
      ${duration_type_detail2}=  Get From List    ${split_string}  1
      ${duration_type_detail}=  Catenate  ${duration_type_detail1}  ${duration_type_detail2}
      ${removeable_string}=  Split String    ${duration_type_detail}  ,
      ${duration_type_detail}=  Get From List    ${removeable_string}    0
      ${duration_type_detail}=  Strip String    ${duration_type_detail}
      Set To Dictionary    ${flight_details}    FlightDurationFlightType${i}=${duration_type_detail}
      ${i}=   Evaluate   ${i}+1
    END
    ${layover_list}    Create List
    IF    ${is_flilisting_page}
      ${indexing}  Set Variable    2
      ${loop_count}     Set Variable    1
      ${no_of_stops}     SeleniumLibrary.Get Element Count    ${flight_duration_text}
      ${layover_list}    Create List
      WHILE   ${loop_count} < ${no_of_stops}
           ${arrival_time_first}   Get Text    (${arrival_details_text})[${indexing}]
           ${arrival_time_first}    Extract Time    ${arrival_time_first}
           ${indexing}=  Evaluate   ${indexing} + 1
           ${departure_time_secound}   Get Text    (${arrival_details_text})[${indexing}]
           ${departure_time_secound}    Extract Time   ${departure_time_secound}
           ${indexing}=  Evaluate   ${indexing} + 1
           ${calculated_layover_time}   Calculate Time Difference    ${arrival_time_first}   ${departure_time_secound}
           ${layover_time}     Get Text  (${layover_time_text})[${loop_count}]
           Should Contain    ${layover_time}  ${calculated_layover_time}
           Append To List    ${layover_list}  ${calculated_layover_time}
           ${loop_count}=  Evaluate   ${loop_count} + 1
      END
    ELSE
      ${layover_elements}  Get WebElements    ${layover_text}
      FOR    ${layover_element}    IN    @{layover_elements}
          ${layover_value}  Get Text    ${layover_element}
          ${layover_value}    Get Layover Time   ${layover_value}
          Log    ${layover_value}
          Append To List    ${layover_list}  ${layover_value}
      END
    END
    RETURN  ${flight_details}    ${layover_list}

Verify Layover Details For Round Trip For Booking Summary
    [Arguments]    ${layover_details}
    ${flight_details}    ${layover_details_from_itinerary}    Get Flight Details And Layover Details For Round Trip    ${flight_Name_locator}  ${flight_departure_detail}   ${flight_destination_detail}    ${flight_duration_flight_type_search_result}
    Lists Should Be Equal    ${layover_details}    ${layover_details_from_itinerary}

Get Flight Details And Layover Details For Round Trip Domestic | International
  [Arguments]     ${flightNameLocator}    ${flightDepartureLocator}    ${flightDestinationLocator}    ${flight_duration_flight_type_locator}
  ${is_flilisting_page}=      Run Keyword And Return Status    Element Should Be Visible    ${view_details_button}
  ${layover_list}    Create List
  IF    ${is_flilisting_page}
      Wait Until Page Contains Element    ${view_details_button}    timeout=10
      Sleep    10s
      ${fare_type}    Run Keyword And Return Status    Element Should Contain    //div[@class="asr-tbcell"]/child::div[1]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][1]    Instant Offer Return Fare
      IF    ${fare_type}
          ${count_fare_type}    SeleniumLibrary.Get Element Count    //div[@class="asr-tbcell"]/child::div[1]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")]
          FOR    ${count}    IN RANGE    1    ${count_fare_type}+1
              ${fare_type_text}    Get Text    //div[@class="asr-tbcell"]/child::div[1]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]
              IF    "${fare_type_text}"!= "Instant Offer Return Fare"
                  Wait Until Element Is Visible    //div[@class="asr-tbcell"]/child::div[1]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]/preceding-sibling::label
                  Click Element    //div[@class="asr-tbcell"]/child::div[1]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]/preceding-sibling::label
                  ${view_element}    Set Variable    //div[@class="asr-tbcell"]/child::div[1]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]/preceding-sibling::label/ancestor::div[contains(@class,"flightrightview ")]/preceding-sibling::div/descendant::button[contains(@class,"viewbtn")]
                  Exit For Loop If    "${fare_type_text}"!= "Instant Offer Return Fare"
              END
          END
      ELSE
          Click Element    //div[@class="asr-tbcell"]/child::div[1]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][1]/preceding-sibling::label
          ${view_element}    Set Variable    ${view_details_button}
          Click Element    ${view_details_button}
      END
      IF    ${is_flilisting_page}
          ${indexing}  Set Variable    2
          ${loop_count}     Set Variable    1
          ${no_of_stops}     SeleniumLibrary.Get Element Count    //li[contains(@class,'ars-lsprice round')]
#            ${layover_list}    Create List
          WHILE   ${loop_count} < ${no_of_stops}
               ${arrival_time_first}   Get Text    (//li[contains(@class,"ars-lsprice ars-prclist round-flighttime")])[${indexing}]
               ${arrival_time_first}    Extract Time    ${arrival_time_first}
               ${indexing}=  Evaluate   ${indexing} + 1
               ${departure_time_secound}   Get Text    (//li[contains(@class,"ars-lsprice ars-prclist round-flighttime")])[${indexing}]
               ${departure_time_secound}    Extract Time   ${departure_time_secound}
               ${indexing}=  Evaluate   ${indexing} + 1
               ${calculated_layover_time}   Calculate Time Difference    ${arrival_time_first}   ${departure_time_secound}
               ${layover_time}     Get Text  (${layover_time_text})[${loop_count}]
               Should Contain    ${layover_time}  ${calculated_layover_time}
               Append To List    ${layover_list}  ${calculated_layover_time}
               ${loop_count}=  Evaluate   ${loop_count} + 1
          END
      END
      Click Element    ${view_details_button}
      Sleep    10s
      ${fare_type}    Run Keyword And Return Status    Element Should Contain    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][1]    Instant Offer Return Fare
      IF    ${fare_type}
          ${count_fare_type}    SeleniumLibrary.Get Element Count    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")]
          FOR    ${count}    IN RANGE    1    ${count_fare_type}+1
              ${fare_type_text}    Get Text    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]
              IF    "${fare_type_text}"!= "Instant Offer Return Fare"
                  Wait Until Element Is Visible    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]/preceding-sibling::label
                  Sleep    10s
                  Click Element    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]/preceding-sibling::label
                  Sleep    5s
                  ${view_element}    Set Variable    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]/preceding-sibling::label/ancestor::div[contains(@class,"flightrightview ")]/preceding-sibling::div/descendant::button[contains(@class,"viewbtn")]




  #                Click Element    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][${count}]/preceding-sibling::label/ancestor::div[contains(@class,"flightrightview ")]/preceding-sibling::div/descendant::button[contains(@class,"viewbtn")]
                  Exit For Loop If    "${fare_type_text}"!= "Instant Offer Return Fare"
              END
          END
      ELSE
          Click Element    //div[@class="asr-tbcell"]/child::div[2]//div[@class="asr-roundbtm"]/descendant::span[contains(@class,"flightlabel")][1]/preceding-sibling::label
          ${view_element}    Set Variable    ${view_details_button_right_section}
          Click Element    ${view_details_button_right_section}
      END
      IF    ${is_flilisting_page}
          ${indexing}  Set Variable    2
          ${loop_count}     Set Variable    1
          ${no_of_stops}     SeleniumLibrary.Get Element Count    //li[contains(@class,'ars-lsprice round')]
#            ${layover_list}    Create List
          WHILE   ${loop_count} < ${no_of_stops}
               ${arrival_time_first}   Get Text    (//li[contains(@class,"ars-lsprice ars-prclist round-flighttime")])[${indexing}]
               ${arrival_time_first}    Extract Time    ${arrival_time_first}
               ${indexing}=  Evaluate   ${indexing} + 1
               ${departure_time_secound}   Get Text    (//li[contains(@class,"ars-lsprice ars-prclist round-flighttime")])[${indexing}]
               ${departure_time_secound}    Extract Time   ${departure_time_secound}
               ${indexing}=  Evaluate   ${indexing} + 1
               Sleep    20s
               Capture Page Screenshot
               ${calculated_layover_time}   Calculate Time Difference    ${arrival_time_first}   ${departure_time_secound}
               ${layover_time}     Get Text  (${layover_time_text})[${loop_count}]
               Should Contain    ${layover_time}  ${calculated_layover_time}
               Append To List    ${layover_list}  ${calculated_layover_time}
               ${loop_count}=  Evaluate   ${loop_count} + 1
          END
      END
      Sleep    10s
      Wait Until Element Is Visible    ${fare_details_tab}
  END
  Click Element    ${view_details_button}
  ${flight_details}    Create Dictionary
  ${flight_name_elements}=  Get WebElements    ${flightNameLocator}
  ${i}=   Set Variable    1
  FOR    ${element}    IN    @{flight_name_elements}
      ${flight_name}=  Get Text    ${element}
      IF    ${is_flilisting_page}
          ${split}=   Split String    ${flight_name}    \n
          ${temp1}=  Get From List    ${split}    0
          ${temp2}=   Get From List    ${split}    1
          ${flight_name}=  Catenate    ${temp1}${temp2}
      END
      Set To Dictionary    ${flight_details}   FlightName${i}=${flight_name}
      ${i}=   Evaluate   ${i}+1
  END
  ${flight_departure_elements}=    Get WebElements    ${flightDepartureLocator}
  ${i}=   Set Variable    1
  FOR    ${element}    IN    @{flight_departure_elements}
      ${departure_detail}=  Get Text    ${element}
      Set To Dictionary    ${flight_details}   FlightDeparture${i}=${departure_detail}
      ${i}=   Evaluate   ${i}+1
  END
  ${flight_destination_element}=   Get WebElements    ${flightDestinationLocator}
  ${i}=   Set Variable    1
  FOR    ${element}    IN    @{flight_destination_element}
      ${destination_detail}=  Get Text    ${element}
      Set To Dictionary    ${flight_details}    FlightDestination${i}=${destination_detail}
      ${i}=   Evaluate   ${i}+1
  END
  ${flight_duration_flight_type_element}=   Get WebElements    ${flight_duration_flight_type_locator}
  ${i}=   Set Variable    1
  FOR    ${element}    IN    @{flight_duration_flight_type_element}
      ${duration_type_detail}=  Get Text    ${element}
      ${split_string}=  Split String    ${duration_type_detail}   \n
      ${duration_type_detail1}=  Get From List    ${split_string}  0
      ${duration_type_detail2}=  Get From List    ${split_string}  1
      # ${duration_type_detail}=  Catenate  ${duration_type_detail1}  ${duration_type_detail2}
      ${removeable_string}=  Split String    ${duration_type_detail1}  ,
      ${duration_type_detail}=  Get From List    ${removeable_string}    0
      ${duration_type_detail}=  Strip String    ${duration_type_detail}
      Set To Dictionary    ${flight_details}    FlightDurationFlightType${i}=${duration_type_detail}
      ${i}=   Evaluate   ${i}+1
  END
#    ${layover_list}    Create List
  IF    "${is_flilisting_page}"=="False"
#        ${indexing}  Set Variable    2
#        ${loop_count}     Set Variable    1
#        ${no_of_stops}     SeleniumLibrary.Get Element Count    //li[contains(@class,'ars-lsprice round')]
#        ${layover_list}    Create List
#        WHILE   ${loop_count} < ${no_of_stops}
#             ${arrival_time_first}   Get Text    (//li[contains(@class,"ars-lsprice ars-prclist round-flighttime")])[${indexing}]
#             ${arrival_time_first}    Extract Time    ${arrival_time_first}
#             ${indexing}=  Evaluate   ${indexing} + 1
#             ${departure_time_secound}   Get Text    (//li[contains(@class,"ars-lsprice ars-prclist round-flighttime")])[${indexing}]
#             ${departure_time_secound}    Extract Time   ${departure_time_secound}
#             ${indexing}=  Evaluate   ${indexing} + 1
#             ${calculated_layover_time}   Calculate Time Difference    ${arrival_time_first}   ${departure_time_secound}
#             ${layover_time}     Get Text  (${layover_time_text})[${loop_count}]
#             Should Contain    ${layover_time}  ${calculated_layover_time}
#             Append To List    ${layover_list}  ${calculated_layover_time}
#             ${loop_count}=  Evaluate   ${loop_count} + 1
#        END
#    ELSE
      ${layover_elements}  Get WebElements    ${layover_text}
      FOR    ${layover_element}    IN    @{layover_elements}
          ${layover_value}  Get Text    ${layover_element}
          ${layover_value}    Get Layover Time   ${layover_value}
          Log    ${layover_value}
          Append To List    ${layover_list}  ${layover_value}
      END
  END
  RETURN  ${flight_details}    ${layover_list}








Handle Sold Out Popup | Round Trip International
  [Arguments]  ${button_number}    ${booking_data}
  Click Element    ${sold_out_back_to_search_btn}
  Enter Supplier ID Into Current URL    ${booking_data}
  Wait Until Element Is Visible    ${cheapest_flight_filter}    timeout=180
  Split Flight For International Round Trip
  Sleep    10s
  Select One Stop Filter For Round Trip Search
  Sleep    10s
  Check Flights Are Available On Search Page
#    ${btn}    Click View Details For Right Panel
#    ${Fare_summary}    Verify Fare Details And Get Fare Summary    ${btn}
#    ${btn1}    Click View Details For Left Panel
#    ${fare_summary_2}    Verify Fare Details And Get Fare Summary    ${btn1}
#    Verify Fare Details At Bottom Of Screen For Round Trip    ${Fare_summary}    ${fare_summary_2}
#    ${fare_summary}     Add Fare Dictionary      ${fare_summary}   ${fare_summary_2}
  ${flight_details_from_search_page}    ${layover_details}    Get Flight Details And Layover Details For Round Trip Domestic | International    ${flight_Name_locator}  ${flight_departure_detail}   ${flight_destination_detail}    ${flight_duration_flight_type_search_result}
  Execute Javascript    window.scroll(0,-50)
  Click On Book Button
  Handle Consent Message Popup
  Run Keyword And Ignore Error    Wait Until Element Is Visible    ${amount_to_pay}    timeout=30s
  ${flag}    Set Variable    True
  Handle All Popups And Update Data | Round Trip For Booking Summary    ${flight_details_from_search_page}  ${False}    ${booking_data}    ${flag}    ${layover_details}
  RETURN  ${flight_details_from_search_page}    ${layover_details}




Handle All Popups And Update Data | Round Trip International For Booking Summary
    [Arguments]  ${flight_details}  ${Fare_summary}    ${booking_data}    ${flag}    ${layover_details}
    Handle Consent Message Popup
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${amount_to_pay}    timeout=30
    ${is_fare_jump}    Run Keyword And Return Status    Element Should Be Visible    ${fare_jump_popup_new}
    Capture Page Screenshot
    ${is_fare_type_change}    Run Keyword And Return Status    Element Should Be Visible    ${fare_type_change_popup}
    ${is_hand_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_hand_baggage_popup}
    ${is_sold_out}    Run Keyword And Return Status    Element Should Be Visible    ${sold_out_popup}
    ${is_fare_changed_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_fare_have_changed_baggage}
    IF    ${is_fare_type_change}
      ${flight_details}  Handle Fare Type Change Popup    ${flight_details}
    ELSE IF   ${is_fare_jump}
      ${Fare_summary}  Handle Fare Jump Popup  ${Fare_summary}
    ELSE IF    ${is_hand_baggage}
      Click Element    ${hand_baggage_continue_button}
    ELSE IF   ${is_sold_out}
      IF    ${flag}
          Skip
      ELSE
          ${flight_details_from_search_page}    ${layover_details}    Handle Sold Out Popup | Round Trip International    1    ${booking_data}
          Log    ${flight_details_from_search_page}
          log    ${fare_summary}
      END
    ELSE IF    ${is_fare_changed_baggage}
        Click Element    ${continue_btn_fare}
    END
    RETURN  ${flight_details}  ${Fare_summary}    ${layover_details}

Verify User Is Able To Redirect On Cart Details Page For Markup
    Sleep    10s
    ${booking_status}    ${booking_id_text}    Get Booking Status And Id From Booking Summary Page
    ${booking_id_text}    Convert To String    ${booking_id_text}
    Wait Until Element Is Visible    ${booking_id}
    Scroll Element Into View    ${booking_id}
    Click Element    ${booking_id}
    Wait Until Page Contains    Cart-detail
    Wait Until Element Is Visible    ${booking_id_text_cart_details}
    ${nav_id}    Get Text    ${booking_id_text_cart_details}
    ${nav_id}    Convert To String    ${nav_id}
    ${trimmed_nav_id}=    Strip String    ${nav_id}
    Wait Until Element Is Visible    ${booking_id_text_on_cart}
    ${id}    Get Text    ${booking_id_text_on_cart}
    ${id}    Convert To String    ${id}
    ${trimmed_id}=    Strip String    ${nav_id}
    IF    "${booking_status}"!="Pending"
      Wait Until Element Is Visible    ${cart_detail_status_text}
      ${status}    Get Text    ${cart_detail_status_text}
      Element Should Contain    ${cart_detail_status_text}    ${booking_status}
      Should Be Equal As Strings    ${booking_id_text}    ${trimmed_id}
      Should Be Equal As Strings    ${booking_id_text}    ${trimmed_nav_id}
      Wait Until Page Contains Element    ${cart_details_notes_tab}
      Click Element    ${cart_details_notes_tab}
      Capture Page Screenshot
      Log    Failed due to booking status is "${booking_status}"
      Fail
    ELSE
      Should Be Equal As Strings    ${booking_id_text}    ${trimmed_id}
      Should Be Equal As Strings    ${booking_id_text}    ${trimmed_nav_id}
    END

Check Flights Are Available On Search Page
    ${no_flights_available}    Run Keyword And Return Status    Page Should Contain    Sorry, There were no flights found for this route Please, Modify your search and try again.
    Capture Page Screenshot
    IF    ${no_flights_available}
      Log    Sorry, There were no flights found for this route Please, Modify your search and try again.
      Fail
    END

Verify User Is Able To Redirect On Cart Details Page For PNR and Ticket Number
    [Arguments]    ${booking_status}    ${id}
    ${booking_id_text}    Convert To String    ${id}
    Wait Until Element Is Visible    ${booking_id}
    Scroll Element Into View    ${booking_id}
    Click Element    ${booking_id}
    Wait Until Page Contains    Cart-detail
    Wait Until Element Is Visible    ${booking_id_text_cart_details}
    ${nav_id}    Get Text    ${booking_id_text_cart_details}
    ${nav_id}    Convert To String    ${nav_id}
    ${trimmed_nav_id}=    Strip String    ${nav_id}
    Wait Until Element Is Visible    ${booking_id_text_on_cart}
    ${id}    Get Text    ${booking_id_text_on_cart}
    ${id}    Convert To String    ${id}
    ${trimmed_id}=    Strip String    ${nav_id}
    Wait Until Element Is Visible    ${cart_detail_status_text}
    ${status}    Get Text    ${cart_detail_status_text}
    Element Should Contain    ${cart_detail_status_text}    ${booking_status}
    Should Be Equal As Strings    ${booking_id_text}    ${trimmed_id}
    Should Be Equal As Strings    ${booking_id_text}    ${trimmed_nav_id}

Handle Sold Out Popup | Round Trip Domestic
    [Arguments]  ${button_number}    ${booking_data}
    Click Element    ${sold_out_back_to_search_btn}
    Enter Supplier ID Into Current URL    ${booking_data}
    Wait Until Element Is Visible    ${cheapest_flight_filter}    timeout=180
    Check Flights Are Available On Search Page
    #    ${btn}    Click View Details For Right Panel
    #    ${Fare_summary}    Verify Fare Details And Get Fare Summary    ${btn}
    #    ${btn1}    Click View Details For Left Panel
    #    ${fare_summary_2}    Verify Fare Details And Get Fare Summary    ${btn1}
    #    Verify Fare Details At Bottom Of Screen For Round Trip    ${Fare_summary}    ${fare_summary_2}
    #    ${fare_summary}     Add Fare Dictionary      ${fare_summary}   ${fare_summary_2}
    ${flight_details_from_search_page}    ${layover_details}    Get Flight Details And Layover Details For Round Trip Domestic | International    ${flight_Name_locator}  ${flight_departure_detail}   ${flight_destination_detail}    ${flight_duration_flight_type_search_result}
    Execute Javascript    window.scroll(0,-50)
    Click On Book Button
    Handle Consent Message Popup
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${amount_to_pay}    timeout=30s
    ${flag}    Set Variable    True
    Handle All Popups And Update Data | Round Trip For Booking Summary    ${flight_details_from_search_page}  ${False}    ${booking_data}    ${flag}    ${layover_details}
    RETURN  ${flight_details_from_search_page}    ${layover_details}

Handle All Popups And Update Data | Round Trip Domestic For Booking Summary
    [Arguments]  ${flight_details}  ${Fare_summary}    ${booking_data}    ${flag}    ${layover_details}
    Handle Consent Message Popup
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${amount_to_pay}    timeout=30
    ${is_fare_jump}    Run Keyword And Return Status    Element Should Be Visible    ${fare_jump_popup_new}
    Capture Page Screenshot
    ${is_fare_type_change}    Run Keyword And Return Status    Element Should Be Visible    ${fare_type_change_popup}
    ${is_hand_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_hand_baggage_popup}
    ${is_sold_out}    Run Keyword And Return Status    Element Should Be Visible    ${sold_out_popup}
    ${is_fare_changed_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_fare_have_changed_baggage}
    IF    ${is_fare_type_change}
      ${flight_details}  Handle Fare Type Change Popup    ${flight_details}
    ELSE IF   ${is_fare_jump}
      ${Fare_summary}  Handle Fare Jump Popup  ${Fare_summary}
    ELSE IF    ${is_hand_baggage}
      Click Element    ${hand_baggage_continue_button}
    ELSE IF   ${is_sold_out}
      IF    ${flag}
          Skip
      ELSE
          ${flight_details_from_search_page}    ${layover_details}    Handle Sold Out Popup | Round Trip Domestic    1    ${booking_data}
          Log    ${flight_details_from_search_page}
          log    ${fare_summary}
      END
    ELSE IF    ${is_fare_changed_baggage}
        Click Element    ${continue_btn_fare}
    END
    RETURN  ${flight_details}  ${Fare_summary}    ${layover_details}

Get Baggage Information From Search Results For Round Trip Domestic Right
    [Arguments]    ${view_element_right}
    Wait Until Element Is Visible    ${view_element_right}
    Click Element    ${view_element_right}
    ${flag}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${flight_details_tab}    5s
    IF    ${flag} == False
       Click Element    ${view_element_right}
    END
    Wait Until Element Is Visible       ${flight_details_tab}
    Wait Until Element Is Visible    ${baggage_allowance_tab}
    Click Element    ${baggage_allowance_tab}
    Sleep    30s
    Wait Until Element Is Visible    ${baggage_allowance_text}
    @{checkin_list}    Create List
    @{cabin_list}    Create List
    ${rows_count}    SeleniumLibrary.Get Element Count    ${baggage_info_row_search_page}
    FOR    ${cnt}    IN RANGE  1    ${rows_count}+1
      ${check_in_element}    Get Text    //div[contains(@class, 'baggageData-row-positionHandle')][${cnt}]/div[2]
      ${cab_in_element}    Get Text    //div[contains(@class, 'baggageData-row-positionHandle')][${cnt}]/div[3]
      Log    ${check_in_element}
      Log    ${cab_in_element}
      Append To List    ${checkin_list}    ${check_in_element}
      Append To List    ${cabin_list}    ${cab_in_element}
    END
    RETURN    ${checkin_list}    ${cabin_list}

Get Baggage Information From Search Results For Round Trip Domestic Left
    [Arguments]    ${view_element_left}
    Wait Until Element Is Visible    ${view_element_left}
    Click Element    ${view_element_left}
    ${flag}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${flight_details_tab}    5s
    IF    ${flag} == False
       Click Element    ${view_element_left}
    END
    Wait Until Element Is Visible       ${flight_details_tab}
    Wait Until Element Is Visible    //i[@class="fa fa-share-alt"]//following::div[@class="ars-tabsbg"]//a[text()='Baggage Information']
    Click Element    //i[@class="fa fa-share-alt"]//following::div[@class="ars-tabsbg"]//a[text()='Baggage Information']
    Sleep    30s
    Wait Until Element Is Visible    ${baggage_allowance_text}
    @{checkin_list}    Create List
    @{cabin_list}    Create List
    ${rows_count}    SeleniumLibrary.Get Element Count    ${baggage_info_row_search_page}
    FOR    ${cnt}    IN RANGE  1    ${rows_count}+1
      ${check_in_element}    Get Text    //div[contains(@class, 'baggageData-row-positionHandle')][${cnt}]/div[2]
      ${cab_in_element}    Get Text    //div[contains(@class, 'baggageData-row-positionHandle')][${cnt}]/div[3]
      Log    ${check_in_element}
      Log    ${cab_in_element}
      Append To List    ${checkin_list}    ${check_in_element}
      Append To List    ${cabin_list}    ${cab_in_element}
    END
    RETURN    ${checkin_list}    ${cabin_list}

Success Booking With TripJack Popup Handle
    Sleep    10s
    ${status}    Run Keyword And Return Status    Wait Until Page Contains    OK
    IF    ${status}
      Click Element    ${ok_button_on_popup}
    END
