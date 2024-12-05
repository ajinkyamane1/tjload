*** Settings ***
Library    SeleniumLibrary
Library    XML
Library    String
Library    DateTime
Library    Collections
Library    ../../Commonkeywords/CustomKeywords/user_keywords.py
Variables  ../../../Environment/environments.py
Variables    ../../PageObjects/SearchFlights/search_page_locators.py
Variables    ../../PageObjects/SearchResults/search_results_locators.py
Variables    ../../PageObjects/SearchPageFilter/search_page_filter_locators.py
Variables    ../../PageObjects/Booking/booking_summary_locators.py
Resource    ../../Commonkeywords/FlightItinerary/flight_itinerary_keywords.robot
Resource    ../../Commonkeywords/PaxDetails/pax_details_keywords.robot

*** Variables ***
${loop_count}    0
${IMAP_SERVER}    imap.gmail.com
${IMAP_PORT}    993
${EMAIL}    ajinkya.mane@indexnine.com
${PASSWORD}    ozum ydlx yttm jveq

*** Keywords ***
Search One Way Flights
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Sleep    3s
    Wait Until Page Contains Element    ${where_from_field}    timeout=20s
    Input Text    ${where_from_field}   ${my_dict.From}
    Wait Until Page Contains Element    ${select_airport}    timeout=30s
    Get List Of Source City Airports
    Click Element    ${select_airport}
    Input Text    ${where_to_field}     ${my_dict.TO}
    Wait Until Page Contains Element    ${select_airport}    timeout=30
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
    Click Element    ${search_button}
    IF    ${my_dict.NoOfInfant} > ${my_dict.NoOfAdults}
        Wait Until Page Contains    Infant cannot be greater Adult
    ELSE IF    "${my_dict.sId}" != "Null"
        Wait Until Element Is Visible   ${cheapest_flight_filter}     timeout=180s
        ${current_url}=    Get Location
        Log    ${current_url}
        ${new_url}=    Set Variable    ${current_url}&sId=${my_dict.sId}
        ${start_time}=    DateTime.Get Current Date      result_format=%Y-%m-%d %H:%M:%S
        Set Test Variable    ${start_time}
        Go To    ${new_url}
        Wait Until Element Is Visible   ${cheapest_flight_filter}     timeout=180s
    ELSE
        Wait Until Element Is Visible   ${cheapest_flight_filter}     timeout=180s
    END

Search Flights For Round-Trip
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


Select Departure Date
    [Arguments]       ${no_of_months}     ${day}
    ${day}=    Convert To String    ${day}
    ${list_for_dates}        No Of Months Ahead    ${no_of_months}
    ${month}    Get From List    ${list_for_dates}    1
    ${year}    Get From List    ${list_for_dates}    2
    ${replaced_with_year}        Replace String    ${final_date_locator_to_replace}          replaceyear         ${year}
    ${replaced_with_year}        Replace String    ${replaced_with_year}          replacemonth         ${month}
    ${replaced_with_day}        Replace String    ${replaced_with_year}          replaceday         ${day}
    Click Element    ${departure_date_field}
    Scroll Element Into View     ${replaced_with_day}
    Wait Until Element Is Visible     ${replaced_with_day}         10s
    Click Element     ${replaced_with_day}
    ${selected_departure_date}   Get Value    ${departure_date_selected_text}
    Set Test Variable    ${selected_departure_date}


Select Departure Date | Multicity
    [Arguments]       ${no_of_months}     ${day}    ${departure_date_field}
    ${day}=    Convert To String    ${day}
    ${list_for_dates}        No Of Months Ahead    ${no_of_months}
    ${month}    Get From List    ${list_for_dates}    1
    ${year}    Get From List    ${list_for_dates}    2
    ${replaced_with_year}        Replace String    ${final_date_locator_to_replace}          replaceyear         ${year}
    ${replaced_with_year}        Replace String    ${replaced_with_year}          replacemonth         ${month}
    ${replaced_with_day}        Replace String    ${replaced_with_year}          replaceday         ${day}
    Click Element    ${departure_date_field}
    Scroll Element Into View     ${replaced_with_day}
    Wait Until Element Is Visible     ${replaced_with_day}         10s
    Click Element     ${replaced_with_day}


Select Return Date
    [Arguments]       ${no_of_months}     ${day}
    ${day}=    Convert To String    ${day}
    ${list_for_dates}        No Of Months Ahead    ${no_of_months}
    ${month}    Get From List    ${list_for_dates}    1
    ${year}    Get From List    ${list_for_dates}    2
    ${replaced_with_year}        Replace String    ${final_date_locator_to_replace}          replaceyear         ${year}
    ${replaced_with_year}        Replace String    ${replaced_with_year}          replacemonth         ${month}
    ${replaced_with_day}        Replace String    ${replaced_with_year}          replaceday         ${day}
    Click Element    ${return_date_field}
    Scroll Element Into View     ${replaced_with_day}
    Wait Until Element Is Visible     ${replaced_with_day}         10s
    Click Element     ${replaced_with_day}
    ${selected_return_date}   Get Value    ${return_date_selected_text}
    Set Test Variable    ${selected_return_date}


Select Passangers
    [Arguments]     ${adults}   ${child}    ${Infant}
    Wait Until Page Contains Element    ${passenger_and_class}      timeout=10
    Click Element    ${passenger_and_class}
    IF    ${adults} > 0
        Click Element    //h4[text()='Adult']/following-sibling::ul/li/a[text()='${adults}']
    END
    IF    ${child} > 0
        Click Element    //h4[text()='Children']/following-sibling::ul/li/a[text()='${child}']
    END
    IF    ${Infant} > 0
        Click Element    //h4[text()='Infant']/following-sibling::ul/li/a[text()='${Infant}']
    END
    Click Element    ${done_button}

Select Class
    [Arguments]   ${class}
    Wait Until Page Contains Element    ${passenger_and_class}
    Click Element    ${passenger_and_class}
    IF    "${class}" == "Economy"
       Click Element    ${economy_class}
    ELSE IF    "${class}" == "Premium Economy"
       Click Element    ${premium_economy_class}
    ELSE IF    "${class}" == "Business"
       Click Element    ${business_class}
    ELSE IF    "${class}" == "First"
       Click Element    ${first_class}
    ELSE
       Log    "Flight Class Undefined"
    END
    Click Element    ${done_button}


Select Prefereed Airline
   [Arguments]     ${airline}
   Click Element    ${select_preferred_airline_dropdown}
   ${is_list}=    Run Keyword And Return Status    Evaluate    isinstance(${airline}, list)
   IF  ${is_list}
       IF    ${airline.__len__()} > 1
            FOR    ${element}    IN    @{airline}
                Wait Until Page Contains Element    ${search_dropdown}
                Click Element    ${search_dropdown}
                IF    "${element}" == "Indigo"
                    Wait Until Page Contains Element    ${indigo_airline}
                    Click Element    ${indigo_airline}
                ELSE IF    "${element}" == "Spicejet"
                    Wait Until Page Contains Element    ${spicejet_airline}
                    Click Element    ${spicejet_airline}
                ELSE IF    "${element}" == "Air India"
                    Wait Until Page Contains Element    ${air_india_airline}
                    Click Element    ${air_india_airline}
                ELSE IF    "${element}" == "Go First"
                    Wait Until Page Contains Element    ${go_first_airline}
                    Click Element    ${go_first_airline}
                ELSE IF    "${element}" == "Akasa Air"
                    Wait Until Page Contains Element    ${akasa_air_airline}
                    Click Element    ${akasa_air_airline}
                ELSE IF    "${element}" == "AirAsia India"
                    Wait Until Page Contains Element    ${air_asia_india_airline}
                    Click Element    ${air_asia_india_airline}
                ELSE
                    Log    "Flight Preference Undefined"
                END
            END
       END
   ELSE
       Wait Until Page Contains Element    ${search_dropdown}
       Click Element    ${search_dropdown}
       IF    "${airline}" == "Indigo"
            Wait Until Page Contains Element    ${indigo_airline}
            Click Element    ${indigo_airline}
       ELSE IF    "${airline}" == "Spicejet"
            Wait Until Page Contains Element    ${spicejet_airline}
            Click Element    ${spicejet_airline}
       ELSE IF    "${airline}" == "Air India"
            Wait Until Page Contains Element    ${air_india_airline}
            Click Element    ${air_india_airline}
       ELSE IF    "${airline}" == "Go First"
            Wait Until Page Contains Element    ${go_first_airline}
            Click Element    ${go_first_airline}
       ELSE IF    "${airline}" == "Akasa Air"
            Wait Until Page Contains Element    ${akasa_air_airline}
            Click Element    ${akasa_air_airline}
       ELSE IF    "${airline}" == "AirAsia India"
            Wait Until Page Contains Element    ${air_asia_india_airline}
            Click Element    ${air_asia_india_airline}
       ELSE
            Log    "Flight Preference Undefined"
       END
   END


Select the Preferred Airline
    [Arguments]     ${airline}
    Sleep    3s
    Click Element    ${select_preferred_airline_dropdown}
    Wait Until Page Contains Element    ${search_dropdown}    timeout=20s
    Click Element    ${search_dropdown}
    Sleep    2
    Input Text    ${search_dropdown1}   ${airline}
    Wait Until Element Is Visible    ${select_preferred_airline}    10
    Click Element    ${select_preferred_airline}


Select Fare Type
   [Arguments]     ${fare_types}
   ${is_list}=    Run Keyword And Return Status    Evaluate    isinstance(${fare_types}, list)
   IF  ${is_list}
       FOR    ${type}    IN    @{fare_types}
           IF    "${type}" == "Direct Flight"
                Click Element    ${direct_flight_checkbox}
           ELSE IF  "${type}" == "Credit Shell"
                Click Element    ${credit_shell_checkbox}
           ELSE IF  "${type}" == "Student Fares"
                Click Element    ${student_fares_checkbox}
                Click Element    ${regular_fares_checkbox}
           ELSE IF  "${type}" == "Senior Citizen Fares"
                Click Element    ${senior_citizen_fares}
                Click Element    ${regular_fares_checkbox}
           END
       END
   ELSE
       IF  "${fare_types}" == "Direct Flight"
           Click Element    ${direct_flight_checkbox}
       ELSE IF  "${fare_types}" == "Credit Shell"
           Click Element    ${credit_shell_checkbox}
       ELSE IF  "${fare_types}" == "Student Fares"
           Click Element    ${student_fares_checkbox}
           Click Element    ${regular_fares_checkbox}
       ELSE IF  "${fare_types}" == "Senior Citizen Fares"
           Click Element    ${senior_citizen_fares}
           Click Element    ${regular_fares_checkbox}
       END
   END

Search Flight | Multicity
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Sleep    4s
    Click Element    ${multicity_button}
    Wait Until Page Contains Element    ${where_from_field}
    Input Text    ${from_first_field}   ${my_dict.From}
    Wait Until Page Contains Element    ${select_airport}
    ${multicity_first_source_cities}    Get List Of Source City Airports
    Set Test Variable    ${multicity_first_source_cities}
    Click Element    ${select_airport}
    Input Text    ${to_first_field}    ${my_dict.TO}
    Wait Until Page Contains Element    ${select_airport}
    Get List Of Destination City Airports
    Click Element    ${select_airport}
    Select Departure Date    ${my_dict.NumberOfMonthsAhead}   ${my_dict.DepartureDate}
    ${zero_departure_date_multicity}   Get Value    (${departure_date_selected_text})[1]
    Set Test Variable    ${zero_departure_date_multicity}
    Select Class           ${my_dict.Class}
    Select Passangers      ${my_dict.NoOfAdults}       ${my_dict.NoOfChildren}     ${my_dict.NoOfInfant}
    Input Text    ${to_second_field}    ${my_dict.TO1}
    Wait Until Page Contains Element    ${select_airport}
    ${multicity_first_city}    Get List Of Source City Airports
    Set Test Variable    ${multicity_first_city}
    Click Element    ${select_airport}
    Select Departure Date | Multicity    ${my_dict.NumberOfMonthsAhead}   ${my_dict.DepartureDate1}    ${departure_second_date_field}
    ${first_departure_date_multicity}   Get Value    (${departure_date_selected_text})[2]
    Set Test Variable    ${first_departure_date_multicity}
    IF    "${my_dict.TO2}" != "Null"
        Click Element    ${add_one_more_button}
        Input Text    ${to_third_field}    ${my_dict.TO2}
        Wait Until Page Contains Element    ${select_airport}
        ${multicity_secound_city}    Get List Of Source City Airports
        Set Test Variable    ${multicity_secound_city}
        Click Element    ${select_airport}
        Select Departure Date | Multicity    ${my_dict.NumberOfMonthsAhead}     ${my_dict.DepartureDate2}      ${departure_third_date_field}
        ${second_departure_date_multicity}   Get Value    (${departure_date_selected_text})[3]
        Set Test Variable    ${second_departure_date_multicity}
    END
    IF  "${my_dict.TO3}" != "Null"
        Click Element    ${add_one_more_button}
        Input Text    ${to_four_field}    ${my_dict.TO3}
        Wait Until Page Contains Element    ${select_airport}
        ${multicity_third_city}    Get List Of Source City Airports
        Set Test Variable    ${multicity_third_city}
        Click Element    ${select_airport}
        Select Departure Date | Multicity    ${my_dict.NumberOfMonthsAhead}     ${my_dict.DepartureDate3}    ${departure_four_date_field}
        ${third_departure_date_multicity}   Get Value    (${departure_date_selected_text})[4]
        Set Test Variable    ${third_departure_date_multicity}
    END
    IF  "${my_dict.TO4}" != "Null"
        Click Element    ${add_one_more_button}
        Input Text    ${to_five_field}    ${my_dict.TO4}
        Wait Until Page Contains Element    ${select_airport}
        ${multicity_fourth_city}    Get List Of Source City Airports
        Set Test Variable    ${multicity_fourth_city}
        Click Element    ${select_airport}
        Select Departure Date | Multicity    ${my_dict.NumberOfMonthsAhead}     ${my_dict.DepartureDate4}    ${departure_five_date_field}
        ${fourth_departure_date_multicity}   Get Value    (${departure_date_selected_text})[5]
        Set Test Variable    ${fourth_departure_date_multicity}
    END
    IF  "${my_dict.TO5}" != "Null"
        Click Element    ${add_one_more_button}
        Input Text    ${to_six_field}    ${my_dict.TO5}
        Wait Until Page Contains Element    ${select_airport}
        ${multicity_fifth_city}    Get List Of Source City Airports
        Set Test Variable    ${multicity_fifth_city}
        Click Element    ${select_airport}
        Select Departure Date | Multicity    ${my_dict.NumberOfMonthsAhead}     ${my_dict.DepartureDate5}    ${departure_six_date_field}
        ${fifth_departure_date_multicity}   Get Value    (${departure_date_selected_text})[6]
        Set Test Variable    ${fifth_departure_date_multicity}
    END
    IF    "${my_dict.SelectPrefereedAirline}" != "Null"
       Select The Preferred Airline    ${my_dict.SelectPrefereedAirline}
    END
    IF    "${my_dict.SelectFareType}" != "Null"
       Select Fare Type    ${my_dict.SelectFareType}
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


Verify Flight Search Details
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Verify Source City    ${my_dict}
    Verify Destination City    ${my_dict}
    Verify Passenger Class    ${my_dict}
    Verify Details In Modify Search    ${my_dict}
    Verify Departure Date    ${my_dict}


Verify Flight Details In View Details For Multicity
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary    &{search_data}
    IF    "${my_dict.TO1}" != "Null"
        Click Element       (${multicity_flight_tabs})[2]
        Wait Until Element Is Visible    (${multicity_flight_tabs})[2]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
        ${airline_text_search_page}     Get Text    (${multicity_flight_tabs})[2]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
        ${airline_text_search_page}   Extract Airline    ${airline_text_search_page}
        Click Element    ${search_results_scroll_button}
        Sleep    1s
        Click Element    (${multicity_flight_tabs})[2]/following::button[text()='View Details'][1]
        Wait Until Page Contains Element    (${multicity_flight_tabs})[2]/following::span[@class='at-fontweight arct-idcode']   timeout=10s
        Execute Javascript    window.scrollBy(0,200);
        Click Element    (${multicity_flight_tabs})[2]/following::span[@class='at-fontweight arct-idcode']
        ${airline_text}    Get Text    (${multicity_flight_tabs})[2]/following::p[@class='at-fontweight cancellation-details']
        Should Be Equal    ${airline_text_search_page}      ${airline_text}
        ${source_city_text}   Get Text     (${multicity_flight_tabs})[2]/following::b[@class='cityContainer-positionHandle']/span[1]
        Should Be Equal    ${source_city_text}   ${my_dict.TO}
        ${destination_city_text}   Get Text     (${multicity_flight_tabs})[2]/following::b[@class='cityContainer-positionHandle']/span[3]
        Should Be Equal    ${destination_city_text}    ${my_dict.TO1}
        ${departure_date_formated}  Format Date    ${first_departure_date_multicity}
        ${departure_date_view_details}  Get Text    (${multicity_flight_tabs})[2]/following::span[@class='graycolor flightDetails-dateDetails-positionHandle']
        Should Be Equal    ${departure_date_formated}   ${departure_date_view_details}
        ${source_air_port_details}  Get Text    (${multicity_flight_tabs})[2]/following::li[@class='ars-lsprice ars-prclist round-flighttime flight-timedata-font10']
        Should Contain    ${source_air_port_details}   ${my_dict.TO}
        ${destination_air_port_details}  Get Text    (${multicity_flight_tabs})[2]/following::li[@class='ars-lsprice ars-prclist round-flighttime flight-timedata-font10'][last()-0]
        Should Contain    ${destination_air_port_details}   ${my_dict.TO1}
        ${departure_date_formated_details}  Format Date For Departure    ${first_departure_date_multicity}
        Should Contain   ${source_air_port_details}   ${departure_date_formated_details}
    END
    IF    "${my_dict.TO2}" != "Null"
        Click Element       (${multicity_flight_tabs})[3]
        Wait Until Element Is Visible    (${multicity_flight_tabs})[3]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
        ${airline_text_search_page}     Get Text    (${multicity_flight_tabs})[3]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
        ${airline_text_search_page}   Extract Airline    ${airline_text_search_page}
        Click Element    ${search_results_scroll_button}
        Sleep    1s
        Click Element    (${multicity_flight_tabs})[3]/following::button[text()='View Details'][1]
        Wait Until Page Contains Element    (${multicity_flight_tabs})[2]/following::span[@class='at-fontweight arct-idcode']   timeout=10s
        Execute Javascript    window.scrollBy(0,200);
        Click Element    (${multicity_flight_tabs})[3]/following::span[@class='at-fontweight arct-idcode']
        ${airline_text}    Get Text    (${multicity_flight_tabs})[3]/following::p[@class='at-fontweight cancellation-details']
        Should Be Equal    ${airline_text_search_page}      ${airline_text}
        ${source_city_text}   Get Text     (${multicity_flight_tabs})[3]/following::b[@class='cityContainer-positionHandle']/span[1]
        Should Be Equal    ${source_city_text}   ${my_dict.TO1}
        ${destination_city_text}   Get Text     (${multicity_flight_tabs})[3]/following::b[@class='cityContainer-positionHandle']/span[3]
        Should Be Equal    ${destination_city_text}    ${my_dict.TO2}
        ${departure_date_formated}  Format Date    ${second_departure_date_multicity}
        ${departure_date_view_details}  Get Text    (${multicity_flight_tabs})[3]/following::span[@class='graycolor flightDetails-dateDetails-positionHandle']
        Should Be Equal    ${departure_date_formated}   ${departure_date_view_details}
        ${source_air_port_details}  Get Text    (${multicity_flight_tabs})[3]/following::li[@class='ars-lsprice ars-prclist round-flighttime flight-timedata-font10']
        Should Contain    ${source_air_port_details}   ${my_dict.TO1}
        ${destination_air_port_details}  Get Text    (${multicity_flight_tabs})[3]/following::li[@class='ars-lsprice ars-prclist round-flighttime flight-timedata-font10'][last()-0]
        Should Contain    ${destination_air_port_details}   ${my_dict.TO2}
        ${departure_date_formated_details}  Format Date For Departure    ${second_departure_date_multicity}
        Should Contain   ${source_air_port_details}   ${departure_date_formated_details}
    END
    IF    "${my_dict.TO3}" != "Null"
        Click Element       (${multicity_flight_tabs})[4]
        Wait Until Element Is Visible    (${multicity_flight_tabs})[3]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
        ${airline_text_search_page}     Get Text    (${multicity_flight_tabs})[3]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
        ${airline_text_search_page}   Extract Airline    ${airline_text_search_page}
        Click Element    ${search_results_scroll_button}
        Sleep    1s
        Click Element    (${multicity_flight_tabs})[3]/following::button[text()='View Details'][1]
        Wait Until Page Contains Element    (${multicity_flight_tabs})[3]/following::span[@class='at-fontweight arct-idcode']   timeout=10s
        Execute Javascript    window.scrollBy(0,200);
        Click Element    (${multicity_flight_tabs})[3]/following::span[@class='at-fontweight arct-idcode']
        ${airline_text}    Get Text    (${multicity_flight_tabs})[3]/following::p[@class='at-fontweight cancellation-details']
        Should Be Equal    ${airline_text_search_page}      ${airline_text}
        ${source_city_text}   Get Text     (${multicity_flight_tabs})[3]/following::b[@class='cityContainer-positionHandle']/span[1]
        Should Be Equal    ${source_city_text}   ${my_dict.TO2}
        ${destination_city_text}   Get Text     (${multicity_flight_tabs})[3]/following::b[@class='cityContainer-positionHandle']/span[3]
        Should Be Equal    ${destination_city_text}    ${my_dict.TO3}
        ${departure_date_formated}  Format Date    ${third_departure_date_multicity}
        ${departure_date_view_details}  Get Text    (${multicity_flight_tabs})[3]/following::span[@class='graycolor flightDetails-dateDetails-positionHandle']
        Should Be Equal    ${departure_date_formated}   ${departure_date_view_details}
        ${source_air_port_details}  Get Text    (${multicity_flight_tabs})[3]/following::li[@class='ars-lsprice ars-prclist round-flighttime flight-timedata-font10']
        Should Contain    ${source_air_port_details}   ${my_dict.TO2}
        ${destination_air_port_details}  Get Text    (${multicity_flight_tabs})[3]/following::li[@class='ars-lsprice ars-prclist round-flighttime flight-timedata-font10'][last()-0]
        Should Contain    ${destination_air_port_details}   ${my_dict.TO3}
        ${departure_date_formated_details}  Format Date For Departure    ${third_departure_date_multicity}
        Should Contain   ${source_air_port_details}   ${departure_date_formated_details}
    END
    IF    "${my_dict.TO4}" != "Null"
        Click Element       (${multicity_flight_tabs})[5]
        Wait Until Element Is Visible    (${multicity_flight_tabs})[4]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
        ${airline_text_search_page}     Get Text    (${multicity_flight_tabs})[4]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
        ${airline_text_search_page}   Extract Airline    ${airline_text_search_page}
        Click Element    ${search_results_scroll_button}
        Sleep    1s
        Click Element    (${multicity_flight_tabs})[4]/following::button[text()='View Details'][1]
        Wait Until Page Contains Element    (${multicity_flight_tabs})[4]/following::span[@class='at-fontweight arct-idcode']   timeout=10s
        Execute Javascript    window.scrollBy(0,200);
        Click Element    (${multicity_flight_tabs})[4]/following::span[@class='at-fontweight arct-idcode']
        ${airline_text}    Get Text    (${multicity_flight_tabs})[4]/following::p[@class='at-fontweight cancellation-details']
        Should Be Equal    ${airline_text_search_page}      ${airline_text}
        ${source_city_text}   Get Text     (${multicity_flight_tabs})[4]/following::b[@class='cityContainer-positionHandle']/span[1]
        Should Be Equal    ${source_city_text}   ${my_dict.TO3}
        ${destination_city_text}   Get Text     (${multicity_flight_tabs})[4]/following::b[@class='cityContainer-positionHandle']/span[3]
        Should Be Equal    ${destination_city_text}    ${my_dict.TO4}
        ${departure_date_formated}  Format Date    ${fourth_departure_date_multicity}
        ${departure_date_view_details}  Get Text    (${multicity_flight_tabs})[4]/following::span[@class='graycolor flightDetails-dateDetails-positionHandle']
        Should Be Equal    ${departure_date_formated}   ${departure_date_view_details}
        ${source_air_port_details}  Get Text    (${multicity_flight_tabs})[4]/following::li[@class='ars-lsprice ars-prclist round-flighttime flight-timedata-font10']
        Should Contain    ${source_air_port_details}   ${my_dict.TO3}
        ${destination_air_port_details}  Get Text    (${multicity_flight_tabs})[4]/following::li[@class='ars-lsprice ars-prclist round-flighttime flight-timedata-font10'][last()-0]
        Should Contain    ${destination_air_port_details}   ${my_dict.TO4}
        ${departure_date_formated_details}  Format Date For Departure    ${fourth_departure_date_multicity}
        Should Contain   ${source_air_port_details}   ${departure_date_formated_details}
    END
    IF    "${my_dict.TO5}" != "Null"
        Click Element       (${multicity_flight_tabs})[6]
        Wait Until Element Is Visible    (${multicity_flight_tabs})[5]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
        ${airline_text_search_page}     Get Text    (${multicity_flight_tabs})[5]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
        ${airline_text_search_page}   Extract Airline    ${airline_text_search_page}
        Click Element    ${search_results_scroll_button}
        Sleep    1s
        Click Element    (${multicity_flight_tabs})[5]/following::button[text()='View Details'][1]
        Wait Until Page Contains Element    (${multicity_flight_tabs})[2]/following::span[@class='at-fontweight arct-idcode']   timeout=10s
        Execute Javascript    window.scrollBy(0,200);
        Click Element    (${multicity_flight_tabs})[5]/following::span[@class='at-fontweight arct-idcode']
        ${airline_text}    Get Text    (${multicity_flight_tabs})[5]/following::p[@class='at-fontweight cancellation-details']
        Should Be Equal    ${airline_text_search_page}      ${airline_text}
        ${source_city_text}   Get Text     (${multicity_flight_tabs})[5]/following::b[@class='cityContainer-positionHandle']/span[1]
        Should Be Equal    ${source_city_text}   ${my_dict.TO4}
        ${destination_city_text}   Get Text     (${multicity_flight_tabs})[5]/following::b[@class='cityContainer-positionHandle']/span[3]
        Should Be Equal    ${destination_city_text}    ${my_dict.TO5}
        ${departure_date_formated}  Format Date    ${fifth_departure_date_multicity}
        ${departure_date_view_details}  Get Text    (${multicity_flight_tabs})[5]/following::span[@class='graycolor flightDetails-dateDetails-positionHandle']
        Should Be Equal    ${departure_date_formated}   ${departure_date_view_details}
        ${source_air_port_details}  Get Text    (${multicity_flight_tabs})[5]/following::li[@class='ars-lsprice ars-prclist round-flighttime flight-timedata-font10']
        Should Contain    ${source_air_port_details}   ${my_dict.TO4}
        ${destination_air_port_details}  Get Text    (${multicity_flight_tabs})[5]/following::li[@class='ars-lsprice ars-prclist round-flighttime flight-timedata-font10'][last()-0]
        Should Contain    ${destination_air_port_details}   ${my_dict.TO5}
        ${departure_date_formated_details}  Format Date For Departure    ${fifth_departure_date_multicity}
        Should Contain   ${source_air_port_details}   ${departure_date_formated_details}
    END


Verify Departure date
   [Arguments]     ${search_data}
   @{source_dates}=    Get Webelements     ${departure_date_text}
   ${indexing}     Set Variable    1
   FOR    ${element}    IN    @{source_dates}
       ${start_date}    Get Text    ${element}
       ${selected_start_date}     Format Date For Departure    ${selected_departure_date}
       Should Contain    ${selected_start_date}     ${start_date}
   END


Verify Preferred Airline
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary    &{search_data}
    Wait Until Element Is Visible    ${ailine_searched_text}
    ${status}   Run Keyword And Return Status    Should Not Be Equal As Strings    '${my_dict.SelectPrefereedAirline}'    'Null'
    IF    ${status} == True
        @{airlines_on_search_page}    Get Webelements    ${ailine_searched_text}
        FOR    ${element}    IN    @{airlines_on_search_page}
            ${element_source}=   Get Text     ${element}
            ${extracted_airline_name}   Extract Airline    ${element_source}
            ${extracted_airline_name}   Evaluate    "${extracted_airline_name}".lower()
            ${my_dict.SelectPrefereedAirline}   Evaluate    "${my_dict.SelectPrefereedAirline}".lower()
            Should Contain  ${my_dict.SelectPrefereedAirline}    ${extracted_airline_name}
        END
    ELSE
       Fail
    END


Verify Destination City
   [Arguments]    ${my_dict}
   Sleep    2
   ${destination_city's}=    Get WebElements     ${destination_cities}
   FOR    ${city}    IN    @{destination_city's}
       ${destination_city}   Get Text     ${city}
       ${match_result}    Check For Match    ${formatted_destination_city_list}    ${destination_city}
       IF    "${match_result}"=="True"
           Continue For Loop
       ELSE
           Fail
       END
   END


Verify Details In Modify Search
    [Arguments]    ${my_dict}
    IF    "${my_dict.TO1}" != "Null"
        Verify Source Details In Modify Tab | Multicity    ${my_dict}
        Verify Destination Details In Modify Tab | Multicity    ${my_dict}
    ELSE
        # One way | Round Trip
        ${modify_source}=   Get Text     ${source_city_modify}
        Log    ${modify_source}
        Should Contain    ${modify_source}    ${my_dict.From}
        ${modify_destination}=   Get Text     ${destination_city_modify}
        Log    ${modify_destination}
        Should Contain    ${modify_destination}    ${my_dict.TO}
    END


Verify Source Details In Modify Tab | Multicity
    [Arguments]    ${my_dict}
    ${modify_source}=   Get Text     ${source_city_one_modify}
    Log    ${modify_source}
    Should Contain    ${modify_source}    ${my_dict.From}
    IF    "${my_dict.From1}" != "Null"
        ${modify_source}=   Get Text     ${source_city_two_modify}
        Log    ${modify_source}
        Should Contain    ${modify_source}    ${my_dict.From1}
    END


Verify Destination Details In Modify Tab | Multicity
    [Arguments]    ${my_dict}
    ${modify_destination}=   Get Text     ${destination_city_one_modify}
    Log    ${modify_destination}
    Should Contain    ${modify_destination}    ${my_dict.TO}
    IF    "${my_dict.TO1}" != "Null"
        ${modify_destination}=   Get Text     ${destination_city_two_modify}
        Log    ${modify_destination}
        Should Contain    ${modify_destination}    ${my_dict.TO1}
    END
    IF    "${my_dict.TO2}" != "Null"
        ${modify_destination}=   Get Text     ${destination_city_three_modify}
        Log    ${modify_destination}
        Should Contain    ${modify_destination}    ${my_dict.TO2}
    END
    IF    "${my_dict.TO3}" != "Null"
        ${modify_destination}=   Get Text     ${destination_city_four_modify}
        Log    ${modify_destination}
        Should Contain    ${modify_destination}    ${my_dict.TO3}
    END
    IF    "${my_dict.TO4}" != "Null"
        ${modify_destination}=   Get Text     ${destination_city_five_modify}
        Log    ${modify_destination}
        Should Contain    ${modify_destination}    ${my_dict.TO1}
    END    
    ${modify_class}=    Get Text    ${modify_class_text}
    Log    ${modify_class}
    ${class_uppercase}=    Evaluate     "${my_dict.Class}".upper()
    Should Contain    ${modify_class}    ${class_uppercase}
    ${modify_passenger}=    Get Text    ${modify_passenger_text}
    Log    ${modify_passenger}
    IF    "${my_dict.NoOfAdults}">= "1"
        ${element_adults}=    Get Text    ${modify_adults_text}
        Should Contain    ${element_adults}    ${my_dict.NoOfAdults}
        Log    Adults= ${element_adults}
    END
    IF    "${my_dict.NoOfChildren}"> "0"
        ${element_children}=    Get Text    ${modify_children_text}
        Should Contain    ${element_children}    ${my_dict.NoOfChildren}
        Log    Children= ${element_children}
    END


Click On View Details
   Wait Until Element Is Visible   ${view_details_button}
   Click Element    ${view_details_button}
   ${flag}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${flight_details_tab}    5s
   IF    ${flag} == False
       Click Element    ${view_details_button}
       Scroll Element Into View    ${flight_details_tab}
   END
   Scroll Element Into View    ${flight_details_tab}

Verify Different Tabs In View Details
    Click On View Details
    Wait Until Element Is Visible   ${flight_details_tab}    20
    Click Element    ${fare_details_tab}
    Wait Until Element Is Visible    ${fare_details_text}
    Click Element    ${fare_rules_tab}
    Wait Until Element Is Visible    ${detailed_rule_button}    20
    Click Element    ${baggage_allowance_tab}
    Wait Until Element Is Visible    ${baggage_allowance_text}    20


Verify Flight Details In View Details After Search
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary    &{search_data}
    ${airline_text_search_page}     Get Text    ${ailine_searched_text}
    ${airline_text_search_page}   Extract Airline    ${airline_text_search_page}
    Click On View Details
    Click Element    ${view_details_airline_text}
    ${airline_text}    Get Text    ${view_details_airline_hover}
    Should Be Equal    ${airline_text_search_page}      ${airline_text}
    ${source_city_text}   Get Text     ${view_details_source_text}
    Should Be Equal    ${source_city_text}   ${my_dict.From}
    ${destination_city_text}   Get Text     ${view_details_destination_text}
    Should Be Equal    ${destination_city_text}    ${my_dict.TO}
    ${departure_date_formated}  Format Date    ${selected_departure_date}
    ${departure_date_view_details}  Get Text    ${view_details_date_text}
    Should Be Equal    ${departure_date_formated}   ${departure_date_view_details}
    ${source_air_port_details}  Get Text    ${view_details_source_airport}
    Should Contain    ${source_air_port_details}   ${my_dict.From}
    Element Should Contain    ${non_stop_text}     Non-Stop
    ${destination_air_port_details}  Get Text    ${view_details_destination_airport}
    Should Contain    ${destination_air_port_details}   ${my_dict.TO}
    ${departure_date_formated_details}  Format Date For Departure    ${selected_departure_date}
    Should Contain   ${source_air_port_details}   ${departure_date_formated_details}
    Verify Flight Duration
    IF    '${my_dict.ReturnDate}' != 'Null'
        Click Element    ${view_details_button}
        Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
        Scroll Element Into View    //i[@class='fa fa-share-alt']/following::li[contains(@class,'multiair-lines-list')]
        ${airline_text_search_page}     Get Text    //i[@class='fa fa-share-alt']/following::li[contains(@class,'multiair-lines-list')]
        ${airline_text_search_page}   Extract Airline    ${airline_text_search_page}
        Click Element    ${view_details_button_right_section}
        Scroll Element Into View    ${View_round_airline_text}
        Mouse Over    ${View_round_airline_text}
        ${airline_text}    Get Text    ${view_round_airline_hover}
        Should Be Equal    ${airline_text_search_page}      ${airline_text}
        ${source_city_text}   Get Text     ${view_round_source_text}
        Should Be Equal    ${source_city_text}   ${my_dict.TO}
        ${destination_city_text}   Get Text     ${view_round_destination_text}
        Should Be Equal    ${destination_city_text}    ${my_dict.From}
        ${departure_date_formated}  Format Date    ${selected_return_date}
        ${departure_date_view_details}  Get Text    ${view_details_date_text}
        Should Be Equal    ${departure_date_formated}   ${departure_date_view_details}
        ${source_air_port_details}  Get Text    ${view_details_source_airport}
        Should Contain    ${source_air_port_details}   ${my_dict.TO}
        ${destination_air_port_details}  Get Text    ${view_details_destination_airport}
        Element Should Contain    ${non_stop_text}     Non-Stop
        Should Contain    ${destination_air_port_details}   ${my_dict.From}
        ${departure_date_formated_details}  Format Date For Departure    ${selected_return_date}
        Should Contain   ${source_air_port_details}   ${departure_date_formated_details}
        Verify Flight Duration
    END


Verify flight duration
    ${indexing_departure}     Set Variable    1
    ${indexing_arrival}     Set Variable    1
    ${loop_count}     Set Variable    1
    ${no_of_stops}  SeleniumLibrary.Get Element Count    ${view_details_flight_duration}
    WHILE   ${loop_count} <= ${no_of_stops}
        ${departure_time}  Get Text    (${view_details_departure_time})[${indexing_departure}]
        ${departure_time}   Extract Time    ${departure_time}
        ${arrival_time}  Get Text    (${view_details_arrival_time})[${indexing_arrival}]
        ${arrival_time}   Extract Time    ${arrival_time}
        ${flight_duration}    Get Text    (${view_details_flight_duration})[${indexing_arrival}]
        @{flight_duration_hrs}    Split String    ${flight_duration}
        ${flight_duration_hrs_mins}    Catenate    ${flight_duration_hrs}[0]     ${flight_duration_hrs}[1]
        ${calculated_flight_duration}   Calculate Time Difference   ${departure_time}   ${arrival_time}
        Should Contain    ${calculated_flight_duration}     ${flight_duration_hrs_mins}
        ${indexing_arrival}=  Evaluate   ${indexing_arrival} + 1
        ${indexing_departure}=  Evaluate   ${indexing_departure} + 1
        ${loop_count}=  Evaluate   ${loop_count} + 1
    END

Select One Stop Filter
    Wait Until Element Is Visible      ${one_stop_filter}    40
    Click Element   ${one_stop_filter}
    ${status}     Run Keyword And Return Status    Wait Until Element Is Visible        ${unselected_trip_text}
    IF    ${status}
        Wait Until Element Is Visible    ${unselected_trip_text}
        Click Element    ${unselected_trip_text}
        Wait Until Element Is Visible      ${one_stop_filter}    40
        Click Element   ${one_stop_filter}
    END

Select Two Stop Filter
    Wait Until Element Is Visible     ${two_stop_filter}    40
    Click Element   ${two_stop_filter}
    ${status}     Run Keyword And Return Status    Wait Until Element Is Visible        ${unselected_trip_text}
    IF    ${status}
        Wait Until Element Is Visible    ${unselected_trip_text}
        Click Element    ${unselected_trip_text}
        Wait Until Element Is Visible      ${two_stop_filter}    40
        Click Element   ${two_stop_filter}
    END

Select Three Stop Filter
    Wait Until Element Is Visible     ${three_stop_filter}    40
    Click Element   ${three_stop_filter}
    ${status}     Run Keyword And Return Status    Wait Until Element Is Visible        ${unselected_trip_text}
    IF    ${status}
        Wait Until Element Is Visible    ${unselected_trip_text}
        Click Element    ${unselected_trip_text}
        Wait Until Element Is Visible     ${three_stop_filter}   40
        Click Element   ${three_stop_filter}
    END

Select Zero Stop Filter
    Wait Until Element Is Visible     ${zero_stop_filter}    50
    Click Element   ${zero_stop_filter}
    ${status}     Run Keyword And Return Status    Wait Until Element Is Visible        ${unselected_trip_text}
    IF    ${status}
        Wait Until Element Is Visible    ${unselected_trip_text}
        Click Element    ${unselected_trip_text}
        Wait Until Element Is Visible     ${zero_stop_filter}   40
        Click Element   ${zero_stop_filter}
    END


Verify Layover Time
    ${status}    Run Keyword And Return Status    Page Should Contain Element    //button[text()='Please, Modify your search and try again.']
    IF    ${status} == False
        Click On View Details
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
            ${loop_count}=  Evaluate   ${loop_count} + 1
        END
    ELSE
      Log    No Flights available
    END


Verify Error Message Of Flight Time For Round Trip
    Select Two Stop Filter
    ${warning_message}     Set Variable    Departure time must be greater than previous Arrival time by 2hours
    ${search_date}    Get Text    //span[@class='ar-fontrntrip']
    ${search_date}    Split String   ${search_date}
    ${search_date_number}   Convert To Integer    ${search_date}[1]
    ${search_date_number}   Evaluate    ${search_date_number} + 1
    Convert To String    ${search_date_number}
    ${date}    Catenate    ${search_date}[0]   ${search_date_number}
    ${selected_departure_fare}     Replace String    ${return_fare_radio_button}   date    ${date}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Scroll Element Into View    ${selected_departure_fare}
    Click Element    ${selected_departure_fare}
    Click Element    ${book_button}
    Wait Until Page Contains    ${warning_message}

Select One Direct And One Connecting Flight For Round Trip
   Select One Stop Filter
   Wait Until Element Is Visible    //li[@class='multicity__wrapper--cityname ']
   Click Element   //li[@class='multicity__wrapper--cityname ']
   Select Zero Stop Filter
   Sleep    2s


Modify Search Data
    [Arguments]     ${search_data}
    ${my_dict}=    Create Dictionary   &{search_data}
    Click Element    ${modify_button}
    Click Element    (${modify_clear_button})[1]
    Input Text    ${where_from_field}   ${my_dict.FromInModify}
    Wait Until Element Is Visible    ${select_airport}
    Wait Until Page Contains Element    ${select_airport}
    Click Element    ${select_airport}
    Click Element    (${modify_clear_button})[2]
    Input Text    ${where_to_field}     ${my_dict.ToInModify}
    Wait Until Page Contains Element    ${select_airport}
    Click Element    ${select_airport}
    Click Element    ${search_button}
    Wait Until Element Is Visible   ${cheapest_flight_filter}     timeout=180s

Select Cross-Airline Flight For Round Trip
    Run Keyword And Ignore Error      Scroll Element Into View      //i[@class='fa fa-plus pull-right filter-minus'][last()-0]
    Sleep    5
    Click Element    //p[text()='Onward']/span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::i[@class='fa fa-check']
    Run Keyword And Ignore Error      Scroll Element Into View      //i[@class='fa fa-plus pull-right filter-minus'][last()-0]
    ${ailine_text}  Get Text    //p[text()='Return']/span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::span[@class='flight__airline__name' and not(contains(text(),'Multi Airline'))]
    Click Element    (//p[text()='Return']/span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::span[@class='flight__airline__name' and not(contains(text(),'${ailine_text}'))]/../descendant::i[@class='fa fa-check'])[1]
    Wait Until Element Is Visible    ${select_return_flight}    10
    Click Element    ${select_return_flight}

Select Cross-Airline Connecting Flight For Round Trip
    Run Keyword And Ignore Error      Scroll Element Into View      //i[@class='fa fa-plus pull-right filter-minus'][last()-0]
    Click Element    //p[text()='Onward']/span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::i[@class='fa fa-check']
    Run Keyword And Ignore Error      Scroll Element Into View      //i[@class='fa fa-plus pull-right filter-minus'][last()-0]
    ${ailine_text}  Get Text    //p[text()='Return']/span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::span[@class='flight__airline__name' and not(contains(text(),'Multi Airline'))]
    Click Element    (//p[text()='Return']/span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::span[@class='flight__airline__name' and not(contains(text(),'${ailine_text}'))]/../descendant::i[@class='fa fa-check'])[3]
    Wait Until Element Is Visible    ${select_return_flight}    10
    Click Element    ${select_return_flight}

Select Cross-Airline Flight For Round Trip For International
    Run Keyword And Ignore Error    Scroll Element Into View    //p[@class="al-prresets pb-10" or text()='Onward']//span[text()='Airlines']//following::span[@class="flight__airline__name"][2]
    Click Element    //p[text()='Onward']/span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::i[@class='fa fa-check']
    ${ailine_text}  Get Text    //p[text()='Return']/span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::span[@class='flight__airline__name' and not(contains(text(),'Multi Airline'))]
    Run Keyword And Ignore Error      Scroll Element Into View      //i[@class='fa fa-plus pull-right filter-minus'][last()-0]
    Sleep    30s
    Click Element    (//p[text()='Return']/span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::span[@class='flight__airline__name' and not(contains(text(),'${ailine_text}'))]/../descendant::i[@class='fa fa-check'])[2]
    Wait Until Element Is Visible    ${select_return_flight}    10
    Click Element    ${select_return_flight}


Click On Fare Rules from view details section
    [Arguments]     ${search_data}
    ${my_dict}        Create Dictionary   &{search_data}
    Click Element    ${fare_rules_tab}
    Wait Until Element Is Visible    ${detailed_rule_button}
    Click Element    ${detailed_rule_button}
    Switch Window     locator=NEW
    ${status}   Run Keyword And Return Status    Element Should Be Visible   ${fare_rules_tab}
    IF    ${status} == "True"
        ${detailed_rule_flight_text}    Get Text    //button[contains(@class,'fare-rules-tabs')]
        Should Contain    ${detailed_rule_flight_text}    ${my_dict.From}
        Should Contain    ${detailed_rule_flight_text}    ${my_dict.TO}
        Element Should Be Visible    //h3[text()='Conditions']
    ELSE
        Page Should Contain    No Fare Rule Found. Please contact Customer Care!!!
    END
    
    
Verify Direct Flights
    ${all_stop_flights}=    Get Webelements    ${stops_flight_text}
    FOR    ${element}    IN     @{all_stop_flights}
        ${stops}=    Get Text    ${element}
        Should Be Equal As Strings    ${stops}   Non-Stop
    END


Click On Fare Details from view details section
    Wait Until Element Is Visible    ${fare_details_tab}
    Click Element    ${fare_details_tab}


Verify Pax Details SectionIn Fare
    [Arguments]    ${search_result}
    ${my_dict}=    Create Dictionary   &{search_result}
    Click Element    ${pax_details_fare_details}
    ${tooltip_text}    Get Text    ${pax_details_tooltip_text_fare_details}
    ${words}    Split String    ${tooltip_text}
    ${noa_string}    Convert To String    ${my_dict.NoOfAdults}
    ${noc_string}    Convert To String    ${my_dict.NoOfChildren}
    ${noi_string}    Convert To String    ${my_dict.NoOfInfant}
    Should Contain    ${tooltip_text}    ${noa_string}
    Should Contain        ${tooltip_text}    ${noc_string}
    Should Contain        ${tooltip_text}    ${noi_string}
    Click On View Details
    Click On Fare Details from view details section
    ${adults}    Get Text    ${no_of_adults_fare_details}
    ${childs}    Get Text    ${no_of_child_fare_details}
    ${infants}    Get Text    ${no_of_infant_fare_details}
    Should End With    ${adults}    ${noa_string}
    Should End With    ${childs}    ${noc_string}
    Should End With    ${infants}    ${noi_string}


Verify Fare Types | Regular Fare
    [Arguments]     ${search_data}
    ${my_dict}=    Create Dictionary   &{search_data}
    ${fare_types}=     Create List           Published    Flexi Plus    Published-in green color    Instant Offer Fare    SME    Promo    Lite    Premium Flex  Comfort  Comfort Plus   Family  Eco Standard
    Sleep    30s
#    Wait Until Page Contains Element    //p[@class='flight-segmentcolor']    timeout=40s
    Wait Until Page Contains Element    //span[contains(@class,'ars-flightlabel')]    timeout=40s
    Run Keyword If    '${my_dict.SelectFareType}' in ${fare_types}     Log    It matches one of the specified values
    ${student_fare}=    Get Webelements    ${fare_type_search_page}
    FOR    ${element}    IN    @{student_fare}
        ${fare_type_search_result}=    Get Text    ${element}
        List Should Contain Value    ${fare_types}  ${fare_type_search_result}
    END


Verify Fare Types | Student Fare | Senior Citizen Fare For One Way And Round Trip
   [Arguments]     ${search_data}
   ${my_dict}=    Create Dictionary   &{search_data}
   Scroll Element Into View    (${view_details_button})[last()]
   Sleep    10s
   IF    "${my_dict.SelectFareType}" == "Student Fares"
       ${student_fare}=    Get Webelements    ${fare_type_search_page}
       FOR    ${element}    IN    @{student_fare}
           ${fare_type}=    Get Text    ${element}
           ${fare_type}=    Run Keyword And Return Status    Should Contain    ${fare_type}    Student
           IF    "${fare_type}"=="False"
               Log    "No Student Fares"
               Fail
           END
       END
       IF   '${my_dict.ReturnDate}' != 'Null'
            ${student_fare_round_trip}=    Get Webelements    //i[@class='fa fa-share-alt']/following::span[contains(@class,'ars-flightlabel-positionHandle')]
            FOR    ${element}    IN    @{student_fare_round_trip}
               ${fare_type}=    Get Text    ${element}
               ${fare_type}=    Run Keyword And Return Status    Should Contain    ${fare_type}    Student
               IF    "${fare_type}"=="False"
                   Log    "No Student Fares"
                   Fail
               END
           END
       END
   ELSE IF    "${my_dict.SelectFareType}"== "Senior Citizen Fares"
       ${senior_citizen_fare}=    Get Webelements    ${fare_type_search_page}
       ${search_page_faretypes}    Create List
       FOR    ${element}    IN    @{senior_citizen_fare}
           ${fare_type}=    Get Text    ${element}
           Append To List    ${search_page_faretypes}   ${fare_type}
       END
       Should Contain    ${search_page_faretypes}   Senior Citizen
       IF   '${my_dict.ReturnDate}' != 'Null'
            ${senior_fare_round_trip}=    Get Webelements    //i[@class='fa fa-share-alt']/following::span[contains(@class,'ars-flightlabel-positionHandle')]
            FOR    ${element}    IN    @{senior_fare_round_trip}
               ${fare_type}=    Get Text    ${element}
               ${fare_type}=    Run Keyword And Return Status    Should Contain    ${fare_type}    Senior Citizen
               IF    "${fare_type}"=="False"
                   Log    "No Student Fares"
                   Fail
               END
           END
       END
   END



Update Agent MarkUp On Search Page
   [Arguments]    ${search_data}
   ${my_dict}=    Create Dictionary   &{search_data}
   ${list}     Get WebElements    ${parentlist_flightsearch}
   ${length}      Get Length    ${list}
   Execute Javascript    window.scrollBy(0,-600);
   FOR    ${counter}    IN RANGE    1    ${length}+1
       ${count}      Convert To String    ${counter}
       ${fare_price}     Replace String      ${fare_price_to_be_replaced}        replace        ${count}
       Scroll Element Into View    ${fare_price}
       ${amount}=    Convert To Integer    ${my_dict.MarkupAmount}
       ${current_amount}    Get Text    ${fare_price}
       ${num_current_amount}    Extract Final Fare As String    ${current_amount}
       ${num_current_amount}=    Convert To Number   ${num_current_amount}
       Log    ${num_current_amount}
       Scroll Element Into View    ${fare_price}
       Wait Until Element Is Enabled    ${fare_price}
       Click Element    ${fare_price}
       Input Text    ${markup_price_field}    ${amount}
       Click Element    ${markup_update_btn}
       Sleep    2s
       ${updated_amount}   Get Text    ${fare_price}
       ${num_updated_amount}    Extract Final Fare As String    ${updated_amount}
       ${cal_current_amount}=     Evaluate   ${num_current_amount}+${amount}
       Should Be Equal As Numbers    ${num_updated_amount}    ${cal_current_amount}
       Log    "${num_updated_amount}":"${cal_current_amount}"
   END


Update All Agent Markup On Search Page
   [Arguments]    ${search_data}
   ${my_dict}=    Create Dictionary   &{search_data}
   ${increment}  Set Variable    1
   WHILE    ${increment}>0
       ${status}  Run Keyword And Return Status     Wait Until Element Is Visible    (${view_details_button})[${increment}]
       IF    ${status}
           Scroll Element Into View  (${view_details_button})[${increment}]
           Run Keyword And Ignore Error    Click Element   ${expand_arrow_button}
           IF  '${my_dict.ReturnDate}' != 'Null'
                   Run Keyword And Ignore Error   Click Element   //i[@class='fa fa-share-alt']/following::span[@class='flight__dropdown__icon']
           END
           ${increment}   Evaluate    ${increment} + 1
       ELSE
           BREAK
       END
   END
   @{before_mark_up}     Create List
   @{before_markup_round_trip}     Create List
   IF  '${my_dict.ReturnDate}' != 'Null'
        ${fare_prices}    Get Webelements    //i[@class='fa fa-share-alt']/preceding::span[@class='fare__amount']
        ${fare_prices_round_trip}    Get Webelements    //i[@class='fa fa-share-alt']/following::span[@class='fare__amount']
   ELSE
       ${fare_prices}    Get Webelements   ${fare_amounts_searchpage}
   END
   FOR    ${price}  IN  @{fare_prices}
        ${fares}     Get Text    ${price}
        ${fare_symbol_removed}  Extract Final Fare As String    ${fares}
        ${fare_numbers}  Convert To Number    ${fare_symbol_removed}
        Append To List    ${before_mark_up}   ${fare_symbol_removed}
   END
   IF  '${my_dict.ReturnDate}' != 'Null'
       FOR    ${price}  IN  @{fare_prices_round_trip}
            ${fares}     Get Text    ${price}
            ${fare_symbol_removed}  Extract Final Fare As String    ${fares}
            ${fare_numbers}  Convert To Number    ${fare_symbol_removed}
            Append To List    ${before_markup_round_trip}   ${fare_symbol_removed}
       END
   END
   Log    ${before_mark_up}
   Log    ${before_markup_round_trip}
   Scroll Element Into View    (${fare_amounts_searchpage})[1]
   Click Element    (${fare_amounts_searchpage})[1]
   Input Text    ${markup_price_field}   ${my_dict.MarkupAmount}
   Wait Until Element Is Visible    ${markup_update_all_btn}
   Sleep    1s
   Click Element     ${markup_update_all_btn}
   Sleep    10s
   IF  '${my_dict.ReturnDate}' != 'Null'
        Scroll Element Into View    //i[@class='fa fa-share-alt']/following::span[@class='fare__amount']
        Click Element    //i[@class='fa fa-share-alt']/following::span[@class='fare__amount']
        Input Text    //i[@class='fa fa-share-alt']/following::input[@id='markupPrice_feild']   ${my_dict.MarkupAmount}
        Wait Until Element Is Visible    //i[@class='fa fa-share-alt']/following::button[@class='markup__update-btn']
        Sleep    5s
        Click Element    //i[@class='fa fa-share-alt']/following::button[@class='markup__update-btn']
        Wait Until Element Is Not Visible    //i[@class='fa fa-share-alt']/following::button[@class='markup__update-btn']   timeout=50s
   END
   @{calculated_mark_up}     Create List
   @{calculated_mark_up_round_trip}    Create List
   IF  '${my_dict.ReturnDate}' != 'Null'
       FOR    ${element}   ${element_roundtrip}  IN ZIP  ${before_mark_up}  ${before_markup_round_trip}
            ${fares_markup}  Evaluate    ${element} + ${my_dict.MarkupAmount}
            ${fares_markup}    Convert To Float With Two Decimals    ${fares_markup}
            ${fares_markup_roundtrip}  Evaluate    ${element_roundtrip} + ${my_dict.MarkupAmount}
            ${fares_markup_roundtrip}    Convert To Float With Two Decimals    ${fares_markup_roundtrip}
            Append To List   ${calculated_mark_up}   ${fares_markup}
            Append To List   ${calculated_mark_up_round_trip}   ${fares_markup_roundtrip}
       END
   ELSE
       FOR    ${element}  IN  @{before_mark_up}
            Log To Console    ${element}
            ${fares_markup}  Evaluate    ${element} + ${my_dict.MarkupAmount}
            ${fares_markup}    Convert To Float With Two Decimals    ${fares_markup}
            Append To List   ${calculated_mark_up}   ${fares_markup}
       END
   END
   Log    ${calculated_mark_up}
   Log    ${calculated_mark_up_round_trip}
   @{after_mark_up}     Create List
   @{after_markup_roundtrip}    Create List
   IF  '${my_dict.ReturnDate}' != 'Null'
        ${fare_prices}    Get Webelements    //i[@class='fa fa-share-alt']/preceding::span[@class='fare__amount']
        ${fare_prices_roundtrip}    Get Webelements    //i[@class='fa fa-share-alt']/following::span[@class='fare__amount']
   ELSE
       ${fare_prices}    Get Webelements   ${fare_amounts_searchpage}
   END
   IF  '${my_dict.ReturnDate}' != 'Null'
       FOR    ${price}  ${price_roundtrip}  IN ZIP   ${fare_prices}    ${fare_prices_roundtrip}
          ${fares}     Get Text    ${price}
          ${fare_symbol_removed}  Extract Final Fare As String   ${fares}
          ${fares_rt}     Get Text    ${price_roundtrip}
          ${fare_symbol_removed_rt}  Extract Final Fare As String   ${fares_rt}
          Append To List    ${after_mark_up}   ${fare_symbol_removed}
          Append To List     ${after_markup_roundtrip}   ${fare_symbol_removed_rt}
          Log    ${after_mark_up}
          Log    ${after_markup_roundtrip}
       END
        Should Be Equal     ${after_mark_up}     ${calculated_mark_up}
        Should Be Equal     ${after_markup_roundtrip}     ${calculated_mark_up_roundtrip}
   ELSE
       FOR    ${price}   IN   @{fare_prices}
          ${fares}     Get Text    ${price}
          ${fare_symbol_removed}  Extract Final Fare As String   ${fares}
          Append To List    ${after_mark_up}   ${fare_symbol_removed}
       END
       Should Be Equal     ${after_mark_up}     ${calculated_mark_up}
   END


Verify expand arrow button | One way
   ${flight_count}    Get Webelements    ${view_details_button}
   ${length}      Get Length    ${flight_count}
   Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
   FOR    ${flight_value}    IN RANGE   1    ${length}+1
       ${count}      Convert To String    ${flight_value}
       ${fare_price}     Replace String      ${all_fare_amounts_to_be_replaced}        replace        ${count}
       ${is_arrow_present}     Run Keyword And Return Status   Element Should Be Visible    ${expand_arrow_button}
       IF    "${is_arrow_present}" == "${True}"
           ${click_status}    Run Keyword And Return Status    Page Should Contain Element    ${expand_arrow_button}
           IF    "${click_status}"=="${True}"
               Scroll Element Into View    ${expand_arrow_button}
               Execute Javascript    window.scrollBy(0,100);
               Click Element    ${expand_arrow_button}
               Log    Expand Arrow is clickable
           ELSE
               Log    Expand Arrow is not clickable
               Fail
           END
       END
       ${all_fare_amount}=    Get Webelements    ${fare_price}
       ${list}    Create List
       FOR    ${fare_amount}    IN    @{all_fare_amount}
           Sleep    2
           ${current_amount}    Get Text    ${fare_amount}
           ${num_current_amount}    Extract Final Fare As String    ${current_amount}
           ${num_current_amount}=    Convert To Number   ${num_current_amount}
           Append To List   ${List}      ${num_current_amount}
       END
       Log    ${List}
       ${cal_ascending_list}    Ascending Order    ${List}
       Log    ${cal_ascending_list}
       ${status_ascending}    Run Keyword And Return Status    Should Be Equal As Strings    ${List}    ${cal_ascending_list}
       IF    ${status_ascending}
           Log    fare amounts are in ascending order
       ELSE
           Log    fare amounts are not in ascending order
           Fail
       END
   END


Verify expand arrow button | Multicity
   [Arguments]    ${search_data}
   ${my_dict}=    Create Dictionary   &{search_data}
   IF    "${my_dict.TO1}" != "Null"
       Scroll Element Into View    (${multicity_flight_tabs})[2]
       Click Element       (${multicity_flight_tabs})[2]
       Execute Javascript    window.scrollBy(0,-400);
       Wait Until Element Is Visible   (${one_stop_filter})[2]
       Click Element    (${one_stop_filter})[2]
       Verify Expand Arrow Button | One Way
   END
   IF    "${my_dict.TO2}" != "Null"
       Scroll Element Into View    (${multicity_flight_tabs})[3]
       Click Element    (${multicity_flight_tabs})[3]
       Execute Javascript    window.scrollBy(0,-400);
       Wait Until Element Is Visible   (${one_stop_filter})[3]
       Click Element    (${one_stop_filter})[3]
       Verify Expand Arrow Button | One Way
   END
   IF    "${my_dict.TO3}" != "Null"
       Scroll Element Into View    (${multicity_flight_tabs})[4]
       Click Element    (${multicity_flight_tabs})[4]
       Execute Javascript    window.scrollBy(0,-400);
       Wait Until Element Is Visible    (${one_stop_filter})[4]
       Click Element    (${one_stop_filter})[4]
       Verify Expand Arrow Button | One Way
   END
   IF    "${my_dict.TO4}" != "Null"
       Scroll Element Into View    (${multicity_flight_tabs})[5]
       Click Element    (${multicity_flight_tabs})[5]
       Execute Javascript    window.scrollBy(0,-400);
       Wait Until Element Is Visible    (${one_stop_filter})[5]
       Click Element    (${one_stop_filter})[5]
       Verify Expand Arrow Button | One Way
   END
   IF    "${my_dict.TO5}" != "Null"
       Scroll Element Into View    (${multicity_flight_tabs})[6]
       Click Element    (${multicity_flight_tabs})[6]
       Execute Javascript    window.scrollBy(0,-400);
       Wait Until Element Is Visible    (${one_stop_filter})[6]
       Click Element    (${one_stop_filter})[6]
       Verify Expand Arrow Button | One Way
   END


Modify International Search Data
    [Arguments]     ${search_data}
    ${my_dict}=    Create Dictionary   &{search_data}
    Click Element    ${modify_button}
    Click Element    (${modify_clear_button})[1]
    Input Text    ${where_from_field}   ${my_dict.FromInModify}
    Wait Until Element Is Visible    ${select_airport}
    Wait Until Page Contains Element    ${select_airport}
    Click Element    ${select_airport}
    Click Element    (${modify_clear_button})[2]
    Input Text    ${where_to_field}     ${my_dict.ToInModify}
    Wait Until Page Contains Element    ${select_airport}
    Click Element    ${select_airport}
    Click Element    ${search_button}
    Wait Until Element Is Visible   ${cheapest_flight_filter}     timeout=180s




Verify Passenger Class
   [Arguments]     ${search_data}
   ${my_dict}=         Create Dictionary   &{search_data}
   ${flight_count}    Get Webelements    ${total_flights}
   ${length}      Get Length    ${flight_count}
   FOR    ${flight}    IN    ${length}+1
       ${is_arrow_present}     Run Keyword And Return Status   Element Should Be Visible    ${expand_arrow_button}
       IF    "${is_arrow_present}" == "${True}"
           Scroll Element Into View    ${expand_arrow_button}
           Click Element    ${expand_arrow_button}
           Sleep    1
       END
       Wait Until Element Is Visible    ${passenger_class_text}    timeout=30s
       ${passenger_classes}=    Get WebElements     ${passenger_class_text}
       FOR    ${class}    IN    @{passenger_classes}
           Wait Until Element Is Visible    ${class}
           ${passenger_class}=   Get Text     ${class}
           ${extracted_class}    Extract Only Class    ${passenger_class}
           IF    "${my_dict.Class}"=="Business"
               ${multiple_classes}    Create List    First    Business
               ${class_status}    Run Keyword And Return Status    Should Contain    ${multiple_classes}    ${extracted_class}
               IF    ${class_status}==True
                   Log    ${extracted_class}
               ELSE
                   Log    "Different class"
                   Fail
               END
               ${no_flights}=    Run Keyword And Return Status    Page Should Contain Element    ${no_flight_text}
               IF    "${no_flights}"== "True"
                   Log    "There were no flights found for this route"
               END
           ELSE IF    "${my_dict.Class}"=="Premium Economy"
               ${multiple_classes}    Create List    First    Business    Premium Economy
               ${class_status}    Run Keyword And Return Status    Should Contain    ${multiple_classes}    ${extracted_class}
               IF    ${class_status}==True
                   Log    ${extracted_class}
               ELSE
                   Log    "Different class"
                   Fail
              END
               ${no_flights}=    Run Keyword And Return Status    Page Should Contain Element    ${no_flight_text}
               IF    "${no_flights}"== "True"
                   Log    "There were no flights found for this route"
               END
           ELSE IF    "${my_dict.Class}"=="Economy"
               ${multiple_classes}    Create List    First    Business    Premium Economy    Economy
               ${class_status}    Run Keyword And Return Status    Should Contain    ${multiple_classes}    ${extracted_class}
               IF    ${class_status}==True
                   Log    ${extracted_class}
               ELSE
                   Log    "Different class"
                   Fail
              END
               ${no_flights}=    Run Keyword And Return Status    Page Should Contain Element    ${no_flight_text}
               IF    "${no_flights}"== "True"
                   Log    "There were no flights found for this route"
               END
           ELSE IF    "${my_dict.Class}"=="First"
               ${multiple_classes}    Create List    First
               ${class_status}    Run Keyword And Return Status    Should Contain    ${multiple_classes}    ${extracted_class}
               IF    ${class_status}==True
                   Log    ${extracted_class}
               ELSE
                   Log    "Different class"
                   Fail
              END
               ${no_flights}=    Run Keyword And Return Status    Page Should Contain Element    ${no_flight_text}
               IF    "${no_flights}"== "True"
                   Log    "There were no flights found for this route"
               END
            END
       END
       ${result}    Run Keyword And Return Status    Should Contain    ${modify_passenger_text}
       IF    ${result}==True
           Scroll Element Into View    ${passenger_class_text}
       END
   END


Select One Stop
   [Arguments]    ${index}
   Wait Until Page Contains Element    ${one_stop_filter}
   Click Element    (${connecting_flight_filter})[${index}]

Get List Of Source City Airports
   [Return]    ${formatted_sourcecity_list}
   @{sourcelist}    Create List
   ${source_airports}    Get Webelements    ${airport_list}
   FOR    ${counter}    IN    @{source_airports}
           ${city_code}    Get Text    ${counter}
           Append To List    ${sourcelist}    ${city_code}
   END
   ${formatted_sourcecity_list}    extract_values_inside_parentheses    ${sourcelist}
   Set Test Variable    ${formatted_sourcecity_list}


Get List Of Destination City Airports
    [Return]    ${formatted_destination_city_list}
    @{destination_list}    Create List
    ${destination_airports}    Get Webelements    ${airport_list}
    FOR    ${counter}    IN    @{destination_airports}
        ${city_code}    Get Text    ${counter}
        Append To List    ${destinationlist}    ${city_code}
    END
    ${formatted_destination_city_list}    extract_values_inside_parentheses    ${destination_list}
    Set Test Variable    ${formatted_destination_city_list}

Verify Source City
   [Arguments]    ${my_dict}
   Sleep    2
   ${source_city's}=    Get WebElements     ${source_cities}
   FOR    ${city}    IN    @{source_city's}
       ${source_city}=   Get Text     ${city}
       ${match_result}    Check For Match    ${formatted_sourcecity_list}    ${source_city}
       IF    "${match_result}"=="True"
           Continue For Loop
       ELSE
           Fail
       END
   END


Verify Fare Details And Get Fare Summary
    [Arguments]     ${arg_view_detail_btn}
    Wait Until Page Contains Element     ${arg_view_detail_btn}   70s
    Click Element    ${arg_view_detail_btn}
    Wait Until Page Contains Element    ${fare_details_tab}
    Scroll Element Into View    ${fare_details_tab}
    Click Element    ${fare_details_tab}
    Wait Until Page Contains Element     ${adult_base_fare}
    ${adult}=    Run Keyword And Return Status    Page Should Contain Element    ${adult_base_fare}
    ${child}=    Run Keyword And Return Status    Page Should Contain Element    ${child_base_fare}
    ${infant}=    Run Keyword And Return Status    Page Should Contain Element    ${infant_base_fare}
    ${total_base_fare}=     Convert To Integer        0
    ${total_taxes}=    Convert To Integer        0
    ${total_tj_flex}=    Convert To Integer        0
    IF   ${adult}
        ${a_base_fare}=     Get Text    ${adult_base_fare}
        ${a_taxes}=    Get Text    ${adult_taxes}
        ${a_total_base_fare}=    Get Text    ${adult_total_base_price}
        ${a_total_taxes}=    Get Text    ${adult_total_taxes_price}
        Compare Fares Prices    ${a_base_fare}    ${a_taxes}    ${a_total_base_fare}   ${a_total_taxes}
        ${temp_base}=    Extract Final Fare As String    ${a_total_base_fare}
        ${total_base_fare}=    Evaluate     ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${a_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
        IF    ${is_tj_flex}
            ${a_tj_flex}=    Get Text    ${adult_total_tj_flex_fee}
            ${temp_tj_flex}=    Extract Final Fare As String        ${a_tj_flex}
            ${total_tj_flex}=    Evaluate    ${total_tj_flex} + ${temp_tj_flex}
        END
    END
    IF   ${child}
        ${c_base_fare}=     Get Text    ${child_base_fare}
        ${c_taxes}=    Get Text    ${child_taxes}
        ${c_total_base_fare}=    Get Text    ${child_total_base_price}
        ${c_total_taxes}=    Get Text    ${child_total_taxes_price}
        Compare Fares Prices    ${c_base_fare}    ${c_taxes}    ${c_total_base_fare}   ${c_total_taxes}
        ${temp_base}=    Extract Final Fare As String   ${c_total_base_fare}
        ${total_base_fare}=   Evaluate  ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${c_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
        IF    ${is_tj_flex}
            ${c_tj_flex}=    Get Text    ${child_total_tj_flex_fee}
            ${temp_tj_flex}=    Extract Final Fare As String    ${c_tj_flex}
            ${total_tj_flex}=    Evaluate    ${total_tj_flex} + ${temp_tj_flex}
        END
    END
    IF   ${infant}
        ${i_base_fare}=     Get Text    ${infant_base_fare}
        ${i_taxes}=    Get Text    ${infant_taxes}
        ${i_total_base_fare}=    Get Text    ${infant_total_base_price}
        ${i_total_taxes}=    Get Text    ${infant_total_taxes_price}
        Compare Fares Prices    ${i_base_fare}    ${i_taxes}    ${i_total_base_fare}   ${i_total_taxes}
        ${temp_base}=    Extract Final Fare As String    ${i_total_base_fare}
        ${total_base_fare}=  Evaluate    ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${i_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
    END
    ${total}=    Get Text    ${total_fare_price}
    Execute Javascript  window.scroll(0,200)
    Click Element    ${arg_view_detail_btn}
    ${total}=    Extract Final Fare As String    ${total}
    &{fare_summary}=    Create Dictionary    base_fare=${total_base_fare}    taxes=${total_taxes}    total_fare_price=${total}    is_fare_jump=${False}
    RETURN    ${fare_summary}


Emulate To User Id
    [Arguments]    ${fare_rules_data}
    ${my_dict}    Create Dictionary   &{fare_rules_data}
    Click Element   ${manage_user_menu}
    Wait Until Element Is Visible    ${user_id_field}     timeout=10s
    Input Text    ${user_id_field}   ${my_dict.UserIds}
    Wait Until Element Is Visible    ${user_id_option}    timeout=20s
    Click Element    ${user_id_option}
    Wait Until Element Is Enabled    ${user_search_button}    timeout=10s
    Click Element    ${user_search_button}
    Wait Until Element Is Enabled    ${emulate_button}   timeout=20s
    Click Element    ${emulate_button}
    Wait Until Element Is Visible    ${switch_back_button}     timeout=20s

Emulate To User Id For Exclusion
    [Arguments]    ${fare_rules_data}
    ${my_dict}    Create Dictionary   &{fare_rules_data}
    Click Element   ${manage_user_menu}
    Wait Until Element Is Visible    ${user_id_field}     timeout=10s
    Input Text    ${user_id_field}   ${my_dict.ExclusionUserId}
    Wait Until Element Is Visible    ${user_id_option}    timeout=20s
    Click Element    ${user_id_option}
    Wait Until Element Is Enabled    ${user_search_button}    timeout=10s
    Click Element    ${user_search_button}
    Wait Until Element Is Enabled    ${emulate_button}   timeout=20s
    Click Element    ${emulate_button}
    Wait Until Element Is Visible    ${switch_back_button}     timeout=20s

Verify Fare Rule Id
    [Arguments]    ${fare_rules_data}       ${search_data}
    ${my_dict}    Create Dictionary   &{fare_rules_data}
    ${my_dict1}    Create Dictionary   &{search_data}
    Wait Until Element Is Visible    ${fare_id_i_button}
    Sleep    1
    Click Element    ${fare_id_i_button}
    Wait Until Element Is Visible    ${fare_rule_id_text}
    ${fare_rule_id_searchpage}     Get Text    ${fare_rule_id_text}
    IF    '${my_dict1.ReturnDate}' != 'Null'
        Click Element    //i[@class='fa fa-share-alt']/following::span[@class='fa fa-info-circle edit-icon-tiles']
        Wait Until Element Is Visible    (${fare_rule_id_text})[2]
        ${fare_rule_id_roundtrip}     Get Text    (${fare_rule_id_text})[2]
        Should Be Equal    ${fare_rule_id}      ${fare_rule_id_roundtrip}
        Click Element    //i[@class='fa fa-share-alt']/following::button[@class='airlineInfo__headerButton']
    END
    Should Be Equal    ${fare_rule_id}      ${fare_rule_id_searchpage}
    Sleep    1
    ${status}  Run Keyword And Return Status    Element Should Be Visible    //button[@class='airlineInfo__headerButton']
    IF  ${status}
        Wait Until Keyword Succeeds    3x    1s    Click Element    //button[@class='airlineInfo__headerButton']
    END


Verify Baggage Details In View Details
    [Arguments]    ${fare_rules_data}   ${view_details_button}
    ${my_dict}    Create Dictionary   &{fare_rules_data}
    Wait Until Element Is Visible   ${view_details_button}
    Click Element    ${view_details_button}
    Execute JavaScript    window.scrollBy(0,-50)
    Wait Until Element Is Visible    ${baggage_allowance_tab}
    Click Element    ${baggage_allowance_tab}
    ${adult_checkin_details}     Get Text    ${view_details_adult_checkin}
    ${adult_checkin_baggage}    Convert To String    ${my_dict.AdultCheckInBaggage}
    Should Contain Any    ${adult_checkin_details}     ${adult_checkin_baggage}
    ${child_checkin_details}     Get Text    ${view_details_child_checkin}
    ${child_checkin_baggage}    Convert To String     ${my_dict.ChildCheckInBaggage}
    Should Contain    ${child_checkin_details}     ${child_checkin_baggage}
    ${infant_checkin_details}     Get Text    ${view_details_infant_checkin}
    ${infant_checking_baggage}    Convert To String     ${my_dict.InfantCheckInBaggage}
    Should Contain    ${infant_checkin_details}     ${infant_checking_baggage}
    ${adult_baggage_details}     Get Text    ${view_details_adult_handbaggage}
    ${adult_hand_baggage}     Convert To String    ${my_dict.AdultHandBaggage}
    Should Contain    ${adult_baggage_details}     ${adult_hand_baggage}
    ${child_baggage_details}     Get Text    ${view_details_child_handbaggage}
    ${child_hand_baggage}    Convert To String    ${my_dict.ChildHandBaggage}
    Should Contain    ${child_baggage_details}     ${child_hand_baggage}
    ${infant_baggage_details}     Get Text    ${view_details_infant_handbaggage}
    ${infant_hand_baggage}    Convert To String    ${my_dict.InfantHandBaggage}
    Should Contain    ${infant_baggage_details}     ${infant_hand_baggage}
    Click Element    //span[@class='pull-right ars-tbtimes ars-tbtimes-positionHandle']

Verify Fare Taxes And Fees ON I Button
    [Arguments]     ${arg_view_detail_btn}
    Wait Until Page Contains Element     ${arg_view_detail_btn}   10s
    Click Element    ${arg_view_detail_btn}
    Click Element    ${fare_details_tab}
    Wait Until Element Is Visible    ${view_details_total_text}
    ${status}  Run Keyword And Return Status      Wait Until Element Is Visible    ${fare_details_i_button}
    IF     ${status}==True
        Scroll Element Into View    ${fare_details_i_button}
        Mouse Over    ${fare_details_i_button}
        Wait Until Element Is Visible    ${taxes_and_fees_hover}
        ${fares_taxes_count}    SeleniumLibrary.Get Element Count    ${airline_gst_text}
        ${calculated_total_fare_inclusive}  Set Variable    0
        ${indexing}     Set Variable    1
        WHILE   ${indexing} <= ${fares_taxes_count}
            ${total_fare_inclusive}     Get Text    (${airline_gst_text})[${indexing}]
            ${total_fare_inclusive}     Extract Final Fare As String    ${total_fare_inclusive}
            Evaluate    ${calculated_total_fare_inclusive} + ${total_fare_inclusive}
            ${indexing}     Evaluate      ${indexing} + 1
        END
    END

Verify Student Fare Type And Senior Citizen Fare Type Conditions
    ${senior_citizen_conditions}    Set Variable    Only senior citizens above the age of 60 years can avail this special fare. It is mandatory to produce proof of Date of Birth at the airport, without which prevailing fares will be charged.
    ${student_fares_conditions}   Set Variable    Only students above 12 years of age are eligible for special fares and/or additional baggage allowances. Carrying valid student ID cards and student visas (where applicable) is mandatory, else the passenger may be denied boarding or asked to pay for extra baggage.
    Wait Until Element Is Visible    ${student_fares_text}   timeout=10s
    Mouse Over        ${student_fares_text}
    Wait Until Page Contains Element    //label[@for='studentFare' and normalize-space(@data-text='${student_fares_conditions}')]
    Click Element    ${direct_flight_checkbox}
    Mouse Over    ${senior_citizen_text}
    Wait Until Page Contains Element    //label[@for='seniorFare' and normalize-space(@data-text='${senior_citizen_conditions}')]


Click On Flight Tab From Dashboard
    Wait Until Element Is Visible    ${dashboard_flight_text}
    Click Element    ${dashboard_flight_text}


CLick on Last search history and Verify details
    Wait Until Element Is Visible    ${view_last_search}    timeout=10s
    Click Element    ${view_last_search}
    ${last_search_source_city}   Get Text    ${last_source_city_text}
    ${last_search_destination_city}     Get Text    ${last_destination_city_text}
    ${last_search_date}     Get Text    ${last_search_date_text}
    Click Element    ${last_search_button}
    Wait Until Element Is Visible    ${source_city_modify}
    ${search_source_city}   Get Text    ${source_city_modify}
    Should Contain     ${search_source_city}    ${last_search_source_city}
    ${search_destination_city}   Get Text    ${destination_city_modify}
    Should Contain    ${search_destination_city}    ${last_search_destination_city}
    ${search_destination_date}    Get Text    ${departure_date_modify}
    ${last_search_date}    DateTime.Convert Date   ${last_search_date}    result_format=%d-%m-%Y
    ${last_search_date}    Format Date    ${last_search_date}
    Should Be Equal    ${search_destination_date}   ${last_search_date}


Verify All Fare Rule In View Detail
    [Arguments]    ${fare_rules_data}   ${view_details_button}
    ${my_dict}    Create Dictionary   &{fare_rules_data}
    Click Element    ${view_details_button}
    Wait Until Element Is Visible    ${fare_rules_tab}
    Click Element    ${fare_rules_tab}
    Sleep    2
    Scroll Element Into View    //p[@class='fareRules__tabsMessage']
    Wait Until Page Contains     To view charges, click on the below fee sections.
    Wait Until Page Contains    Mentioned fees are Per Pax Per Sector
    Wait Until Page Contains     Apart from airline charges, GST + RAF + applicable charges if any, will be charged.
    Wait Until Element Is Visible    ${detailed_rule_button}
    Wait Until Element Is Visible    ${view_details_cancellation_fees}
    ${time_frame_text}   Get Text    ${view_details_time_frame}
    ${parts}    Split String    ${time_frame_text}    to
    ${time_frame_to}    Set Variable    ${parts}[1]
    ${time_frame_from}    Set Variable    ${parts}[0]
    ${status}   Run Keyword And Return Status    Should Contain    ${time_frame_to}   hrs
    IF      ${status} == True
        ${time_to}    Convert To String    ${my_dict.CancellationTo}
        Should Contain      ${time_frame_to}      ${time_to}
    ELSE
        ${time_to}    Evaluate    ${my_dict.CancellationTo} / 24
        ${time_to}    Convert To Integer    ${time_to}
        ${time_to}    Convert To String    ${time_to}
        Should Contain      ${time_frame_to}      ${time_to}
    END
    ${status}   Run Keyword And Return Status    Should Contain    ${time_frame_from}   hrs
    IF      ${status} == True
        ${time_from}    Convert To String    ${my_dict.CancellationFrom}
        Should Contain      ${time_frame_from}      ${time_from}
    ELSE
        ${time_from}    Evaluate    ${my_dict.CancellationFrom} / 24
        ${time_from}    Convert To String    ${time_from}
        Should Contain      ${time_frame_from}      ${time_from}
    END
    ${cancellation_amount}   Get Text     ${view_details_different_amounts}
    ${cancellation_amount}   Remove String    ${cancellation_amount}    ,
    ${cancellation_amount_testdata}   Convert To String    ${my_dict.CancellationAmount}
    ${additional_cancellation_amount}   Convert To String    ${my_dict.CancellationAdditionalFee}
    Should Contain    ${cancellation_amount}    ${cancellation_amount_testdata}     ${additional_cancellation_amount}
    ${cancellation_policy}    Get Text    ${view_details_fare_policy}
    Should Be Equal As Strings    ${cancellation_policy}     ${my_dict.CancellationPolicyInfo}
    Wait Until Element Is Visible    ${view_date_change_tab}
    Click Element    ${view_date_change_tab}
    ${time_frame_text}   Get Text    ${view_details_time_frame}
    ${parts}    Split String    ${time_frame_text}    to
    ${time_frame_to}    Set Variable    ${parts}[1]
    ${time_frame_from}    Set Variable    ${parts}[0]
    ${status}   Run Keyword And Return Status    Should Contain    ${time_frame_to}   hrs
    IF      ${status} == True
        ${time_to}    Convert To String    ${my_dict.DateChangeTo}
        Should Contain      ${time_frame_to}      ${time_to}
    ELSE
        ${time_to}    Evaluate    ${my_dict.DateChangeTo} / 24
        ${time_to}    Convert To Integer    ${time_to}
        ${time_to}    Convert To String    ${time_to}
        Should Contain      ${time_frame_to}      ${time_to}
    END
    ${status}   Run Keyword And Return Status    Should Contain    ${time_frame_from}   hrs
    IF      ${status} == True
        ${time_from}    Convert To String    ${my_dict.DateChangeFrom}
        Should Contain      ${time_frame_from}      ${time_from}
    ELSE
        ${time_from}    Evaluate    ${my_dict.DateChangeFrom} / 24
        ${time_from}    Convert To String    ${time_from}
        Should Contain      ${time_frame_from}      ${time_from}
    END
    ${date_change_amount}   Get Text    ${view_details_different_amounts}
    ${date_change_amount}   Remove String    ${date_change_amount}    ,
    ${date_change_amount_testdata}   Convert To String    ${my_dict.DateChangeAmount}
    ${additional_date_change_amount}   Convert To String    ${my_dict.DateChangeAdditionalFees}
    Should Contain    ${date_change_amount}    ${date_change_amount_testdata}     ${additional_date_change_amount}
    ${date_change_policy}    Get Text    ${view_details_fare_policy}
    Should Be Equal As Strings    ${date_change_policy}     ${my_dict.DateChangePolicyInfo}
    Wait Until Element Is Visible    ${view_no_show_tab}
    Click Element    ${view_no_show_tab}
    ${time_frame_text}   Get Text    ${view_details_time_frame}
    ${parts}    Split String    ${time_frame_text}    to
    ${time_frame_to}    Set Variable    ${parts}[1]
    ${time_frame_from}    Set Variable    ${parts}[0]
    ${status}   Run Keyword And Return Status    Should Contain    ${time_frame_to}   hrs
    IF      ${status} == True
        ${time_to}    Convert To String    ${my_dict.NoShowTo}
        Should Contain      ${time_frame_to}      ${time_to}
    ELSE
        ${time_to}    Evaluate    ${my_dict.NoShowTo} / 24
        ${time_to}    Convert To Integer    ${time_to}
        ${time_to}    Convert To String    ${time_to}
        Should Contain      ${time_frame_to}      ${time_to}
    END
    ${status}   Run Keyword And Return Status    Should Contain    ${time_frame_from}   hrs
    IF      ${status} == True
        ${time_from}    Convert To String    ${my_dict.NoShowFrom}
        Should Contain      ${time_frame_from}      ${time_from}
    ELSE
        ${time_from}    Evaluate    ${my_dict.NoShowFrom} / 24
        ${time_from}    Convert To String    ${time_from}
        Should Contain      ${time_frame_from}      ${time_from}
    END
    ${no_show_amount}   Get Text    ${view_details_different_amounts}
    ${no_show_amount}   Remove String    ${no_show_amount}    ,
    ${no_show_amount_testdata}   Convert To String    ${my_dict.NoShowAmount}
    ${additional_no_show_amount}   Convert To String    ${my_dict.NoShowAdditionalFee}
    Should Contain    ${no_show_amount}    ${no_show_amount_testdata}     ${additional_no_show_amount}
    ${no_show_policy}    Get Text    ${view_details_fare_policy}
    Should Be Equal As Strings    ${no_show_policy}     ${my_dict.NoShowPolicyInfo}
    Wait Until Element Is Visible    ${view_seat_chargeable_tab}
    Click Element    ${view_seat_chargeable_tab}
    ${time_frame_text}   Get Text    ${view_details_time_frame}
    ${parts}    Split String    ${time_frame_text}    to
    ${time_frame_to}    Set Variable    ${parts}[1]
    ${time_frame_from}    Set Variable    ${parts}[0]
    ${status}   Run Keyword And Return Status    Should Contain    ${time_frame_to}   hrs
    IF      ${status} == True
        ${time_to}    Convert To String    ${my_dict.SeatChargeableTo}
        Should Contain      ${time_frame_to}      ${time_to}
    ELSE
        ${time_to}    Evaluate    ${my_dict.SeatChargeableTo} / 24
        ${time_to}    Convert To Integer    ${time_to}
        ${time_to}    Convert To String    ${time_to}
        Should Contain      ${time_frame_to}      ${time_to}
    END
    ${status}   Run Keyword And Return Status    Should Contain    ${time_frame_from}   hrs
    IF      ${status} == True
        ${time_from}    Convert To String    ${my_dict.SeatChargeableFrom}
        Should Contain      ${time_frame_from}      ${time_from}
    ELSE
        ${time_from}    Evaluate    ${my_dict.SeatChargeableFrom} / 24
        ${time_from}    Convert To String    ${time_from}
        Should Contain      ${time_frame_from}      ${time_from}
    END
    ${seat_chargeable_amount}   Get Text    ${view_details_different_amounts}
    ${seat_chargeable_amount}   Remove String    ${seat_chargeable_amount}    ,
    ${seat_chargeable_amount_testdata}   Convert To String    ${my_dict.SeatChargeableAmount}
    ${additional_seat_chargeable_amount}   Convert To String    ${my_dict.SeatChargeableAdditionalFee}
    Should Contain    ${seat_chargeable_amount}    ${seat_chargeable_amount_testdata}     ${additional_seat_chargeable_amount}
    ${seat_chargeable_policy}    Get Text    ${view_details_fare_policy}
    Should Be Equal As Strings    ${seat_chargeable_policy}     ${my_dict.SeatChargeablePolicyInfo}
    Click Element    //span[@class='pull-right ars-tbtimes ars-tbtimes-positionHandle']


Verify No Flights Found Message
    Wait Until Page Contains    Sorry, There were no flights found for this route Please, Modify your search and try again.
    Element Should Be Visible    ${search_page_retry_button}


Verify Results Filtered According To Cheapest Fare
    ${actual_list}=     Create List
    ${indexing}    Set Variable    1
    ${all_fare_amount_count}=    SeleniumLibrary.Get Element Count       ${fare_amounts}
    FOR    ${indexing}    IN RANGE    1    ${all_fare_amount_count}
        ${element}    Get Text     ${fare_amounts}
        ${element}  Extract Final Fare As String   ${element}
        Append To List     ${actual_list}    ${element}
        Execute JavaScript    window.scrollBy(0,200)
    END
    ${sorted_list}    Ascending Order        ${actual_list}
    ${status}    Run Keyword And Return Status     Lists Should Be Equal    ${actual_list}    ${sorted_list}
    IF    ${status} == False
        Log    "Search results are Not Filtered according to Cheapest Fare"
        Fail
    END


#Select Prefereed Airline
#    [Arguments]     ${airline}
#    Click Element    ${select_preferred_airline_dropdown}
#    ${is_list}=    Run Keyword And Return Status    Evaluate    isinstance(${airline}, list)
#    IF  ${is_list}
#            Wait Until Page Contains Element    ${search_dropdown}
#            Click Element    ${search_dropdown}


Verify Source City And Destination City For Multicity International
   [Arguments]     ${search_data}
   ${my_dict}=         Create Dictionary   &{search_data}
   Wait Until Element Is Visible    ${source_cities}
   ${source_city's}=    Get WebElements     ${multicity_first_source_city}
   FOR    ${city}    IN    @{source_city's}
       ${source_city}=   Get Text     ${city}
       Should Contain    ${multicity_first_source_cities}    ${source_city}
   END
   ${destination_city's}=    Get WebElements     ${multicity_first_destination_city}
   FOR    ${city}    IN    @{destination_city's}
       ${destination_city}   Get Text     ${city}
       Should Contain    ${formatted_destination_city_list}    ${destination_city}
   END
   ${muliticity_second}=    Get Webelements    ${multicity_second_source_city}
   FOR    ${city}    IN    @{muliticity_second}
       ${source_city}   Get Text     ${city}
       Should Contain    ${formatted_destination_city_list}    ${source_city}
   END
   ${muliticity_second}=    Get Webelements    ${multicity_second_destination_city}
   FOR    ${city}    IN    @{muliticity_second}
       ${destination_city}   Get Text     ${city}
       Should Contain    ${multicity_first_city}    ${destination_city}
   END
   ${muliticity_third}=    Get Webelements    ${multicity_third_source_city}
   FOR    ${city}    IN    @{muliticity_third}
       ${source_city}   Get Text     ${city}
       Should Contain    ${multicity_first_city}    ${source_city}
   END
   ${muliticity_third}=    Get Webelements    ${multicity_third_destination_city}
   FOR    ${city}    IN    @{muliticity_third}
       ${destination_city}   Get Text     ${city}
       Should Contain    ${multicity_secound_city}    ${destination_city}
   END
   ${muliticity_forth}=    Get Webelements    ${multicity_fourth_source_city}
   FOR    ${city}    IN    @{muliticity_forth}
       ${source_city}   Get Text     ${city}
       Should Contain    ${multicity_secound_city}    ${source_city}
   END
   ${muliticity_forth}=    Get Webelements    ${multicity_fourth_destination_city}
   FOR    ${city}    IN    @{muliticity_forth}
       ${destination_city}   Get Text     ${city}
       Should Contain    ${multicity_third_city}    ${destination_city}
   END
   ${muliticity_fifth}=    Get Webelements    ${multicity_fifth_source_city}
   FOR    ${city}    IN    @{muliticity_fifth}
       ${source_city}   Get Text     ${city}
       Should Contain    ${multicity_third_city}    ${destination_city}
   END
   ${muliticity_fifth}=    Get Webelements    ${multicity_fifth_destination_city}
   FOR    ${city}    IN    @{muliticity_fifth}
       ${destination_city}   Get Text     ${city}
       Should Contain    ${multicity_fourth_city}    ${destination_city}
   END
   ${muliticity_sixth}=    Get Webelements    ${multicity_sixth_source_city}
   FOR    ${city}    IN    @{muliticity_sixth}
       ${source_city}   Get Text     ${city}
       Should Contain    ${multicity_fourth_city}    ${destination_city}
   END
   ${muliticity_sixth}=    Get Webelements    ${multicity_sixth_destination_city}
   FOR    ${city}    IN    @{muliticity_sixth}
       ${destination_city}   Get Text     ${city}
       Should Contain    ${multicity_fifth_city}    ${destination_city}
   END

Verify Departure Date For Multicity
   [Arguments]     ${search_data}
   @{source_dates}=    Get Webelements     ${multicity_first_departure_date}
   FOR    ${element}    IN    @{source_dates}
       ${start_date}    Get Text    ${element}
       ${selected_start_date}     Format Date For Departure    ${zero_departure_date_multicity}
       Should Contain    ${selected_start_date}    ${start_date}     
   END
   @{source_dates}=    Get Webelements     ${multicity_second_departure_date}
   FOR    ${element}    IN    @{source_dates}
       ${start_date}    Get Text    ${element}
       ${selected_start_date}     Format Date For Departure    ${first_departure_date_multicity} 
       Should Contain    ${selected_start_date}    ${start_date}
   END
   @{source_dates}=    Get Webelements     ${multicity_third_departure_date}
   FOR    ${element}    IN    @{source_dates}
       ${start_date}    Get Text    ${element}
       ${selected_start_date}     Format Date For Departure    ${secound_departure_date_multicity}
       Should Contain      ${selected_start_date}    ${start_date}
   END
   @{source_dates}=    Get Webelements     ${multicity_fourth_departure_date}
   FOR    ${element}    IN    @{source_dates}
       ${start_date}    Get Text    ${element}
       ${selected_start_date}     Format Date For Departure    ${third_departure_date_multicity} 
       Should Contain      ${selected_start_date}    ${start_date} 
   END
   @{source_dates}=    Get Webelements     ${multicity_fifth_departure_date}
   FOR    ${element}    IN    @{source_dates}
       ${start_date}    Get Text    ${element}
       ${selected_start_date}     Format Date For Departure    ${fourth_departure_date_multicity}
       Should Contain      ${selected_start_date}    ${start_date}
   END
   @{source_dates}=    Get Webelements     ${multicity_sixth_departure_date}
   FOR    ${element}    IN    @{source_dates}
       ${start_date}    Get Text    ${element}
       ${selected_start_date}     Format Date For Departure    ${fifth_departure_date_multicity}
       Should Contain      ${selected_start_date}    ${start_date}
   END


Split Flight For International Round Trip
   Reload Page
   Wait Until Element Is Visible    ${roundtrip_split_flights_toggle_button}    60s
   Click Element    ${roundtrip_split_flights_toggle_button}
   Sleep    30


Select Nonstop Flights For Roundtrip
   Sleep    35s
   Execute Javascript    window.scrollBy(0,900);
   Wait Until Element Is Visible    ${select_onward_flight_for_stops_filter}    30s
   Click Element    ${select_onward_flight_for_stops_filter}
   Wait Until Element Is Visible    ${zero_stop_filter}
   Click Element    ${zero_stop_filter}
   Sleep    2s
   Wait Until Element Is Visible    ${select_return_flight_for_stops_filter}    30s
   Click Element    ${select_return_flight_for_stops_filter}
   Click Element    ${zero_stop_filter}


Select Cross Fares For Round Trip
   Sleep    10s
   Wait Until Element Is Visible    ${onward_flight_fare_type_text}    30s
   ${onward_fare}=    Get Text    ${onward_flight_fare_type_text}
   Click Element    (//following::label[contains(@class,'sort-labelfi')])[1]
   Set Test Variable    ${onward_fare}
   Wait Until Element Is Visible    ${select_fare_for_onward_flight}    10
   Click Element    ${select_fare_for_onward_flight}
   ${fare_count}=    SeleniumLibrary.Get Element Count        ${return_flight_fare_count}
   FOR    ${element}    IN RANGE    1     ${fare_count}
       ${element}=    Convert To String    ${element}
       ${return_fare_text}=    Replace String    ${return_flight_fare_type_text}    index     ${element}
       ${return_fare}=    Get Text    ${return_fare_text}
       IF    "${onward_fare}" == "${return_fare}"
           Continue For Loop
       ELSE
           ${select_return_fare}=    Replace String   ${select_fare_for_return_flight}    index    ${element}
           Scroll Element Into View    ${select_return_fare}
           Click Element    ${select_return_fare}
           Exit For Loop
       END
   END
   Set Test Variable    ${return_fare}

Click On Book Button On Search Page
   Wait Until Element Is Visible    ${book_button}    20s
   Run Keyword And Ignore Error    Scroll Element Into View    ${book_button}
   Click Element    ${book_button}


Click on zero stops
   Wait Until Element Is Visible    ${zero_stop_filter}    30s
   Click Element    ${zero_stop_filter}

#Update Single Agent MarkUp On Search Page
#    [Arguments]    ${search_data}
#    ${my_dict}=    Create Dictionary   &{search_data}
#    ${list}     Get WebElements    ${parentlist_flightsearch}
#    ${length}      Get Length    ${list}
##    FOR    ${counter}    IN RANGE    1    ${length}+1
##        ${count}      Convert To String    ${counter}
#        ${fare_price}     Replace String      ${fare_price_to_be_replaced}        replace        ${count}
#    Scroll Element Into View    ${fare_price}
#    ${amount}=    Convert To Number    ${my_dict.MarkupAmount}
#    ${current_amount}    Get Text    ${fare_price}
#    ${num_current_amount}    Extract Final Fare As String    ${current_amount}
#    ${num_current_amount}=    Convert To Number   ${num_current_amount}
#    Log    ${num_current_amount}
#    Scroll Element Into View    ${fare_price}
#    Wait Until Element Is Enabled    ${fare_price}
#    Click Element    ${fare_price}
#    Input Text    ${markup_price_field}    ${amount}
#    Click Element    ${markup_update_btn}
#    Sleep    2s
#    ${updated_amount}   Get Text    ${fare_price}
#    ${num_updated_amount}    Extract Final Fare As String    ${updated_amount}
#    ${cal_current_amount}=     Evaluate   ${num_current_amount}+${amount}
#    Should Be Equal As Numbers    ${num_updated_amount}    ${cal_current_amount}
#    Log    "${num_updated_amount}":"${cal_current_amount}"
##    END
#     [Return]    ${num_updated_amount}

Change Class for GDS Airlines
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Wait Until Element Is Visible    ${arrival_button}    30s
    Wait Until Element Is Visible    ${change_class_link}    20s
    Capture Page Screenshot
    Click Element    ${change_class_link}
    ${select_class}=    Replace String    ${select_class_radiobutton}   classname    ${my_dict.FareClass}
    Wait Until Element Is Visible    ${select_class}    30s
    Click Element    ${select_class}
    Wait Until Element Is Visible    ${get_fare_button}
    Click Element    ${get_fare_button}
    Sleep    10s
    ${fare_summary}=    Verify Fare Details And Get Fare Summary After Changing Class
    [Return]    ${fare_summary}


Verify Fare Details And Get Fare Summary After Changing Class
    Wait Until Page Contains Element    ${fare_details_tab}    10s
    Click Element    ${fare_details_tab}
    Wait Until Page Contains Element     ${adult_base_fare}
    ${adult}=    Run Keyword And Return Status    Page Should Contain Element    ${adult_base_fare}
    ${child}=    Run Keyword And Return Status    Page Should Contain Element    ${child_base_fare}
    ${infant}=    Run Keyword And Return Status    Page Should Contain Element    ${infant_base_fare}
    ${total_base_fare}=     Convert To Integer        0
    ${total_taxes}=    Convert To Integer        0
    ${total_tj_flex}=    Convert To Integer        0
    IF   ${adult}
        ${a_base_fare}=     Get Text    ${adult_base_fare}
        ${a_taxes}=    Get Text    ${adult_taxes}
        ${a_total_base_fare}=    Get Text    ${adult_total_base_price}
        ${a_total_taxes}=    Get Text    ${adult_total_taxes_price}
        Compare Fares Prices    ${a_base_fare}    ${a_taxes}    ${a_total_base_fare}   ${a_total_taxes}
        ${temp_base}=    Extract Final Fare As String    ${a_total_base_fare}
        ${total_base_fare}=    Evaluate     ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${a_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
        IF    ${is_tj_flex}
            ${a_tj_flex}=    Get Text    ${adult_total_tj_flex_fee}
            ${temp_tj_flex}=    Extract Final Fare As String        ${a_tj_flex}
            ${total_tj_flex}=    Evaluate    ${total_tj_flex} + ${temp_tj_flex}
        END
    END
    IF   ${child}
        ${c_base_fare}=     Get Text    ${child_base_fare}
        ${c_taxes}=    Get Text    ${child_taxes}
        ${c_total_base_fare}=    Get Text    ${child_total_base_price}
        ${c_total_taxes}=    Get Text    ${child_total_taxes_price}
        Compare Fares Prices    ${c_base_fare}    ${c_taxes}    ${c_total_base_fare}   ${c_total_taxes}
        ${temp_base}=    Extract Final Fare As String   ${c_total_base_fare}
        ${total_base_fare}=   Evaluate  ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${c_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
        IF    ${is_tj_flex}
            ${c_tj_flex}=    Get Text    ${child_total_tj_flex_fee}
            ${temp_tj_flex}=    Extract Final Fare As String    ${c_tj_flex}
            ${total_tj_flex}=    Evaluate    ${total_tj_flex} + ${temp_tj_flex}
        END
    END
    IF   ${infant}
        ${i_base_fare}=     Get Text    ${infant_base_fare}
        ${i_taxes}=    Get Text    ${infant_taxes}
        ${i_total_base_fare}=    Get Text    ${infant_total_base_price}
        ${i_total_taxes}=    Get Text    ${infant_total_taxes_price}
        Compare Fares Prices    ${i_base_fare}    ${i_taxes}    ${i_total_base_fare}   ${i_total_taxes}
        ${temp_base}=    Extract Final Fare As String    ${i_total_base_fare}
        ${total_base_fare}=  Evaluate    ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${i_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
    END
    ${total}=    Get Text    ${total_fare_price}
    ${total}=    Extract Final Fare As String    ${total}
    &{fare_summary}=    Create Dictionary    base_fare=${total_base_fare}    taxes=${total_taxes}    total_fare_price=${total}    is_fare_jump=${False}
    RETURN    ${fare_summary}


Click Book Button On Change Class
    Wait Until Element Is Visible    ${book_button_on_change_class}    5s
    Click Element    ${book_button_on_change_class}

Change Class for GDS Airlines | Roundtrip
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Wait Until Element Is Visible    ${arrival_button}    30s
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${roundtrip_split_flights_toggle_button}    20s
    ${toggle}=    Run Keyword And Return Status    Page Should Contain Element    ${roundtrip_split_flights_toggle_button}
    IF    ${toggle}
        Split Flight For International Round Trip
        Sleep    10s
    END
    FOR    ${i}    IN RANGE    1    3
        ${i}=    Convert To String    ${i}
        ${onward}=    Replace String    ${select_onward_fare}    index     ${i}
        Wait Until Element Is Visible    ${onward}
        Click Element    ${onward}
        ${return}=    Replace String    ${select_return_fare}    index     ${i}
        Wait Until Element Is Visible    ${return}
        Click Element    ${return}
        ${total_segment1}=    Check Total Segments    (//button[text()='View Details'])[${i}]
        ${tatal_segment2}=    Check Total Segments    ((//div[@class='col-sm-6 domestic_tiles_view'])[2]//child::button[text()='View Details'])[${i}]
        Log    ${total_segment1}
        Log    ${tatal_segment2}
        ${total_segment}=    Add Total Segments    ${total_segment1}    ${tatal_segment2}
#        ${fare_summary_1}     Verify Fare Details And Get Fare Summary    (//button[text()='View Details'])[${i}]
#        ${fare_summary_2}    Verify Fare Details And Get Fare Summary    ((//div[@class='col-sm-6 domestic_tiles_view'])[2]//child::button[text()='View Details'])[${i}]
#        ${fare_summary}     Add Fare Dictionary      ${fare_summary_1}   ${fare_summary_2}
        Capture Page Screenshot
        Wait Until Element Is Visible    ${change_class_link}    10s
        Click Element    ${change_class_link}
        Sleep    10s
        ${flag_to_terminate_class}=    Set Variable    0
        FOR    ${j}    IN RANGE    1     ${total_segment}
            ${j}=    Convert To String    ${j}
            ${class_list}=    Replace String    ${no_class_text}    index     ${j}
            ${status}=    Run Keyword And Return Status    Page Should Contain Element    ${class_list}
            IF    ${status} == 'True'
                ${flag_to_terminate_class}    Set Test Variable    1
            END
        END
        IF    ${flag_to_terminate_class} == 1
            Wait Until Element Is Visible    ${change_class_cross_link}
            Click Element    ${change_class_cross_link}
            Continue For Loop If    ${flag_to_terminate_class} == 1
        END
        ${loop_to_select_class}=    SeleniumLibrary.Get Element Count    //ul[@class='changeclass__wrapper--className']
        FOR    ${index}    IN RANGE    1    ${loop_to_select_class}+1
            ${index}=    Convert To String    ${index}
            ${select_class}=    Replace String        ${index_select_class_radiobutton}        index    ${index}
            Wait Until Element Is Visible    ${select_class}    30s
            Click Element    ${select_class}
        END
        Wait Until Element Is Visible    ${get_fare_button}
        Click Element    ${get_fare_button}
        Sleep    10s
        ${fare_summary_11}     Verify Fare Details And Get Fare Summary for Change Class
        ${fare_summary_22}    Verify Fare Details And Get Fare Summary After Changing Class For Return Flight
        ${fare_summary12}     Add Fare Dictionary      ${fare_summary_11}   ${fare_summary_22}
        Click Book Button On Change Class
        Exit For Loop
    END
    RETURN    ${fare_summary12}


Select Cross Airlines For Round Trip
    Sleep    10s
    Wait Until Element Is Visible    ${first_airline_searched_text}    30s
    ${airline}=    Get Text    ${first_airline_searched_text}
    Execute Javascript    window.scrollBy(0,600);
    ${onward_airline}=    Replace String    ${select_onward_airline}    airlinetxt    ${airline}
    Wait Until Element Is Visible    ${onward_airline}    30s
    Click Element    ${onward_airline}
    ${return_airline}=    Replace String    ${select_return_airline}    airlinetxt    ${airline}
    Wait Until Element Is Visible      ${return_airline}    30s
    Click Element    ${return_airline}


Verify Fare Details And Get Fare Summary After Changing Class for Return Flight
    Wait Until Page Contains Element    ${fare_details_tab_for_roundtrip}
    #    Click Element    ${fare_details_tab_for_roundtrip}
    Wait Until Page Contains Element     ${adult_base_fare}
    ${adult}=    Run Keyword And Return Status    Page Should Contain Element    ${adult_base_fare_for_roundtrip}
    ${child}=    Run Keyword And Return Status    Page Should Contain Element    ${child_base_fare_for_roundtrip}
    ${infant}=    Run Keyword And Return Status    Page Should Contain Element    ${infant_base_fare_for_roundtrip}
    ${total_base_fare}=     Convert To Integer        0
    ${total_taxes}=    Convert To Integer        0
    ${total_tj_flex}=    Convert To Integer        0
    IF   ${adult}
        ${a_base_fare}=     Get Text    ${adult_base_fare_for_roundtrip}
        Log    ${a_base_fare}
        ${a_taxes}=    Get Text    ${adult_taxes_roundtrip}
        ${a_total_base_fare}=    Get Text    ${adult_total_base_price_roundtrip}
        ${a_total_taxes}=    Get Text    ${adult_total_tax_price_roundtrip}
        Compare Fares Prices    ${a_base_fare}    ${a_taxes}    ${a_total_base_fare}   ${a_total_taxes}
        ${temp_base}=    Extract Final Fare As String    ${a_total_base_fare}
        ${total_base_fare}=    Evaluate     ${total_base_fare} + ${temp_base}
        Log    ${total_base_fare}
        ${temp_taxes}=    Extract Final Fare As String    ${a_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
        IF    ${is_tj_flex}
            ${a_tj_flex}=    Get Text    ${adult_total_tj_flex_fee}
            ${temp_tj_flex}=    Extract Final Fare As String        ${a_tj_flex}
            ${total_tj_flex}=    Evaluate    ${total_tj_flex} + ${temp_tj_flex}
        END
    END
    IF   ${child}
        ${c_base_fare}=     Get Text    ${child_base_fare_for_roundtrip}
        ${c_taxes}=    Get Text    ${child_taxes_for_roundtrip}
        ${c_total_base_fare}=    Get Text    ${child_total_base_price_roundtrip}
        ${c_total_taxes}=    Get Text    ${child_total_taxes_price_roundtrip}
        Compare Fares Prices    ${c_base_fare}    ${c_taxes}    ${c_total_base_fare}   ${c_total_taxes}
        ${temp_base}=    Extract Final Fare As String   ${c_total_base_fare}
        ${total_base_fare}=   Evaluate  ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${c_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
        IF    ${is_tj_flex}
            ${c_tj_flex}=    Get Text    ${child_total_tj_flex_fee}
            ${temp_tj_flex}=    Extract Final Fare As String    ${c_tj_flex}
            ${total_tj_flex}=    Evaluate    ${total_tj_flex} + ${temp_tj_flex}
        END
    END
    IF   ${infant}
        ${i_base_fare}=     Get Text    ${infant_base_fare_for_roundtrip}
        ${i_taxes}=    Get Text    ${infant_taxes_roundtrip}
        ${i_total_base_fare}=    Get Text    ${infant_total_base_price_roundtrip}
        ${i_total_taxes}=    Get Text    ${infant_total_taxes_price_roundtrip}
        Compare Fares Prices    ${i_base_fare}    ${i_taxes}    ${i_total_base_fare}   ${i_total_taxes}
        ${temp_base}=    Extract Final Fare As String    ${i_total_base_fare}
        ${total_base_fare}=  Evaluate    ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${i_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
    END
    ${total}=    Get Text    ${total_fare_price_roundtrip}
    ${total}=    Extract Final Fare As String    ${total}
    &{fare_summary}=    Create Dictionary    base_fare=${total_base_fare}    taxes=${total_taxes}    total_fare_price=${total}    is_fare_jump=${False}
    RETURN    ${fare_summary}


Verify Fare Details And Get Fare Summary for Change Class
    Sleep    1s
    Wait Until Page Contains Element     ${change_class_onward_adult_base_fare}
    ${adult}=    Run Keyword And Return Status    Page Should Contain Element    ${change_class_onward_adult_base_fare}
    ${child}=    Run Keyword And Return Status    Page Should Contain Element    ${child_base_fare}
    ${infant}=    Run Keyword And Return Status    Page Should Contain Element    ${infant_base_fare}
    ${total_base_fare}=     Convert To Integer        0
    ${total_taxes}=    Convert To Integer        0
    ${total_tj_flex}=    Convert To Integer        0
    IF   ${adult}
        ${a_base_fare}=     Get Text    ${change_class_onward_adult_base_fare}
        ${a_taxes}=    Get Text    ${change_class_onward_adult_tax}
        ${a_total_base_fare}=    Get Text    ${change_class_onwards_total_base_fare}
        ${a_total_taxes}=    Get Text    ${change_class_onwards_adult_total_taxes}
        Compare Fares Prices    ${a_base_fare}    ${a_taxes}    ${a_total_base_fare}   ${a_total_taxes}
        ${temp_base}=    Extract Final Fare As String    ${a_total_base_fare}
        ${total_base_fare}=    Evaluate     ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${a_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
        IF    ${is_tj_flex}
            ${a_tj_flex}=    Get Text    ${adult_total_tj_flex_fee}
            ${temp_tj_flex}=    Extract Final Fare As String        ${a_tj_flex}
            ${total_tj_flex}=    Evaluate    ${total_tj_flex} + ${temp_tj_flex}
        END
    END
    IF   ${child}
        ${c_base_fare}=     Get Text    ${child_base_fare}
        ${c_taxes}=    Get Text    ${change_class_onwards_child_tax}
        ${c_total_base_fare}=    Get Text    ${change_class_onwards_child_base_fare}
        ${c_total_taxes}=    Get Text    ${change_class_onwards_child_total_taxes_price}
        Compare Fares Prices    ${c_base_fare}    ${c_taxes}    ${c_total_base_fare}   ${c_total_taxes}
        ${temp_base}=    Extract Final Fare As String   ${c_total_base_fare}
        ${total_base_fare}=   Evaluate  ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${c_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
        IF    ${is_tj_flex}
            ${c_tj_flex}=    Get Text    ${child_total_tj_flex_fee}
            ${temp_tj_flex}=    Extract Final Fare As String    ${c_tj_flex}
            ${total_tj_flex}=    Evaluate    ${total_tj_flex} + ${temp_tj_flex}
        END
    END
    IF   ${infant}
        ${i_base_fare}=     Get Text    ${infant_base_fare}
        ${i_taxes}=    Get Text    ${change_class_onwards_infants_taxes}
        ${i_total_base_fare}=    Get Text    ${infant_total_base_price}
        ${i_total_taxes}=    Get Text    ${change_class_onwards_infants_all_taxes}
        Compare Fares Prices    ${i_base_fare}    ${i_taxes}    ${i_total_base_fare}   ${i_total_taxes}
        ${temp_base}=    Extract Final Fare As String    ${i_total_base_fare}
        ${total_base_fare}=  Evaluate    ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${i_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
    END
    ${total}=    Get Text    ${change_class_onwards_total_fare}
    Execute Javascript  window.scroll(0,200)
    ${total}=    Extract Final Fare As String    ${total}
    &{fare_summary}=    Create Dictionary    base_fare=${total_base_fare}    taxes=${total_taxes}    total_fare_price=${total}    is_fare_jump=${False}
    RETURN    ${fare_summary}



Check Total Segments
    [Arguments]    ${view_details_button}
    Scroll Element Into View    ${view_details_button}
    Wait Until Element Is Visible    ${view_details_button}    30s
    Click Element    ${view_details_button}
    Wait Until Element Is Visible    ${flight_details_tab}    10s
    ${total_segments}=    Get Webelements    ${total_segment_count}
    Log       ${total_segments}
    ${total_segments}=    SeleniumLibrary.Get Element Count     ${total_segment_count}
    Log    ${total_segments}
    [Return]    ${total_segments}


Add Total Segments
    [Arguments]    ${total_segment1}    ${tatal_segment2}
    ${total_segment}=    Evaluate    ${total_segment1}+${tatal_segment2}
    [Return]    ${total_segment}


Verify Cross Fare Type On Flight Itinerary Page
    Wait Until Element Is Visible    ${onward_fare_type_text}
    Wait Until Element Is Visible    ${onward_fare_type_text}
    ${onward_fare_text}=    Get Text    ${onward_fare_type_text}
    #    Wait Until Element Is Visible    ${return_fare_type_text}
    ${return_fare_text}=    Get Text    ${return_fare_type_text}
    Should Be Equal As Strings    ${onward_fare}    ${onward_fare_text}
    Should Be Equal As Strings    ${return_fare}    ${return_fare_text}


Select One Stop Flights For Roundtrip
#    Sleep    40s
    Execute Javascript    window.scrollBy(0,900);
    Wait Until Element Is Visible    ${select_onward_flight_for_stops_filter}    30s
    Click Element    ${select_onward_flight_for_stops_filter}
    Wait Until Element Is Visible      ${one_stop_filter}
    Click Element   ${one_stop_filter}
    Sleep    2s
    Wait Until Element Is Visible    ${select_return_flight_for_stops_filter}    30s
    Click Element    ${select_return_flight_for_stops_filter}
    Wait Until Element Is Visible      ${one_stop_filter}
    Click Element   ${one_stop_filter}


Verify Fare Details And Get Fare Summary For Muliticity
   [Arguments]     ${search_data}
   ${my_dict}=         Create Dictionary    &{search_data}
   IF    "${my_dict.TO1}" != "Null"
       Click Element       (${multicity_flight_tabs})[2]
       Wait Until Element Is Visible    (${multicity_flight_tabs})[2]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
       ${airline_text_search_page}     Get Text    (${multicity_flight_tabs})[2]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
       ${airline_text_search_page}   Extract Airline    ${airline_text_search_page}
       Click Element    ${search_results_scroll_button}
       Sleep    1s
       Execute Javascript    window.scrollBy(0,-200)
       Verify Fare Details And Get Fare Summary    ${view_details_button2}
   END
   IF    "${my_dict.TO2}" != "Null"
       Click Element       (${multicity_flight_tabs})[3]
       Wait Until Element Is Visible    (${multicity_flight_tabs})[3]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
       Verify Fare Details And Get Fare Summary    ${view_details_button3}
   END
   IF    "${my_dict.TO3}" != "Null"
       Click Element       (${multicity_flight_tabs})[4]
       Wait Until Element Is Visible    (${multicity_flight_tabs})[3]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
       Verify Fare Details And Get Fare Summary    ${view_details_button3}
   END
   IF    "${my_dict.TO4}" != "Null"
       Click Element       (${multicity_flight_tabs})[5]
       Wait Until Element Is Visible    (${multicity_flight_tabs})[3]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
       Verify Fare Details And Get Fare Summary    ${view_details_button3}
   END
   IF    "${my_dict.TO5}" != "Null"
       Click Element       (${multicity_flight_tabs})[5]
       Wait Until Element Is Visible    (${multicity_flight_tabs})[3]/following::li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']
       Verify Fare Details And Get Fare Summary    ${view_details_button3}
   END


Select Cross Supplier For Round Trip
   Scroll Element Into View    ${return_airlines_ai_express}
   ${airline_text}  Get Text    //p[text()='Return']/span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::span[@class='flight__airline__name' and not(contains(text(),'Multi Airline'))]
   Click Element    ${first_onward_airline}
   Scroll Element Into View    ${onward_terminal_text}
   Click Element    //p[text()='Return']/span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::span[@class='flight__airline__name' and not(contains(text(),'${airline_text}'))]/../descendant::i[@class='fa fa-check']
   Wait Until Element Is Visible    ${fare_id_i_button}    10
   Sleep    1
   Click Element    ${fare_id_i_button}
   Wait Until Element Is Visible    ${from_supplier_id_text}    10
   ${from_supplier_id}     Get Text    ${from_supplier_id_text}
   Click Element    ${to_price_button}
   Click Element    ${to_fare_id_i_button}
   Wait Until Element Is Visible    ${to_supplier_id_text}    10
   ${to_supplier_id}    Get Text    ${to_supplier_id_text}
   IF    "${from_supplier_id}" != "${to_supplier_id}"
       Click Element    ${fare_id_i_cross_button}
   ELSE
       Click Element    ${to_fare_id_i_button}
       Click Element    ${to_arrival_button}
       Click Element    ${to_fare_id_i_button}
       Wait Until Element Is Visible    ${to_supplier_id_text}
       ${to_supplier_id}    Get Text    ${to_supplier_id_text}
       Click Element    ${fare_id_i_cross_button}
   END


Verify Cross Airlines
    FOR    ${index}    IN RANGE    3
        Wait Until Element Is Visible    ${onward_airlines_text_code_flight_details_page}    20
        ${onward_airlines_text_flight_details_page}    Get Text    ${onward_airlines_text_code_flight_details_page}
        ${onward_airlines_text_flight_details_page}    Extract Airline   ${onward_airlines_text_flight_details_page}
        Log    ${onward_airlines_text_flight_details_page}
        ${return_airlines_text_flight_details_page}    Get Text    ${return_airlines_text_code_flight_details_page}
        ${return_airlines_text_flight_details_page}    Extract Airline   ${return_airlines_text_flight_details_page}
        Log    ${return_airlines_text_flight_details_page}
        IF    "${onward_airlines_text_flight_details_page}" != "${return_airlines_text_flight_details_page}"
           ${pax_list}    Add Passenger
        ELSE
           Handle All Popups And Update Data
        #        Scroll Element Into View    ${flight_details_back_button}
           Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
           Click Button    ${flight_details_back_button}
           Select Nonstop Flights For Roundtrip
           Select Cross-Airline Flight For Round Trip
           Click Book Button
           Handle All Popups And Update Data
           ${loop_count}=    Evaluate    ${loop_count} + 1
           Exit For Loop If    ${loop_count} == 3
           Verify Cross Airlines
        END
    END


Refresh Page For The Toggle Button
   Sleep    3
   Reload Page


Select Connecting Flights For Roundtrip
   Sleep    40
   Execute Javascript    window.scrollBy(0,900);
   Wait Until Element Is Visible    ${select_onward_flight_for_stops_filter}    40s
   Click Element    ${select_onward_flight_for_stops_filter}
   Wait Until Element Is Visible    ${one_stop_filter}    40
   Click Element    ${one_stop_filter}
   Sleep    2s
   Wait Until Element Is Visible    ${select_return_flight_for_stops_filter}    30s
   Click Element    ${select_return_flight_for_stops_filter}
   Click Element    ${one_stop_filter}



Change Class for GDS Airlines | Multicity
   [Arguments]     ${search_data}
   ${my_dict}=         Create Dictionary   &{search_data}
   Wait Until Element Is Visible    ${arrival_button}    30s
   Run Keyword And Ignore Error    Wait Until Element Is Visible    ${roundtrip_split_flights_toggle_button}    20s
   ${toggle}=    Run Keyword And Return Status    Page Should Contain Element    ${roundtrip_split_flights_toggle_button}
   IF    ${toggle}
       Split Flight For International Round Trip
       Sleep    10s
   END
   FOR    ${i}    IN RANGE    1    3
       Wait Until Element Is Visible    ${change_class_link}    10s
       Click Element    ${change_class_link}
       Sleep    10s
       ${flag_to_terminate_class}=    Set Variable    0
       ${total_segment}=    Get Text    //ul[@class='changeclass__wrapper--ullist']
           FOR    ${j}    IN RANGE    1     ${total_segment}+1
           ${j}=    Convert To String    ${j}
           ${class_list}=    Replace String    ${no_class_text}    index     ${j}
           ${status}=    Run Keyword And Return Status    Page Should Contain Element    ${class_list}
           IF    ${status} == 'True'
               ${flag_to_terminate_class}    Set Test Variable    1
           END
       END
       IF    ${flag_to_terminate_class} == 1
           Wait Until Element Is Visible    ${change_class_cross_link}
           Click Element    ${change_class_cross_link}
           Continue For Loop If    ${flag_to_terminate_class} == 1
       END
       ${loop_to_select_class}=    SeleniumLibrary.Get Element Count    //ul[@class='changeclass__wrapper--className']
       FOR    ${index}    IN RANGE    1    ${loop_to_select_class}+1
           ${index}=    Convert To String    ${index}
           ${select_class}=    Replace String        ${index_select_class_radiobutton}        index    ${index}
           Wait Until Element Is Visible    ${select_class}    30s
           Click Element    ${select_class}
       END
       Wait Until Element Is Visible    ${get_fare_button}
       Click Element    ${get_fare_button}
       Sleep    10s
       ${fare_summary_11}     Verify Fare Details And Get Fare Summary for Change Class
       ${fare_summary_22}    Verify Fare Details And Get Fare Summary After Changing Class For Second Flight
       ${fare_summary_33}    Verify Fare Details And Get Fare Summary After Changing Class For Third Flight
       ${fare_summary12}     Add Fare Dictionary      ${fare_summary_11}   ${fare_summary_22}
       ${fare_summary13}    Add Fare Dictionary    ${fare_summary12}    ${fare_summary_33}
       Click Book Button On Change Class
       Exit For Loop
   END
   RETURN    ${fare_summary13}


Verify Fare Details And Get Fare Summary After Changing Class for Second Flight
    Wait Until Page Contains Element    ${fare_details_tab_for_roundtrip}
    #    Click Element    ${fare_details_tab_for_roundtrip}
    Wait Until Page Contains Element     ${adult_base_fare}
    ${adult}=    Run Keyword And Return Status    Page Should Contain Element    ${adult_base_fare_for_roundtrip}
    ${child}=    Run Keyword And Return Status    Page Should Contain Element    ${child_base_fare_for_roundtrip}
    ${infant}=    Run Keyword And Return Status    Page Should Contain Element    ${infant_base_fare_for_roundtrip}
    ${total_base_fare}=     Convert To Integer        0
    ${total_taxes}=    Convert To Integer        0
    ${total_tj_flex}=    Convert To Integer        0
    IF   ${adult}
        ${a_base_fare}=     Get Text    ${adult_base_fare_for_roundtrip}
        Log    ${a_base_fare}
        ${a_taxes}=    Get Text    ${adult_taxes_roundtrip}
        ${a_total_base_fare}=    Get Text    ${adult_total_base_price_roundtrip}
        ${a_total_taxes}=    Get Text    ${adult_total_tax_price_roundtrip}
        Compare Fares Prices    ${a_base_fare}    ${a_taxes}    ${a_total_base_fare}   ${a_total_taxes}
        ${temp_base}=    Extract Final Fare As String    ${a_total_base_fare}
        ${total_base_fare}=    Evaluate     ${total_base_fare} + ${temp_base}
        Log    ${total_base_fare}
        ${temp_taxes}=    Extract Final Fare As String    ${a_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
        IF    ${is_tj_flex}
            ${a_tj_flex}=    Get Text    ${adult_total_tj_flex_fee}
            ${temp_tj_flex}=    Extract Final Fare As String        ${a_tj_flex}
            ${total_tj_flex}=    Evaluate    ${total_tj_flex} + ${temp_tj_flex}
        END
    END
    IF   ${child}
        ${c_base_fare}=     Get Text    ${child_base_fare_for_roundtrip}
        ${c_taxes}=    Get Text    ${child_taxes_for_roundtrip}
        ${c_total_base_fare}=    Get Text    ${child_total_base_price_roundtrip}
        ${c_total_taxes}=    Get Text    ${child_total_taxes_price_roundtrip}
        Compare Fares Prices    ${c_base_fare}    ${c_taxes}    ${c_total_base_fare}   ${c_total_taxes}
        ${temp_base}=    Extract Final Fare As String   ${c_total_base_fare}
        ${total_base_fare}=   Evaluate  ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${c_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
        IF    ${is_tj_flex}
            ${c_tj_flex}=    Get Text    ${child_total_tj_flex_fee}
            ${temp_tj_flex}=    Extract Final Fare As String    ${c_tj_flex}
            ${total_tj_flex}=    Evaluate    ${total_tj_flex} + ${temp_tj_flex}
        END
    END
    IF   ${infant}
        ${i_base_fare}=     Get Text    ${infant_base_fare_for_roundtrip}
        ${i_taxes}=    Get Text    ${infant_taxes_roundtrip}
        ${i_total_base_fare}=    Get Text    ${infant_total_base_price_roundtrip}
        ${i_total_taxes}=    Get Text    ${infant_total_taxes_price_roundtrip}
        Compare Fares Prices    ${i_base_fare}    ${i_taxes}    ${i_total_base_fare}   ${i_total_taxes}
        ${temp_base}=    Extract Final Fare As String    ${i_total_base_fare}
        ${total_base_fare}=  Evaluate    ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${i_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
    END
    ${total}=    Get Text    ${total_fare_price_roundtrip}
    ${total}=    Extract Final Fare As String    ${total}
    &{fare_summary}=    Create Dictionary    base_fare=${total_base_fare}    taxes=${total_taxes}    total_fare_price=${total}    is_fare_jump=${False}
    RETURN    ${fare_summary}


Verify Fare Details And Get Fare Summary After Changing Class for Third Flight
    Wait Until Page Contains Element    ${fare_details_tab_for_third_trip}
    #    Click Element    ${fare_details_tab_for_roundtrip}
    Wait Until Page Contains Element     ${adult_base_fare}
    ${adult}=    Run Keyword And Return Status    Page Should Contain Element    ${adult_base_fare_for_third_trip}
    ${child}=    Run Keyword And Return Status    Page Should Contain Element    ${child_base_fare_for_third_trip}
    ${infant}=    Run Keyword And Return Status    Page Should Contain Element    ${infant_base_fare_for_third_trip}
    ${total_base_fare}=     Convert To Integer        0
    ${total_taxes}=    Convert To Integer        0
    ${total_tj_flex}=    Convert To Integer        0
    IF   ${adult}
        ${a_base_fare}=     Get Text    ${adult_base_fare_for_third_trip}
        Log    ${a_base_fare}
        ${a_taxes}=    Get Text    ${adult_taxes_third_trip}
        ${a_total_base_fare}=    Get Text    ${adult_total_base_price_third_trip}
        ${a_total_taxes}=    Get Text    ${adult_total_tax_price_third_trip}
        Compare Fares Prices    ${a_base_fare}    ${a_taxes}    ${a_total_base_fare}   ${a_total_taxes}
        ${temp_base}=    Extract Final Fare As String    ${a_total_base_fare}
        ${total_base_fare}=    Evaluate     ${total_base_fare} + ${temp_base}
        Log    ${total_base_fare}
        ${temp_taxes}=    Extract Final Fare As String    ${a_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
        IF    ${is_tj_flex}
            ${a_tj_flex}=    Get Text    ${adult_total_tj_flex_fee}
            ${temp_tj_flex}=    Extract Final Fare As String        ${a_tj_flex}
            ${total_tj_flex}=    Evaluate    ${total_tj_flex} + ${temp_tj_flex}
        END
    END
    IF   ${child}
        ${c_base_fare}=     Get Text    ${child_base_fare_for_third_trip}
        ${c_taxes}=    Get Text    ${child_taxes_for_third_trip}
        ${c_total_base_fare}=    Get Text    ${child_total_base_price_third_trip}
        ${c_total_taxes}=    Get Text    ${child_total_taxes_price_third_trip}
        Compare Fares Prices    ${c_base_fare}    ${c_taxes}    ${c_total_base_fare}   ${c_total_taxes}
        ${temp_base}=    Extract Final Fare As String   ${c_total_base_fare}
        ${total_base_fare}=   Evaluate  ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${c_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
        IF    ${is_tj_flex}
            ${c_tj_flex}=    Get Text    ${child_total_tj_flex_fee}
            ${temp_tj_flex}=    Extract Final Fare As String    ${c_tj_flex}
            ${total_tj_flex}=    Evaluate    ${total_tj_flex} + ${temp_tj_flex}
        END
    END
    IF   ${infant}
        ${i_base_fare}=     Get Text    ${infant_base_fare_for_third_trip}
        ${i_taxes}=    Get Text    ${infant_taxes_third_trip}
        ${i_total_base_fare}=    Get Text    ${infant_total_base_price_third_trip}
        ${i_total_taxes}=    Get Text    ${infant_total_taxes_price_third_trip}
        Compare Fares Prices    ${i_base_fare}    ${i_taxes}    ${i_total_base_fare}   ${i_total_taxes}
        ${temp_base}=    Extract Final Fare As String    ${i_total_base_fare}
        ${total_base_fare}=  Evaluate    ${total_base_fare} + ${temp_base}
        ${temp_taxes}=    Extract Final Fare As String    ${i_total_taxes}
        ${total_taxes}=    Evaluate   ${total_taxes} + ${temp_taxes}
        ${is_tj_flex}=    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_label}
    END
    ${total}=    Get Text    ${total_fare_price_roundtrip}
    ${total}=    Extract Final Fare As String    ${total}
    &{fare_summary}=    Create Dictionary    base_fare=${total_base_fare}    taxes=${total_taxes}    total_fare_price=${total}    is_fare_jump=${False}
    RETURN    ${fare_summary}


Select Zero Stop Filters
   Wait Until Element Is Visible     ${zero_stop_filter}    40s
   Click Element   ${zero_stop_filter}

Send Email For Updated Markup
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Execute Javascript      window.scroll(0,-150)
    Wait Until Element Is Visible    ${email_icon}
    Click Element    ${email_icon}
    ${int}=    Get Element Count    ${total_fare_checkbox}
    ${int}=    Set Variable    ${length}
    ${int}=    Convert To Integer    ${int}
    FOR    ${i}    IN RANGE    ${int}
        ${i}=    Evaluate    ${i}+1
        ${i}=    Convert To String    ${i}
        ${checkbox}=    Replace String    ${select_fare_checkbox}    index     ${i}
        Wait Until Element Is Visible    ${checkbox}
        Click Element    ${checkbox}
    END
    Execute Javascript      window.scroll(0,-1500)
    Wait Until Element Is Visible    ${send_icon}
    Click Element    ${send_icon}
    Capture Page Screenshot
    Wait Until Element Is Visible    ${send_with_price_button}
    Sleep    1s
    Click Element    ${send_with_price_button}
    Sleep    5s
    Capture Page Screenshot

Update Agent MarkUp On Search Page for Email
    [Arguments]    ${search_data}
    ${my_dict}=    Create Dictionary   &{search_data}
    Click Element    ${first_fare_price}
    ${amount}=    Convert To Number    ${my_dict.MarkupAmount}
    Input Text    ${markup_price_field}    ${amount}
    Click Element    ${markup_update_all_btn}

Get Fares on Search Page
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    ${fares_on_search_page}=    Create Dictionary
    ${list}     Get WebElements    ${parentlist_flightsearch}
#    ${length}      Get Length    ${list}
#    Set Test Variable    ${length}
    FOR    ${counter}    IN RANGE    1    ${length}+1
        ${count}      Convert To String    ${counter}
        ${fare_price}     Replace String      ${fare_price_to_be_replaced}        replace        ${count}
        Scroll Element Into View    ${fare_price}
        ${current_amount}    Get Text    ${fare_price}
        ${num_current_amount}    Extract Final Fare As String    ${current_amount}
        ${num_current_amount}=    Convert To Number   ${num_current_amount}
        Log    ${num_current_amount}
        ${key}=    Set Variable    fare
        Scroll Element Into View    ${fare_price}
        Set To Dictionary    ${fares_on_search_page}       ${Key}${counter}=${num_current_amount}
    END
    Log    ${fares_on_search_page}
    Set Test Variable    ${fares_on_search_page}

Get Flight Details On Search Page for Email Verification
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    ${departure_cities_search_page}=    Create Dictionary
    ${arrival_cities_search_page}=    Create Dictionary
    ${list}     Get WebElements    ${parentlist_flightsearch}
    ${length}      Get Length    ${list}
    Log    ${length}
    Set Test Variable    ${length}
    Click Element    ${view_details_button}
    Wait Until Element Is Visible    ${flight_details_tab}
    ${departure}=    Get Text    ${departure_city_text}
    ${arrival}=    Get Text    ${arrival_city_text}
    ${departure}=    Extract City    ${departure}
    ${arrival}=    Extract City    ${arrival}
    Set Test Variable    ${departure}
    Set Test Variable    ${arrival}
    Wait Until Element Is Visible    //span[text()='×']
    Sleep    2s
    Click Element    //span[text()='×']
    Execute Javascript      window.scroll(0,-200)
    FOR    ${counter}    IN RANGE    1    ${length}+1
        ${count}      Convert To String    ${counter}
        Wait Until Page Contains Element    ${view_details_button}    timeout=10
        ${view_details}=    Replace String    ${view_details_email}    index    ${count}
        Scroll Element Into View    ${view_details}
        Click Element    ${view_details}
        Sleep    20s
        Wait Until Element Is Visible    ${flight_details_tab}
        ${departure}    Get Text    ${departure_city_text}
        Log    ${departure}
        ${key}=    Set Variable    departure_city
        Set To Dictionary    ${departure_cities_search_page}       ${Key}${counter}=${departure}
    END
    Log    ${departure_cities_search_page}
    Set Test Variable    ${departure_cities_search_page}
    Execute Javascript      window.scroll(0,-2000)
    FOR    ${counter}    IN RANGE    1    ${length}+1
        ${count}      Convert To String    ${counter}
        Wait Until Page Contains Element    ${view_details_button}    timeout=10
        ${view_details}=    Replace String    ${view_details_email}    index    ${count}
        Scroll Element Into View    ${view_details}
        Click Element    ${view_details}
        Sleep    50s
        Wait Until Element Is Visible    ${flight_details_tab}
        ${arrival}    Get Text    ${arrival_city_text}
        Log    ${arrival}
        ${key}=    Set Variable    arrival_city
        Set To Dictionary    ${arrival_cities_search_page}       ${Key}${counter}=${arrival}
    END
    Log    ${arrival_cities_search_page}
    Set Test Variable    ${arrival_cities_search_page}

