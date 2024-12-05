*** Settings ***
Library    SeleniumLibrary
Library    XML
Library    String
Library    DateTime
Library    Collections
Library    ../../../CommonKeywords/CustomKeywords/user_keywords.py
Variables  ../../../../Environment/environments.py
Variables    ../../../PageObjects/SearchFlights/search_page_locators.py
Variables    ../../../PageObjects/SearchResults/search_results_locators.py
Variables    ../../../PageObjects/SearchPageFilter/search_page_filter_locators.py
Variables    ../../../PageObjects/Booking/booking_summary_locators.py
Variables    ../../../PageObjects/Corporate/SearchFlights/search_flight_locators.py
Resource    ../../../CommonKeywords/FlightItinerary/flight_itinerary_keywords.robot
Resource    ../../../CommonKeywords/BookingSummary/booking_summary_keywords.robot

*** Keywords ***
Navigate To Flight Search Page
    Wait Until Page Contains Element    ${flight_nav_link}      timeout=30s
    Click Element    ${flight_nav_link}
    Wait Until Page Contains Element    ${where_from_field}     timeout=30s

Search One Way Flights For Corporate
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Sleep    3s
    Wait Until Page Contains Element    ${where_from_field}    timeout=20s
    Input Text    ${where_from_field}   ${my_dict.From}
    Wait Until Page Contains Element    ${select_airport}    timeout=10s
    Get List Of Source City Airports
    Click Element    ${select_airport}
    Input Text    ${where_to_field}     ${my_dict.TO}
    Wait Until Page Contains Element    ${select_airport}    timeout=10
    Get List Of Destination City Airports
    Click Element    ${select_airport}
    Select Departure Date    ${my_dict.NumberOfMonthsAhead}   ${my_dict.DepartureDate}
    Select Passangers      ${my_dict.NoOfAdults}       ${my_dict.NoOfChildren}     ${my_dict.NoOfInfant}
    Select Class           ${my_dict.Class}
    IF    "${my_dict.SelectPrefereedAirline}" != "Null"
        Select The Preferred Airline    ${my_dict.SelectPrefereedAirline}
    END
    IF    "${my_dict.SelectFareType}" != "Null"
        Select Fare Type    ${my_dict.SelectFareType}
    END
    IF    "${my_dict.DepartureTime}" != "Null"
        Click Element    (//input[@placeholder="Select Time"])[1]
        ${departure_time}       Replace String    //li[contains(text(),'time')]    time    ${my_dict.DepartureTime}
        Click Element    ${departure_time}
    END
    IF    "${my_dict.ArrivalTime}" != "Null"
        Click Element    (//input[@placeholder="Select Time"])[2]
        ${arrival_time}       Replace String    //li[contains(text(),'time')]    time    ${my_dict.ArrivalTime}
        Click Element    ${arrival_time}
    END
    Click Element    ${search_button}
    IF    ${my_dict.NoOfInfant} > ${my_dict.NoOfAdults}
        Wait Until Page Contains    Infant cannot be greater Adult
    ELSE IF    "${my_dict.sId}" != "Null"
        Wait Until Element Is Visible   ${cheapest_flight_filter}     timeout=180s
        ${current_url}=    Get Location
        Log    ${current_url}
        ${new_url}=    Set Variable    ${current_url}&sId=${my_dict.sId}
        Go To    ${new_url}
        Wait Until Element Is Visible   ${cheapest_flight_filter}     timeout=180s
    ELSE
        Wait Until Element Is Visible   ${cheapest_flight_filter}     timeout=180s
    END

Search Flights For Round-Trip For Corporate
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Wait Until Page Contains Element    ${where_from_field}
    Input Text    ${where_from_field}   ${my_dict.From}
    Wait Until Page Contains Element    ${select_airport}    timeout=10
    Click Element    ${select_airport}
    Input Text    ${where_to_field}     ${my_dict.TO}
    Wait Until Page Contains Element    ${select_airport}    timeout=10
    Click Element    ${select_airport}
    Select Departure Date    ${my_dict.NumberOfMonthsAhead}   ${my_dict.DepartureDate}
    Select Return Date       ${my_dict.NumberOfMonthsAheadForReturn}   ${my_dict.ReturnDate}
    Select Passangers      ${my_dict.NoOfAdults}       ${my_dict.NoOfChildren}     ${my_dict.NoOfInfant}
    Select Class           ${my_dict.Class}
    IF    "${my_dict.SelectPrefereedAirline}" != "Null"
        Select The Preferred Airline        ${my_dict.SelectPrefereedAirline}
    END
    IF    "${my_dict.SelectFareType}" != "Null"
        Select Fare Type    ${my_dict.SelectFareType}
    END
    IF    "${my_dict.DepartureTime}" != "Null"
        Click Element    (//input[@placeholder="Select Time"])[1]
        ${departure_time}       Replace String    //li[contains(text(),'time')]    time    ${my_dict.DepartureTime}
        Click Element    ${departure_time}
    END
    IF    "${my_dict.ArrivalTime}" != "Null"
        Click Element    (//input[@placeholder="Select Time"])[2]
        ${arrival_time}       Replace String    //li[contains(text(),'time')]    time    ${my_dict.ArrivalTime}
        Click Element    ${arrival_time}
    END
    Click Element    ${search_button}
    IF    ${my_dict.NoOfInfant} > ${my_dict.NoOfAdults}
        Wait Until Page Contains    Infant cannot be greater Adult
    ELSE IF    "${my_dict.sId}" != "Null"
        Wait Until Element Is Visible   ${cheapest_flight_filter}     timeout=180s
        ${current_url}=    Get Location
        Log    ${current_url}
        ${new_url}=    Set Variable    ${current_url}&sId=${my_dict.sId}
        Go To    ${new_url}
        Wait Until Element Is Visible   ${cheapest_flight_filter}     timeout=180s
    ELSE
        Wait Until Element Is Visible   ${cheapest_flight_filter}     timeout=180s
    END

Select Fare Amount
    ${total_flight_count}       SeleniumLibrary.Get Element Count    //div[@class="asr-albtm"]
    FOR    ${counter}    IN RANGE    1    ${total_flight_count}+1
        ${status}       Run Keyword And Return Status    Element Should Be Visible    (//ul[@class="ars-radiolist"])[${counter}]/li/li[3]
        IF    ${status}
            Click Element    (//ul[@class="ars-radiolist"])[${counter}]/li/li[3]
            ${flight_details_from_result_page}      Get FLight Details From Flight Result Page    ${counter}
            ${flight_details_after_click_on_view}       Get Flight Details After Clicking On View Details    ${counter}
            Execute JavaScript    window.scrollBy(0, -window.innerHeight)
            Scroll Element Into View    (//button[contains(text(),'BOOK')])[${counter}]
            Click Element    (//button[contains(text(),'BOOK')])[${counter}]
            Exit For Loop
        ELSE
            Log    Only one fare amount is present for flight
            Execute JavaScript    window.scrollTo(0, 500)
        END
    END
    Log    ${flight_details_after_click_on_view}
    [Return]    ${flight_details_from_result_page}      ${flight_details_after_click_on_view}

Get FLight Details From Flight Result Page
    [Arguments]     ${index}
    ${flight_details_from_result_page}      Create Dictionary
    ${flight_name_elements}=     Get WebElements    (//div[contains(@class,'flight-leftresult')])[${index}]/div[1]
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_name_elements}
        ${flight_name}=     Get Text    ${element}

        ${split}=   Split String    ${flight_name}    \n
        ${length}    Get Length    ${split}
#        IF    ${length}== 2
            ${flight_name}=  Get From List    ${split}    0
#            ${temp2}=   Get From List    ${split}    1
#            ${flight_name}=  Catenate    ${temp1}${temp2}
#        ELSE IF    ${length}< 2
#            ${flight_name}=  Get From List    ${split}    0
#                ${temp2}=   Get From List    ${split}    0
#                ${flight_name}=  Catenate    ${temp1}${temp2}
#        END

        Set To Dictionary    ${flight_details_from_result_page}   FlightName${i}=${flight_name}
        ${i}=   Evaluate   ${i}+1
    END
    ${departure_elements}=     Get WebElements    (//div[contains(@class,'flight-leftresult')])[${index}]/div[2]
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{departure_elements}
        ${flight_departure_text}=     Get Text    ${element}
        ${splited_string_1}       Split String    ${flight_departure_text}     \n
        ${flight_departure}      Catenate    ${splited_string_1}[0]\n${splited_string_1}[1]
        Set To Dictionary    ${flight_details_from_result_page}   FlightDeparture${i}=${flight_departure}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_stops_elements}=     Get WebElements    (//div[contains(@class,'flight-leftresult')])[${index}]/div[3]
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_stops_elements}
        ${flight_stop}=     Get Text    ${element}
        Set To Dictionary    ${flight_details_from_result_page}   FlightStops${i}=${flight_stop}
        ${i}=   Evaluate   ${i}+1
    END
    ${arrival_elements}=     Get WebElements    (//div[contains(@class,'flight-leftresult')])[${index}]/div[4]
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{arrival_elements}
        ${flight_arrival_text}=     Get Text    ${element}
        ${splited_string_2}     Split String    ${flight_arrival_text}      \n
        ${flight_arrival}       Catenate     ${splited_string_2}[0]\n${splited_string_2}[1]
        Set To Dictionary    ${flight_details_from_result_page}   FlightArrival${i}=${flight_arrival}
        ${i}=   Evaluate   ${i}+1
    END
    [Return]    ${flight_details_from_result_page}

Get Flight Details From Flight Recommendation Page
    Wait Until Page Contains    Selected Flight     timeout=30s
    ${selected_flight_details}      Create Dictionary
    ${flight_name_elements}=     Get WebElements    (//div[@class="inner_content-modal"]//following::div[contains(@class,'flight-leftresult')])[1]/div[1]
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_name_elements}
        ${flight_name}=     Get Text    ${element}
        Set To Dictionary    ${selected_flight_details}   FlightName${i}=${flight_name}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_departure_elements}=     Get WebElements    (//div[@class="inner_content-modal"]//following::div[contains(@class,'flight-leftresult')])[1]/div[2]
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_departure_elements}
        ${flight_departure}=     Get Text    ${element}
        Set To Dictionary    ${selected_flight_details}   FlightDeparture${i}=${flight_departure}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_stops_elements}=     Get WebElements    (//div[@class="inner_content-modal"]//following::div[contains(@class,'flight-leftresult')])[1]/div[3]
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_stops_elements}
        ${flight_stops}=     Get Text    ${element}
        Set To Dictionary    ${selected_flight_details}   FlightStops${i}=${flight_stops}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_arrival_elements}=     Get WebElements    (//div[@class="inner_content-modal"]//following::div[contains(@class,'flight-leftresult')])[1]/div[4]
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_arrival_elements}
        ${flight_arrival}=     Get Text    ${element}
        Set To Dictionary    ${selected_flight_details}   FlightArrival${i}=${flight_arrival}
        ${i}=   Evaluate   ${i}+1
    END
    ${recommended_flight_details}      Create Dictionary
    ${flight_name_elements}=     Get WebElements    (//div[@class="inner_content-modal"]//following::div[contains(@class,'flight-leftresult')])[2]/div[1]
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_name_elements}
        ${flight_name}=     Get Text    ${element}
        Set To Dictionary    ${recommended_flight_details}   FlightName${i}=${flight_name}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_departure_elements}=     Get WebElements    (//div[@class="inner_content-modal"]//following::div[contains(@class,'flight-leftresult')])[2]/div[2]
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_departure_elements}
        ${flight_departure}=     Get Text    ${element}
        Set To Dictionary    ${recommended_flight_details}   FlightDeparture${i}=${flight_departure}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_stops_elements}=     Get WebElements    (//div[@class="inner_content-modal"]//following::div[contains(@class,'flight-leftresult')])[2]/div[3]
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_stops_elements}
        ${flight_stops}=     Get Text    ${element}
        Set To Dictionary    ${recommended_flight_details}   FlightStops${i}=${flight_stops}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_arrival_elements}=     Get WebElements    (//div[@class="inner_content-modal"]//following::div[contains(@class,'flight-leftresult')])[2]/div[4]
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_arrival_elements}
        ${flight_arrival}=     Get Text    ${element}
        Set To Dictionary    ${recommended_flight_details}   FlightArrival${i}=${flight_arrival}
        ${i}=   Evaluate   ${i}+1
    END
    [Return]    ${selected_flight_details}      ${recommended_flight_details}

Verify Flight Details On Flight Recommendation Page
    [Arguments]     ${flight_details_from_result_page}      ${recommended_flight_details}       ${selected_flight_details}      ${lowest_fare_flight_details}
    Log    ${flight_details_from_result_page}
    Log    ${recommended_flight_details}
    Log    ${selected_flight_details}
    Dictionaries Should Be Equal    ${recommended_flight_details}    ${lowest_fare_flight_details}
    Dictionaries Should Be Equal    ${flight_details_from_result_page}    ${selected_flight_details}

Get Flight Details After Clicking On View Details
    [Arguments]     ${index}
    Wait Until Page Contains Element    (//button[contains(text(),'View Details')])[${index}]
    Click Element    (//button[contains(text(),'View Details')])[${index}]
    Wait Until Page Contains    Flight Details      timeout=30s
    ${flight_details}      Create Dictionary
    ${flight_name_elements}=     Get WebElements    ${flight_Name_locator}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_name_elements}
        ${flight_name_text}=     Get Text    ${element}
        ${splited_string}       Split String    ${flight_name_text}      \n
        ${flight_name}      Catenate    ${splited_string}[0]${splited_string}[1]
        Set To Dictionary    ${flight_details}   FlightName${i}=${flight_name}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_departure_elements}=     Get WebElements    ${flight_departure_detail}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_departure_elements}
        ${flight_departure}=     Get Text    ${element}
        Set To Dictionary    ${flight_details}   FlightDeparture${i}=${flight_departure}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_destination_elements}=     Get WebElements    ${flight_destination_detail}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_destination_elements}
        ${flight_destination}=     Get Text    ${element}
        Set To Dictionary    ${flight_details}   FlightDestination${i}=${flight_destination}
        ${i}=   Evaluate   ${i}+1
    END
    ${flight_duration_elements}=     Get WebElements    ${flight_duration_flight_type_search_result}
    ${i}=   Set Variable    1
    FOR    ${element}    IN    @{flight_duration_elements}
        ${flight_duration_text}=     Get Text    ${element}
        ${splited_string_2}     Split String    ${flight_duration_text}     \n
        ${flight_duration}      Catenate        ${splited_string_2}[0]
        Set To Dictionary    ${flight_details}   FlightDurationFlightType${i}=${flight_duration}
        ${i}=   Evaluate   ${i}+1
    END
    Click Element    //span[text()='×']
    Execute JavaScript    window.scrollBy(0, -window.innerHeight)
    [Return]    ${flight_details}

Select Reasons For Not Selecting Lowest Preferred Flight
    ${reason_for_not_selecting_preferred_flight}    Get Text    //label[text()='Personal preference']
    Log    Reason for not selecting lowest preferred flight : ${reason_for_not_selecting_preferred_flight}
    Click Element    //label[text()='Personal preference']

Click On Proceed Button From Flight Recommendation Page
    Wait Until Page Contains Element    ${recomendation_page_proceed_button}    timeout=30s
    Click Element    ${recomendation_page_proceed_button}
    Wait Until Page Contains    Flight Details      timeout=30s

Click On Book Button From Flight Recommendation Page
    Wait Until Page Contains Element    ${recomendation_page_book_button}   timeout=30s
    Click Element    ${recomendation_page_book_button}
    Wait Until Page Contains    Flight Details      timeout=30s

Select Fare Amount With Layover Details
    ${total_flight_count}       SeleniumLibrary.Get Element Count    //div[@class="asr-albtm"]
    FOR    ${counter}    IN RANGE    1    ${total_flight_count}+1
        ${status}       Run Keyword And Return Status    Element Should Be Visible    (//ul[@class="ars-radiolist"])[${counter}]/li/li[3]
        IF    ${status}
            Click Element    (//ul[@class="ars-radiolist"])[${counter}]/li/li[3]
            ${flight_details_from_result_page}      Get FLight Details From Flight Result Page    ${counter}
            ${flight_details_after_click_on_view}       Get Flight Details After Clicking On View Details    ${counter}
            ${layover_list}    Get Layover Details For Booking Summary
            Execute JavaScript    window.scrollBy(0, -window.innerHeight)
            Scroll Element Into View    (//button[contains(text(),'BOOK')])[${counter}]
            Click Element    (//button[contains(text(),'BOOK')])[${counter}]
            Exit For Loop
        ELSE
            Log    Only one fare amount is present for flight
            Execute JavaScript    window.scrollTo(0, 500)
        END
    END
    Log    ${flight_details_after_click_on_view}
    [Return]    ${flight_details_from_result_page}      ${flight_details_after_click_on_view}    ${layover_list}

Get Layover Details For Corporate Booking Summary
    ${is_search_result_page}  Run Keyword And Return Status    Element Should Be Visible    ${cheapest_flight_filter}
    ${layover_list}  Create List
    IF    ${is_search_result_page}
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
#      Close Fare View Button    ${view_details_button}
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
