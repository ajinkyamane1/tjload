*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    DateTime
Variables  ../../PageObjects/Login/login_locators.py
Variables  ../../PageObjects/SearchResults/search_results_locators.py
Variables  ../../../Environment/environments.py
Variables  ../../PageObjects/Manage_Inventory/manage_inventory_locator.py
Library    ../../CommonKeywords/Customkeywords/user_keywords.py
Library    OperatingSystem
Library    XML


*** Keywords ***
Cancel Icons on Search Filter
    Wait Until Element Is Visible    ${search_button}   timeout=10s
    Sleep    1
    Click Element    ${clear_date_field}
    Click Element    ${clear_date_field}
    Click Element    ${clear_user_role_field}
    Wait Until Element Is Visible    ${search_button}

Select Search Filter | Admin
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    Wait Until Element Is Visible    ${dashboard_nav_btn}    10s
    Click Element    ${dashboard_nav_btn}
    Wait Until Element Is Visible    ${show_more_button}    10s
    Click Element    ${show_more_button}
    Wait Until Element Is Visible    ${search_button}    10s
    IF  "${my_dict.User_id}" != "Null"
        Log    ${my_dict.User_id}
        Wait Until Element Is Visible    ${user_id_field}    10s
        Input Text    ${user_id_field}    ${my_dict.User_id}
        Wait Until Element Is Visible    ${select_user_id}    10s
        Sleep    2s
        Click Element    ${select_user_id}
    END
    Wait Until Element Is Visible    ${search_button}    10s
    Click Element    ${search_button}
    Sleep    2s

Verify Admin can emulate Supplier
    [Arguments]    ${manageuser_td}
    ${my_dict}=    Create Dictionary   &{manageuser_td}
    ${test_data_userid}    Convert To String    ${my_dict.User_id}
    ${user_id_on_card}     Replace String    ${user_id_link_on_search_card}   replace    ${test_data_userid}
    Wait Until Element Is Visible    ${user_id_on_card}
    ${user_id_on_card_text}=    Get Text    ${user_id_on_card}
    Wait Until Element Is Visible    ${emulate_user_link}    10s
    Click Element    ${emulate_user_link}
    Sleep    5
    Wait Until Element Is Visible    (//li[@class='topbar__list'])[1]    10s
    ${emulated_user_text}=    Get Text   (//li[@class='topbar__list'])[1]
    Should Contain    ${emulated_user_text}    ${user_id_on_card_text.upper()}

Select Manage Inventory
    Click Element    ${manage_inventory_field}
    Wait Until Element Is Visible    ${add_icon}    10s

Fill up Manage Inventory Details
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    Set Test Variable    ${my_dict}
    Click Element    ${show_more_button}
    Sleep    3
    IF    "${my_dict.Source}" != "Null"
          Input Text    ${source_search}    ${my_dict.Source}
          Wait Until Element Is Enabled    ${top_search_result}
          Click Element    ${top_search_result}
    END
    IF    "${my_dict.Destination}" != "Null"
          Input Text    ${destination_search}    ${my_dict.Destination}
          Wait Until Element Is Enabled    ${top_search_result}
          Click Element    ${top_search_result}
    END
    IF    "${my_dict.Airline}" != "Null"
          Input Text    ${airline_search}    ${my_dict.Airline}
          Wait Until Element Is Enabled    ${top_search_result}
          Click Element    ${top_search_result}
    END
    IF    "${my_dict.Inventory_Enabled}" != "Null"
          Input Text    ${inventory_enable_select}    ${my_dict.Inventory_Enabled}
          Wait Until Element Is Enabled    ${top_search_result}
          Click Element    ${top_search_result}
    END
    IF    "${my_dict.is_deleted}" != "Null"
          Input Text   ${is_deleted_select}    ${my_dict.is_deleted}
          Wait Until Element Is Enabled    ${top_search_result}
          Click Element    ${top_search_result}
    END
    IF    "${my_dict.Search_Inventory_Name}" != "Null"
           Input Text    ${inventory_name_input}    ${my_dict.Search_Inventory_Name}
    END

Click On Search Button On Manage Inventory Page
    Wait Until Element Is Visible   ${search_button}    timeout=20s
    Click Element    ${search_button}
    Sleep    5

Verify Inventory Name Are Present In Search Result
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    ${inventory_name}        Run Keyword And Return Status      Page Should Contain    ${my_dict.Inventory_Name}    timeout=20
    IF    "${inventory_name}" == "True"
        Click Element    (//tbody[@class='table__body-border']//following::span[text()='${my_dict.Inventory_Name}']//following::td/a[text()='View'])[1]
        Sleep    2
        Page Should Contain    Seat Allocation    timeout=10s
        Select Rate Plan For Already Created Manage Inventory    ${data}
    ELSE
        Wait Until Element Is Visible    ${add_icon}
        Click Element    ${add_icon}
        Create a Domestic Round Trip deal inventory    ${data}
        Select Rate Plan For Already Created Manage Inventory    ${data}
    END

Create a Domestic Round Trip deal inventory
     [Arguments]    ${data}
     ${my_dict}    Create Dictionary    &{data}
     Page Should Contain    Add Inventory
     Page Should Contain    Segment Info
     Input Text    ${inventory_name_input}    ${my_dict.Inventory_Name}
     Input Text    ${disable_departure_input}    ${my_dict.Disable_departure}
     Input Text    ${type_input}    ${my_dict.Type}
     Click Element    ${top_search_result}
     Click Element    ${journey_type_inventory}
     Wait Until Element Is Enabled    ${round_trip_dropdown}
     Scroll Element Into View    ${round_trip_dropdown}
     Click Element    ${round_trip_dropdown}
     Input Text    ${source_input}    ${my_dict.Segment_Source}
     Wait Until Element Is Enabled    ${top_search_result}
     Click Element    ${top_search_result}
     Input Text    ${destination_input}     ${my_dict.Segment_destination}
     Wait Until Element Is Enabled    ${top_search_result}
     Click Element    ${top_search_result}
     Input Text    ${airline_input}    ${my_dict.Segment_Airline}
     Wait Until Element Is Enabled    ${top_search_result}
     Click Element    ${top_search_result}
     Input Text    ${flight_number_input}    ${my_dict.Segment_FlightNumber}
     Click Element    ${departure_time_input}
     Run Keyword And Ignore Error    Wait Until Element Is Visible        //li[@class='react-datepicker__time-list-item' and text()='${my_dict.Segment_Departure_Time}']
     Scroll Element Into View    //li[@class='react-datepicker__time-list-item' and text()='${my_dict.Segment_Departure_Time}']
     Click Element    //li[@class='react-datepicker__time-list-item' and text()='${my_dict.Segment_Departure_Time}']
     Click Element    ${arrival_time_input}
     Run Keyword And Ignore Error    Wait Until Element Is Visible        //li[@class='react-datepicker__time-list-item' and text()='${my_dict.Segment_Arrival_Time}']
     Scroll Element Into View    //li[@class='react-datepicker__time-list-item' and text()='${my_dict.Segment_Arrival_Time}']
     Click Element    //li[@class='react-datepicker__time-list-item' and text()='${my_dict.Segment_Arrival_Time}']
     Click Element    ${add_more_segment_button}
     Execute Javascript     window.scrollTo(0, 2000);
     Wait Until Element Is Visible   ${source_input_return}
     Input Text    ${source_input_return}     ${my_dict.Segment_Roundtrip_Source}
     Wait Until Element Is Enabled    ${top_search_result}
     Click Element    ${top_search_result}
     Input Text    ${destination_input_return}    ${my_dict.Segment_Roundtrip_Destination}
     Wait Until Element Is Enabled    ${top_search_result}
     Click Element    ${top_search_result}
     Input Text    ${airline_input_round}    ${my_dict.Segment_Roundtrip_Airline}
     Wait Until Element Is Enabled    ${top_search_result}
     Click Element    ${top_search_result}
     Input Text    ${flight_number_input_round}    ${my_dict.Segment_Roundtrip_FlightNumber}
     Click Element    ${departure_time_input_round}
     Run Keyword And Ignore Error    Wait Until Element Is Visible        //li[@class='react-datepicker__time-list-item' and text()='${my_dict.Segment_Roundtrip_DepartureTime}']
     Scroll Element Into View    //li[@class='react-datepicker__time-list-item' and text()='${my_dict.Segment_Roundtrip_DepartureTime}']
     Click Element    //li[@class='react-datepicker__time-list-item' and text()='${my_dict.Segment_Roundtrip_DepartureTime}']
     Click Element    ${arrival_time_input_round}
     Run Keyword And Ignore Error    Wait Until Element Is Visible        //li[@class='react-datepicker__time-list-item' and text()='${my_dict.Segment_Roundtrip_ArrivalTime}']
     Scroll Element Into View    //li[@class='react-datepicker__time-list-item' and text()='${my_dict.Segment_Roundtrip_ArrivalTime}']
     Click Element    //li[@class='react-datepicker__time-list-item' and text()='${my_dict.Segment_Roundtrip_ArrivalTime}']
     Click Element    ${journey_type_input_segment_round}
     Wait Until Element Is Enabled    ${return_round_trip_journey}
     Scroll Element Into View    ${return_round_trip_journey}
     Click Element    ${return_round_trip_journey}
     Scroll Element Into View    ${save_continue_button}
     Click Element    ${save_continue_button}

Set Indexes For Search Table
    &{dic}      Create Dictionary
    Wait Until Element Is Visible    ${table_columns}   timeout=30s
    ${all_columns_list}     Get WebElements    ${table_columns}
    Log    ${all_columns_list}
    ${len}      Get Length    ${all_columns_list}
    FOR    ${counter}    IN RANGE    1    ${len}+1
         Log    ${counter}
         ${cnt}     Convert To String    ${counter}
         ${text_of_column}      Get Text    (//thead/tr/td)[${cnt}]
         Set To Dictionary    ${dic}       ${text_of_column}       ${cnt}
    END
    [Return]    ${dic}


Select Rate Plan For Already Created Manage Inventory
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    Sleep    5
    ${check_plan_availability}    Run Keyword And Return Status    Element Should Be Visible    ${download_button}
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    Get Flight Details On Seat Allocation Page
    IF    "${is_no_data}" == "True"
                Log    No Data Found
    ELSE IF    ${check_plan_availability}
            ${dic}      Set Indexes For Search Table
            ${column_index}        Get From Dictionary    ${dic}    Rate Plan Name
            ${column_range}        Get From Dictionary    ${dic}    Seats Remaining
            ${rate_plan}    Get Webelements    ${displayed_plan_name_count}
            ${len}    Get Length    ${rate_plan}
            FOR    ${i}    IN RANGE    1    ${len}+1
                  ${actual_text}    Get Text    //tbody/tr[${i}]/td[${column_index}]
                  Should Be Equal As Strings    ${actual_text}    ${my_dict.Rate_Plan_Name}
            END
            ${seat_count}    Get Webelements    ${displayed_seat_count}
            ${seat_len}    Get Length    ${seat_count}
            FOR    ${i}    IN RANGE    1    ${seat_len}+1
                ${actual_seat}    Get Text    //tbody/tr[${i}]/td[${column_range}]
                Should Be Equal As Strings    ${actual_seat}    ${my_dict.Available_Seats}
            END
    ELSE
         ${indexing}    Set Variable    1
         Click Element    ${allocate_more_button}
         ${total_allocation_info}    SeleniumLibrary.Get Element Count    ${total_allocation_field}
         WHILE   ${indexing} <= ${total_allocation_info}
             Click Element    (${rate_plan_input_field})[1]
             Input Text    (${rate_plan_input_field})[1]    ${my_dict.Rate_Plan_Name}
             Click Element    ${top_search_result}
             Click Element    (${start_date})[${indexing}]
             Select Start Date    ${my_dict.DepartureDate}
             ${for_one_waydate}    Run Keyword And Return Status    Element Should Be Visible    (${end_date})[1]
             IF    "${for_one_waydate}" == "True"
                 Click Element    (${end_date})[1]
                 Select End Date    ${my_dict.DepartureDate}
             END
                 Click Element    (${end_date})[2]
                 Select End Date    ${my_dict.ReturnDate}
             Input Text    (${seat_available})[${indexing}]   ${my_dict.Available_Seats}
             IF    "${my_dict.Airline_Pnr}" != "Null"
                 Input Text    (${airline_pnr})[${indexing}]    ${my_dict.Airline_Pnr}
             END
             ${indexing}=    Evaluate    ${indexing} + 1
         END
         Click Element    ${save_seat_allocation_button}
    END
    Click Element    ${switch_back_button}
    [Return]    ${rate_plan_id}


Select Start Date
    [Arguments]     ${months_next}
    Wait Until Element Is Visible    ${calendar_container}
    Capture Page Screenshot
    @{date_list}        next_month_date    ${months_next}
    ${day}      Get From List    ${date_list}    0
    ${month}      Get From List    ${date_list}    1
    ${year}      Get From List    ${date_list}    2
    ${my_date1}      Replace String    ${final_date_locator_to_replace}    replaceday   ${day}
    ${my_date2}      Replace String    ${my_date1}    replacemonth   ${month}
    ${my_from_date_final}      Replace String    ${my_date2}    replaceyear   ${year}
    Capture Page Screenshot
    Set Test Variable    ${my_from_date_final}
    FOR    ${counter}    IN RANGE    1    12
        ${status}       Run Keyword And Return Status    Wait Until Element Is Visible    ${my_from_date_final}
        IF    "${status}" == "${True}"
            Click Element    ${my_from_date_final}
            Exit For Loop
        ELSE
        Click Element    ${next_month_btn}
        Sleep    2
        END
    END

Select End Date
    [Arguments]     ${months_next}
    Wait Until Element Is Visible    ${calendar_container}
    Capture Page Screenshot
    @{date_list}        next_month_date    ${months_next}
    ${day}      Get From List    ${date_list}    0
    ${month}      Get From List    ${date_list}    1
    ${year}      Get From List    ${date_list}    2
    ${my_date1}      Replace String    ${final_date_locator_to_replace}    replaceday   ${day}
    ${my_date2}      Replace String    ${my_date1}    replacemonth   ${month}
    ${my_from_date_final}      Replace String    ${my_date2}    replaceyear   ${year}
    Capture Page Screenshot
    Set Test Variable    ${my_from_date_final}
    FOR    ${counter}    IN RANGE    1    12
        ${status}       Run Keyword And Return Status    Wait Until Element Is Visible    ${my_from_date_final}
        IF    "${status}" == "${True}"
            Click Element    ${my_from_date_final}
            Exit For Loop
        ELSE
        Click Element    ${next_month_btn}
        Sleep    2
        END
    END

Navigate Manage Inventory Of Admin
    Execute JavaScript    window.document.getElementById(id="bs-sidebar-collapse-1").scrollBy(0,2400);
    Wait Until Element Is Visible    ${manage_inventory_field}    10s
    Sleep    2
    Click Element    ${manage_inventory_field}
    Wait Until Element Is Visible    ${add_icon}    10s

Fill The Manage Inventory Of Admin & Verify
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    Set Test Variable    ${my_dict}
    Sleep    3
    Click Element    ${show_more_button}
    IF    "${my_dict.Source}" != "Null"
          Input Text    ${source_search}    ${my_dict.Source}
          Wait Until Element Is Enabled    ${top_search_result}
          Click Element    ${top_search_result}
    END
    IF    "${my_dict.Destination}" != "Null"
          Input Text    ${destination_search}    ${my_dict.Destination}
          Wait Until Element Is Enabled    ${top_search_result}
          Click Element    ${top_search_result}
    END
    IF    "${my_dict.Airline}" != "Null"
          Input Text    ${airline_search}    ${my_dict.Airline}
          Wait Until Element Is Enabled    ${top_search_result}
          Click Element    ${top_search_result}
    END
    IF    "${my_dict.Supplier_Id}" != "Null"
          Input Text    ${supplier_name_input}    ${my_dict.Supplier_Id}
          Wait Until Element Is Enabled    ${top_search_result}
          Click Element    ${top_search_result}
    END
    IF    "${my_dict.Inventory_Enabled}" != "Null"
          Input Text    ${inventory_enable_admin}    ${my_dict.Inventory_Enabled}
          Wait Until Element Is Enabled    ${top_search_result}
          Click Element    ${top_search_result}
    END
    IF    "${my_dict.Search_Inventory_Name}" != "Null"
           Input Text    ${inventory_name_input}    ${my_dict.Search_Inventory_Name}
    END


Verify Manage Inventory With ID & Navigate to Seat Allocation
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    Click Element    ${search_button}
    Wait Until Element Is Visible    ${download_button}    10s
    Scroll Element Into View    //table[@class="table table__fixed-container"]//td[@class="fixedColumn"]
    Execute Javascript    window.scrollBy(0,0)
    Click Element   //tbody[@class='table__body-border']//td[2]//span[text()='${rate_plan_id}']//following::td[11]/a[text()="View"]
    Sleep    4

Verify Seat Allocation of Admin
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    ${check_plan_availability}    Run Keyword And Return Status    Element Should Be Visible    ${download_button}
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    IF    "${is_no_data}" == "True"
                Log    No Data Found
                Fail
    ELSE IF    ${check_plan_availability}
            Update the Start Date & End Date In Updated Seat Allocation    ${data}
    ELSE
        ${indexing}    Set Variable    1
         Click Element    ${allocate_more_button}
         ${total_allocation_info}    SeleniumLibrary.Get Element Count    ${total_allocation_field}
         WHILE   ${indexing} <= ${total_allocation_info}
             Click Element    (${rate_plan_input_field})[1]
             Input Text    (${rate_plan_input_field})[1]    ${my_dict.Rate_Plan_Name}
             Click Element    ${top_search_result}
             Click Element    (${start_date})[${indexing}]
             Select Start Date    ${my_dict.DepartureDate}
             ${for_one_waydate}    Run Keyword And Return Status    Element Should Be Visible    (${end_date})[1]
             IF    "${for_one_waydate}" == "True"
                 Click Element    (${end_date})[1]
                 Select End Date    ${my_dict.DepartureDate}
             END
                 Click Element    (${end_date})[2]
                 Select End Date    ${my_dict.ReturnDate}
             Input Text    (${seat_available})[${indexing}]   ${my_dict.Available_Seats}
             ${indexing}=    Evaluate    ${indexing} + 1
         END
         Click Element    ${save_seat_allocation_button}
         Enable Force Display Checkbox & Verify Seat Allocation    ${data}
    END

Enable Force Display Checkbox & Verify Seat Allocation
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    ${dic}      Set Indexes For Search Table
    ${date_time_list_for_oneway}    Create List
    ${date_time_list_for_returnway}    Create List
    ${column_index}        Get From Dictionary    ${dic}    Rate Plan Name
    ${column_range}        Get From Dictionary    ${dic}    Seats Remaining
    ${start_date}    Get Text    (//tr[1]//div[@class="generic-td "])[2]
    ${final_start_date}    convert_date_for_inventory    ${start_date}
    ${end_date}    Get Text    (//tr[2]//div[@class="generic-td "])[2]
    ${final_end_date}    convert_date_for_inventory    ${end_date}
    Set Global Variable    ${final_start_date}
    Set Global Variable    ${final_end_date}
    Log    ${final_start_date}
    Log    ${final_end_date}
    ${one_way_timefrom}    Get Text    (//div[@class='segment_body-airsource']//p)[2]
    ${one_way_timeto}    Get Text    (//div[@class='segment_body-airdestination']//p)[2]
    ${round_way_timefrom}    Get Text    (//div[@class='segment_body-airsource']//p)[4]
    ${round_way_timeto}    Get Text    (//div[@class='segment_body-airdestination']//p)[4]
    Set Global Variable    ${one_way_timefrom}
    Set Global Variable    ${one_way_timeto}
    Set Global Variable    ${round_way_timefrom}
    Set Global Variable    ${round_way_timeto}
    Log    ${final_end_date}
    ${time_differnce_for_oneway}    Calculate Time Difference    ${one_way_timefrom}    ${one_way_timeto}
    ${time_differnce_for_roundway}    Calculate Time Difference    ${round_way_timefrom}    ${round_way_timeto}
    Set Global Variable    ${time_differnce_for_oneway}
    Set Global Variable    ${time_differnce_for_roundway}
    ${rate_plan}    Get Webelements    ${displayed_plan_name_count}
    ${len}    Get Length    ${rate_plan}
    FOR    ${i}    IN RANGE    1    ${len}+1
           ${actual_text}    Get Text    //tbody/tr[${i}]/td[${column_index}]
           Should Be Equal As Strings    ${actual_text}    ${my_dict.Rate_Plan_Name}
    END
    ${seat_count}    Get Webelements    ${displayed_seat_count}
    ${seat_len}    Get Length    ${seat_count}
    FOR    ${i}    IN RANGE    1    ${seat_len}+1
           ${actual_seat}    Get Text    //tbody/tr[${i}]/td[${column_range}]
           Should Be Equal As Strings    ${actual_seat}    ${my_dict.Available_Seats}
    END
    ${update_count}    Get Webelements    ${update_element}
    ${update_len}    Get Length    ${update_count}
    FOR    ${i}    IN RANGE    1    ${update_len}+1
           Click Element   (${update_element})[${i}]
           Wait Until Element Is Visible    //h3[text()='Update Seat Allocation']
           Sleep    5
           ${force_display_true}    Run Keyword And Return Status    Page Should Contain Element    //input[@name="isfd" and @value="true"]    timeout=10s
           IF    '${force_display_true}' == 'True'
                  Click Element    ${update_button}
           ELSE
                  Click Element    ${force_display}
                  Click Element    ${update_button}
           END
           Sleep    2s
           Element Should Be Visible    //div[@id="notification-wrapper"]//div//span    timeout=10s
    END
    Append To List    ${date_time_list_for_oneway}

Verify Created Manage Inventory Details With Domestic Search Flights
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    Scroll Element Into View    ${manage_user_menu}
    Click Element    ${manage_user_menu}
    Wait Until Element Is Visible    ${search_button}    10s
    Wait Until Element Is Visible    ${clear_user_role_field}   10s
    Sleep    1s
#    Click Element    ${clear_user_role_field}
    IF  "${my_dict.Agent_Id}" != "Null"
        Log    ${my_dict.Agent_Id}
        Wait Until Element Is Visible    ${user_id_field}    10s
        Input Text    ${user_id_field}    ${my_dict.Agent_Id}
        Wait Until Element Is Visible    ${select_user_id}    10s
        Sleep    2s
        Click Element    ${select_user_id}
    END
    Click Element    ${search_button}
    Wait Until Element Is Visible    ${emulate_user_link}    10s
    Click Element    ${emulate_user_link}
    Sleep    5
    Wait Until Element Is Visible    ${display_agent_id}    10s
    ${display_id}    Get Text    ${display_agent_id}
    ${agent_id_as_str}=    Convert To String    ${my_dict.Agent_Id}
    Should Contain    ${display_id}     ${agent_id_as_str}

Verify Manage Inventory ID With Search Flight For One Way
     ${display_flight_details_single}    Create List
     Click Element    ${i_icon_single}
     Wait Until Element Is Visible    ${inventory_id_single}
     ${invetory_id_text}    Get Text    ${inventory_id_single}
     Click Element    ${cross_icon_single}
     Page Should Contain    Offer Return Fare
     ${flight_single_id}    Get Text    ${flight_number_from_single}
     ${time_departure_text_single}    Get Text    ${time_from_single}
     ${time_arrival_text_single}    Get Text    ${time_to_single}
     Append To List    ${display_flight_details_single}    ${invetory_id_text}
     Append To List    ${display_flight_details_single}    ${flight_single_id}
     Append To List    ${display_flight_details_single}    ${time_departure_text_single}
     Append To List    ${display_flight_details_single}    ${time_arrival_text_single}
     Log    ${inventory_data_list}
     Log     ${display_flight_details_single}
     List Should Contain Sub List    ${inventory_data_list}   ${display_flight_details_single}

Verify Manage Inventory ID With Search Flight For Round Way
     ${display_flight_details_return}    Create List
     Click Element    ${i_icon_return}
     Wait Until Element Is Visible    ${inventory_id_return}
     ${invetory_id_text}    Get Text    ${inventory_id_return}
     Click Element    ${cross_icon_return}
     Page Should Contain    Offer Return Fare
     ${return_flight_id}    Get Text    ${flight_number_to_return}
     ${return_time_departure_text}    Get Text    ${time_from_return}
     ${return_time_arrival_text}   Get Text    ${time_to_return}
     Append To List    ${display_flight_details_return}    ${invetory_id_text}
     Append To List    ${display_flight_details_return}    ${return_flight_id}
     Append To List    ${display_flight_details_return}    ${return_time_departure_text}
     Append To List    ${display_flight_details_return}    ${return_time_arrival_text}
     List Should Contain Sub List    ${inventory_data_list}   ${display_flight_details_return}

Verify Manage Inventory Details For One Way With View Details Section
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    Click Element    ${view_details_button_single}
    Wait Until Element Is Visible    ${display_city_from_to}
    ${one_way_city}    Get Text    ${display_city_from_to}
    Should Contain    ${one_way_city}    ${my_dict.Segment_Source}
    Should Contain    ${one_way_city}    ${my_dict.Segment_destination}
    ${display_air_code}    Get Text    //span[@class="at-fontweight arct-idcode"]
    Should Be Equal As Strings    ${display_air_code}    ${one_way_airline_code}
    ${display_date_time}    Get Text    (//ul[@class='ars-listair flightDetails-listair-positionHandle']//li[not(ancestor::br)])[1]
    ${display_date}    Split String    ${display_date_time}    \n
    ${final_date}    Set Variable    ${display_date}[0]
    ${given_date_from}    replace_month_name    ${final_date}
    Log    ${given_date_from}
    Should Contain    ${given_date_from}    ${final_start_date}
    Should Contain    ${given_date_from}    ${one_way_timefrom}
    ${display_date_time_to}    Get Text    (//ul[@class='ars-listair flightDetails-listair-positionHandle']//li[not(ancestor::br)])[3]
    ${display_date_time}    Split String    ${display_date_time_to}    \n
    ${final_date_to}    Set Variable    ${display_date_time}[0]
    ${given_date_to}    replace_month_name    ${final_date_to}
    Log    ${given_date_from}
    Should Contain    ${given_date_to}    ${final_start_date}
    Should Contain    ${given_date_to}    ${one_way_timeto}
    ${display_calculated_time}    Get Text    //ul[@class="ars-listair"]//li
    ${display_time}    Split String    ${display_calculated_time}    \n
    ${final_time}    Set Variable    ${display_time}[0]
    ${final_available_seat}    Set Variable    ${display_time}[2]
    Log    ${final_time}
    Should Contain    ${final_time}    ${time_differnce_for_oneway}
    ${previous_available_seat}    Convert To String    ${my_dict.Available_Seats}
    Should Contain    ${final_available_seat}     ${previous_available_seat}
    Click Element     ${view_details_button_single}

Verify Manage Inventory Details For Round Way With View Details Section
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    Click Element    ${view_details_button_return}
    Wait Until Element Is Visible    ${display_city_to_from}
    ${round_way_city}    Get Text    ${display_city_to_from}
    Should Contain    ${round_way_city}    ${my_dict.Segment_Roundtrip_Source}
    Should Contain    ${round_way_city}    ${my_dict.Segment_Roundtrip_Destination}
    ${display_air_code}    Get Text    //span[@class="at-fontweight arct-idcode"]
    Should Be Equal As Strings    ${display_air_code}    ${return_way_airline_code}
    ${display_date_time}    Get Text    (//ul[@class='ars-listair flightDetails-listair-positionHandle']//li[not(ancestor::br)])[1]
    ${display_date}    Split String    ${display_date_time}    \n
    ${final_date_from}    Set Variable    ${display_date}[0]
    ${given_date_from}    replace_month_name    ${final_date_from}
    Log    ${given_date_from}
    Should Contain    ${given_date_from}    ${final_end_date}
    Should Contain     ${given_date_from}    ${round_way_timefrom}
    ${display_date_time_to}    Get Text    (//ul[@class='ars-listair flightDetails-listair-positionHandle']//li[not(ancestor::br)])[3]
    ${display_date_time}    Split String    ${display_date_time_to}    \n
    ${final_date_to}    Set Variable    ${display_date_time}[0]
    ${given_date_to}    replace_month_name    ${final_date_to}
    Log    ${given_date_to}
    Should Contain    ${given_date_to}    ${final_end_date}
    Should Contain    ${given_date_to}    ${round_way_timeto}
    ${display_calculated_time}    Get Text    //ul[@class="ars-listair"]//li
    ${display_time}    Split String    ${display_calculated_time}    \n
    ${final_time}    Set Variable    ${display_time}[0]
    ${final_available_seat}    Set Variable    ${display_time}[2]
    Log    ${final_time}
    Should Contain    ${final_time}    ${time_differnce_for_roundway}
    ${previous_available_seat}    Convert To String    ${my_dict.Available_Seats}
    Should Contain    ${final_available_seat}     ${previous_available_seat}
    Click Element    ${view_details_button_return}

Get Flight Details On Seat Allocation Page
    ${inventory_data_list}    Create List
    ${rate_plan_id}    Get Text    (//ol[@class='breadcrumb-arrow']//li//span)[2]
    ${one_way_airline_code}    Get Text    (//span[@class="airline-code"])[1]
    ${return_way_airline_code}    Get Text    (//span[@class="airline-code"])[2]
    ${one_way_timefrom}    Get Text    (//div[@class='segment_body-airsource']//p)[2]
    ${one_way_timeto}    Get Text    (//div[@class='segment_body-airdestination']//p)[2]
    ${round_way_timefrom}    Get Text    (//div[@class='segment_body-airsource']//p)[4]
    ${round_way_timeto}    Get Text    (//div[@class='segment_body-airdestination']//p)[4]
    Append To List    ${inventory_data_list}    ${rate_plan_id}
    Append To List    ${inventory_data_list}    ${one_way_airline_code}
    Append To List    ${inventory_data_list}    ${return_way_airline_code}
    Append To List    ${inventory_data_list}    ${one_way_timefrom}
    Append To List    ${inventory_data_list}    ${one_way_timeto}
    Append To List    ${inventory_data_list}    ${round_way_timefrom}
    Append To List    ${inventory_data_list}    ${round_way_timeto}
    Set Global Variable    ${rate_plan_id}
    Set Global Variable    ${one_way_airline_code}
    Set Global Variable    ${return_way_airline_code}
    Set Global Variable    ${inventory_data_list}

Verify Manage Inventory ID & Flight ID With International Flights
    Page Should Contain    Instant Offer Return Fare    timeout=10s
    Click Element    ${i_icon}
    Wait Until Element Is Visible    ${inventory_id}
    ${international_flight_datalist}    Create List
    ${inventory_id_text}    Get Text    ${inventory_id}
    Append To List    ${international_flight_datalist}    ${inventory_id_text}
    ${flight_id}    Get Webelements    (//div[@class="asr-albtm"])[1]//span[@class="at-fontweight apt-flightids"]
    ${len}    Get Length    ${flight_id}
    FOR    ${i}    IN RANGE    1    ${len}+1
        ${flight_id_text}    Get Text    ((//div[@class="asr-albtm"])[1]//span[@class="at-fontweight apt-flightids"])[${i}]
        ${value}    Split String    ${flight_id_text}    ,
        Append To List    ${international_flight_datalist}    ${value}[0]
    END
    ${flight_time}    Get Webelements    (//div[@class="asr-albtm"])[1]//span[@class="dep-timefont"]
    ${count}    Get Length    ${flight_time}
    FOR    ${i}    IN RANGE    1    ${count}+1
        ${flight_time_text}    Get Text    ((//div[@class="asr-albtm"])[1]//span[@class="dep-timefont"])[${i}]
        Append To List    ${international_flight_datalist}    ${flight_time_text}
    END
    Log    ${international_flight_datalist}
    List Should Contain Sub List    ${inventory_data_list}   ${international_flight_datalist}

Verify Date-Time-Seats Under View Details Section for International Flight(going)
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    ${display_date_time}    Get Text    (//ul[@class='ars-listair flightDetails-listair-positionHandle']//li[not(ancestor::br)])[1]
    ${display_date}    Split String    ${display_date_time}    \n
    ${final_date}    Set Variable    ${display_date}[0]
    ${given_date_from}    replace_month_name    ${final_date}
    Log    ${given_date_from}
    Should Contain    ${given_date_from}    ${final_start_date}
    Should Contain     ${given_date_from}    ${one_way_timefrom}
    ${display_date_time_to}    Get Text    (//ul[@class='ars-listair flightDetails-listair-positionHandle']//li[not(ancestor::br)])[3]
    ${display_date_time}    Split String    ${display_date_time_to}    \n
    ${final_date_to}    Set Variable    ${display_date_time}[0]
    ${given_date_to}    replace_month_name    ${final_date_to}
    Log    ${given_date_to}
    Should Contain    ${given_date_to}    ${given_date_to}
    Should Contain    ${given_date_to}    ${one_way_timeto}
    ${display_calculated_time}    Get Text    (//ul[@class="ars-listair"]//li)[1]
    ${display_time}    Split String    ${display_calculated_time}    \n
    ${final_time}    Set Variable    ${display_time}[0]
    ${final_available_seat}    Set Variable    ${display_time}[2]
    Log    ${final_time}
    ${previous_available_seat}    Convert To String    ${my_dict.Available_Seats}
    Should Contain    ${final_available_seat}     ${previous_available_seat}

Verify Date-Time-Seats Under View Details Section for International Flight(Return)
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    ${display_date_time}    Get Text    (//ul[@class='ars-listair flightDetails-listair-positionHandle']//li[not(ancestor::br)])[4]
    ${display_date}    Split String    ${display_date_time}    \n
    ${final_date}    Set Variable    ${display_date}[0]
    ${given_date_from}    replace_month_name    ${final_date}
    Log    ${given_date_from}
    Should Contain    ${given_date_from}    ${final_end_date}
    Should Contain     ${given_date_from}    ${round_way_timefrom}
    ${display_date_time_to}    Get Text    (//ul[@class='ars-listair flightDetails-listair-positionHandle']//li[not(ancestor::br)])[6]
    ${display_date_time}    Split String    ${display_date_time_to}    \n
    ${final_date_to}    Set Variable    ${display_date_time}[0]
    ${given_date_to}    replace_month_name    ${final_date_to}
    Log    ${given_date_to}
    Should Contain    ${given_date_to}    ${final_end_date}
    Should Contain    ${given_date_to}    ${round_way_timeto}
    ${display_calculated_time}    Get Text     (//ul[@class="ars-listair"]//li)[2]
    ${display_time}    Split String    ${display_calculated_time}    \n
    ${final_time}    Set Variable    ${display_time}[0]
    ${final_available_seat}    Set Variable    ${display_time}[2]
    Log    ${final_time}
    ${previous_available_seat}    Convert To String    ${my_dict.Available_Seats}
    Should Contain    ${final_available_seat}     ${previous_available_seat}

Verify Manage Inventory Details of International Flights With View Details Section
     [Arguments]    ${data}
     ${my_dict}    Create Dictionary    &{data}
     ${flight-details_list}    Create List
     Click Element    //div[@class="asr-albtm"][1]//button[text()="View Details"]
     ${from_to_city}    Get Text    ((//div[@class='trip-sepration-line'])//b)[1]
     ${to_from_city}    Get Text    ((//div[@class='trip-sepration-line'])//b)[2]
     Should Contain    ${from_to_city}    ${my_dict.Segment_Source}
     Should Contain    ${from_to_city}    ${my_dict.Segment_destination}
     Should Contain    ${to_from_city}    ${my_dict.Segment_Roundtrip_Source}
     Should Contain    ${to_from_city}    ${my_dict.Segment_Roundtrip_Destination}
     ${flight_id_from_to}    Get Text    (//span[@class="at-fontweight arct-idcode"])[1]
     Should Be Equal As Strings    ${flight_id_from_to}    ${one_way_airline_code}
     ${flight_id_to_from}    Get Text    (//span[@class="at-fontweight arct-idcode"])[2]
     Should Be Equal As Strings    ${flight_id_to_from}    ${return_way_airline_code}

Verify Search Deal Inventory As a Supplier
     [Arguments]    ${data}
     ${my_dict}    Create Dictionary    &{data}
     ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
     IF    "${is_no_data}" == "True"
                Log    No Data Found
                Fail
     ELSE
         ${dic}      Set Indexes For Search Table
         ${column_index}        Get From Dictionary    ${dic}    Inventory Name
         ${inventory_name}    Get Webelements    ${inventory_name_as_supplier}
         ${len}    Get Length    ${inventory_name}
         FOR    ${i}    IN RANGE    1    ${len}+1
           ${actual_text}    Get Text    //tbody/tr[${i}]/td[${column_index}]
           Should Be Equal As Strings    ${actual_text}    ${my_dict.Search_Inventory_Name}
         END
     END

Verify Search Deal Inventory As a Admin
    [Arguments]    ${data}
     ${my_dict}    Create Dictionary    &{data}
     ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
     IF    "${is_no_data}" == "True"
                Log    No Data Found
                Fail
     ELSE
         ${dic}      Set Indexes For Search Table
         ${column_index}        Get From Dictionary    ${dic}    Inventory Name
         ${inventory_name}    Get Webelements    ${inventory_name_as_supplier}
         ${len}    Get Length    ${inventory_name}
         FOR    ${i}    IN RANGE    1    ${len}+1
           ${actual_text}    Get Text    //tbody/tr[${i}]/td[${column_index}]
           Should Be Equal As Strings    ${actual_text}    ${my_dict.Search_Inventory_Name}
         END
     END

Update the Start Date & End Date In Updated Seat Allocation
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    ${current_date}=    DateTime.Get Current Date    result_format=%d/%m/%Y
    ${previous_date}    Get Text    (//tbody[@class="table__body-border"]//td)[3]//span
    ${three_months_ahead}    Is Next Three Months    ${previous_date}
    Log    ${three_months_ahead}
    IF    '${three_months_ahead}'== 'True'
        Enable Force Display Checkbox & Verify Seat Allocation    ${data}
    ELSE
        ${delete_icons}    Get Webelements    //i[@class="fa fa-trash linkcontainer__delete__icon"]
        ${num_icons}=    Get Length    ${delete_icons}
        FOR    ${i}    IN RANGE    1    ${num_icons}+1
            Wait Until Element Is Visible     //i[@class="fa fa-trash linkcontainer__delete__icon"]    timeout=10s
            Click Element    (//i[@class="fa fa-trash linkcontainer__delete__icon"])[1]
            Wait Until Element Is Visible    //button[text()="Delete"]
            Click Element    //button[text()="Delete"]
            Sleep    1s
        END
        ${indexing}    Set Variable    1
        Click Element    ${allocate_more_button}
        ${total_allocation_info}    SeleniumLibrary.Get Element Count    ${total_allocation_field}
        WHILE   ${indexing} <= ${total_allocation_info}
             Click Element    (${rate_plan_input_field})[1]
             Input Text    (${rate_plan_input_field})[1]    ${my_dict.Rate_Plan_Name}
             Click Element    ${top_search_result}
             Wait Until Element Is Visible    (${start_date})[${indexing}]    timeout=10s
             Click Element    (${start_date})[${indexing}]
             Select Start Date    ${my_dict.DepartureDate}
             ${for_one_waydate}    Run Keyword And Return Status    Element Should Be Visible    (${end_date})[1]
             IF    "${for_one_waydate}" == "True"
                 Click Element    (${end_date})[1]
                 Select End Date    ${my_dict.DepartureDate}
             END
             Click Element    (${end_date})[2]
             Select End Date    ${my_dict.ReturnDate}
             Input Text    (${seat_available})[${indexing}]   ${my_dict.Available_Seats}
             IF    "${my_dict.Airline_Pnr}" != "Null"
                Input Text    (${airline_pnr})[${indexing}]    ${my_dict.Airline_Pnr}
             END
             ${indexing}=    Evaluate    ${indexing} + 1
        END
        Click Element    ${save_seat_allocation_button}
        Sleep    3s
        Enable Force Display Checkbox & Verify Seat Allocation    ${data}
    END



