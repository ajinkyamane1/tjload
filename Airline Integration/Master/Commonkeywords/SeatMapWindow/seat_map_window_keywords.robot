*** Settings ***
Library    SeleniumLibrary
Library    ../../Commonkeywords/CustomKeywords/user_keywords.py
Library    String
Library    Collections
Variables  ../../../Environment/environments.py
Variables    ../../PageObjects/SearchFlights/search_page_locators.py
Variables    ../../PageObjects/SearchResults/search_results_locators.py
Variables    ../../PageObjects/SeatMapWindow/seat_map_window_locators.py
Resource    ../SearchFlights/search_flights_keywords.robot
Resource    ../FlightItinerary/flight_itinerary_keywords.robot
Resource    ../PaxDetails/pax_details_keywords.robot

*** Keywords ***
Click On Book Button
    Wait Until Page Contains Element    ${book_button}
    Scroll Element Into View    ${book_button}
    Execute Javascript    window.scrollBy(0,-100);
    Scroll Element Into View    ${book_button}
    Click Element   ${book_button}
    Handle All Popups    ${False}    ${False}    ${False}    ${False}

Click On Add Passanger Button
    Handle All Popups And Update Data
    Execute Javascript    window.scrollBy(0, 300);
    Wait Until Page Contains Element    ${add_passanger_button}   timeout=15
    Click Element   ${add_passanger_button}

Click on Show Seat Map Button
    Execute Javascript   window.scrollBy(0, 500);
    ${check}    Run Keyword And Return Status    Page Should Contain Element    ${show_seat_map_button}
    IF   ${check} == True
        Click Element    ${show_seat_map_button}
        ${seat_selection_error_check}    Run Keyword And Return Status    Wait Until Page Contains      Seat Selection Not Applicable for this Itinerary        timeout=5s
        IF    ${seat_selection_error_check} == True
            Capture Page Screenshot
            Pass Execution    Seat Selection Not Applicable for this Itinerary error messaage displayed
        ELSE
             Get Available Seats
             Element Should Be Visible    ${aircraft_body_seats}
        END
    ELSE
         Execute Javascript   window.scrollBy(0, 500);
         Capture Page Screenshot
         Pass Execution    Seat Map Window Button Is Not Present
    END

Verify Select Seat Page
    Click On Book Button
    Click On Add Passanger Button
    Click on Show Seat Map Button
    Wait Until Page Contains Element   ${select_seat_title}   timeout=20
    Wait Until Page Contains Element   ${airline_info}
    Wait Until Page Contains Element   ${source_destination}
    Wait Until Page Contains Element   ${passanger_details}
    Wait Until Page Contains Element   ${proceed_button}
    Wait Until Page Contains Element   ${proceed_without_seats}
    Wait Until Page Contains Element   ${seat_status_heading}
    Wait Until Page Contains Element   ${seat_fees_section}
    Wait Until Page Contains Element   ${aircraft_body}
    Wait Until Page Contains    * Conditions apply. We will try our best to accomodate your seat preferences, however due to operational considerations we can't guarantee this selection. The seat map shown may not be the exact replica of flight layout, we shall not responsible for losses arising from the same. Thank you for your understanding

Verify Name On The Select Flight
    ${displayed_airline_name_text}   Get Text   ${displayed_airline_name}
    ${split}   Split String   ${displayed_airline_name_text}
    ${displayed_airline_name_text}   Set Variable   ${split}[0]
    Click On Book Button
    Click On Add Passanger Button
    Click on Show Seat Map Button
    Wait Until Page Contains Element   ${select_seat_airline_name}
    ${select_seat_airline_details}   Get Text   ${select_seat_airline_name}
    ${split}   Split String   ${select_seat_airline_details}
    ${select_seat_airline_name}   Set Variable   ${split}[0]
    Should Be Equal As Strings   ${displayed_airline_name_text}   ${select_seat_airline_name}

Verify Number On The Select Flight
    ${displayed_airline_name_text}   Get Text   ${displayed_airline_name}
    ${split}   Split String   ${displayed_airline_name_text}
    Log   ${split}
    ${displayed_airline_name_text}   Set Variable   ${split}[1]
    Click On Book Button
    Click On Add Passanger Button
    Click on Show Seat Map Button
    Wait Until Page Contains Element   ${select_seat_airline_name}
    ${select_seat_airline_details}   Get Text   ${select_seat_airline_name}
    ${split}   Split String   ${select_seat_airline_details}
    ${select_seat_airline_name}   Set Variable   ${split}[1]
    Should Be Equal As Strings   ${displayed_airline_name_text}   ${select_seat_airline_name}

Verify Source & Destination
    ${source_city_name}   Get Text   ${source_city_text}
    ${destination_city_name}   Get Text   ${destination_city}
    Log   ${source_city_name}
    Log   ${destination_city_name}
    Click On Book Button
    Click On Add Passanger Button
    Click on Show Seat Map Button
    Wait Until Page Contains Element   ${select_seat_airline_name}
    ${displayed_source_city}   Get Text   ${displayed_source_city}
    ${displayed_destination_city}   Get Text   ${displayed_destination_city}
    Should Be Equal As Strings   ${source_city_name}   ${displayed_source_city}
    Should Be Equal As Strings   ${destination_city_name}   ${displayed_destination_city}

Verify No Seat Selected Status
    Click On Book Button
    Click On Add Passanger Button
    Wait Until Page Contains    No Seat Selected

Verify Booked Seat
    Click On Book Button
    Click On Add Passanger Button
    Click on Show Seat Map Button
    Wait Until Page Contains Element   ${booked_seat}    timeout=20
    ${booked_seat_tooltip}=    SeleniumLibrary.Get Element Count   ${booked_seat}

Select Booked Seat
    [Arguments]    ${seat_no}
    Wait Until Element Is Visible    (//div[contains(@class,'box--booked')])[${seat_no}]   timeout=20
    Click Element    (//div[contains(@class,'box--booked')])[${seat_no}]
    ${booked_seat_tooltip}   Get Text   (//div[contains(@class,'box--booked')])[${seat_no}]
    Should Be Equal As Strings   ${booked_seat_tooltip}   Sorry! This seat is taken

Verify Meal, Baggage & Seat Price
    Click On Book Button
    Click On Add Passanger Button
    Click on Show Seat Map Button
    Wait Until Page Contains Element   ${proceed_without_seats}   timeout=10
    Click Element   ${proceed_without_seats}
    Execute JavaScript   window.scrollTo(0, 100);
    Wait Until Element Is Visible   ${amount_to_pay}       timeout=30
    Wait Until Page Contains Element   ${meal_baggage_section}    timeout=10
    Wait Until Page Contains Element   ${meal_baggage_seat_price}  timeout=15
    ${default_price}   Get Text   ${meal_baggage_seat_price}
    Should Be Equal As Strings   ${default_price}   ₹0.00

Get pax count
    Click On Book Button
    Click On Add Passanger Button
    Click on Show Seat Map Button
    ${adult_pax_count}   Set Global Variable   ${adult_pax_count}   SeleniumLibrary.Get Element Count   ${adult_pax}
    ${child_pax_count}   Set Global Variable   ${child_pax_count}   SeleniumLibrary.Get Element Count   ${child_pax}

Verify Not Selected Seat on Pax Detail Page for three passangers
    Wait Until Element Is Visible    (//div[@class="col-sm-4 seatmap-box--seat"]/p[@class="p-20"])[1]
    ${selected_seat_on_ui}=    Get Text    (//div[@class="col-sm-4 seatmap-box--seat"]/p[@class="p-20"])[1]
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
    Should Be Equal As Strings   ${ui_seat_1}    NA
    Should Be Equal As Strings   ${ui_seat_2}    NA
    Should Be Equal As Strings   ${ui_seat_3}    NA

Verify Proceed Button Without Passanger Multiple Passanger
    Click On Book Button
    Click On Add Passanger Button
    Click on Show Seat Map Button
    Wait Until Page Contains Element   ${proceed_button}
    Click Element   ${proceed_button}
    Verify Not Selected Seat on Pax Detail Page for three passangers

Verify Proceed Button Without Passanger One Passanger
    Click On Book Button
    Click On Add Passanger Button
    Click on Show Seat Map Button
    Wait Until Page Contains Element   ${proceed_button}    timeout=20
    Click Element   ${proceed_button}
    Verify Not Selected Seat on Pax Detail Page for one passangers

Verify Not Selected Seat on Pax Detail Page for one passangers
    Wait Until Element Is Visible   (//div[@class="col-sm-4 seatmap-box--seat"]/p[@class="p-20"])[1]
    ${selected_seat_on_ui}=   Get Text   (//div[@class="col-sm-4 seatmap-box--seat"]/p[@class="p-20"])[1]
    ${split_text}=   Split String   ${selected_seat_on_ui}    ,
    ${ui_seat_1}=   Get From List   ${split_text}    0
    ${ui_seat_1}=   Split String   ${ui_seat_1}    :
    ${ui_seat_1}=   Strip String   ${ui_seat_1}[1]
    Should Be Equal As Strings   ${ui_seat_1}    NA

Get Available Seats
    Wait Until Page Contains Element   ${select_seat_title}   timeout=20
    ${available_seat_element}=  Get WebElements   //div[@class="grid-item seat-map__box--background-0" or @class="grid-item seat-map__box--background-1" or @class="grid-item seat-map__box--background--1" or @class="grid-item seat-map__box--background-2" or @class="grid-item seat-map__box--background-3" or @class="grid-item seat-map__box--background-4" or @class="grid-item seat-map__box--background-5" or @class="grid-item seat-map__box--background-6"]//span
    ${available_seats}   Create List
    FOR    ${element}    IN    @{available_seat_element}
        ${seat_no}=  Get Text   ${element}
        Append To List   ${available_seats}   ${seat_no}
    END
    Log   ${available_seats}
    RETURN   ${available_seats}

Select Seat
    [Arguments]   ${seat_no}
    Wait Until Element Is Visible   //div[@class="aircraft__body--seats"]//child::span[text()='${seat_no}']    timeout=20
    Click Element   //div[@class="aircraft__body--seats"]//child::span[text()='${seat_no}']
    Element Should Be Visible   //div[@class="aircraft__body--seats"]//child::span[text()='${seat_no}' and @class="grid-item__text grid-item__text--selected"]
    ${seat_price}=   Get Text   //span[text()='${seat_no}' and @class="grid-item__text grid-item__text--selected"]//preceding-sibling::div/p[2]
    RETURN   ${seat_price}

Select Seat For Three Passangers and Verify Selection
    [Arguments]   ${available_seats}
    ${seat_price_1}   select seat   ${available_seats}[0]
    Verify Selected Seat on Seat Map Window   ${available_seats}[0]   1
    Click Element   (//li[@class="seat-map__seat-data "])[1]
    ${seat_price_2}   select seat   ${available_seats}[1]
    Verify Selected Seat on Seat Map Window   ${available_seats}[1]   2
    Click Element   (//li[@class="seat-map__seat-data "])[2]
    ${seat_price_3}   select seat   ${available_seats}[2]
    Verify Selected Seat on Seat Map Window   ${available_seats}[2]   3
    RETURN   ${seat_price_1}   ${seat_price_2}   ${seat_price_3}

Verify Selected Seat on Seat Map Window
    [Arguments]   ${selected_seat}   ${seat_locator_index}
    ${selected_seat_on_ui}=   Get Text   (//div[@class="seat-map__select-box__item seat-map--seatNo"])[${seat_locator_index}]
    Should Be Equal   ${selected_seat}   ${selected_seat_on_ui}

Verify Selected Seat on Pax Detail Page
    [Arguments]   ${available_seats}
    Wait Until Element Is Visible   ${seat_detail_pax}
    ${selected_seat_on_ui}=   Get Text   ${seat_detail_pax}
    ${split_text}=   Split String   ${selected_seat_on_ui}    :
    ${split_text}=   Strip String   ${split_text}[1]
    Should Be Equal   ${available_seats}[0]   ${split_text}

Verify Second Selected Seat on Pax Detail Page
    [Arguments]   ${available_seats}
    Wait Until Element Is Visible   (${seat_detail_pax})[2]
    ${selected_seat_on_ui}=   Get Text   (${seat_detail_pax})[2]
    ${split_text}=   Split String   ${selected_seat_on_ui}    :
    ${split_text}=   Strip String   ${split_text}[1]
    Should Be Equal   ${available_seats}[1]   ${split_text}

Go to Pax Detail Page
    Click On Book Button
    Click On Add Passanger Button

Verify Selected Seat on Pax Detail Page for three passanger
    [Arguments]   ${available_seats}   ${seat1}   ${seat2}   ${seat3}
    Wait Until Element Is Visible   ${seat_detail_pax}
    ${selected_seat_on_ui}=   Get Text   ${seat_detail_pax}
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

Select Checkbox And Get Filter Price
    [Arguments]   ${checkbox_locator}
    Wait Until Element Is Visible   ${checkbox_locator}   timeout=10
    Click Element   ${checkbox_locator}
    ${filter_price}   Get Text   ${checkbox_locator}//preceding-sibling::div//span[2]
    RETURN   ${filter_price}

Verify Selected Seat Price With Filter Price
    [Arguments]   ${filter_price}
    ${available_seats}   Get Available Seats
    Select Seat   ${available_seats}[0]
    ${selected_seat_price}   Get Text   ${seat_fee_seat_map}
    Should Be Equal   ${filter_price}   ${selected_seat_price}

Verify Selected Seat Price With Two Filter Price
    [Arguments]   ${filter_price1}   ${filter_price2}
    ${available_seats}   Get Available Seats
    ${selected_seat_price1}   Select Seat   ${available_seats}[-1]
    ${selected_seat_price2}    Select Seat   ${available_seats}[0]
    ${check_equal}=   Run Keyword And Return Status   Should Be Equal   ${selected_seat_price1}   ${filter_price1}
    IF   ${check_equal}!=True
        Should Be Equal   ${selected_seat_price1}   ${filter_price2}
    END
    ${check_equal}=   Run Keyword And Return Status   Should Be Equal   ${selected_seat_price2}   ${filter_price1}
    IF    ${check_equal}!=True
        Should Be Equal   ${selected_seat_price2}   ${filter_price2}
    END

Verify Seat Fee on Seat Map Window
    [Arguments]   ${seat_price}   ${locator_index}
    ${seat_price_on_ui}=   Get Text   (//div[@class="seat-map__select-box__item seat-map--fee"])[${locator_index}]
    Should Be Equal   ${seat_price}   ${seat_price_on_ui}

Verify Total Fee of Selected Seats on Seat Map Window For Three Passanger
    [Arguments]   ${seat_price1}   ${seat_price2}   ${seat_price3}
    ${seat_price1}=   Extract Final Fare As String   ${seat_price1}
    ${seat_price2}=   Extract Final Fare As String   ${seat_price2}
    ${seat_price3}=   Extract Final Fare As String   ${seat_price3}
    ${total_seat_price}=   Evaluate   ${seat_price1}+${seat_price2}+${seat_price3}
    ${total_seat_price_on_ui}=   Get Text   (//div[@class="seat-map__select-box__item seat-map--fee"])[4]
    ${total_seat_price_on_ui}=   Extract Final Fare As String   ${total_seat_price_on_ui}
    Should Be Equal As Numbers   ${total_seat_price}   ${total_seat_price_on_ui}
    RETURN    ${total_seat_price}

Verify Seat Fee On Pax Details Page
    [Arguments]   ${selected_seat_price}   ${total_fare_before}
    Wait Until Element Is Visible   ${baggage_seat_locator_pax}   timeout=10
    Click Element   ${baggage_seat_locator_pax}
    Wait Until Element Is Visible   ${seat_fare_pax}
    ${total_seat_price_on_pax_details}=   Get Text   ${seat_fare_pax}
    ${total_seat_price_on_pax_details}=   Extract Final Fare As String   ${total_seat_price_on_pax_details}
    ${selected_seat_price}=   Extract Final Fare As String   ${selected_seat_price}
    Should Be Equal As Numbers   ${selected_seat_price}   ${total_seat_price_on_pax_details}
    ${updated_total_fare_on_ui}=   Get Text   ${total_fare_locator_pax_details}
    ${updated_total_fare_on_ui}=   Extract Final Fare As String   ${updated_total_fare_on_ui}
    ${total_fare_before}=   Extract Final Fare As String   ${total_fare_before}
    Log    ${total_fare_before}
    Log    ${total_seat_price_on_pax_details}
    ${expected_total_fare}=   Evaluate   ${total_fare_before}+${total_seat_price_on_pax_details}
    Sleep    10s
    Should Be Equal As Numbers   ${expected_total_fare}   ${updated_total_fare_on_ui}

Verify Total Seat Fee on Pax Details Page for Three Passangers
    [Arguments]   ${seat_price1}   ${seat_price2}   ${seat_price3}   ${total_fare_before}
    ${seat_price1}=   Extract Final Fare As String   ${seat_price1}
    ${seat_price2}=   Extract Final Fare As String   ${seat_price2}
    ${seat_price3}=   Extract Final Fare As String   ${seat_price3}
    ${total_seat_fee}=   Evaluate   ${seat_price1}+${seat_price2}+${seat_price3}
    ${total_seat_fee}=   Convert To String   ${total_seat_fee}
    Verify Seat Fee on Pax Details Page   ${total_seat_fee}   ${total_fare_before}

Select Seat and Update Fare Summary
    [Arguments]   ${fare_summary}
    Wait Until Page Contains Element   ${show_seat_map_button}   timeout=20
    Execute Javascript   window.scrollBy(0, 500);
    Click Element   (${show_seat_map_button})[1]
    ${available_seats}=   Get Available Seats
    ${seat_price1}   ${seat_price2}   ${seat_price3}   Select Seat For Three Passangers and Verify Selection    ${available_seats}
    ${seat_price1}=   Extract Final Fare As String   ${seat_price1}
    ${seat_price2}=   Extract Final Fare As String   ${seat_price2}
    ${seat_price3}=   Extract Final Fare As String   ${seat_price3}
    ${total_seat_price}=   Evaluate   ${seat_price1}+${seat_price2}+${seat_price3}
    Set To Dictionary   ${fare_summary}   BaggageMealSeatFee=${total_seat_price}
    ${fare_summary.total_fare_price}=   Evaluate   ${fare_summary.total_fare_price}+${total_seat_price}
    RETURN   ${fare_summary}

Select Seat and Verify for Different Segments
    Wait Until Page Contains Element   ${show_seat_map_button}   timeout=20
    Execute Javascript   window.scrollBy(0, 500);
    Click Element   (${show_seat_map_button})[1]
    ${available_seats}=  Get Available Seats
    Select Seat   ${available_seats}[0]
    Click Element   ${proceed_button}
    Verify Selected Seat On Pax Detail Page    ${available_seats}
    Wait Until Element Is Visible   (${show_seat_map_button})[2]
    Click Element   (${show_seat_map_button})[2]
    ${available_seats}=   Get Available Seats
    Select Seat   ${available_seats}[1]
    Click Element   ${proceed_button}
    Verify Second Selected Seat on Pax Detail Page    ${available_seats}

Open Search Page
#    Go To    https://auto.tripjack.com/flight/
    Go To    https://staging.tripjack.com/flight/

Total Fare Pax Details Wait
    Wait Until Element Is Visible   ${total_fare_locator_pax_details}   timeout=20

Verify Seat Map Window
    Get Available Seats
    Element Should Be Visible    ${aircraft_body_seats}

Verify Pax Details On Seat Map Window
    [Arguments]   ${no_of_adults_td}  ${no_of_children_td}
    Wait Until Page Contains Element   ${adult_pax}   timeout=10
    Wait Until Page Contains Element   ${child_pax}   timeout=10
    ${adult_pax_count}   SeleniumLibrary.Get Element Count   ${adult_pax}
    ${child_pax_count}   SeleniumLibrary.Get Element Count   ${child_pax}
    Should Be Equal   ${no_of_adults_td}   ${adult_pax_count}
    Should Be Equal   ${no_of_children_td}   ${child_pax_count}

Verify Seat Map Window For Different Class
    Click On Book Button
    Click On Add Passanger Button
    ${check}    Run Keyword And Return Status    Page Should Contain Element    ${show_seat_map_button}
    IF   ${check} == True
        Click on Show Seat Map Button
        Get Available Seats
        Element Should Be Visible    ${aircraft_body_seats}
    ELSE
         Execute Javascript   window.scrollBy(0, 500);
         Capture Page Screenshot
         Log    Seat Map Window Button Is Not Present
    END
