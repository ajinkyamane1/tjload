*** Settings ***
Library    SeleniumLibrary
#Library    CustomLibrary.py
Library    Collections
Library    BuiltIn
Library    String
Library    ../../CustomKeywords/user_keywords.py
Variables    ../../PageObjects/Booking/booking_summary_locators.py
Variables    ../../PageObjects/FlightItinerary/flight_itinerary_locators.py
Variables    ../../PageObjects/SeatMapWindow/seat_map_window_locators.py
Resource    ../../Commonkeywords/Review/review_keywords.robot
Resource    ../../Commonkeywords/SeatMapWindow/seat_map_window_keywords.robot
Variables    ../../PageObjects/SearchPageFilter/search_page_filter_locators.py
Variables    ../../PageObjects/AirlineIntegration/airline_integration_locators.py


*** Variables ***



*** Keywords ***
Click On Book Button with Cancellation Charge Applied
    ${total_flights}=    Get Element Count    ${total_availed_flights}
    FOR    ${i}    IN RANGE    ${total_flights}
        ${i}=    Evaluate    ${i}+1
        ${i}=    Convert To String    ${i}
        ${view_detail}=    Replace String    ${view_detail_button}   index     ${i}
        Wait Until Element Is Visible    ${view_detail}
        Scroll Element Into View    ${view_detail}
        Execute Javascript    window.scrollBy(0,200);
        Run Keyword And Ignore Error    Scroll Element Into View    ${view_detail}
        Click Element    ${view_detail}
        ${status}=    Click On Fare Rules from view details section and Return Status    ${i}
        IF    '${status}' == 'True'
            ${book}=    Replace String    ${book_button_index}    index         ${i}
            Wait Until Element Is Visible    ${book}
            Scroll Element Into View    ${book}
            Execute Javascript    window.scrollBy(0,-100);
            Scroll Element Into View    ${book_button}
            Capture Page Screenshot
            Click Element    ${book}
            Handle All Popupss    ${False}    ${False}    ${False}    ${False}
            BREAK
        ELSE
            Log    No Fare Rule Found
        END   
    END
    
Click On Fare Rules from view details section and Return Status
    [Arguments]    ${j}
    Wait Until Element Is Visible    ${fare_rules_tab}
    Click Element    ${fare_rules_tab}
#    ${status}=    Set Variable   
    Sleep    3s
    Capture Page Screenshot    
    ${total_fare}=    Replace String    ${total_fare_in_single_trip}    tripindex    ${j}
    ${total_fares}=    Get Element Count    ${total_fare}
    FOR    ${i}    IN RANGE    ${total_fares}
        ${i}=    Evaluate    ${i}+1
        ${i}=    Convert To String    ${i}
#        ${status}=    Set Variable    False
        ${select_radio}    Replace String    ${select_radio_label}    tripindex    ${j}
        ${select_radio_button}    Replace String    ${select_radio}    index     ${i}
        Execute Javascript    window.scrollBy(0, -150); 
        Run Keyword And Ignore Error    Scroll Element Into View      ${select_radio_button}
        Wait Until Element Is Visible    ${select_radio_button}    10s
        Click Element    ${select_radio_button}
        Execute Javascript    window.scrollBy(0, 150);
        Run Keyword And Ignore Error    Scroll Element Into View      ${date_change_fee_tab}
        Capture Page Screenshot
#        Click Element    ${date_change_fee_tab}
        ${flag_for_fare}=    Run Keyword And Return Status    Element Should Be Visible        ${date_change_fee_tab}
        IF    '${flag_for_fare}' == 'True'
            Wait Until Element Is Visible    ${date_change_fee_tab}    10s
            Click Element    ${date_change_fee_tab}
            Sleep    2s
            Capture Page Screenshot
            ${flag}=    Run Keyword And Return Status    Element Should Be Visible    ${date_change_fee_locator}
            IF    '${flag}' == 'True'
                ${cancel_text}=    Get Text    ${date_change_fee_locator}
                Log    ${cancel_text}
                ${status}=    Run Keyword And Return Status    Is Real Number    ${cancel_text}
                Set Test Variable    ${status}
                IF    '${status}' == 'True'
                    RETURN    ${status}
                    BREAK
                END
            END
        END
    END

Handle All Popupss
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
          Handle Sold Out Popup From Flight Itinerary Airline Integration
      END
    ELSE IF    ${is_fare_changed_baggage}
        Click Element    ${continue_btn_fare}
    END
    Log    ${flight_details}
    RETURN  ${flight_details}  ${Fare_summary}    ${layover_details}

Handle Sold Out Popup From Flight Itinerary Airline Integration
    Click Element    ${sold_out_back_to_search_btn}
    Wait Until Element Is Visible    ${cheapest_flight_filter}    timeout=180
    Check Flights Are Available On Search Page
    Click On Book Button with Cancellation Charge Applied
    
Validate The Baggage price With Fare Summary Price
    [Arguments]    ${total_baggage}       
    Sleep    5
    Execute Javascript    window.scrollBy(0, -document.body.scrollHeight);
    Sleep    5
    ${baggage_meal_fare_visible}    Run Keyword And Return Status    Click Element    ${baggage_meal_fare}
    ${baggage_is_present}    Run Keyword And Return Status    Page Should Contain Element    (//label[text()="Baggage Information"])[1] 
    IF    ${baggage_is_present}
        Wait Until Element Is Visible    ${baggage_fare_price}    timeout=10
        ${fare_baggege}    Get Text    ${baggage_fare_price}
        ${fare_baggege}    Extract Final Fare As String    ${fare_baggege}
        Should Be Equal As Numbers    ${fare_baggege}    ${total_baggage}
        Sleep    10s
    END
    RETURN    ${baggage_is_present}

Validate The Meal Price With Fare Summary Price
   [Arguments]    ${total_meal}
   Sleep    5
   Execute Javascript    window.scrollBy(0, -document.body.scrollHeight);
   Sleep    5
   ${baggage_meal_fare_visible}    Run Keyword And Return Status    Click Element    ${baggage_meal_fare}
   IF    ${baggage_meal_fare_visible}
       ${meal_fare_price_status}    Run Keyword And Return Status    Page Should Contain Element    ${meal_fare_price}
       IF    ${meal_fare_price_status}
           ${fare_meal}    Get Text    ${meal_fare_price}
           ${fare_meal}    Extract Final Fare As String    ${fare_meal}
           Should Be Equal As Numbers    ${fare_meal}    ${total_meal}
           ${calculated_total_baggage_meal_fare}    Set Variable    ${fare_meal}
       END
           Log    ${calculated_total_baggage_meal_fare}
           ${total_baggage_meal_fare}    Get Text    //span[text()='Meal, Baggage & Seat']/parent::div//i/following-sibling::span[@class='pull-right fareSummary-prices-positionHandle']
           ${total_baggage_meal_fare}    Extract Final Fare As String    ${total_baggage_meal_fare}
           Should Be Equal As Numbers    ${total_baggage_meal_fare}    ${calculated_total_baggage_meal_fare}
       ELSE
           ${fare_meal}    Get Text    (//div[@class='tax-dropdown airline-gst-print']//child::span[@class='pull-right fareSummary-prices-positionHandle'])[1]
           ${fare_meal}    Extract Final Fare As String    ${fare_meal}
           Should Be Equal As Numbers    ${fare_meal}    ${total_meal}
           ${total_baggage_meal_fare}    Get Text    //span[text()='Meal, Baggage & Seat']/parent::div//i/following-sibling::span[@class='pull-right fareSummary-prices-positionHandle']
           ${total_baggage_meal_fare}    Extract Final Fare As String    ${total_baggage_meal_fare}
           Should Be Equal As Numbers    ${total_baggage_meal_fare}    ${fare_meal}
       END
   END

Append Id To Excel Sheet
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    append_booking_id_to_excel    ${my_dict.file_name}     ${my_dict.From}    ${my_dict.TO}    ${my_dict.NoOfAdults}    ${my_dict.NoOfChildren}    ${my_dict.NoOfInfant}    ${booking_id}    ${my_dict.SelectFareType}

Search Flight According to TestData
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    IF    '${my_dict.TO1}' != 'Null'
        Search Flight | Multicity    ${search_data}
    ELSE IF    '${my_dict.ReturnDate}' != 'Null'
        Search Flights For Round-Trip    ${search_data}
    ELSE IF    '${my_dict.DepartureDate}' != 'Null'
        Search One Way Flights    ${search_data}
    END
