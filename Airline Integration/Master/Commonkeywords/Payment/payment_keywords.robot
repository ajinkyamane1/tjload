*** Settings ***
Library    SeleniumLibrary
Library     String
Library    XML
Library    Collections
Library  DateTime
Variables  ../../../Environment/environments.py
Variables   ../../PageObjects/PaxDetails/pax_details_locators.py
Variables   ../../PageObjects/SearchFlights/search_page_locators.py
Variables   ../../PageObjects/Payment/payment_locators.py
Variables    ../../PageObjects/Booking/booking_summary_locators.py
Resource    ../../Commonkeywords/PaxDetails/pax_details_keywords.robot
Library    ../../Commonkeywords/CustomKeywords/user_keywords.py



*** Variables ***
${first_name_temp}=     Gorakh
${last_name_temp} =     Sawant
${mobile_number_temp}=      9309824107
${email_id}=    gorakh.sawant@gmail.com


*** Keywords ***
Handle Popup
   Wait Until Element Is Visible    ${add_passengers_btn}  30s
   ${is_popupVisible}    Run Keyword And Return Status    Element Should Be Visible    ${fare_jump_popup}
   IF    ${is_popupVisible}
       Click Button    ${fare_jump_continue_btn}
   END


Get Total Amount Payment Page
    ${base_total_price}    Get Text    ${payments_total_amount}
    ${remove_rupees_sign}    Replace String    ${base_total_price}    ₹    ${EMPTY}
    ${payment_final_total_amount}    Replace String    ${remove_rupees_sign}    ,    ${EMPTY}
    [Return]    ${payment_final_total_amount}


Verify Pay Now Amount On Pay Now Button
    Wait Until Element Is Visible    ${pay_now_button}    timeout=60s
    ${pay_now_btn_amount}=     Get Text    ${pay_now_button}
    ${remove_rupees_sign}    Replace String    ${pay_now_btn_amount}    ₹    ${EMPTY}
    ${pay_now_final_total_amount}    Replace String    ${remove_rupees_sign}    ,    ${EMPTY}
    ${pay_now_without_text}=    Replace String    ${pay_now_final_total_amount}    Pay Now     ${EMPTY}
    ${final_pay_now}=    Strip String    ${pay_now_without_text}
    ${payment_final_total_amount}=      Get Total Amount Payment Page
    Should Be Equal As Strings    ${final_pay_now}      ${payment_final_total_amount}
    [Return]    ${payment_final_total_amount}


Verify Terms And Conditions Check Box On Payment Page
    wait until element is visible   ${pay_now_checkbox}     timeout=60s
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Click Element    ${pay_now_checkbox}
    Wait Until Element Is Enabled    ${pay_now_checkbox}    timeout=30s


Verify Pay Now Amount On Confirm Pop Up Box
    ${confirm_box_amt_value}=   Get Text    ${confirm_box_amt}
    ${remove_rupees_sign}    Replace String    ${confirm_box_amt_value}    ₹    ${EMPTY}
    ${confirm_box_final_total_amount}    Replace String    ${remove_rupees_sign}    ,    ${EMPTY}
    ${payment_final_total_amount}=  Get Total Amount Payment Page
    Should Be Equal As Strings    ${confirm_box_final_total_amount}    ${payment_final_total_amount}


Click Pay Now Button
    Wait Until Element Is Visible    ${pay_now_button}    20s
    Click Button    ${pay_now_button}
    Wait Until Element Is Visible    ${continue_button}
    Wait Until Page Contains    Confirm Transaction
    Page Should Contain    Confirm Transaction


Click Back Button On Payment Page
    Click Button    ${confirm_trans_back_btn}
    Wait Until Element Is Visible    ${pay_now_button}
    Element Should Be Visible    ${pay_now_button}


Click Continue Button To View Booking Status
    Wait Until Element Is Visible    ${continue_button}    timeout=30s
    Click Button    ${continue_button}
    Sleep    20s
    Success TJ Popup Handle
    Capture Page Screenshot
#    Wait Until Element Is Visible    ${reference_id}    timeout=40s
#    ${reference_id_value}=  Get Text    ${reference_id}
    Wait Until Element Is Visible    ${booking_status_confirmation_page}    timeout=60s
    ${booking_status}=  Get Text    ${booking_status_confirmation_page}
    ${booking_id}=     Get Text    ${booking_status_id}
    ${booking_id}=    extract_booking_id     ${booking_id}
    Set Test Variable    ${booking_id}
    Log    ${booking_id}
    Log To Console    ${booking_id}
    RETURN    ${booking_status}


Click Back Button For Duplicate Booking
    Click Button    ${continue_button}
    Success TJ Popup Handle
    Wait Until Element Is Visible    ${reference_id}
    ${reference_id_value}=  Get Text    ${reference_id}
    IF    "${booking_status}"=="Success"
        Wait Until Element Is Visible    ${duplicate_booking_back_to_search_btn}    timeout=30s
        Click Button    ${duplicate_booking_back_to_search_btn}
    END


#The keyword is commented as it is taken for session expire time test case
#Check Session Expire Time
#    Wait Until Element Is Visible    ${ele_session_expire_time}   20s
#    Sleep    2s
#    Page Should Contain    Your Session will expire in


#The keyword is commented as it is taken for session expire time test case
#Check After Session Expires
#    ${session_expire_time}    Get Text    ${ele_session_expire_time}
#    Log To Console    ${session_expire_time}
#    ${time_array}    Split String    ${session_expire_time}
#    Log To Console    ${time_array}
#    ${ExMin}    Get From List   ${time_array}    0
#    ${ExSec}    Get From List    ${time_array}    3
#    Sleep    ${ExMin}min ${ExSec}sec
#    Sleep    2s
#    Element Should Be Visible    ${ele_session_expired_popup}
#    Element Should Be Visible    ${btn_back_to_flight_list}
#    Element Should Be Visible    ${btn_session_expired_continue}


#The keyword is commented as it is taken for session expire time test case
#Click Continue to Payment Page
#    ${location}   Get Location
#    Click Button    ${btn_session_expired_continue}
#    Sleep    5s
#    Location Should Be    ${location}


Click Back Button To Review Page
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Wait Until Element Is Visible    ${back_to_review_button}   timeout=50s
    Click Element    ${back_to_review_button}


Add Passenger For Duplicate Booking
    Execute Javascript     window.scrollBy(0, 800);
    Handle All Popups And Update Data
    ${is_fare_changed}    Run Keyword And Return Status    Page Should Contain    Fare have changed
    IF    ${is_fare_changed}
        Click Element    ${fare_have_changed_continue_button}
        Sleep    3
    END
    Handle Consent Message Popup
    Handle All Popups And Update Data
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Wait Until Element Is Visible    ${add_passengers_btn}     timeout=40s
    Click Element       ${add_passengers_btn}
    Wait Until Element Is Visible    ${cust_title}    timeout=40s
    Click Element    ${cust_title}
    Sleep    1s
    Input Text    ${cust_first_name}    ${first_name_temp}
    Sleep    1s
    Input Text    ${cust_last_name}    ${last_name_temp}
    Sleep    1s
    ${adult_dob}   Generate Adult Birth Date
    ${dob}=  Run Keyword And Return Status     Page Should Contain Element    (${adult_dob_field})[1]
    Run Keyword If     ${dob}   Input Text    (${adult_dob_field})[1]    ${adult_dob}
    Scroll Element Into View    //h5[@class='paxheading-contact']
    Click Element    ${radio_skip}
    Sleep    1s
    Input Text    ${cust_mobile_num}    ${mobile_number_temp}
    Enter Passenger Destination Address If Available
    Sleep    1s
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Click Button    ${proceed_to_review_button}
    Sleep    10s


Verify Navigate To Review Page
    Click proceed to Review button
    Wait Until Element Is Visible    ${review_page_title}     timeout=60s

Payment From Deposit
    Wait Until Element Is Visible    ${deposit_link}    timeout=30s
    Click Element    ${deposit_link}
    Click Element    ${accept_terms_checkbox}
    Wait Until Element Is Enabled    ${pay_now_button}
    Click Button    ${pay_now_button}
    Wait Until Element Is Visible    ${continue_button}
    Click Element    ${continue_button}
    Success TJ Popup Handle
    Wait Until Page Contains Element    ${booking_status}    timeout=120

