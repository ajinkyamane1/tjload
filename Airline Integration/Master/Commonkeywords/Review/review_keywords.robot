*** Settings ***
Library    SeleniumLibrary
Library    XML
Library    Collections
Variables    ../../PageObjects/Review/review_locaters.py
Variables    ../../PageObjects/PaxDetails/pax_details_locators.py
Resource    ../FlightItinerary/flight_itinerary_keywords.robot
Resource    ../PaxDetails/pax_details_keywords.robot
Library     ../CustomKeywords/user_keywords.py


*** Keywords ***
Verify Flight Details For One Way Flight
    [Arguments]    ${flight_detail_itinerary_page}    ${fare_prices}
    Wait Until Element Is Visible    ${review_page_title}   timeout=60
    Page Should Contain Element    ${review_page_title}
    ${element_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${down_arrow}
    Run Keyword If   '${element_visible}' == 'True'    Click Element   ${down_arrow}
    ${flight_detail_review_page}    Get Flight Details     ${flight_name_itinerary}  ${departure_itinerary}   ${destination_itinerary}    ${flight_duration_flight_type_review}
    Verify Flight Details    ${flight_detail_review_page}    ${flight_detail_itinerary_page}
    Verify Fare Summary    ${fare_prices}


Verify Flight Details For Round Flight On Review Page
    [Arguments]    ${flight_detail_itinerary_page}
    Wait Until Page Contains Element    ${review_page_title}   timeout=60
    Page Should Contain Element    ${review_page_title}
    ${element_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${down_arrow}
    Run Keyword If   '${element_visible}' == 'True'    Click Element   ${down_arrow}
    ${flight_detail_review_page}    Get Flight Details     ${flight_name_itinerary}  ${departure_itinerary}   ${destination_itinerary}    ${flight_duration_flight_type_review}
    Verify Flight Details    ${flight_detail_review_page}    ${flight_detail_itinerary_page}


Verify Passenger Details And Contact Details On Review Page
   [Arguments]        ${passenger_list}    ${Contact_details}
   ${passenger_names}    Get Webelements    ${passenger_name}
   ${review_passenger_list}    Create List
   FOR    ${current_passenger_name}  IN   @{passenger_names}
       ${passenger_text}    Get Text    ${current_passenger_name}
       ${passenger_text}   Remove Newline        ${passenger_text}
       Append To List    ${review_passenger_list}    ${passenger_text}
   END
   ${passenger_list_updated}    Create List
   ${review_passenger_list_updated}    Create List
   FOR    ${item}    IN    @{passenger_list}
       Append To List    ${passenger_list_updated}    ${item.upper()}
   END
   FOR    ${item}    IN    @{review_passenger_list}
       Append To List    ${review_passenger_list_updated}    ${item.upper()}
   END
   Log    ${passenger_list_updated}
   Log    ${review_passenger_list_updated}
#    ${passenger_list}    Convert To Upper Case    ${passenger_list}
#   Lists Should Be Equal    ${passenger_list_updated}    ${review_passenger_list_updated}
   Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
   ${passenger_contact_email_text}    Get Text    ${passenger_contact_email}
   ${passenger_contact_mobile_text}   Get Text    ${passenger_contact_mobile}
#   Should Contain    ${passenger_contact_email_text}    ${Contact_details.email}
#   Should Contain    ${passenger_contact_mobile_text}   ${Contact_details.mobile}
   RETURN    ${review_passenger_list}    ${Contact_details}


Verify Updated Markup On Review Page
    [Arguments]    ${markup_price_details}
    Wait Until Page Contains Element    ${edit_taxes_btn}    timeout=10
    ${total_amount}=    Get Text    ${amount_to_pay}
    ${total_amount}=    Extract Final Fare As String    ${total_amount}
    Click Element    ${edit_taxes_btn}
#    ${markup}=    Convert To Number    ${markup_price_details}
    Input Text    ${markup_price_field}    ${markup_price_details}
    ${updated_total_amount}=    Evaluate    ${markup_price_details}+${total_amount}
    Click Element    ${markup_update_btn}
    Sleep    1
    ${new_total_amount}=    Get Text    ${amount_to_pay}
    ${new_total_amount}=    Extract Final Fare As String    ${new_total_amount}
    Should Be Equal As Numbers    ${new_total_amount}    ${updated_total_amount}


Click Round Trip Book Button
    Wait Until Page Contains Element    ${roundtrip_button}
    Click Element    ${roundtrip_button}


Verify GST Details On Review Page
    [Arguments]     ${gst_details}
    IF    "${gst_details}"=="False"
        Wait Until Page Contains Element    ${review_page_title}   timeout=60
        Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
        ${current_gst_number}=    Get Text    ${gst_number}
        ${current_gst_company_name}=    Get Text    ${gst_company_name}
        ${name}=    Remove String    ${gst_details.name}    \n
        ${name}=    Remove Space From First Char    ${name}
        ${current_gst_company_name}    Remove Space From First Char    ${current_gst_company_name}
        Should Be Equal As Strings    ${current_gst_number}    ${gst_details.gst_no}
        Should Be Equal As Strings    ${current_gst_company_name}    ${name}
    END


Verify Back Button On Review Page Is Clickable And Redirectes To Pax Details Page
    Click Proceed To Review Button
    Wait Until Element Is Visible    ${review_page_title}     timeout=60s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Wait Until Page Contains Element    ${back_btn}
    Click Element    ${back_btn}
    Execute Javascript  window.scroll(300,0)
    Wait Until Page Contains Element    ${gst_no}    timeout=10
    Page Should Contain Element    ${gst_no}
    Execute JavaScript  window.scrollTo(0, 0);
    Wait Until Page Contains Element    ${pax_detail_title}
    Page Should Contain Element    ${pax_detail_title}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Enter Contact Details
    Click Proceed To Review Button
    Wait Until Element Is Visible    ${review_page_title}     timeout=60s
    Proceed To Pay


Proceed To Pay
    ${loop_count}=    Set Variable    0
    Execute JavaScript    window.scrollBy(0, document.body.scrollHeight)
    Wait Until Page Contains Element    ${proceed_to_pay_button}    timeout=20
    Run Keyword And Ignore Error    Scroll Element Into View    ${proceed_to_pay_button}
    Execute JavaScript    window.scrollBy(0, document.body.scrollHeight)
    Wait Until Element Is Visible    ${proceed_to_pay_button}    10s
    Click Element    ${proceed_to_pay_button}
    ${status}    Run Keyword And Return Status    Wait Until Page Contains Element    ${paynow_btn}
    WHILE    "${status}" == "False" and ${loop_count} < 5
        Execute JavaScript    window.scrollBy(0, 200)
        Sleep    5s
        Run Keyword And Ignore Error    Scroll Element Into View    //h3[text()="How can we help you?"]
        Run Keyword And Ignore Error    Click Element    ${proceed_to_pay_button}
        ${status}    Run Keyword And Return Status    Wait Until Page Contains Element    ${paynow_btn}
        ${loop_count}=    Evaluate    ${loop_count} + 1    # Increment loop counter
    END


Verify Proceed To Pay Button Is Clickable And User Gets Redirecte/d To Payment Page
    Wait Until Page Contains Element    ${payment_page_title}  timeout=30
    Page Should Contain Element    ${payment_page_title}
    Wait Until Page Contains Element    ${paynow_btn}    timeout=20
    Page Should Contain Element    ${paynow_btn}


Click On I Accept CheckBox
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Wait Until Page Contains Element    ${i_accept_checkbox}    timeout=10
    Click Element    ${i_accept_checkbox}


Block Flight
    ${block_btn_status}    Run Keyword And Return Status    Page Should Contain Element    ${block_btn}
    IF    ${block_btn_status}
        Click On I Accept CheckBox
        Click Element    ${block_btn}
    END
    RETURN    ${block_btn_status}

Verify Flight Hold Page
    [Arguments]    ${block_btn_status}
    IF    "${block_btn_status}"== "True"
       Wait Until Page Contains Element    ${booking_status}  timeout=30
    END


Click On Terms And Conditions Link
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Sleep    2
    ${terms_and_conditions_link_status}    Run Keyword And Return Status    Page Should Contain Element    ${terms_and_conditions_link}
    IF    ${terms_and_conditions_link_status}
        Wait Until Page Contains Element    ${terms_and_conditions_link}   timeout=10
        Scroll Element Into View    ${terms_and_conditions_link}
        Click Element    ${terms_and_conditions_link}
        switch window   locator=NEW
        ${url}=    Get Location
        Log To Console    ${url}
    END


Get Baggage Information From Search Result to verify on review
    Wait Until Element Is Visible    ${view_details_button}
    Click Button    ${view_details_button}
    ${status}=  Run Keyword And Return Status    ${view_details_button_right_section}
    IF    ${status}
        Click Element    ${view_details_button_right_section}
    END
    Wait Until Element Is Visible    ${fare_rules_btn}    20s
    Click Element    (${baggage_information_btn})[1]
    IF    ${status}
        Click Element    (${baggage_information_btn})[2]
    END
    Wait Until Element Is Visible    ${baggage_data_div}
    ${baggage_data}    Create Dictionary
    ${data_row_count}=  SeleniumLibrary.Get Element Count    ${baggage_data_div}
    ${is_baggage_info}=    Run Keyword And Return Status    Element Should Contain    ${baggage_data_div}    Adult
    FOR    ${counter}    IN RANGE    1    ${data_row_count}+1
        ${baggage_info}=  Get Text    ${baggage_data_div}
        Set To Dictionary    ${baggage_data}      BaggageData${counter}=${baggage_info}
    END
    Execute Javascript  window.scroll(0,-50)
    Click Button    ${view_details_button}
    RETURN     ${baggage_data}  ${is_baggage_info}


Proceed To Pay GDS
    Execute JavaScript    window.scrollBy(0, document.body.scrollHeight);
    Wait Until Page Contains Element    ${proceed_to_pay_button}    timeout=10
    Run Keyword And Ignore Error    Scroll Element Into View    //div[@class='footer__mainWrap']
    Click Element    ${proceed_to_pay_button}
    Wait Until Page Contains Element    ${paynow_btn}    timeout=30

Verify Baggage Information | review page
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
          ${cabin_weight}=    Get From List    ${bag_info_s_r}    1
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
          Should Be Equal    ${checkin_weight}    ${checkin_weight_2}
          Should Be Equal    ${cabin_weight}    ${cabin_weight_2}
    ELSE
        Log To Console    No Baggage Information
    END
