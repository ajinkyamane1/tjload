*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    XML
Library    ../CustomKeywords/user_keywords.py
Library    ../../Commonkeywords/CustomKeywords/user_keywords.py
Variables  ../../PageObjects/Login/login_locators.py
Variables  ../../PageObjects/SearchResults/search_results_locators.py
Variables  ../../PageObjects/FlightItinerary/flight_itinerary_locators.py
Resource    ../SearchFlights/search_flights_keywords.robot
Resource    ../BookingSummary/booking_summary_keywords.robot

*** Keywords ***
Verify Fare Summary
    [Arguments]    ${Fare_summary}
    Wait Until Element Is Visible    ${add_passengers_btn}  50s
    ${fare_jump}=    Run Keyword And Return Status    Wait Until Page Contains Element   ${fare_jump_popup}  timeout=7
    IF    ${fare_jump}
        # Check Older Fare on pop-up
        ${old_total_amount}=    Get Text    ${old_fare_amount}
        ${old_total_amount}=    Extract Final Fare As String    ${old_total_amount}
        Should Be Equal As Numbers    ${old_total_amount}    ${Fare_summary.total_fare_price}
       # fare price updated
       ${new_total_amount}=    Get Text    ${new_fare_amount}
       ${new_total_amount}=    Extract Final Fare As String    ${new_total_amount}
       ${Fare_summary.total_fare_price}=    Evaluate    ${new_total_amount}

       ${Fare_summary.is_fare_jump} =   Set Variable    ${True}
       Click Element  ${fare_jump_continue_btn}
     END
    IF    "${Fare_summary.is_fare_jump}"!="True"
        ${total}=    Get Text    ${amount_to_pay}
        ${total}=    Extract Final Fare As String    ${total}
         Should Be Equal As Numbers      ${total}      ${Fare_summary.total_fare_price}
    ELSE
        Wait Until Page Contains Element    ${base_fare_summary}    30s
        ${base}=    Get Text  ${base_fare_summary}
        ${taxes}=    Get Text    ${taxes_fees_summary}
        ${total}=    Get Text    ${amount_to_pay}
        ${base}=    Extract Final Fare As String    ${base}
        ${taxes}=   Extract Final Fare As String   ${taxes}
        ${total}=   Extract Final Fare As String    ${total}
        Should Be Equal As Numbers      ${base}        ${Fare_summary.base_fare}
        Should Be Equal As Numbers      ${taxes}       ${Fare_summary.taxes}
        Should Be Equal As Numbers      ${total}      ${Fare_summary.total_fare_price}
    END

Verify Fare Jump
    [Arguments]    ${Fare_summary}
    Log    ${Fare_summary}
    Click Element    ${book_button}
    Handle Consent Message Popup
#    ${is_sold_out}    Run Keyword And Return Status    Element Should Be Visible    ${sold_out_popup}
#    IF   ${is_sold_out} 
#    ${False}  ${Fare_summary}    Handle Sold Out Popup    1
    ${False}  ${Fare_summary}    ${False}    Handle All Popups    ${False}  ${Fare_summary}    ${False}    ${False}
    ${is_fare_jump_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${fare_jump_popup}
    IF    ${is_fare_jump_visible}
        Wait Until Element Is Visible    ${fare_jump_popup}     30s
        # Check Older Fare on pop-up
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
        Log To Console    No Fare Jump
        Verify Fare Summary    ${Fare_summary}
    END

Verify Updated Markup On Flight Itinerary Page
    [Arguments]    ${markup_price_details}
    Log To Console    ${markup_price_details}
    Wait Until Page Contains Element    ${edit_taxes_btn}    timeout=10
    ${total_amount}=    Get Text    ${amount_to_pay}
    ${total_amount}=    Extract Final Fare As String    ${total_amount}
    Should Be Equal As Numbers   ${total_amount}    ${markup_price_details.total_amount_to_pay}
    Click Element    ${edit_taxes_btn}
    ${current_markup_price}=    SeleniumLibrary.Get Element Attribute    ${markup_price_field}  value
    ${current_markup_price}=    Convert To Number    ${current_markup_price}
    Should Be Equal As Numbers     ${current_markup_price}    ${markup_price_details.markup}
    Clear Element Text    ${markup_price_field}
    # Incressing Markup amounnt to verify update on itinerary page
    Input Text    ${markup_price_field}    1500
    ${updated_markup_price}=    SeleniumLibrary.Get Element Attribute    ${markup_price_field}  value
    ${updated_markup_price}=     Convert To Number    ${updated_markup_price}
    Click Element    ${markup_update_btn}
    Sleep    1
    ${difference_between_markup}=    Evaluate    ${updated_markup_price}-${current_markup_price}
    ${updated_total_amount}=    Evaluate    ${total_amount}+${difference_between_markup}
    ${total_amount}=    Get Text    ${amount_to_pay}
    ${total_amount}=    Extract Final Fare As String    ${total_amount}
    ${total_amount}=     Convert To Number    ${total_amount}
    Should Be Equal As Numbers   ${total_amount}    ${updated_total_amount}

Verify Back to Search Button
    Wait Until Element Is Visible    ${book_button}  30s
    Click Element    ${book_button}
    Handle Consent Message Popup
    Wait Until Element Is Visible   ${a_backToSearch}   10s
    Click Element    ${a_backToSearch}
    Wait Until Element Is Visible    ${book_button}  30s
    Page Should Contain Element    ${book_button}

Verify Back Button
    Wait Until Element Is Visible    ${book_button}  90s
    Click Element    ${book_button}
    Handle Consent Message Popup
    Handle All Popups And Update Data
    Wait Until Element Is Visible    ${back_btn}    30s
    Execute Javascript    window.scrollBy(0,document.body.scrollHeight);
    Click Button    ${back_btn}
    Wait Until Element Is Visible    ${book_button}     timeout=20s
    Page Should Contain Element    ${book_button}

Get Flight Details
    [Arguments]     ${flightNameLocator}    ${flightDepartureLocator}    ${flightDestinationLocator}    ${flight_duration_flight_type_locator}
    ${is_flilisting_page}=      Run Keyword And Return Status    Wait Until Page Contains Element    ${view_details_button}
    IF    ${is_flilisting_page}
        Wait Until Page Contains Element    ${view_details_button}    timeout=10
        Click Element    ${view_details_button}
        Wait Until Element Is Visible    ${fare_details_tab}
        Sleep    5
    END
    ${flight_details}    Create Dictionary
    ${flight_name_elements}=  Get WebElements    ${flightNameLocator}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_name_elements}
        ${flight_name}=  Get Text    ${element}
        IF    ${is_flilisting_page}
            ${split}=   Split String    ${flight_name}    \n
            ${length}    Get Length    ${split}
            IF    ${length}== 2
                ${temp1}=  Get From List    ${split}    0
                ${temp2}=   Get From List    ${split}    1
                ${flight_name}=  Catenate    ${temp1}${temp2}
            ELSE IF    ${length}< 2
                ${flight_name}=  Get From List    ${split}    0
#                ${temp2}=   Get From List    ${split}    0
#                ${flight_name}=  Catenate    ${temp1}${temp2}
            END
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
        Log To Console    ${split_string}
        ${duration_type_detail1}=  Get From List    ${split_string}  0
#        ${duration_type_detail2}=  Get From List    ${split_string}  1
#        ${duration_type_detail}=  Catenate  ${duration_type_detail1}  ${duration_type_detail2}
        ${removeable_string}=  Split String    ${duration_type_detail1}  ,
        ${duration_type_detail}=  Get From List    ${removeable_string}    0
        ${duration_type_detail_stripped}=  Strip String    ${duration_type_detail}
        Set To Dictionary    ${flight_details}    FlightDurationFlightType${i}=${duration_type_detail_stripped}
        Log    ${flight_details}
        ${i}=   Evaluate   ${i}+1
    END
    IF    ${is_flilisting_page}
        Execute Javascript  window.scroll(0,-50)
        Click Element    ${view_details_button}
    END
    Execute Javascript  window.scroll(0,-50)
    RETURN  ${flight_details}

Verify Flight Details
    [Arguments]     ${dict1}    ${dict2}
    Log    ${dict1}
    Log    ${dict2}
    Dictionaries Should Be Equal    ${dict1}    ${dict2}

Get Fare Rules
    ${isFlilistingPage}=      Run Keyword And Return Status    Page Should Contain Element    ${view_details_button}
    IF    ${isFlilistingPage}
        Click Button    ${view_details_button}
        Wait Until Element Is Visible    ${fare_rules_btn}    20s
        Click Element    ${fare_rules_btn}
    ELSE
        Execute Javascript  window.scroll(0,1000)
        Scroll Element Into View    ${fare_detail_btn_itinerary}
        Wait Until Element Is Visible    ${fare_detail_btn_itinerary}    20s
        Click Element    ${fare_detail_btn_itinerary}
    END
    ${is_no_rule}=  Run Keyword And Return Status    Wait Until Element Is Visible    ${no_rules}
    IF  ${is_no_rule}!=True
        Wait Until Element Is Visible    ${fare_rule_segment_info_element}  20s
        ${fare_rules_segment_info}  Get Text   ${fare_rule_segment_info_element}
        Execute Javascript    window.scrollBy(0, 100);
        Click Element    ${fare_rule_cancellation_fee_element}
        ${cancellation_fee}     Get Text     ${fare_rule_cancellation_fee}
        Scroll Element Into View    ${fare_rule_date_change_element}
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

Verify Fare Rules
    [Arguments]  ${dict1}  ${dict2}
    Dictionaries Should Be Equal    ${dict1}    ${dict2}

Click Book Button
    Execute Javascript  window.scroll(0,-50)
    Wait Until Element Is Visible    ${book_button}  40s
    Click Element    ${book_button}
    Handle Consent Message Popup

Close Fare And Click Book Button
    Execute Javascript  window.scroll(0,-50)
    Click Element    ${view_details_button}
    Execute Javascript  window.scroll(0,-50)
    Click Element    ${book_button}
    Handle Consent Message Popup
    Handle All Popups And Update Data

Get Baggage Information From Search Page
     Wait Until Element Is Visible    ${view_details_button}
     Click Button    ${view_details_button}
     Wait Until Element Is Visible    ${fare_rules_btn}    20s
     Click Element    ${baggage_information_btn}
     Wait Until Element Is Visible    ${baggage_data_div}
     ${baggage_data}    Create Dictionary
     ${data_row_count}=  SeleniumLibrary.Get Element Count    ${baggage_data_div}
     ${is_baggage_info}=    Run Keyword And Return Status    Element Should Contain    ${baggage_data_div}    Adult
     FOR    ${counter}    IN RANGE    1    ${data_row_count}+1
          ${baggage_info}=  Get Text    ${baggage_data_div}
          Set To Dictionary    ${baggage_data}      BaggageData${counter}=${baggage_info}
     END
     RETURN     ${baggage_data}  ${is_baggage_info}

Verify Baggage Information On Itinerary Page
    [Arguments]  ${baggage_dict_search_results}  ${is_baggage_info}
    ${baggage_info_search_result}=    Get From Dictionary    ${baggage_dict_search_results}    BaggageData1
    IF    ${is_baggage_info}
          ${bag_info_s_r}=   Split String    ${baggage_info_search_result}   \n
          ${checkin_weight}=    Get From List    ${bag_info_s_r}    1
          ${checkin_weight}=    Split String    ${checkin_weight}   :     1
          ${checkin_weight}=    Get From List    ${checkin_weight}    1
          ${bag_info_s_r}=   Split String    ${baggage_info_search_result}   \n
          ${cabin_weight}=    Get From List    ${bag_info_s_r}    2
          ${cabin_weight}=    Split String    ${cabin_weight}   :     1
          ${cabin_weight}=    Get From List    ${cabin_weight}    1
          Scroll Element Into View    ${baggage_info_itinerary}
          ${baggage_info_itinerary}=    Get Text    ${baggage_info_itinerary}
          ${bag_info_f_i}=   Split String    ${baggage_info_itinerary}   ,
          ${checkin_weight_2}=   Get From List    ${bag_info_f_i}    0
          ${checkin_weight_2}=    Split String    ${checkin_weight_2}   :
          ${checkin_weight_2}=    Get From List    ${checkin_weight_2}    1
          ${bag_info_f_i}=   Split String    ${baggage_info_itinerary}   ,
          ${cabin_weight_2}=    Get From List    ${bag_info_f_i}    1
          ${cabin_weight_2}=    Split String    ${cabin_weight_2}   :
          ${cabin_weight_2}=    Get From List    ${cabin_weight_2}    1
          Should Be Equal    ${checkin_weight}    ${checkin_weight_2}
          Should Be Equal    ${cabin_weight}    ${cabin_weight_2}
    ELSE
        Log To Console    No Baggage Information
    END

Get Flight Details Round Trip
    [Arguments]     ${flightNameLocator}    ${flightDepartureLocator}    ${flightDestinationLocator}    ${flight_duration_flight_type_locator}
    ${is_flilisting_page}=      Run Keyword And Return Status    Element Should Be Visible    ${view_details_button}
    IF    ${is_flilisting_page}
        Wait Until Page Contains Element    //input[@class='toggle__wrapper--checkbox']    timeout=20s
        Click Element    //input[@class='toggle__wrapper--checkbox']
        Sleep    30s
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
            ${length}    Get Length    ${split}
            IF    ${length}== 2
                ${temp1}=  Get From List    ${split}    0
                ${temp2}=   Get From List    ${split}    1
                ${flight_name}=  Catenate    ${temp1}${temp2}
            ELSE IF    ${length}< 2
                ${flight_name}=  Get From List    ${split}    0
#                ${temp2}=   Get From List    ${split}    0
#                ${flight_name}=  Catenate    ${temp1}${temp2}
            END
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
#        ${duration_type_detail}=  Catenate  ${duration_type_detail1}  ${duration_type_detail2}
        ${removeable_string}=  Split String    ${duration_type_detail1}  ,
        ${duration_type_detail}=  Get From List    ${removeable_string}    0
        ${duration_type_detail}=  Strip String    ${duration_type_detail}
        Set To Dictionary    ${flight_details}    FlightDurationFlightType${i}=${duration_type_detail}
        ${i}=   Evaluate   ${i}+1
    END
    RETURN  ${flight_details}

Verify Add Passengers Button
    Handle All Popups    ${False}  ${False}    ${False}    ${False}
    Wait Until Element Is Visible    //div[@class='apt-btmborder']    30s
    Execute Javascript    window.scrollTo(0, 1500);
    Wait Until Element Is Visible    ${add_passengers_button}  30s
    Click Element    ${add_passengers_button}
    Wait Until Page Contains Element    ${passenger_details_text}   10s
    Page Should Contain Element    ${passenger_details_text}

Add Fare Dictionary
    [Arguments]     ${fare_summary_1}   ${fare_summary_2}
    ${base_fare}    Evaluate    ${fare_summary_1.base_fare}+${fare_summary_2.base_fare}
    ${taxes}    Evaluate    ${fare_summary_1.taxes}+${fare_summary_2.taxes}
    ${total_fare_price}    Evaluate    ${fare_summary_1.total_fare_price}+${fare_summary_2.total_fare_price}
    ${is_fare_jump}     Set Variable    ${fare_summary_1.is_fare_jump}
    ${fare_summary}     Create Dictionary   base_fare=${base_fare}      taxes=${taxes}      total_fare_price=${total_fare_price}      is_fare_jump=${is_fare_jump}
    [Return]    ${fare_summary}

Get Baggage Information From Search Result | One Stop
     Wait Until Element Is Visible    ${view_details_button}
     Click Button    ${view_details_button}
     Click Element    ${view_details_button_right_section}
     Wait Until Element Is Visible    ${fare_rules_btn}    20s
     Click Element    (${baggage_information_btn})[1]
     Click Element    (${baggage_information_btn})[2]
     Wait Until Element Is Visible    ${baggage_data_div}
     ${baggage_data}    Create Dictionary
     ${data_row_count}=  SeleniumLibrary.Get Element Count    ${baggage_data_div}
     ${is_baggage_info}=    Run Keyword And Return Status    Element Should Contain    ${baggage_data_div}    Adult
     FOR    ${counter}    IN RANGE    1    ${data_row_count}+1
          ${baggage_info}=  Get Text    ${baggage_data_div}
          Set To Dictionary    ${baggage_data}      BaggageData${counter}=${baggage_info}
     END
     Click Button    ${view_details_button}
     RETURN     ${baggage_data}  ${is_baggage_info}

Verify Baggage Information | One Stop
    [Arguments]  ${baggage_dict_search_results}  ${is_baggage_info}
    Sleep    5
    ${baggage_info_search_result}=    Get From Dictionary    ${baggage_dict_search_results}    BaggageData1
    ${baggage_info_search_result2}=    Get From Dictionary    ${baggage_dict_search_results}    BaggageData2
    IF    ${is_baggage_info}
          ${bag_info_s_r}=   Split String    ${baggage_info_search_result}   \n
          ${checkin_weight}=    Get From List    ${bag_info_s_r}    1
          ${checkin_weight}=    Split String    ${checkin_weight}   :     1
          ${checkin_weight}=    Get From List    ${checkin_weight}    1
          ${bag_info_s_r}=   Split String    ${baggage_info_search_result}   \n
          ${cabin_weight}=    Get From List    ${bag_info_s_r}    2
          ${cabin_weight}=    Split String    ${cabin_weight}   :     1
          ${cabin_weight}=    Get From List    ${cabin_weight}    1
          ${baggage_info_itinerary1}=    Get Text    (${baggage_info_itinerary})[1]
          ${bag_info_f_i}=   Split String    ${baggage_info_itinerary1}   ,
          ${checkin_weight_2}=   Get From List    ${bag_info_f_i}    0
          ${checkin_weight_2}=    Split String    ${checkin_weight_2}   :
          ${checkin_weight_2}=    Get From List    ${checkin_weight_2}    1
          ${bag_info_f_i}=   Split String    ${baggage_info_itinerary1}   ,
          ${cabin_weight_2}=    Get From List    ${bag_info_f_i}    1
          ${cabin_weight_2}=    Split String    ${cabin_weight_2}   :
          ${cabin_weight_2}=    Get From List    ${cabin_weight_2}    1
          Should Be Equal    ${checkin_weight}    ${checkin_weight_2}
          Should Be Equal    ${cabin_weight}    ${cabin_weight_2}
    #    For Second info
          ${bag_info_s_r}=   Split String    ${baggage_info_search_result2}   \n
          ${checkin_weight}=    Get From List    ${bag_info_s_r}    1
          ${checkin_weight}=    Split String    ${checkin_weight}   :     1
          ${checkin_weight}=    Get From List    ${checkin_weight}    1
          ${bag_info_s_r}=   Split String    ${baggage_info_search_result}   \n
          ${cabin_weight}=    Get From List    ${bag_info_s_r}    2
          ${cabin_weight}=    Split String    ${cabin_weight}   :     1
          ${cabin_weight}=    Get From List    ${cabin_weight}    1
          ${baggage_info_itinerary2}=    Get Text    (${baggage_info_itinerary})[2]
          ${bag_info_f_i}=   Split String    ${baggage_info_itinerary2}   ,
          ${checkin_weight_2}=   Get From List    ${bag_info_f_i}    0
          ${checkin_weight_2}=    Split String    ${checkin_weight_2}   :
          ${checkin_weight_2}=    Get From List    ${checkin_weight_2}    1
          ${bag_info_f_i}=   Split String    ${baggage_info_itinerary2}   ,
          ${cabin_weight_2}=    Get From List    ${bag_info_f_i}    1
          ${cabin_weight_2}=    Split String    ${cabin_weight_2}   :
          ${cabin_weight_2}=    Get From List    ${cabin_weight_2}    1
          Should Be Equal    ${checkin_weight.lower()}    ${checkin_weight_2.lower()}
          Should Be Equal    ${cabin_weight.lower()}    ${cabin_weight_2.lower()}
    ELSE
        Log To Console    No Baggage Information
    END

Handle Fare Jump Popup
    [Arguments]    ${Fare_summary}
    IF    ${Fare_summary}
        ${old_total_amount}=    Get Text    ${old_fare_amount}
        ${old_total_amount}=    Extract Final Fare As String    ${old_total_amount}
        Should Be Equal As Numbers    ${old_total_amount}    ${Fare_summary.total_fare_price}
        # fare price updated
        ${new_total_amount}=    Get Text    ${new_fare_amount}
        ${new_total_amount}=    Extract Final Fare As String    ${new_total_amount}
        ${Fare_summary.total_fare_price}    Evaluate    ${new_total_amount}
        ${Fare_summary.is_fare_jump}    Set Variable    ${True}
    END
    Click Element    ${fare_jump_continue_btn}
    RETURN  ${Fare_summary}

Handle Fare Type Change Popup
    [Arguments]   ${flight_details}
    IF    ${flight_details}
        ${flight_duration_flight_type_element}   Get WebElements    ${flight_duration_flight_type_itinerary}
        ${i}=   Set Variable    1
        FOR    ${element}    IN    @{flight_duration_flight_type_element}
            ${duration_type_detail}  Get Text    ${element}
            ${split_string}=  Split String    ${duration_type_detail}   \n
            Log To Console    ${split_string}
            ${duration_type_detail1}=  Get From List    ${split_string}  0
            ${duration_type_detail2}=  Get From List    ${split_string}  1
#            ${duration_type_detail}=  Catenate  ${duration_type_detail1}  ${duration_type_detail2}
            ${removeable_string}=  Split String    ${duration_type_detail1}  ,
            ${duration_type_detail}=  Get From List    ${removeable_string}    0
            ${duration_type_detail}=  Strip String    ${duration_type_detail}
            Set To Dictionary    ${flight_details}    FlightDurationFlightType${i}=${duration_type_detail}
            ${i}=   Evaluate   ${i}+1
        END
    END
    Click Element    ${fare_jump_continue_btn}
    Sleep    5
    RETURN  ${flight_details}

Handle Sold Out Popup
    [Arguments]  ${button_number}
    Click Element    ${sold_out_back_to_search_btn}
    Wait Until Element Is Visible    ${cheapest_flight_filter}    timeout=180
    ${Fare_summary}    Verify Fare Details And Get Fare Summary    ${view_details_button}
    ${flight_details_from_search}    Get Flight Details    ${flight_Name_locator}  ${flight_departure_detail}   ${flight_destination_detail}    ${flight_duration_flight_type_search_result}
    Execute Javascript   window.scroll(0,-50)
    ${next_book_button}=  Replace String    ${book_button}    1    ${button_number}
    Click Element    ${next_book_button}
    Handle Consent Message Popup
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${amount_to_pay}    timeout=30
    RETURN  ${flight_details_from_search}  ${Fare_summary}

Handle All Popups And Update Data
    [Arguments]  ${flight_details}=False  ${Fare_summary}=False
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${amount_to_pay}    timeout=20
    ${is_fare_jump}    Run Keyword And Return Status    Element Should Be Visible    ${fare_jump_popup_new}
    Capture Page Screenshot
    ${is_fare_type_change}    Run Keyword And Return Status    Element Should Be Visible    ${fare_type_change_popup}
    ${is_sold_out}    Run Keyword And Return Status    Element Should Be Visible    ${sold_out_popup}
    ${is_fare_changed_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_fare_have_changed_baggage}
    IF    ${is_fare_type_change}
        ${flight_details}  Handle Fare Type Change Popup    ${flight_details}
    ELSE IF   ${is_fare_jump}
        ${Fare_summary}  Handle Fare Jump Popup  ${Fare_summary}
    ELSE IF   ${is_sold_out}
        ${flight_details}  ${Fare_summary}   Handle Sold Out Popup    1
    ELSE IF    ${is_fare_changed_baggage}
        Click Element    ${continue_btn_fare}
    END
    Handle Consent Message Popup
    RETURN  ${flight_details}  ${Fare_summary}

Update Agent MarkUp On Search Page For First Flight
    [Arguments]    ${amount}
#    ${amount}=    Convert To Number    ${amount}
    ${current_amount}    Get Text    ${fare_prices}
    ${num_current_amount}    Extract Final Fare As String    ${current_amount}
    ${expected_amount}       Evaluate    ${num_current_amount}+${amount}
    ${num_current_amount}=    Convert To Number   ${num_current_amount}
    Click Element    ${fare_prices}
    Input Text    ${markup_price_field}    ${amount}
    Click Element    ${markup_update_btn}
    ${updated_amount}   Get Text    ${fare_prices}
    ${num_updated_amount}    Extract Final Fare As String    ${updated_amount}
    ${num_current_amount}=     Evaluate   ${num_current_amount}+${amount}
    Should Be Equal As Strings    ${num_current_amount}    ${expected_amount}
    ${markup_price_details}=     Create Dictionary    markup=${amount}    total_amount_to_pay=${num_current_amount}
    RETURN    ${markup_price_details}

Get Layover Details
    ${is_search_result_page}  Run Keyword And Return Status    Element Should Be Visible    ${cheapest_flight_filter}
    IF    ${is_search_result_page}
        Execute Javascript  window.scrollTo(0,-50)
        Click Element    ${view_details_button}
    END
    ${layover_list}  Create List
    ${layover_elements}  Get WebElements    ${layover_text}
    FOR    ${layover_element}    IN    @{layover_elements}
        ${layover_value}  Get Text    ${layover_element}
        Append To List    ${layover_list}  ${layover_value}
    END
    IF    ${is_search_result_page}
        Execute Javascript  window.scrollTo(0,-50)
        Click Element    ${book_button}
        Handle Consent Message Popup
        Wait Until Element Is Visible    ${flight_duration_flight_type_itinerary}
    END
    RETURN  ${layover_list}

Verify Layover And Flight Details
    [Arguments]    ${layover_details}  ${flight_details_from_search}    ${flight_details_from_itinerary}
    ${layover_details_from_itinerary}  Get Layover Details
    Lists Should Be Equal    ${layover_details}    ${layover_details_from_itinerary}
    Verify Flight Details    ${flight_details_from_search}    ${flight_details_from_itinerary}

Select Multiple Stop Filter
    Wait Until Element Is Visible     ${multiple_stop_filter}
    Click Element   ${multiple_stop_filter}

Get Available Tj Cash
    Wait Until Element Is Visible    ${available_tj_cash}
    ${available_cash}  Get Text    ${available_tj_cash}
    ${available_cash}=    Replace String    ${available_cash}    ,    ${EMPTY}
    RETURN  ${available_cash}

Enter Tj Cash And Click On Redeem
    Wait Until Element Is Visible    ${amount_to_pay}  timeout=30
    ${total_fare}=  Get Text    ${amount_to_pay}
    Wait Until Element Is Visible    ${tj_cash_field}
    ${available_cash}  Get Available Tj Cash
    ${cash_to_enter}  Evaluate    100
    #    ${cash_to_enter}=  Convert To Round Off Number    ${cash_to_enter}
    Input Text    ${tj_cash_field}    ${cash_to_enter}
    Click Element    ${redeem_button}
    RETURN  ${total_fare}  ${cash_to_enter}

Verify Tj Cash And Total Fare After Tj Cash Is Redeemed
    [Arguments]  ${total_fare}  ${cash_to_enter}
    Wait Until Element Is Visible    ${tj_cash_summary}
    ${tj_cash_visible}  Get Text    ${tj_cash_summary}
    ${tj_cash_visible}  extract_final_fare_as_string  ${tj_cash_visible}
    ${tj_cash_visible}  Evaluate    abs(${tj_cash_visible})
    Should Be Equal As Numbers    ${tj_cash_visible}    ${cash_to_enter}
    ${total_fare}  extract_final_fare_as_string  ${total_fare}
    ${expected_total_fare}  Evaluate    ${total_fare}-${tj_cash_visible}
    ${visible_total_fare}  Get Text    ${amount_to_pay}
    ${visible_total_fare}  extract_final_fare_as_string  ${visible_total_fare}
    Should Be Equal As Numbers    ${expected_total_fare}    ${visible_total_fare}

Verify Session Expires
    ${session_expire_time}    Get Text    ${ele_session_expire_time}
    Log To Console    ${session_expire_time}
    ${time_array}    Split String    ${session_expire_time}
    Log To Console    ${time_array}
    ${ExMin}    Get From List   ${time_array}    0
    ${ExSec}    Get From List    ${time_array}    3
    Sleep    ${ExMin}min ${ExSec}sec
    Sleep    2s
    Element Should Be Visible    ${ele_session_expired_popup}
    Element Should Be Visible    ${back_to_flight_list_button}
    Element Should Be Visible    ${session_expired_continue_button}

Verify Session Expire Time
    Wait Until Element Is Visible    ${ele_session_expire_time}   20s
    Sleep    2s
    Page Should Contain    Your Session will expire in

Verify Back to Flight List Button
    Wait Until Element Is Visible    ${back_to_flight_list_button}
    Click Element    ${back_to_flight_list_button}
    Wait Until Element Is Visible    ${book_button}    timeout=30

Verify Continue Button On Session Expire Popup
    Wait Until Element Is Visible    ${session_expired_continue_button}
    ${location_before}  Get Location
    Click Element    ${session_expired_continue_button}
    Wait Until Page Contains    Flight Details
    ${location_after}  Get Location
    Should Be Equal    {location_before}    ${location_after}

Handle All Popups And Update Data | Round Trip
    [Arguments]  ${flight_details}=False  ${Fare_summary}=False
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${amount_to_pay}    timeout=30
    ${is_fare_jump}    Run Keyword And Return Status    Element Should Be Visible    ${fare_jump_popup_new}
    Capture Page Screenshot
    ${is_fare_type_change}    Run Keyword And Return Status    Element Should Be Visible    ${fare_type_change_popup}
    ${is_sold_out}    Run Keyword And Return Status    Element Should Be Visible    ${sold_out_popup}
    ${is_fare_changed_baggage}    Run Keyword And Return Status    Element Should Be Visible    ${is_fare_have_changed_baggage}
    IF    ${is_fare_type_change}
        ${flight_details}  Handle Fare Type Change Popup    ${flight_details}
    ELSE IF   ${is_fare_jump}
        ${Fare_summary}  Handle Fare Jump Popup  ${Fare_summary}
    ELSE IF   ${is_sold_out}
        ${flight_details}  ${Fare_summary}   Handle Sold Out Popup | Round Trip  1
    ELSE IF    ${is_fare_changed_baggage}
        Click Element    ${continue_btn_fare}
    END
    RETURN  ${flight_details}  ${Fare_summary}  # Return updated values

Handle Sold Out Popup | Round Trip
    [Arguments]  ${button_number}
    Click Element    ${sold_out_back_to_search_btn}
    Wait Until Element Is Visible    ${cheapest_flight_filter}    timeout=180
    #    user round trip get fare summary keyword here
    ${flight_details_from_search}    Get Flight Details Round Trip    ${flight_Name_locator}  ${flight_departure_detail}   ${flight_destination_detail}    ${flight_duration_flight_type_search_result}
    Execute Javascript   window.scroll(0,-50)
    ${next_book_button}=  Replace String    ${book_button}    1    ${button_number}
    Click Element    ${next_book_button}
    Handle Consent Message Popup
    RETURN  ${flight_details_from_search}
