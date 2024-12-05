*** Settings ***
Library    SeleniumLibrary
Library    XML
Variables  ../../../Environment/environments.py
Variables    ../../PageObjects/SearchPageFilter/search_page_filter_locators.py
Library    String
Library    ../../Commonkeywords/CustomKeywords/user_keywords.py
Resource    ../../Commonkeywords/BookingSummary/booking_summary_keywords.robot
Library    Collections

*** Keywords ***
Verify Stops Filter
    Wait Until Element Is Enabled    ${zero_stops_option}
    Click Element    ${zero_stops_option}
    ${all_stop_flights}=    Get Webelements    ${stops_flight_text}
    ${status}   Run Keyword And Return Status    Page Should Contain Element    ${stops_flight_text}
    IF    '${status}'=='True'
        FOR    ${element}    IN     @{all_stop_flights}
            ${stops}=    Get Text    ${element}
            Should Be Equal As Strings   ${stops}    Non-Stop
        END
    ELSE
        Page Should Contain    Sorry, There were no flights found for this route Please, Modify your search and try again.
    END
    Click Element    ${zero_stops_option}
    Wait Until Page Contains Element    ${one_stops_option}
    Click Element    ${one_stops_option}
    ${all_stop_flights}=    Get Webelements    ${stops_flight_text}
    ${status}   Run Keyword And Return Status    Page Should Contain Element    ${stops_flight_text}
    IF    '${status}'=='True'
        FOR    ${element}    IN     @{all_stop_flights}
            ${stops}=    Get Text    ${element}
            Should Be Equal As Strings   ${stops}    1 Stop(s)
        END
    ELSE
        Page Should Contain    Sorry, There were no flights found for this route Please, Modify your search and try again.
    END
    Click Element    ${one_stops_option}
    Wait Until Page Contains Element    ${two_stops_option}
    Click Element    ${two_stops_option}
    ${all_stop_flights}=    Get Webelements    ${stops_flight_text}
    ${status}   Run Keyword And Return Status    Page Should Contain Element    ${stops_flight_text}
    IF    '${status}'=='True'
        FOR    ${element}    IN     @{all_stop_flights}
            ${stops}=    Get Text    ${element}
            Should Be Equal As Strings   ${stops}    2 Stop(s)
        END
    ELSE
        Page Should Contain    Sorry, There were no flights found for this route Please, Modify your search and try again.
    END
    Click Element    ${two_stops_option}
    Wait Until Page Contains Element    ${three_stops_option}
    Click Element    ${three_stops_option}
    ${all_stop_flights}=    Get Webelements    ${stops_flight_text}
    ${status}   Run Keyword And Return Status    Page Should Contain Element    ${stops_flight_text}
    IF    '${status}'=='True'
        FOR    ${element}    IN     @{all_stop_flights}
            ${stops}=    Get Text    ${element}
            Should Be Equal As Strings   ${stops}    3 Stop(s)
        END
    ELSE
        Page Should Contain    Sorry, There were no flights found for this route Please, Modify your search and try again.
    END
    Click Element    ${three_stops_option}
    Click Element    ${one_stops_option}
    Click Element    ${two_stops_option}
    #    Set Selenium Speed    1
    ${all_stop_flights}=    Get Webelements    ${stops_flight_text}
    ${status}   Run Keyword And Return Status    Page Should Contain Element    ${stops_flight_text}
    IF    '${status}'=='True'
        FOR    ${element}    IN     @{all_stop_flights}
            ${stops}=    Get Text    ${element}
            Should Be Equal As Strings   ${stops}    1 Stop(s)  or  2 Stop(s)
        END
    ELSE
        Page Should Contain    Sorry, There were no flights found for this route Please, Modify your search and try again.
    END
    Click Element    ${one_stops_option}
    Click Element    ${two_stops_option}

Verify The Departure Time
    [Arguments]    ${start_time}    ${end_time}
    ${status}=    Run Keyword And Return Status    Element Text Should Be    ${no_flights_available}    Please, Modify your search and try again.
    IF    ${status} == 'True'
        Log    No Flights available
    ELSE
        ${departure_elements}    Get Webelements    ${departure_time_elements}
        FOR    ${item}    IN    @{departure_elements}
            ${value}    Get Text     ${item}
            ${matched}=    Run Keyword And Return Status    Should Be True    ${start_time} <= ${value} <= ${end_time}
            IF    ${matched} == 'False'
                Log    Element is not in the range
            ELSE
                Continue For Loop
            END
        END
    END

Verify Results Filtered According To Departure Time
    [Arguments]    ${search_result}
    ${my_dict}=    Create Dictionary   &{search_result}
    IF    '${my_dict.DepartureTime}' == '00-06'
        Wait Until Element Is Visible    ${departure_time1}    timeout=50s
        Click Element    ${departure_time1}
        Verify The Departure Time    00:00    06:00

    ELSE IF    '${my_dict.DepartureTime}' == '06-12'
        Wait Until Element Is Visible    ${departure_time2}    timeout=30s
        Click Element    ${departure_time2}
        Verify The Departure Time    06:00    12:00

    ELSE IF    '${my_dict.DepartureTime}' == '12-18'
        Wait Until Element Is Visible    ${departure_time3}    timeout=30s
        Click Element    ${departure_time3}
        Verify The Departure Time    12:00    18:00

    ELSE
        Wait Until Element Is Visible    ${departure_time4}    timeout=30s
        Click Element    ${departure_time4}
        Verify The Departure Time    18:00    00:00
    END

Verify The Arrival Time
    [Arguments]    ${start_time}    ${end_time}
    ${var}=    Run Keyword And Return Status    Element Text Should Be    ${no_flights_available}    Please, Modify your search and try again.
    IF    ${var} == 'True'
        Log    No Flights available
    ELSE
        ${arrival_elements}    Get Webelements    ${arrival_time_elements}
        FOR    ${item}    IN    @{arrival_elements}
            ${value}    Get Text     ${item}
            ${matched}=    Run Keyword And Return Status    Should Be True    ${start_time} <= ${value} <= ${end_time}
            IF    ${matched} == 'False'
                Log    Element is not in the range
            ELSE
                Continue For Loop
            END
        END
    END

Verify Results Filtered According To Arrival Time
    [Arguments]    ${search_result}
    ${my_dict}=    Create Dictionary   &{search_result}
    IF    '${my_dict.ArrivalTime}' == '00-06'
        Wait Until Element Is Visible    ${arrival_time1}    timeout=10s
        Click Element    ${arrival_time1}
        Verify The Departure Time    00:00    06:00

    ELSE IF    '${my_dict.ArrivalTime}' == '06-12'
        Wait Until Element Is Visible    ${arrival_time2}    timeout=10s
        Click Element    ${arrival_time2}
        Verify The Departure Time    06:00    12:00

    ELSE IF    '${my_dict.ArrivalTime}' == '12-18'
        Wait Until Element Is Visible    ${arrival_time3}    timeout=10s
        Click Element    ${arrival_time3}
        Verify The Departure Time    12:00    18:00

    ELSE
        Wait Until Element Is Visible    ${arrival_time4}    timeout=10s
        Click Element    ${arrival_time4}
        Verify The Departure Time    18:00    00:00
    END

Verify Result Filtered According To Cheapest Fare
    Wait Until Element Is Enabled    ${commission_tab}    timeout=40s
    Click Element    ${commission_tab}
    Wait Until Element Is Enabled    ${cheapest_price_tab}
    Click Element    ${cheapest_price_tab}
    ${actual_list}=     Create List
    ${x}    Set Variable    1
    ${all_fare_amount_count}=    SeleniumLibrary.Get Element Count       ${fare_amounts}
    FOR    ${x}    IN RANGE    1    ${all_fare_amount_count}
        Exit For Loop If    ${x}==10
        ${element}    Get Text    //div[@class="ar-sortby"]//span[${x}]//span[@class="fare__amount"]
        Append To List     ${actual_list}    ${element}
        Execute JavaScript    window.scrollBy(0,200)
    END
    ${sorted_list}    Ascending Order    ${actual_list}
    ${status}    Run Keyword And Return Status     Lists Should Be Equal    ${actual_list}    ${sorted_list}
    IF    ${status} == False
        Log    "Search results are Not Filtered according to Cheapest Fare"
    END

Verify Results Filtered According To Flight Number
    [Arguments]    ${results}
    ${my_dict}=    Create Dictionary   &{results}
    Run Keyword And Ignore Error      Scroll Element Into View      ${nav_scroll_bar}
    Input Text    ${flight_number_input}    ${my_dict.FlightNumber}
    ${flights_availability_status}=    Run Keyword And Return Status    SeleniumLibrary.Element Text Should Be    ${no_flights_available}    PLEASE, MODIFY YOUR SEARCH AND TRY AGAIN.
    IF    ${flights_availability_status} == True
        Log    No Flights available with this flight number.
    ELSE
        Wait Until Element Is Enabled    ${flight_numbers_elements}
        ${elements}    Get Webelements    ${flight_numbers_elements}
        FOR    ${element}    IN    @{elements}
            Wait Until Element Is Enabled    ${element}
            ${element}    Get Text    ${element}
            ${flight_no}    Convert To String    ${my_dict.FlightNumber}
            ${status}    Run Keyword And Return Status      Should Contain    ${element}    ${flight_no}
        END
    END

Verify Fair Identifier
    Wait Until Page Contains Element    ${fair_identifier_title}     timeout=50s
    Run Keyword And Ignore Error      Scroll Element Into View    ${airlines_title}
    ${redcolor_status}   Run Keyword And Return Status    Page Should Contain Element    ${wrap_redcolor}
    ${orangecolor_status}   Run Keyword And Return Status    Page Should Contain Element    ${wrap_orangecolor}
    ${magenta_status}   Run Keyword And Return Status    Page Should Contain Element    ${wrap_magenta}
    ${lightSeaGreen_status}   Run Keyword And Return Status    Page Should Contain Element    ${wrap_lightSeaGreen}
    ${rose_status}   Run Keyword And Return Status    Page Should Contain Element    ${wrap_rose}
    ${brass_status}   Run Keyword And Return Status    Page Should Contain Element    ${wrap_brass}
    ${fawn_status}   Run Keyword And Return Status    Page Should Contain Element    ${wrap_fawn}
    ${khaki_status}   Run Keyword And Return Status    Page Should Contain Element    ${wrap_khaki}
    ${azure_status}   Run Keyword And Return Status    Page Should Contain Element    ${wrap_azure}
    ${robinsegg_status}   Run Keyword And Return Status    Page Should Contain Element    ${wrap_robinsegg}
    IF    '${redcolor_status}'=='True'
        Wait Until Page Contains Element    ${wrap_redcolor}
        Click Element    ${wrap_redcolor}
        ${red_color}=    SeleniumLibrary.Get Element Count    ${redcolor_tag}
        ${common_element}=  SeleniumLibrary.Get Element Count  ${common_elements}
        Should Be Equal    ${common_element}    ${red_color}
        Click Element    ${wrap_redcolor}
    END
    IF    '${orangecolor_status}'=='True'
        Wait Until Page Contains Element    ${wrap_orangecolor}
        Click Element    ${wrap_orangecolor}
        ${orange_color}=    SeleniumLibrary.Get Element Count    ${orangecolor_tag}
        ${common_element}=  SeleniumLibrary.Get Element Count  ${common_elements}
        Should Be Equal    ${common_element}    ${orange_color}
        Click Element    ${wrap_orangecolor}
    END
    IF    '${magenta_status}'=='True'
        Wait Until Page Contains Element    ${wrap_magenta}
        Click Element    ${wrap_magenta}
        ${magenta_color}=    SeleniumLibrary.Get Element Count    ${magenta_tag}
        ${common_element}=  SeleniumLibrary.Get Element Count  ${common_elements}
        Should Be Equal    ${common_element}    ${magenta_color}
        Click Element    ${wrap_magenta}
    END
    IF    '${lightSeaGreen_status}'=='True'
        Wait Until Page Contains Element    ${wrap_lightSeaGreen}
        Click Element    ${wrap_lightSeaGreen}
        ${lightSeaGreen_color}=    SeleniumLibrary.Get Element Count    ${lightSeaGreen_tag}
        ${common_element}=  SeleniumLibrary.Get Element Count    ${common_elements}
        Should Be Equal    ${common_element}    ${lightSeaGreen_color}
        Click Element    ${wrap_lightSeaGreen}
    END
    IF    '${azure_status}'=='True'
        Wait Until Page Contains Element    ${wrap_azure}
        Click Element    ${wrap_azure}
        ${azure_color}=    SeleniumLibrary.Get Element Count    ${azure_tag}
        ${common_element}=  SeleniumLibrary.Get Element Count    ${common_elements}
        Should Be Equal    ${common_element}    ${azure_color}
        Click Element    ${wrap_azure}
    END
    IF    '${robinsegg_status}'=='True'
        Wait Until Page Contains Element    ${wrap_robinsegg}
        Click Element    ${wrap_robinsegg}
        ${robinsegg_color}=    SeleniumLibrary.Get Element Count    ${robinsegg_tag}
        ${common_element}=  SeleniumLibrary.Get Element Count  ${common_elements}
        Should Be Equal    ${common_element}    ${robinsegg_color}
        Click Element    ${wrap_robinsegg}
    END
    IF    '${brass_status}'=='True'
        Wait Until Page Contains Element    ${wrap_brass}
        Click Element    ${wrap_brass}
        ${brass_color}=    SeleniumLibrary.Get Element Count    ${brass_tag}
        ${common_element}=  SeleniumLibrary.Get Element Count  ${common_elements}
        Should Be Equal    ${common_element}    ${brass_color}
        Click Element    ${wrap_brass}
    END
    IF    '${fawn_status}'=='True'
        Wait Until Page Contains Element    ${wrap_fawn}
        Click Element    ${wrap_fawn}
        ${fawn_color}=    SeleniumLibrary.Get Element Count    ${fawn_tag}
        ${common_element}=  SeleniumLibrary.Get Element Count  ${common_elements}
        Should Be Equal    ${common_element}    ${fawn_color}
        Click Element    ${wrap_fawn}
    END
    IF    '${khaki_status}'=='True'
        Wait Until Page Contains Element    ${wrap_khaki}
        Click Element    ${wrap_khaki}
        ${khaki_color}=    SeleniumLibrary.Get Element Count    ${khaki_tag}
        ${common_element}=  SeleniumLibrary.Get Element Count  ${common_elements}
        Should Be Equal    ${common_element}    ${khaki_color}
        Click Element    ${wrap_khaki}
    END

Verify Airlines Filter
    Run Keyword And Ignore Error      Scroll Element Into View    ${terminal_minus_icon}
    Wait Until Page Contains Element    ${airlines_title}
    Run Keyword And Ignore Error      Scroll Element Into View      ${airport_plus_icon}
    ${airlines_count}     Run keyword    SeleniumLibrary.Get Element Count    ${total_airlines}
    ${length}     Get Length    ${total_airlines}
    ${airlines}=    Get WebElements    ${airline_name}
    ${loop_count}=     Set Variable    0
    ${x}=    Set Variable    1
    WHILE   ${loop_count} < ${3}
#        Set Selenium Speed    1
        Wait Until Page Contains Element    ${airline_checkbox}     timeout=40s
        Click Element    (//span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::i[@class='fa fa-check'])[${x}]
        ${total_count}   Get Text    (//span[@class='airline_total-search'])[${x}]
        ${total_count}     Convert To Integer    ${total_count}
        Sleep    20s
        ${displayed_total_count}   Get Text    (//span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::i[@class='fa fa-check'])[${x}]/ancestor::span/ancestor::li/descendant::span[@class='airline_total-search']
        ${displayed_total_count}    Replace String    ${displayed_total_count}    Flights    ${EMPTY}
        ${displayed_total_count1}     Convert To Integer    ${displayed_total_count}
        Should Be Equal    ${total_count}    ${displayed_total_count1}
        ${airline_name_text}   Get Text    (//span[@class='flight__airline__name'])[${x}]
        ${split}    Split String    ${airline_name_text}
        ${airline_name_text}    Set Variable    ${split}[0]
        ${displayed_airline_name_text}   Get Text    ${displayed_airline_name}
        ${split}    Split String    ${displayed_airline_name_text}
        ${displayed_airline_name_text}    Set Variable    ${split}[0]
        Should Be Equal As Strings    ${airline_name_text}    ${displayed_airline_name_text}
        ${total}     Get Text    ${total_prices}
        ${prices}    Extract Final Fare As String    ${total}
        ${displayed_total_price}   Get Text    (//span[@class='fare__amount'])[${x}]
        ${displayed_prices}    Extract Final Fare As String    ${displayed_total_price}
        Should Be True    ${prices}<=${displayed_prices}
        ${len}    SeleniumLibrary.Get Element Count    ${displayed_price}
        FOR    ${counter}    IN RANGE    1    ${len}
            Log    ${counter}
            ${cnt}      Convert To String    ${counter}
            ${txt_replace}      Get Text    (//span[@class='fare__amount'])[${cnt}]
            ${displayed_prices}    Extract Final Fare As String    ${txt_replace}
            Should Be True    ${prices}<=${displayed_prices}
            ${iteration_count}=    Evaluate    ${counter} + 1
            Run Keyword If    ${iteration_count} > 3    Exit For Loop
        END
        Click Element    (//span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::i[@class='fa fa-check'])[${x}]
        ${loop_count}=   Evaluate    ${loop_count} + 1
        ${x}=  Evaluate   ${x} + 1
    END

Click On Book Button
    Wait Until Element Is Visible    ${book_btn_first}
    Scroll Element Into View    ${book_btn_first}
    Click Element    ${book_btn_first}
    Handle Consent Message Popup

Click Departure Airport Filter For Domestic Round Trip
    Sleep    20s
    Wait Until Page Contains Element    ${onward_airport}
    Run Keyword And Ignore Error       Scroll Element Into View   ${return_layover_section}
    Run Keyword And Ignore Error    Scroll Element Into View    //span[text()="Airlines"]/parent::p[contains(text(),"Return")]
    Click Element    //span[text()="Airlines"]/parent::p[contains(text(),"Onward")]
    Run Keyword And Ignore Error       Scroll Element Into View    ${onward_airport}
    Wait Until Element Is Visible    ${onward_airport_icon}
    Run Keyword And Ignore Error       Scroll Element Into View   ${return_layover_section}
    Click Element    ${onward_airport_icon}
    Sleep    3s
    Run Keyword And Ignore Error       Scroll Element Into View    ${return_layover_section}
    Scroll Element Into View    ${onward_airport_checkbox}
    Click Element    ${onward_airport_checkbox}
    Sleep    3s

Click Departure Airport Filter
    ${is_domestic_round}        Run Keyword And Return Status    Wait Until Element Is Visible     ${return_domestic_flight_section}
    IF    "${is_domestic_round}" == "${True}"
        Click Departure Airport Filter For Domestic Round Trip
    ELSE
        Log    THIS IS NOT DOMESTIC ROUND TRIP
        Sleep    20s
        Wait Until Page Contains Element    ${airport_section}
        Run Keyword And Ignore Error       Scroll Element Into View    ${layover_section}
        Wait Until Element Is Visible    ${airport_plus_icon}
        Sleep    3s
        Click Element    ${airport_plus_icon}
        Sleep    3s
        Run Keyword And Ignore Error       Scroll Element Into View    ${layover_section}
        Click Element    ${departure_flight_checkbox}
        Sleep    5s
    END

Click Arrival Airport Filter
    Run Keyword And Ignore Error    Scroll Element Into View    ((//span[text()="Arrival"])[2]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]/parent::div/label/div/i
    Click Element    ((//span[text()="Arrival"])[2]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]/parent::div/label/div/i
    Sleep    3s

Click Arrival Airport Filter For Domestic Round Trip
    ${is_domestic_round}        Run Keyword And Return Status    Wait Until Element Is Visible    ${return_domestic_flight_section}
    IF    "${is_domestic_round}" == "${True}"
        Run Keyword And Ignore Error    Scroll Element Into View    ${arrival_checkbox_roundtrip}
        Click Element    ${arrival_checkbox_roundtrip}
        Sleep    3s
    ELSE
    Run Keyword And Ignore Error    Scroll Element Into View    ${arrival_flight_checkbox}
    Click Element    ${arrival_flight_checkbox}
    Sleep    3s
    END

Verify Flights On Search Result Page Are Relevant To The Departure Filter While Ticked
    ${is_domestic_round}        Run Keyword And Return Status    Wait Until Element Is Visible    ${return_domestic_flight_section}
    IF    "${is_domestic_round}" == "${True}"
        Verify flights on search result page are relevant to the departure filter while ticked for domestic round trip
    ELSE
     ${departure_txt}        Get Text    ((//span[text()="Departure"])[2]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]
    ${departure_txt_list}       Split String    ${departure_txt}        ${SPACE}
    ${departure_airport}        Get From List    ${departure_txt_list}    0
    ${parent_elems}     Get WebElements    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    ${len}      Get Length    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    FOR    ${counter}    IN RANGE    1    10
        ${cnt}      Convert To String    ${counter}
        Run Keyword And Ignore Error    Scroll Element Into View    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
        Log    ${counter}
        ${departure_airport2}       Get Text    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]/div[@class="col-sm-6 no-padding flight-allview"]/div[1]/div[2]/ul/li/p
        Should Be Equal As Strings    ${departure_airport2}    ${departure_airport}
    END
    END

Verify Flights On Search Result Page Are Relevant To The Departure Filter While Ticked For Domestic Round Trip
    ${departure_txt}        Get Text    ((//span[text()="Departure"])[3]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]
    ${departure_txt_list}       Split String    ${departure_txt}        ${SPACE}
    ${departure_airport}        Get From List    ${departure_txt_list}    0
    Log    ${departure_airport}
    ${parent_elems}     Get WebElements   ((//div[@class="col-sm-6 domestic_tiles_view"])[1]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    ${len}      Get Length    ((//div[@class="col-sm-6 domestic_tiles_view"])[1]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    FOR    ${counter}    IN RANGE    1    10
        ${cnt}      Convert To String    ${counter}
        Run Keyword And Ignore Error    Scroll Element Into View             ((//div[@class="col-sm-6 domestic_tiles_view"])[1]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
        Log    ${counter}
        ${departure_airport2}       Get Text    ((//div[@class="col-sm-6 domestic_tiles_view"])[1]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]/div[@class="col-sm-6 no-padding flight-allview"]/div[1]/div[2]/ul/li/p
        Should Be Equal As Strings    ${departure_airport2}    ${departure_airport}
    END

Verify Flights On Search Result Page Are Relevant To The Arrival Filter While Ticked
    ${is_domestic_round}        Run Keyword And Return Status    Wait Until Element Is Visible     ${return_domestic_flight_section}
    IF    "${is_domestic_round}" == "${True}"
        Verify flights on search result page are relevant to the Arrival filter while ticked for domestic round trip
    ELSE
    ${arrival_txt}        Get Text    ((//span[text()="Arrival"])[2]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]
    ${arrival_txt_list}       Split String    ${arrival_txt}        ${SPACE}
    ${arrival_airport}        Get From List    ${arrival_txt_list}    0
    Log    ${arrival_airport}
    ${parent_elems}     Get WebElements    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    ${len}      Get Length    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    FOR    ${counter}    IN RANGE    1    10
        ${cnt}      Convert To String    ${counter}
        Run Keyword And Ignore Error    Scroll Element Into View    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
        Log    ${counter}
        ${arrival_airport2}       Get Text    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]/div[@class="col-sm-6 no-padding flight-allview"]/descendant::ul[3]/li/p
        Should Be Equal As Strings    ${arrival_airport2}    ${arrival_airport}
    END
    END

Verify Flights On Search Result Page Are Relevant To The Arrival Filter While Ticked For Domestic Round Trip
    ${arrival_txt}        Get Text    ((//span[text()="Arrival"])[3]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]
    ${arrival_txt_list}       Split String    ${arrival_txt}        ${SPACE}
    ${arrival_airport}        Get From List    ${arrival_txt_list}    0
    Log    ${arrival_airport}
    ${parent_elems}     Get WebElements   ((//div[@class="col-sm-6 domestic_tiles_view"])[1]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    ${len}      Get Length    ${parent_elems}
    FOR    ${counter}    IN RANGE    1    ${len}
        ${cnt}      Convert To String    ${counter}
        Run Keyword And Ignore Error    Scroll Element Into View    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
        Log    ${counter}
        ${arrival_airport2}       Get Text   ((//div[@class="col-sm-6 domestic_tiles_view"])[1]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]/div[@class="col-sm-6 no-padding flight-allview"]/descendant::ul[3]/li/p
        Should Be Equal As Strings    ${arrival_airport2}    ${arrival_airport}
    END

Click Departure Terminal Filter
    ${is_domestic_round}        Run Keyword And Return Status    Wait Until Element Is Visible     ${return_domestic_flight_section}
    IF    "${is_domestic_round}" == "${True}"
        Log    this is domestic round trip
        Wait Until Page Contains Element    ${onward_terminal_section}
        Sleep    5s
        Run Keyword And Ignore Error       Scroll Element Into View    //p[contains(normalize-space(),"Onward Lay")]/i/parent::p
        Wait Until Element Is Visible    ${onward_terminal_icon}
        Click Element    ${onward_terminal_icon}
        Sleep    3s
        Run Keyword And Ignore Error       Scroll Element Into View    //p[contains(normalize-space(),"Onward Lay")]/i/parent::p
#        Wait Until Element Is Visible    ${departure_terminal_checkbox}      20s
        Click Element    ${departure_terminal_checkbox}
        Sleep    5s
    ELSE
        Sleep    20s
        Wait Until Page Contains Element    ${terminal_section}
        Sleep    5s
        Run Keyword And Ignore Error       Scroll Element Into View    ${layover_section}
        Wait Until Element Is Visible    ${terminal_plus_icon}
        Click Element    ${terminal_plus_icon}
        Sleep    3s
        Run Keyword And Ignore Error       Scroll Element Into View    ${layover_section}
        Wait Until Element Is Visible    ${departure_terminal_checkbox} timeout=60s
        Click Element    ${departure_terminal_checkbox}
        Sleep    5s
    END

Verify Flights On Search Result Page Are Relevant To The Departure Terminal Filter
    ${is_domestic_round}        Run Keyword And Return Status    Wait Until Element Is Visible    ${return_domestic_flight_section}
    IF    "${is_domestic_round}" == "${True}"
        Log    domestic round trip
         ${departureterminal_txt}        Get Text    ${domestic_departure_terminal_txt}
        Log    ${departureterminal_txt}
        ${parent_elems}     Get WebElements    ((//div[@class="col-sm-6 domestic_tiles_view"])[1]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])
        ${len}      Get Length    ${parent_elems}
        FOR    ${counter}    IN RANGE    1    5
            ${cnt}      Convert To String    ${counter}
            Run Keyword And Ignore Error    Scroll Element Into View    ((//div[@class="col-sm-6 domestic_tiles_view"])[1]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
            Run Keyword And Ignore Error    Scroll Element Into View    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
            Click Element    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
            Sleep    2s
            ${departureterminal_txt2}       Get Text    (//span[contains(text(),"Termina")])[1]
            Should Be Equal As Strings    ${departureterminal_txt}    ${departureterminal_txt2}
            Scroll Element Into View     ${cancel_view_details}
            Click Element        ${cancel_view_details}
        END
    ELSE
    ${departureterminal_txt}        Get Text    ((//span[text()="Departure"])[1]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]
    ${parent_elems}     Get WebElements    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    ${len}      Get Length    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    FOR    ${counter}    IN RANGE    1    10
        ${cnt}      Convert To String    ${counter}
        Run Keyword And Ignore Error    Scroll Element Into View    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
        Run Keyword And Ignore Error    Scroll Element Into View    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
        Click Element    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
        Sleep    2s
        ${departureterminal_txt2}       Get Text    (//span[contains(text(),"Termina")])[1]
        Should Be Equal As Strings    ${departureterminal_txt}    ${departureterminal_txt2}
        Scroll Element Into View     ${cancel_view_details}
        Click Element        ${cancel_view_details}
    END
    END

Click Arrival Terminal Filter
    Run Keyword And Ignore Error    Scroll Element Into View    ((//span[text()="Arrival"])[1]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]/parent::div/label/div/i
    ${arrival_city}     Get Text    ((//span[text()="Arrival"])[1]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]/parent::div/preceding-sibling::p
    Click Element    ((//span[text()="Arrival"])[1]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]/parent::div/label/div/i
    ${arrival_city}     Set Test Variable    ${arrival_city}
    Sleep    3s

Verify Flights On Search Result Page Are Relevant To The Arrival Terminal Filter
    Sleep    15s
    ${is_domestic_round}        Run Keyword And Return Status    Wait Until Element Is Visible     ((//div[@class="col-sm-6 domestic_tiles_view"])[2]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    IF    "${is_domestic_round}" == "${True}"
        Log    domestic round trip
        ${arrival_terminal_txt}        Get Text    ((//span[text()="Arrival"])[1]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]
        ${parent_elems}     Get WebElements    ((//div[@class="col-sm-6 domestic_tiles_view"])[1]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])
        ${len}      Get Length     ${parent_elems}
        FOR    ${counter}    IN RANGE    1    5
            ${cnt}      Convert To String    ${counter}
            Run Keyword And Ignore Error    Scroll Element Into View    ((//div[@class="col-sm-6 domestic_tiles_view"])[1]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
            Run Keyword And Ignore Error    Scroll Element Into View    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
            Click Element    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
            Sleep    2s
            ${arrival_terminal_txt2}       Get Text    (//span[contains(text(),"Termina")])[2]
#            Element Should Be Visible    (//span[contains(text(),"${arrival_terminal_txt}")])/preceding-sibling::span[contains(normalize-space(),"${arrival_city}")][1]
            Scroll Element Into View    ${cancel_view_details}
            Click Element       ${cancel_view_details}
        END
    ELSE
     ${arrival_terminal_txt}        Get Text    ((//span[text()="Arrival"])[1]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]
    Log    ${arrival_terminal_txt}
    ${parent_elems}     Get WebElements    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    ${len}      Get Length     ${parent_elems}
    FOR    ${counter}    IN RANGE    1    5
        ${cnt}      Convert To String    ${counter}
        Run Keyword And Ignore Error    Scroll Element Into View    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
        Run Keyword And Ignore Error    Scroll Element Into View    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
        Click Element    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
        Sleep    2s
        ${arrival_terminal_txt2}       Get Text    (//span[contains(text(),"Termina")])[2]
        Element Should Be Visible    (//span[contains(text(),"${arrival_terminal_txt}")])/preceding-sibling::span[contains(normalize-space(),"${arrival_city}")][1]
        Scroll Element Into View    ${cancel_view_details}
        Click Element       ${cancel_view_details}
    END
    END

Click On Fastest Filter Tab On Search Page
    Sleep    15s
    Wait Until Element Is Visible    ${fastest_tab}    timeout=20s
    Wait Until Element Is Enabled    ${fastest_tab}
    Click Element    ${fastest_tab}

Validate Fastest Filter On Search Page
    ${is_domestic_round}        Run Keyword And Return Status    Wait Until Element Is Visible    ${return_domestic_flight_section}
    IF    "${is_domestic_round}" == "${True}"
        Log    domestic round
        @{List}        Create List
        ${parent_elems}     Get WebElements   ((//div[@class="col-sm-6 domestic_tiles_view"])[1]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])
        ${len}      Get Length     ${parent_elems}
        FOR    ${counter}    IN RANGE    1    5
            ${cnt}      Convert To String    ${counter}
            Run Keyword And Ignore Error    Scroll Element Into View    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
            ${entire_time_text}     Get Text    (//span[contains(@class,"arrow-allright arrowclass-loader-flight-search arrow-allright-positionHandle")])[${cnt}]/parent::div
            Log    ${entire_time_text}
            ${time_txt_list}     Split String    ${entire_time_text}     ${SPACE}
            ${hourtxt1}     Get From List    ${time_txt_list}    0
            ${time_txt1l1}     Split String    ${hourtxt1}       \n
            ${hourtxt1}     Get From List    ${time_txt1l1}    1
            ${mins_txt2}     Get From List    ${time_txt_list}    1
            ${hourtxt1}     Remove Letter    ${hourtxt1}        h
            ${mins_txt2}     Remove Letter    ${mins_txt2}    m
            ${total_mins}       Convert To Minutes    ${hourtxt1}    ${mins_txt2}
            Append To List    ${List}       ${total_mins}
        END
        Log    ${List}
        ${is_sorted}       Is Ascending    ${List}
        IF    "${is_sorted}" == "${True}"
             Log    sorted
        ELSE
            Fail
        END
    ELSE
    @{List}        Create List
    ${parent_elems}     Get WebElements    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    ${len}      Get Length     ${parent_elems}
    FOR    ${counter}    IN RANGE    1    5
        ${cnt}      Convert To String    ${counter}
        Run Keyword And Ignore Error    Scroll Element Into View    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
        ${entire_time_text}     Get Text    (//span[@class="arrow-allright arrowclass-loader-flight-search arrow-allright-positionHandle"])[${cnt}]/parent::div
        Log    ${entire_time_text}
        ${txt_list}     Split String    ${entire_time_text}     ${SPACE}
        ${txt1}     Get From List    ${txt_list}    0
        ${txt1l1}     Split String    ${txt1}       \n
        ${txt1}     Get From List    ${txt1l1}    1
        ${txt2}     Get From List    ${txt_list}    1
        ${txt1}     Remove Letter    ${txt1}        h
        ${txt2}     Remove Letter    ${txt2}    m
        ${total_mins}       Convert To Minutes    ${txt1}    ${txt2}
        Append To List    ${List}      ${total_mins}
    END
    Log    ${List}
    ${is_sorted}       Is Ascending    ${List}
    IF    "${is_sorted}" == "${True}"
        Log    sorted
    ELSE
        Fail
    END
    END

Click On Layover Icon
    Sleep    20s
    ${is_domestic_round}        Run Keyword And Return Status    Wait Until Element Is Visible     ${return_domestic_flight_section}
    IF    "${is_domestic_round}" == "${True}"
        Log    domestic internl
        Sleep    20s
        Wait Until Page Contains Element    ${onward_layover_icon}
        Run Keyword And Ignore Error        Scroll Element Into View     ${onward_layover_icon}
        Click Element                       (//span[text()="Airlines"]/parent::p/i)[2]
        Run Keyword And Ignore Error        Scroll Element Into View     ${onward_layover_icon}
        Sleep    2s
        Click Element       ${onward_layover_icon}
        Sleep    3s
        Click Element    ${onward_layover_checkbox}
        Sleep    3s
    ELSE
    Wait Until Page Contains Element    ${layover_icon}
    Run Keyword And Ignore Error        Scroll Element Into View     ${layover_icon}
    Click Element    //span[text()="Airlines"]/parent::p/i
    Run Keyword And Ignore Error        Scroll Element Into View     ${layover_icon}
    Set Focus To Element     ${layover_icon}
    Click Element       ${layover_icon}
    Sleep    3s
    Click Element    ${layover_checkbox}
    Sleep    3s
    END

Verify Flights On Search Result Page Are Relevant To The Layover Filter
    Sleep    15s
    ${is_domestic_round}        Run Keyword And Return Status    Wait Until Element Is Visible      ${return_domestic_flight_section}
    IF    "${is_domestic_round}" == "${True}"
        ${layover_txt}        Get Text    ${Selected_layover_txt}
        ${layover_txt_list}        Split String    ${layover_txt}      -
        ${layover_txtto_replace}       Get From List    ${layover_txt_list}    1
        ${layover_txtto_replace}       Remove Space From First Char    ${layover_txtto_replace}
        ${parent_elems}     Get WebElements     ((//div[@class="col-sm-6 domestic_tiles_view"])[1]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])
        ${len}      Get Length     ${parent_elems}
        FOR    ${counter}    IN RANGE    1    5
            ${cnt}      Convert To String    ${counter}
            Run Keyword And Ignore Error    Scroll Element Into View     ((//div[@class="col-sm-6 domestic_tiles_view"])[2]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
            Run Keyword And Ignore Error    Scroll Element Into View    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
            Click Element    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
            Sleep    2s
            Element Should Be Visible       (//div[@class="row flightDetails-row-positionHandle"])[1]/div[2]/ul/li[3]/span[contains(text(),"${layover_txtto_replace}")]
            Element Should Be Visible       (//div[@class="row flightDetails-row-positionHandle"])[2]/div[2]/ul/li/span[contains(text(),"${layover_txtto_replace}")]
            Scroll Element Into View    ${cancel_view_details}
            Click Element        ${cancel_view_details}
        END
    ELSE
     ${layover_txt}        Get Text    (//p[normalize-space()="Layover"]/parent::div/following-sibling::div/descendant::div[@class="filter__inputContainer"]/p)[1]
     ${layover_txt_list}        Split String    ${layover_txt}      -
     ${layover_txtto_replace}       Get From List    ${layover_txt_list}    1
     ${layover_txtto_replace}       Remove Space From First Char    ${layover_txtto_replace}
    ${parent_elems}     Get WebElements    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    ${len}      Get Length     ${parent_elems}
    FOR    ${counter}    IN RANGE    1    5
        ${cnt}      Convert To String    ${counter}
        Run Keyword And Ignore Error    Scroll Element Into View    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
        Run Keyword And Ignore Error    Scroll Element Into View    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
        Click Element    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
        Sleep    2s
        Element Should Be Visible       (//div[@class="row flightDetails-row-positionHandle"])[1]/div[2]/ul/li[3]/span[contains(text(),"${layover_txtto_replace}")]
        Element Should Be Visible       (//div[@class="row flightDetails-row-positionHandle"])[2]/div[2]/ul/li/span[contains(text(),"${layover_txtto_replace}")]
        Scroll Element Into View     ${cancel_view_details}
        Click Element        ${cancel_view_details}
    END
    END

Verify Flights On Search Result Page Are Relevant To The Arrival Filter For Domestic Round Trip
    ${arrival_txt}        Get Text    ${domestic_round_arrival_txt}
    ${arrival_txt_list}       Split String    ${arrival_txt}        -
    ${arrival_airport}        Get From List    ${arrival_txt_list}    1
    ${arrival_airport}        Remove Space From First Char    ${arrival_airport}
    Log    ${arrival_airport}
    ${parent_elems}     Get WebElements    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    ${len}      Get Length     ${parent_elems}
    FOR    ${counter}    IN RANGE    1    5
        ${cnt}      Convert To String    ${counter}
        Run Keyword And Ignore Error    Scroll Element Into View    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
        Run Keyword And Ignore Error    Scroll Element Into View    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
        Click Element    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
        Sleep    2s
        ${total_airports}      Get WebElements    ${total_left_airports_xpath}
         @{main_list}        Create List
        ${len}      Get Length    ${total_airports}
        FOR    ${counter}    IN RANGE    1    ${len}+1
            Log    ${counter}
            ${cnt}      Convert To String    ${counter}
            ${right_airport_element}     Replace String    ${right_airport_to_replace}    replace    ${cnt}
            ${right_airport_element_txt}     Get Text    ${right_airport_element}
            Append To List    ${main_list}      ${right_airport_element_txt}
            Log    ${main_list}
        END
        ${status}   Check If List Contains      ${arrival_airport}       ${main_list}
        Should Be True    ${status}
        Scroll Element Into View     ${cancel_view_details}
        Click Element     ${cancel_view_details}
    END

Verify Flights On Search Result Page Are Relevant To The Arrival Airport Filter
    ${is_domestic_round}        Run Keyword And Return Status    Wait Until Element Is Visible     ${return_domestic_flight_section}
    IF    "${is_domestic_round}" == "${True}"
        Verify flights on search result page are relevant to the Arrival filter for domestic round trip
    ELSE
    ${arrival_txt}        Get Text    ${arrival_airport_txt_onway}
    ${departure_txt_list}       Split String    ${arrival_txt}        -
    ${arrival_airport}        Get From List    ${departure_txt_list}    1
    ${arrival_airport}        Remove Space From First Char    ${arrival_airport}
    Log    ${arrival_airport}
    ${parent_elems}     Get WebElements    ${all_flights}
    ${len}      Get Length     ${parent_elems}
    FOR    ${counter}    IN RANGE    1    5
        ${cnt}      Convert To String    ${counter}
        Run Keyword And Ignore Error    Scroll Element Into View    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
        Run Keyword And Ignore Error    Scroll Element Into View    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
        Click Element    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
        Sleep    2s
        ${total_airports}      Get WebElements    ${total_left_airports_xpath}
         @{main_list}        Create List
        ${len}      Get Length    ${total_airports}
        FOR    ${counter}    IN RANGE    1    ${len}+1
            Log    ${counter}
            ${cnt}      Convert To String    ${counter}
            ${right_airport_element}     Replace String    ${right_airport_to_replace}    replace    ${cnt}
            ${right_airport_element_txt}     Get Text    ${right_airport_element}
            Append To List    ${main_list}      ${right_airport_element_txt}
        END
        ${status}   Check If List Contains      ${arrival_airport}       ${main_list}
        Should Be True    ${status}
    END
    END

Verify Flights On Search Result Page Are Relevant To The Departure Airport Filter
    ${is_domestic_round}        Run Keyword And Return Status    Wait Until Element Is Visible     ${return_domestic_flight_section}
    IF    "${is_domestic_round}" == "${True}"
        Verify flights on search result page are relevant to the departure filter for domestic round trip
    ELSE
    ${departure_txt}        Get Text    ${departure_airport_text}
    ${departure_txt_list}       Split String    ${departure_txt}        -
    ${departure_airport}        Get From List    ${departure_txt_list}    1
    ${departure_airport}        Remove Space From First Char    ${departure_airport}
    Log    ${departure_airport}

    ${parent_elems}     Get WebElements    ${all_flights}
    ${len}      Get Length     ${parent_elems}
    FOR    ${counter}    IN RANGE    1    5
        ${cnt}      Convert To String    ${counter}
        Run Keyword And Ignore Error    Scroll Element Into View    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
        Run Keyword And Ignore Error    Scroll Element Into View    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
        Click Element    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
        Sleep    2s
        ${total_left_airports}      Get WebElements    ${total_left_airports_xpath}
         @{main_list}        Create List
        ${len}      Get Length    ${total_left_airports}
        FOR    ${counter}    IN RANGE    1    ${len}+1
            Log    ${counter}
            ${cnt}      Convert To String    ${counter}
            ${left_airport_element}     Replace String    ${total_left_airports_xpathTo_replace}    replace    ${cnt}
            ${left_airport_element_txt}     Get Text    ${left_airport_element}
            Append To List    ${main_list}      ${left_airport_element_txt}

        END
        ${status}   Check If List Contains      ${departure_airport}       ${main_list}
        Should Be True    ${status}
    END
    END

Verify Flights On Search Result Page Are Relevant To The Departure Filter For Domestic Round Trip
    ${departure_txt}        Get Text    ((//span[text()="Departure"])[3]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]
    ${departure_txt_list}       Split String    ${departure_txt}        -
    ${departure_airport}        Get From List    ${departure_txt_list}    1
    ${departure_airport}        Remove Space From First Char    ${departure_airport}
    Log    ${departure_airport}
    ${parent_elems}     Get WebElements    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])
    ${len}      Get Length     ${parent_elems}
    FOR    ${counter}    IN RANGE    1    5
        ${cnt}      Convert To String    ${counter}
        Run Keyword And Ignore Error    Scroll Element Into View    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[${cnt}]
        Run Keyword And Ignore Error    Scroll Element Into View    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
        Click Element    (//button[@class="btn btn-default asr-viewbtn"])[${cnt}]
        Sleep    2s
        ${total_left_airports}      Get WebElements    ${total_left_airports_xpath}
         @{main_list}        Create List
        ${len}      Get Length    ${total_left_airports}
        FOR    ${counter}    IN RANGE    1    ${len}+1
            Log    ${counter}
            ${cnt}      Convert To String    ${counter}
            ${left_airport_element}     Replace String    ${total_left_airports_xpathTo_replace}    replace    ${cnt}
            ${left_airport_element_txt}     Get Text    ${left_airport_element}
            Append To List    ${main_list}      ${left_airport_element_txt}
            Log    ${main_list}

        END
        ${status}   Check If List Contains      ${departure_airport}       ${main_list}
        Should Be True    ${status}
        Scroll Element Into View     ${cancel_view_details}
        Click Element     ${cancel_view_details}
    END

Verify Split Flight For International Round Trip
    Split Flight For International Round Trip
    Sleep    10s
    Select One Stop Filter For Round Trip Search
    Sleep    10s
    Check Flights Are Available On Search Page
    Click View Details For Right Panel
    Click View Details For Left Panel

Verify Zero Stop Filter With Layover
    ${no_flights_available}    Run Keyword And Return Status    Page Should Contain    Sorry, There were no flights found for this route Please, Modify your search and try again.
    IF    ${no_flights_available}
       Log    Sorry, There were no flights found for this route Please, Modify your search and try again.
       Fail
    ELSE
        ${stop_text}      Get WebElements    ${number_stop_text}
        FOR    ${count}    IN    ${stop_text}
            ${text}    Get Text    ${count}
            Should Be Equal As Strings    ${text}    Non-Stop
        END
        Click Element    ${view_details_button}
        Wait Until Element Is Visible    ${number_stop_text_under_view}
        ${stop_text_under_view}    Get Webelements    ${number_stop_text_under_view}
        FOR    ${count}    IN    ${stop_text_under_view}
            ${text_under_view}    Get Text    ${count}
            Should Be Equal As Strings    ${text_under_view}    Non-Stop
        END
        Click Element    ${view_details_button}
    END


Verify Zero Stop Filter With Layover For Return Stop
    Execute JavaScript     window.scrollTo(0, -window.scrollY)
    Scroll Element Into View    ${round_trip_return_stop}
    Wait Until Element Is Visible    ${round_trip_return_stop}
    Click Element    ${round_trip_return_stop}
    Sleep    2s
    Select Zero Stop Filter
    Verify Zero Stop Filter With Layover

Verify One Stop Filter With Layover
    Sleep    10s
    Execute JavaScript     window.scrollTo(0, -window.scrollY)
    Click Element    //span[text()='Stops']/following::li[1]
    Select Zero Stop Filter
    Select One Stop Filter
    ${no_flights_available}    Run Keyword And Return Status    Page Should Contain    Sorry, There were no flights found for this route Please, Modify your search and try again.
    IF    ${no_flights_available}
       Log    Sorry, There were no flights found for this route Please, Modify your search and try again.
       Fail
    ELSE
    ${one_stop_text}    Get Text    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"]//span[@class="ars-arrowsun"])[1]
    Should Be Equal As Strings    ${one_stop_text}    1 Stop(s)
    Click Element    ${view_details_button}
    Wait Until Element Is Visible    (//p[@class="apt-laypverdesktop layover-apt-positionHandle"])[1]
    Element Should Be Visible    (//p[@class="apt-laypverdesktop layover-apt-positionHandle"])[1]
    END

Verify One Stop Filter With Return Stop
    Wait Until Element Is Visible    ${round_trip_return_stop}
    Click Element    ${round_trip_return_stop}
    Sleep    2s
    Execute JavaScript     window.scrollTo(0, -window.scrollY)
    Select Zero Stop Filter
    Select One Stop Filter
    ${one_stop_text}    Get Text    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"]//span[@class="ars-arrowsun"])[2]
    Should Be Equal As Strings    ${one_stop_text}    1 Stop(s)
    Click Element    ${view_details_button}
    Wait Until Element Is Visible    (//p[@class="apt-laypverdesktop layover-apt-positionHandle"])[2]
    Element Should Be Visible    (//p[@class="apt-laypverdesktop layover-apt-positionHandle"])[2]

Verify Two Stop Filter With Layover
    Execute JavaScript     window.scrollTo(0, -window.scrollY)
    Click Element    //span[text()='Stops']/following::li[1]
    Select One Stop Filter
    Select Two Stop Filter
    ${no_flights_available}    Run Keyword And Return Status    Page Should Contain    Sorry, There were no flights found for this route Please, Modify your search and try again.
    IF    ${no_flights_available}
       Log    Sorry, There were no flights found for this route Please, Modify your search and try again.
       Capture Page Screenshot
       Fail
    ELSE
        ${two_stop_text}    Get Text    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"]//span[@class="ars-arrowsun"])[1]
        Should Be Equal As Strings    ${two_stop_text}    2 Stop(s)
        Click Element    ${view_details_button}
        Wait Until Element Is Visible    (//p[@class="apt-laypverdesktop layover-apt-positionHandle"])[1]
        Element Should Be Visible    (//p[@class="apt-laypverdesktop layover-apt-positionHandle"])[1]
    END

Verify Two Stop Filter With Return Stop
    Wait Until Element Is Visible    ${round_trip_return_stop}
    Click Element    ${round_trip_return_stop}
    Sleep    2s
    Execute JavaScript     window.scrollTo(0, -window.scrollY)
    Select One Stop Filter
    Select Two Stop Filter
    ${one_stop_text}    Get Text    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"]//span[@class="ars-arrowsun"])[2]
    Should Be Equal As Strings    ${one_stop_text}    2 Stop(s)
    Click Element    ${view_details_button}
    Wait Until Element Is Visible    (//p[@class="apt-laypverdesktop layover-apt-positionHandle"])[2]
    Element Should Be Visible    (//p[@class="apt-laypverdesktop layover-apt-positionHandle"])[2]


Verify Three Stop Filter With Layover
    Execute JavaScript     window.scrollTo(0, -window.scrollY)
    Click Element    //span[text()='Stops']/following::li[1]
    Select Two Stop Filter
    Select Three Stop Filter
    ${no_flights_available}    Run Keyword And Return Status    Page Should Contain    Sorry, There were no flights found for this route Please, Modify your search and try again.
    IF    ${no_flights_available}
        Log    Sorry, There were no flights found for this route Please, Modify your search and try again.
        Fail
    ELSE
        ${three_stop_text}    Get Text    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"]//span[@class="ars-arrowsun"])[1]
        Should Be Equal As Strings    ${three_stop_text}    3 Stop(s)
        Click Element    ${view_details_button}
        Wait Until Element Is Visible    (//p[@class="apt-laypverdesktop layover-apt-positionHandle"])[1]
        Element Should Be Visible    (//p[@class="apt-laypverdesktop layover-apt-positionHandle"])[1]
    END

Verify Three Stop Filter With Return Stop
    Wait Until Element Is Visible    ${round_trip_return_stop}
    Click Element    ${round_trip_return_stop}
    Sleep    2s
    Execute JavaScript     window.scrollTo(0, -window.scrollY)
    Select One Stop Filter
    Select Two Stop Filter
    ${three_stop_text}    Get Text    (//div[@class="row flight-rowmain flight-rowmain-positionHandle"]//span[@class="ars-arrowsun"])[2]
    Should Be Equal As Strings    ${three_stop_text}    3 Stop(s)
    Click Element    ${view_details_button}
    Wait Until Element Is Visible    (//p[@class="apt-laypverdesktop layover-apt-positionHandle"])[2]
    Element Should Be Visible    (//p[@class="apt-laypverdesktop layover-apt-positionHandle"])[2]


Verify Whatsapp Button on Search page
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Send Whatsapp For Updated Markup    ${search_data}

Verify Email Button on Search Page
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Send Email For Updated Markup    ${search_data}
    Page Should Contain Element        //span[text()='Message Sent Successfully']

Send Email For Updated Markup
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Execute Javascript      window.scroll(0,-150)
    Wait Until Element Is Visible    ${email_icon}    35s
    Click Element    ${email_icon}
    ${int}=    Get Element Count    ${total_fare_checkbox}
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
    Capture Page Screenshot

Send Whatsapp For Updated Markup
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Execute Javascript      window.scroll(0,-150)
    Wait Until Element Is Visible    ${whatsapp_icon}
    Click Element    ${whatsapp_icon}
    ${int}=    Get Element Count    ${total_fare_checkbox}
    FOR    ${i}    IN RANGE    ${int}
        ${i}=    Evaluate    ${i}+1
        ${i}=    Convert To String    ${i}
        ${checkbox}=    Replace String    ${select_fare_checkbox}    index     ${i}
        Wait Until Element Is Visible    ${checkbox}
        Click Element    ${checkbox}
    END
    Execute Javascript      window.scroll(0,-1500)
    Wait Until Element Is Visible    ${share_icon}
    Click Element    ${share_icon}
    Sleep    10s
    Switch Window    NEW
    ${url}=    Get Location
    ${url}    Get Valid Url    ${url}
    ${urls}    Set Variable    https://web.whatsapp.com/
    Should Be Equal    ${urls}    ${url}

