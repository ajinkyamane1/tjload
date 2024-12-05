*** Settings ***
Library    SeleniumLibrary
Library    XML
Library    ../../CommonKeywords/CustomKeywords/user_keywords.py
Library    String
Library    Collections
Library     OperatingSystem
Library    DateTime
Library     Process
Library     random
Library     ../../../Environment/environments.py
Variables    ../../PageObjects/ManageCart/manage_cart_locators.py

*** Keywords ***
Input From Date Using Testdata Modified Version
    [Arguments]     ${months_back}
    Wait Until Element Is Visible    ${calendar_container}
    @{date_list}        reverse_current_datefunction       ${months_back}
    ${day}      Get From List    ${date_list}    0
    ${month}      Get From List    ${date_list}    1
    ${year}      Get From List    ${date_list}    2
    ${my_date1}      Replace String    ${date_to_be_replaced}    replaceday   ${day}
    ${my_date2}      Replace String    ${my_date1}    replacemonth   ${month}
    ${my_from_date_final}      Replace String    ${my_date2}    replaceyear   ${year}
    Set Test Variable    ${my_from_date_final}
    FOR    ${counter}    IN RANGE    1    12
        ${status}       Run Keyword And Return Status    Wait Until Element Is Visible    ${my_from_date_final}
        IF    "${status}" == "${True}"
            Click Element    ${my_from_date_final}
            Exit For Loop
        ELSE
        Click Element    ${back_month_btn}
        END
    END

Input To Date Using Testdata Modified Version Current Date
    Wait Until Element Is Visible    ${calendar_container}
    @{date_list}        Get Current Date
    ${day}      Get From List    ${date_list}    0
    ${month}      Get From List    ${date_list}    1
    ${year}      Get From List    ${date_list}    2
    ${year}     Convert To String    ${year}
    ${my_date1}      Replace String    ${date_to_be_replaced}    replaceday   ${day}
    ${my_date2}      Replace String    ${my_date1}    replacemonth   ${month}
    ${my_to_date_final}      Replace String    ${my_date2}    replaceyear   ${year}
    Set Test Variable    ${my_to_date_final}
    FOR    ${counter}    IN RANGE    1    12
        ${status}       Run Keyword And Return Status    Wait Until Element Is Visible    ${my_to_date_final}
        IF    "${status}" == "${True}"
            Click Element    ${my_to_date_final}
            Exit For Loop
        ELSE
        Click Element    ${back_month_btn}
        END
    END

Input Date Using Testdata
    [Arguments]     ${my_dic}
    Wait Until Element Is Visible    ${calendar_container}
    @{date_list}        Convertdate         ${my_dic}
    ${day}      Get From List    ${date_list}    0
    ${month}      Get From List    ${date_list}    1
    ${year}      Get From List    ${date_list}    2
    ${my_date1}      Replace String    ${date_to_be_replaced}    replaceday   ${day}
    ${my_date2}      Replace String    ${my_date1}    replacemonth   ${month}
    ${my_date_final}      Replace String    ${my_date2}    replaceyear   ${year}
    FOR    ${counter}    IN RANGE    1    12
        ${status}       Run Keyword And Return Status    Wait Until Element Is Visible    ${my_date_final}
        IF    "${status}" == "${True}"
            Click Element    ${my_date_final}
            Exit For Loop
        ELSE
        Click Element    ${back_month_btn}
        END
    END

Input Time Using Testdata
    [Arguments]     ${time_dic}
    ${time}     Replace String    ${time_to_replace}    timetoreplace    ${time_dic}
    Run Keyword And Ignore Error       Scroll Element Into View    ${time}
    Click Element    ${time}

Navigate To Dashboard
    Sleep    5s
    Wait Until Element Is Visible    ${dashboard_link}
    Click Element    ${dashboard_link}
    Sleep    5s

Navigate To Manage Cart Section
    Sleep    2s
    Wait Until Element Is Visible    ${manage_cart_link}
    Click Element    ${manage_cart_link}
    Wait Until Element Is Visible    ${input_booking_id}
    Wait Until Element Is Visible    ${from_date_input}
    Wait Until Element Is Visible    ${to_date_input}

Fill Up Manage Cart Details For Air
     [Arguments]     ${data}
     ${my_dict}=         Create Dictionary   &{data}
     Set Test Variable    ${my_dict}
     IF    "${my_dict.BookingId}" != "Null"
          Input Text    ${input_booking_id}    ${my_dict.BookingId}
     END
     IF    "${my_dict.From}" != "Null"
          Click Element    ${from_date_input}
          Input From Date using testdata modified version     1

           IF    "${my_dict.TimeFrom}" != "Null"
            Input Time Using testdata     ${my_dict.TimeFrom}
          END
     END
     IF    "${my_dict.To}" != "Null"
          Click Element    ${to_date_input}
          Input To Date using testdata modified version current Date
          IF    "${my_dict.TimeTo}" != "Null"
            Input Time Using testdata     ${my_dict.TimeTo}
          END
     END
     IF    "${my_dict.Booking_status}" != "Null"
          Click Element      ${remove_all_booking_cancel_icon}
          Sleep    2s
          Click Element    ${booking_status_input}
          Input Text    ${booking_status_input}   ${my_dict.Booking_status}
          Sleep    3s
          Click Element      (//div[text()="${my_dict.Booking_status}" and @role="option"])
          Sleep    3s
          Press Keys      //label[contains(text(),"Booking Status")]/parent::div/descendant::div[@class="css-1izgmon react-select__multi-value__label"]     ESC
     END
     IF    "${my_dict.Payment_status}" != "Null"
          Click Element      ${remove_all_payment_cancel_icon}
          Sleep    2s
          Click Element    ${payment_status_input}
          Input Text    ${payment_status_input}   ${my_dict.Payment_status}
          Sleep    3s
          Click Element      (//div[text()="${my_dict.Payment_status}" and @role="option"])
          Sleep    3s
          Press Keys      //label[contains(text(),"Payment Status")]/parent::div/descendant::div[@class="css-1izgmon react-select__multi-value__label"]     ESC
     END
     IF    "${my_dict.Airline}" != "Null"
         Click Element    ${airline_field}
         Wait Until Element Is Visible    ${airline_input_field}    timeout=20
         Input Text    ${airline_input_field}    ${my_dict.Airline}
         Wait Until Element Is Visible    ${airline_dropdown}    timeout=20
         Click Element    ${airline_dropdown}
    END
    IF    "${my_dict.FirstName}" != "Null"
        Click On Show More Button On Manage Cart Page
        Click Element    ${manage_cart_first_name_field}
        Input Text    ${manage_cart_first_name_field}    ${my_dict.FirstName}
    END
    IF    "${my_dict.LastName}" != "Null"
        Click On Show More Button On Manage Cart Page
        Click Element    ${manage_cart_last_name_field}
        Input Text    ${manage_cart_last_name_field}    ${my_dict.LastName}
    END
    IF    "${my_dict.assigned_userid}" != "Null"
         Click On Show More Button On Manage Cart Page
         Click Element    ${assigned_user_field}
         Wait Until Element Is Visible    ${assigned_user_input_field}    timeout=20
         Input Text    ${assigned_user_input_field}    ${my_dict.assigned_userid}
         Wait Until Element Is Visible    //div[@role="option" and contains(text(),"${my_dict.assigned_userid}")]    timeout=20
         Click Element    //div[@role="option" and contains(text(),"${my_dict.assigned_userid}")]
    END
    IF    "${my_dict.LoggedIn_User_ID}" != "Null"
        Click On Show More Button On Manage Cart Page
        Click Element    ${loggedIn_user_id_field}
        Wait Until Element Is Visible    ${loggedIn_user_id_input}    timeout=20
        Input Text    ${loggedIn_user_id_input}    ${my_dict.LoggedIn_User_ID}
        Sleep    3s
        Click Element    ${loggedIn_user_id_dropdown}
    END
    IF    "${my_dict.Airline_PNR}" != "Null"
        Click On Show More Button On Manage Cart Page
        Input Text    ${pnr_input_field}    ${my_dict.Airline_PNR}
    END
    IF    "${my_dict.From_processed_on}" != "Null"
          Click On Show More Button On Manage Cart Page
          Click Element    ${from_proceesed_on_input}
          Input Date using testdata     ${my_dict.From_processed_on}
          IF    "${my_dict.Time_from_processed_on}" != "Null"
            Input Time Using testdata     ${my_dict.Time_from_processed_on}
          END
     END
     IF    "${my_dict.To_processed_on}" != "Null"
          Click Element    ${to_processed_on_input}
          Input Date using testdata     ${my_dict.To_processed_on}
          IF    "${my_dict.Time_to_processed_on}" != "Null"
            Input Time Using testdata     ${my_dict.Time_to_processed_on}
          END
     END
     IF    "${my_dict.from_travel_date}" != "Null"
          Click On Show More Button On Manage Cart Page
          Click Element    ${from_travel_date_input}
          Input Date using testdata     ${my_dict.from_travel_date}
     END
     IF    "${my_dict.to_travel_date}" != "Null"
          Click Element    ${to_travel_date_input}
          Input Date using testdata     ${my_dict.to_travel_date}
     END
    Click On Search Button On Manage Cart Page

Verify Successful Search By Booking Id On Manage Cart Page
    Click On Reset Button
    Wait Until Element Is Visible    ${booking_status_column_heading}          30s
    Wait Until Element Is Visible    ${payment_status_column_heading}
    Wait Until Element Is Visible    ${generation_time_column_heading}
    Wait Until Element Is Visible    ${booking_id_column_heading}
    Sleep    4s
    Run Keyword And Ignore Error    Scroll Element Into View    ${booking_id_on_results}
    ${booking_id_on_results_txt}        Get Text    ${booking_id_on_results}
    Should Be Equal As Strings    ${booking_id_on_results_txt}    ${my_dict.BookingId}

Verify Successful Search On Manage Cart Page
    Click On Reset Button
    Wait Until Element Is Visible    ${booking_status_column_heading}       50s
    Wait Until Element Is Visible    ${payment_status_column_heading}       50s
    Wait Until Element Is Visible    ${generation_time_column_heading}      50s
    Wait Until Element Is Visible    ${booking_id_column_heading}       50s
    Sleep    4s

Get Booking Detail
    [Arguments]     ${fieldName}
    IF    "${fieldName}" == "Booking_Status"
        ${field_value_index}     Set Variable    2
        ${field_value_index}       Convert To String    ${field_value_index}
    END
    IF    "${fieldName}" == "Payment_Status"
          ${field_value_index}     Set Variable    3
          ${field_value_index}       Convert To String    ${field_value_index}
    END
    ${data}     Get Text    //tbody/tr[1]/td[${field_value_index}]
    Log    ${data}
    [Return]     ${data}

Verify Booking Status In Search Result
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    ${actual_data}      Get Booking Detail      Booking_Status
    #    ${actual_data}      Get Booking Detail      Booking Status
    IF     "${my_dict.Booking_status}" == "Un-Confirmed"
        Should Be Equal As Strings    ${actual_data}     Unconfirmed
        ${all_booking_status}       Get WebElements    //tbody/tr/td[2]/span[text()="Unconfirmed"]
        ${len}      Get Length    ${all_booking_status}
        FOR    ${counter}    IN RANGE    1    ${len}
            Log    ${counter}
             ${actual_txt}      Get Text    //tbody/tr/td[2]/span[text()="Unconfirmed"]
             Should Be Equal As Strings    Unconfirmed    ${actual_txt}
        END
    ELSE
        Should Be Equal As Strings    ${actual_data}    ${my_dict.Booking_status}
        ${all_booking_status}       Get WebElements    //tbody/tr/td[2]/span[text()="${my_dict.Booking_status}"]
        ${len}      Get Length    ${all_booking_status}
        FOR    ${counter}    IN RANGE    1    ${len}
            Log    ${counter}
             ${actual_txt}      Get Text    //tbody/tr/td[2]/span[text()="${my_dict.Booking_status}"]
             Should Be Equal As Strings    ${my_dict.Booking_status}    ${actual_txt}
        END
    END

Verify Payment Status In Search Result
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    ${actual_data}      Get Booking Detail      Payment_Status
    Should Be Equal As Strings    ${actual_data}    ${my_dict.Payment_status}
    ${all_payment_status}       Get WebElements    //tbody/tr/td[2]/span[text()="${my_dict.Booking_status}"]
        ${len}      Get Length    ${all_payment_status}
        FOR    ${counter}    IN RANGE    1    ${len}
            Log    ${counter}
             ${actual_txt}      Get Text    //tbody/tr/td[3]/div/span[text()="${my_dict.Payment_status}"]
             Should Be Equal As Strings    ${my_dict.Payment_status}    ${actual_txt}
        END

Verify All Payment Status In Search Result
    Wait Until Page Contains Element    //tbody/tr/td[3]/div/span

Verify All Booking Status In Search Result
    Wait Until Page Contains Element    //tbody/tr/td[2]/span
    ${my_dic}       Set Indexes For Search Table
    ${my_value}     Get From Dictionary    ${my_dic}    Booking Status
    Log     ${my_value}

Set Indexes For Search Table
    &{dic}      Create Dictionary
    ${all_columns_list}     Get WebElements    ${total_columns}
    ${len}      Get Length    ${all_columns_list}
    FOR    ${counter}    IN RANGE    1    ${len}+1
        Log    ${counter}
         ${cnt}     Convert To String    ${counter}
         ${text_of_column}      Get Text    (//thead/tr/td)[${cnt}]
         Set To Dictionary    ${dic}       ${text_of_column}       ${cnt}
    END
    [Return]       ${dic}

Get Booking Detail Modified
    [Arguments]     ${fieldName}
    ${dic}      Set Indexes For Search Table
    ${field_value_index}        Get From Dictionary    ${dic}    ${fieldName}
    ${data}     Get Text    //tbody/tr[1]/td[${field_value_index}]
    Log    ${data}
    [Return]      ${data}

Get Payment Detail Modified
    [Arguments]     ${fieldName}
    ${dic}      Set Indexes For Search Table
    ${field_value_index}        Get From Dictionary    ${dic}    ${fieldName}
    ${data}     Get Text    //tbody/tr[1]/td[${field_value_index}]/div/span
    Log    ${data}
    [Return]      ${data}

Verify Booking Status In Search Result Modified
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    ${dic}      Set Indexes For Search Table
     ${column_index}        Get From Dictionary    ${dic}    Booking Status
    ${actual_data}      Get Booking Detail Modified      Booking Status
    IF     "${my_dict.Booking_status}" == "Un-Confirmed"
        Should Be Equal As Strings    ${actual_data}     Unconfirmed
        ${all_booking_status}       Get WebElements    //tbody/tr/td[${column_index}]/span[text()="Unconfirmed"]
        ${len}      Get Length    ${all_booking_status}
        FOR    ${counter}    IN RANGE    1    ${len}
            Log    ${counter}
             ${actual_txt}      Get Text    //tbody/tr/td[${column_index}]/span[text()="Unconfirmed"]
             Should Be Equal As Strings    Unconfirmed    ${actual_txt}
        END
    ELSE
        Should Be Equal As Strings    ${actual_data}    ${my_dict.Booking_status}
        ${all_booking_status}       Get WebElements    //tbody/tr/td[${column_index}]/span[text()="${my_dict.Booking_status}"]
        ${len}      Get Length    ${all_booking_status}
        FOR    ${counter}    IN RANGE    1    ${len}
            Log    ${counter}
             ${actual_txt}      Get Text    //tbody/tr/td[${column_index}]/span[text()="${my_dict.Booking_status}"]
             Should Be Equal As Strings    ${my_dict.Booking_status}    ${actual_txt}
        END
    END

Verify Payment Status In Search Result Modified
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    #    ${actual_data}      Get Booking Detail      Booking_Status
    ${dic}      Set Indexes For Search Table
     ${column_index}        Get From Dictionary    ${dic}    Payment Status
    ${actual_data}      Get Payment Detail Modified     Payment Status
    Should Be Equal As Strings    ${actual_data}    ${my_dict.Payment_status}
#    ${all_payment_status}       Get WebElements    //tbody/tr/td[${column_index}]/span[text()="${my_dict.Payment_status}"]
    ${all_payment_status}       Get WebElements    //tbody/tr/td[${column_index}]/div/span[contains(text(),"${my_dict.Payment_status}")]
    ${len}      Get Length    ${all_payment_status}
    FOR    ${counter}    IN RANGE    1    ${len}
        Log    ${counter}
         ${cnt}     Convert To String    ${counter}
         ${actual_txt}      Get Text    (//tbody/tr/td[${column_index}]/div/span[text()="${my_dict.Payment_status}"])[${cnt}]
         Should Be Equal As Strings    ${my_dict.Payment_status}    ${actual_txt}
    END

Verify From And To Date On Search Results
    ${from_date}   Set Variable     ${my_dict.From}
    ${from_date}    Convert To Standard Date Fromat    ${from_date}
    ${to_date}   Set Variable     ${my_dict.To}
    ${to_date}    Convert To Standard Date Fromat    ${to_date}
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Generation Time
    ${total_columns}        Get WebElements    (//tbody/tr/td[${column_index}]/div/span)
    ${len}      Get Length    ${total_columns}
    FOR    ${counter}    IN RANGE    1    ${len}
        Log    ${counter}
        ${cnt}      Convert To String    ${counter}
        ${date_text}        Get Text    (//tbody/tr/td[${column_index}]/div/span)[${cnt}]
        ${given_date}       Convertdate Reverse    ${date_text}
        ${status}       Is Date Between    ${from_date}    ${to_date}    ${given_date}
        Should Be True    ${status}
    END

Verify From And To date On Search Results Modified
    ${from_date}   From Date Table Format   1
    ${to_date}    Get To Date Table Format
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Generation Time
    ${total_columns}        Get WebElements    (//tbody/tr/td[${column_index}]/div/span)
    ${len}      Get Length    ${total_columns}
    FOR    ${counter}    IN RANGE    1    ${len}
        Log    ${counter}
        ${cnt}      Convert To String    ${counter}
        ${date_text}        Get Text    (//tbody/tr/td[${column_index}]/div/span)[${cnt}]
        ${given_date}       Convertdate Reverse    ${date_text}
        ${status}       Is Date Between    ${from_date}    ${to_date}    ${given_date}
        Should Be True    ${status}
    END

Verify From And To Process On Date On Search Results
    ${from_date}   Set Variable     ${my_dict.From_processed_on}
    ${from_date}    Convert To Standard Date Fromat    ${from_date}
    ${to_date}   Set Variable     ${my_dict.To_processed_on}
    ${to_date}    Convert To Standard Date Fromat    ${to_date}
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Processed On
    ${total_columns}        Get WebElements    (//tbody/tr/td[${column_index}]/div/span)
    ${len}      Get Length    ${total_columns}
    FOR    ${counter}    IN RANGE    1    ${len}
        Log    ${counter}
        ${cnt}      Convert To String    ${counter}
        ${date_text}        Get Text    (//tbody/tr/td[${column_index}]/div/span)[${cnt}]
        ${given_date}       Convertdate Reverse    ${date_text}
        ${status}       Is Date Between    ${from_date}    ${to_date}    ${given_date}
        Should Be True    ${status}
    END

Verify Travel Date Filter On Search Results
    ${from_date}   Set Variable     ${my_dict.from_travel_date}
    ${from_date}    Convert To Standard Date Fromat    ${from_date}
    ${to_date}   Set Variable     ${my_dict.to_travel_date}
    ${to_date}    Convert To Standard Date Fromat    ${to_date}
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Travel Date
    ${total_columns}        Get WebElements    (//tbody/tr/td[${column_index}]/div/span)
    ${len}      Get Length    ${total_columns}
    FOR    ${counter}    IN RANGE    1    ${len}
        Log    ${counter}
        ${cnt}      Convert To String    ${counter}
        ${date_text}        Get Text    (//tbody/tr/td[${column_index}]/div/span)[${cnt}]
        ${given_date}       Convertdate Reverse    ${date_text}
        ${status}       Is Date Between    ${from_date}    ${to_date}    ${given_date}
        Should Be True    ${status}
    END

Verify Assigned UserID Filter On Manage Cart Search Page
    ${txt_of_input_assigned_user}       Get Text    ${txt_of_assigned_user}
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Assigned User
    ${total_columns}        Get WebElements    (//tbody/tr/td[${column_index}]/div/span)
    ${len}      Get Length    ${total_columns}
        FOR    ${counter}    IN RANGE    1    ${len}+1
        Log    ${counter}
        ${cnt}      Convert To String    ${counter}
        ${txt_of_assigned_user_in_results}        Get Text    (//tbody/tr/td[${column_index}]/div/span)[${cnt}]
        ${status}    Contains Substring   ${txt_of_input_assigned_user}      ${txt_of_assigned_user_in_results}
    END

Click On Customize Button
    Run Keyword And Ignore Error    Scroll Element Into View    ${customize_btn}
    Execute Javascript      window.scroll(0,150)
    Wait Until Element Is Visible    ${customize_btn}
    Click Element    ${customize_btn}

Unselect Column As Per Test Data
    ${unselect}   Set Variable     ${my_dict.Deselect_column}
    ${deselect_element}     Replace String    ${checkbox_to_deselect_replace}    replace    ${unselect}
    Run Keyword And Ignore Error    Scroll Element Into View    ${deselect_element}
    Click Element    ${deselect_element}
    Sleep    3s
    Click Element    ${save_btn}
    Sleep    3s

Verify Deselected Column Not Visible
    Element Should Not Be Visible    //td[text()="${my_dict.Deselect_column}"]

Click On Reset Button
    Wait Until Element Is Visible    ${reset_btn}
    Click Element    ${reset_btn}
    Wait Until Element Is Visible    ${reset_btn2}
    Click Element    ${reset_btn2}

Verify Deselected Column Is visible After Clicking Reset Button
    Wait Until Element Is Visible    //td[text()="${my_dict.Deselect_column}"]

Click On Download Button
    Wait Until Element Is Visible    ${download_btn}
    Click Element    ${download_btn}
    Sleep    2s

Download File With Required Columns From Testdata
    ${unselect}   Set Variable     ${my_dict.Deselect_column}
    IF    "${unselect}" != "Null"
        ${deselect_element}     Replace String    ${checkbox_to_deselect_replace}    replace    ${unselect}
        Run Keyword And Ignore Error    Scroll Element Into View    ${deselect_element}
        Click Element    ${deselect_element}
    END
    Sleep    3s
    Click Element    ${download_file_btn}
    Sleep    8s
    File Should Exist   ${downloads_path}${/}manage-carts.csv

Verify the Count Of Serach Results On Manage Cart Page
    Sleep    20s
    ${total_result_rows}        SeleniumLibrary.Get Element Count    ${total_rows}
    ${results_shown_txt}        Get Text    ${results_shown}
    ${results_shown_list}       Split String    ${results_shown_txt}        ${SPACE}
    ${actual_rows_count}        Get From List    ${results_shown_list}    3
    ${actual_rows_count}        Convert To Integer    ${${actual_rows_count}}
    Should Be Equal As Integers    ${actual_rows_count}    ${total_result_rows}

Click On Booking Id Link
    ${dic}      Set Indexes For Search Table
    ${column_index1}        Get From Dictionary    ${dic}    Booking Id
    ${column_index2}        Get From Dictionary    ${dic}    Booking Status
    Wait Until Element Is Visible    //tbody/tr/td[${column_index1}]/a           20s
    ${verify_booking_id}        Get Text    //tbody/tr/td[${column_index1}]/a
    ${verify_booking_status}        Get Text    //tbody/tr/td[${column_index2}]/span
    Set Test Variable    ${verify_booking_id}
    Set Test Variable    ${verify_booking_status}
    Scroll Element Into View     //tbody/tr/td[${column_index1}]/a
    Click Element       //tbody/tr/td[${column_index1}]/a

Click On View Ticket Link
    ${dic}      Set Indexes For Search Table
    ${column_index1}        Get From Dictionary    ${dic}    PrintTicket
    ${column_index2}        Get From Dictionary    ${dic}    Booking Id
    Wait Until Element Is Visible    //tbody/tr/td[${column_index2}]/a           20s
    ${verify_booking_id}        Get Text    //tbody/tr/td[${column_index2}]/a
    Set Test Variable    ${verify_booking_id}
    Scroll Element Into View    //tbody/tr/td[${column_index1}]/span/i
    Click Element    //tbody/tr/td[${column_index1}]/span/i

Verify User Navigates To Booking Confirmation Page
    Switch Window       locator=new
    Sleep    12s
    Page Should Contain     ${verify_booking_id}

Click On Raise Amendment Icon On Manage Cart Page
    ${dic}      Set Indexes For Search Table
    ${column_index1}        Get From Dictionary    ${dic}    Raise Amendment
    ${column_index2}        Get From Dictionary    ${dic}    Booking Id
    Scroll Element Into View    //tbody/tr/td[${column_index1}]/i
    ${verify_booking_id}        Get Text    //tbody/tr/td[${column_index2}]/a
    Set Test Variable    ${verify_booking_id}
    Click Element    //tbody/tr/td[${column_index1}]/i

Verify Raise Amendment Functionality On Manage Cart page
    Wait Until Element Is Visible    //input[@value="${verify_booking_id}"]         10s
    Wait Until Element Is Visible    ${raise_btn}
    Sleep    3s

Click On Save Filter Checkbox
    Sleep    8s
    Wait Until Element Is Visible    ${save_filter_checkbox}            25s
    Click Element    ${save_filter_checkbox}

Get Count Of Total Rows In Search Result On Manage Cart page
    Sleep    15s
    ${count_of_rows}        SeleniumLibrary.Get Element Count    ${total_rows}
    Set Test Variable    ${count_of_rows}

Verify Search Results With Save Filter After Reloading page
    Reload Page
    Sleep    12s
    Wait Until Element Is Visible    ${total_rows}      10s
    ${dic}      Set Indexes For Search Table
    ${column_index2}        Get From Dictionary    ${dic}    Booking Id
    ${verify_booking_id}        Get Text    //tbody/tr/td[${column_index2}]/a
    Should Be Equal As Strings    ${verify_booking_id}    ${my_dict.BookingId}

Verify Status and Booking Id After Navigating To Cart Details Page
    Wait Until Element Is Visible    //p[contains(text(),"Booking Id")]/span/span[contains(normalize-space(),"${verify_booking_id}")]               10s
    Wait Until Element Is Visible    (//p[contains(text(),"Status")])[1]/span/span[contains(normalize-space(),"${verify_booking_status}")]          10s

Verify Booking Status Should Not Be Empty
     [Arguments]     ${data}
     ${my_dict}=         Create Dictionary   &{data}
     IF    "${my_dict.Booking_status}" == "Null"
          Click Element      ${remove_all_booking_cancel_icon}
     END
     Click On Search Button On Manage Cart Page
     Wait Until Element Is Visible    ${error_for_booking_status}    timeout=20
     Page Should Contain Element    ${error_for_booking_status}

Verify Payment Status Should Not Be Empty
    [Arguments]     ${data}
    ${my_dict}=         Create Dictionary   &{data}
    IF    "${my_dict.Payment_status}" == "Null"
      Click Element      ${remove_all_payment_cancel_icon}
    END
    Click On Search Button On Manage Cart Page
    Wait Until Element Is Visible    ${error_for_payment_status}    timeout=20
    Page Should Contain Element    ${error_for_payment_status}

Click On Search Button On Manage Cart Page
    Wait Until Element Is Visible   ${search_button}    timeout=20
    Wait Until Element Is Visible    ${search_button}    timeout=20
    Click Element    ${search_button}

Click On Show More Button On Manage Cart Page
    ${status}        Run Keyword And Return Status       Wait Until Element Is Visible    ${show_more_less_button}    timeout=20
    IF    "${status}" == "${True}"
         Click Element    ${show_more_less_button}
    END

Verify Search Result For All Channel Type
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    Click On Show More Button On Manage Cart Page
    Click Element    ${channel_type_field}
    Wait Until Element Is Visible    ${channel_type_all_option}    timeout=20
    Click Element    ${channel_type_all_option}
    Click On Search Button On Manage Cart Page
    Sleep    20s
    Execute Javascript    window.scrollBy(0,800);
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Booking Channel
    Get Booking Detail Modified      Booking Channel
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    IF    "${my_dict.Channel_Types}"=="All"
        ${all_channel_types}    Create List    Desktop    Mobile
        ${all_channels}    Replace String    ${webelements_to_be_replaced}    replace    ${column_index}
        ${Channel_Types}       Get WebElements    ${all_channels}
        ${len}      Get Length    ${Channel_Types}
        FOR    ${counter}    IN RANGE    1    ${len}+1
             ${actual_txt}      Get Text    ${all_channels}
             Should Contain    ${all_channel_types}    ${actual_txt}
        END
    END

Verify Search Result For Desktop Channel Type
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    Click On Show More Button On Manage Cart Page
    Click Element    ${channel_type_field}
    Wait Until Element Is Visible    ${channel_type_desktop_option}    timeout=20
    Click Element    ${channel_type_desktop_option}
    Click On Search Button On Manage Cart Page
    Sleep    20s
    Execute Javascript    window.scrollBy(0,800);
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Booking Channel
    Get Booking Detail Modified      Booking Channel
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    IF    "${my_dict.Channel_Types}"=="Desktop"
        ${all_channels}    Replace String    ${webelements_to_be_replaced}    replace    ${column_index}
        ${Channel_Types}       Get WebElements    ${all_channels}
        ${len}      Get Length    ${Channel_Types}
        FOR    ${counter}    IN RANGE    1    ${len}+1
             ${actual_txt}      Get Text    ${all_channels}
             Should Be Equal As Strings   ${my_dict.Channel_Types}    ${actual_txt}
        END
    END

Verify Search Result For API Channel Type
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    Click On Show More Button On Manage Cart Page
    Click Element    ${channel_type_field}
    Wait Until Element Is Visible    ${channel_type_api_option}    timeout=20
    Wait Until Page Contains Element    ${channel_type_api_option}
    Sleep    2
    Click Element    ${channel_type_api_option}
    Click On Search Button On Manage Cart Page
    Sleep    20s
    Execute Javascript    window.scrollBy(0,800);
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Booking Channel
    Get Booking Detail Modified      Booking Channel
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    IF    "${my_dict.Channel_Types}"=="Api"
        ${all_channels}    Replace String    ${webelements_to_be_replaced}    replace    ${column_index}
        ${Channel_Types}       Get WebElements    ${all_channels}
        ${len}      Get Length    ${Channel_Types}
        FOR    ${counter}    IN RANGE    1    ${len}+1
             ${actual_txt}      Get Text    ${all_channels}
             Should Be Equal As Strings   ${my_dict.Channel_Types}    ${actual_txt}
        END
    END

Verify Search Result For Mobile Channel Type
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    Click On Show More Button On Manage Cart Page
    Click Element    ${channel_type_field}
    Wait Until Element Is Visible    ${channel_type_mobile_option}    timeout=20
    Sleep    2
    Click Element    ${channel_type_mobile_option}
    Click On Search Button On Manage Cart Page
    Sleep    20s
    Execute Javascript    window.scrollBy(0,800);
    Wait Until Element Is Not Visible    //svg[@class="circular"]    timeout=20
    Sleep    10
    ${text_visible_status}    Run Keyword And Return Status    Page Should Contain Element    ${no_data_found_text}
    IF    "${text_visible_status}"== "False"
        ${dic}      Set Indexes For Search Table
        ${column_index}        Get From Dictionary    ${dic}    Booking Channel
        Get Booking Detail Modified      Booking Channel
        Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
        IF    "${my_dict.Channel_Types}"=="Mobile"
            ${all_channels}    Replace String    ${webelements_to_be_replaced}    replace    ${column_index}
            ${Channel_Types}       Get WebElements    ${all_channels}
            ${len}      Get Length    ${Channel_Types}
            FOR    ${counter}    IN RANGE    1    ${len}+1
               ${actual_txt}      Get Text    ${all_channels}
               Should Be Equal As Strings   ${my_dict.Channel_Types}    ${actual_txt}
            END
        END
    ELSE
        Log    no data found
        Page Should Contain Element    ${no_data_found_text}
    END

Verify Result For Journey Type- All
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    Click On Show More Button On Manage Cart Page
    Click Element    ${journey_type_field}
    #    Wait Until Element Is Visible    ${journey_type_all_option}    timeout=20
    Click Element    ${journey_type_all_option}
    Click On Search Button On Manage Cart Page
    Sleep    20s
    Execute Javascript    window.scrollBy(0,800);
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Air Type
    Get Booking Detail Modified      Air Type
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    IF    "${my_dict.Air_Type}"=="All"
        ${all_air_types}    Create List    DOMESTIC    INTERNATIONAL
        ${all_air_type}    Replace String    ${webelements_to_be_replaced}    replace    ${column_index}
        ${Air_Type}       Get WebElements    ${all_air_type}
        ${len}      Get Length    ${Air_Type}
        FOR    ${counter}    IN RANGE    1    ${len}
             ${actual_txt}      Get Text    ${all_air_type}
             Should Contain    ${all_air_types}    ${actual_txt}
        END
    END

Verify Result For Journey Type- Domestic
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    Click On Show More Button On Manage Cart Page
    Click Element    ${journey_type_field}
    Sleep    2
    Click Element    ${journey_type_domestic_option}
    Click On Search Button On Manage Cart Page
    Sleep    20s
    Execute Javascript    window.scrollBy(0,800);
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Air Type
    Get Booking Detail Modified      Air Type
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    IF    "${my_dict.Air_Type}"=="Domestic"
        ${air_type_uppercase}    Evaluate    "${my_dict.Air_Type}".upper()
        ${all_air_type}    Replace String    ${webelements_to_be_replaced}    replace    ${column_index}
        ${Air_Type}       Get WebElements    ${all_air_type}
        ${len}      Get Length    ${Air_Type}
        FOR    ${counter}    IN RANGE    1    ${len}
             ${actual_txt}      Get Text    ${all_air_type}
             Should Contain    ${air_type_uppercase}    ${actual_txt}
        END
    END

Verify Result For Journey Type
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    Click On Show More Button On Manage Cart Page
    Click Element    ${journey_type_field}
    Input Text       //div[text()="Journey Type"]/../descendant::div[@class="react-select__input"]/input       ${my_dict.Air_Type}
    Sleep    2s
    Click Element     //div[@role="option" and text()="${my_dict.Air_Type}"]
    Sleep    2s
    Click On Search Button On Manage Cart Page
    Sleep    20s
    Execute Javascript    window.scrollBy(0,800);
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Air Type
    Get Booking Detail Modified      Air Type
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    IF    "${my_dict.Air_Type}"!="Null"
        ${air_type_uppercase}    Evaluate    "${my_dict.Air_Type}".upper()
        ${all_air_type}    Replace String    ${webelements_to_be_replaced}    replace    ${column_index}
        ${Air_Type}       Get WebElements    ${all_air_type}
        ${len}      Get Length    ${Air_Type}
        FOR    ${counter}    IN RANGE    1    ${len}
             ${actual_txt}      Get Text    ${all_air_type}
             Should Contain    ${air_type_uppercase}    ${actual_txt}
        END
    END

Verify Search Result By Selecting Indigo as Airline Filter
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    Click On Search Button On Manage Cart Page
    Sleep    20s
    Execute Javascript    window.scrollBy(0,800);
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Summary
    Get Booking Detail Modified      Summary
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    IF    "${my_dict.Airline}"=="Indigo"
        ${airline_names}    Replace String    ${webelements_replaced}    replace    ${column_index}
        ${Airlines}       Get WebElements    ${airline_names}
        ${len}      Get Length    ${Airlines}
        FOR    ${counter}    IN RANGE    1    ${len}
             ${actual_txt}      Get Text    ${airline_names}
             ${extracted_airline_code}    Airline    ${actual_txt}
             Should Be Equal As Strings    ${extracted_airline_code}    6E
        END
    END

Verify Search Results By First Name Filter
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    Click On Search Button On Manage Cart Page
    Sleep    20s
    Execute Javascript    window.scrollBy(0,800);
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Passenger Name
    Get Booking Detail Modified      Passenger Name
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    ${passenger_names}    Replace String    ${webelements_replaced}    replace    ${column_index}
    ${Names}       Get WebElements    ${passenger_names}
    ${len}      Get Length    ${Names}
    FOR    ${counter}    IN RANGE    1    ${len}
       ${actual_txt}      Get Text    ${passenger_names}
       ${first_name_uppercase}    Evaluate    "${my_dict.FirstName}".upper()
       ${extracted_first_name}    Extract First Name    ${actual_txt}
       Should Be Equal As Strings    ${extracted_first_name}    ${first_name_uppercase}
    END

Verify Search Results By Last Name Filter
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    Click On Search Button On Manage Cart Page
    Sleep    20s
    Execute Javascript    window.scrollBy(0,800);
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Passenger Name
    Get Booking Detail Modified      Passenger Name
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    ${passenger_names}    Replace String    ${webelements_replaced}    replace    ${column_index}
    ${Names}       Get WebElements    ${passenger_names}
    ${len}      Get Length    ${Names}
    FOR    ${counter}    IN RANGE    1    ${len}
       ${actual_txt}      Get Text    ${passenger_names}
       ${extracted_last_name}    Extract Last Name    ${actual_txt}
       ${last_name_uppercase}    Evaluate    "${my_dict.LastName}".upper()
       Should Be Equal As Strings    ${extracted_last_name}    ${last_name_uppercase}
    END

Verify Search Results By LoggedIn User ID
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    Click On Search Button On Manage Cart Page
    Sleep    30s
    Execute Javascript    window.scrollBy(0,800);
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Logged In User Id
    Get Booking Detail Modified      Logged In User Id
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    ${all_id's}    Replace String    ${webelements_to_be_replaced}    replace    ${column_index}
    ${id's}       Get WebElements    ${all_id's}
    ${len}      Get Length    ${id's}
    FOR    ${counter}    IN RANGE    1    ${len}
       ${actual_txt}      Get Text    ${all_id's}
       ${extracted_user_id}    Extract User Id    ${actual_txt}
       Should Be Equal As Strings    ${extracted_user_id}    ${my_dict.LoggedIn_User_ID}
    END

Verify Search Results By Airline PNR Filter
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    Click On Search Button On Manage Cart Page
    Sleep    30s
    Execute Javascript    window.scrollBy(0,800);
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    PNR
    Get Booking Detail Modified      PNR
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    ${all_pnr}    Replace String    ${webelements_to_be_replaced}    replace    ${column_index}
    ${pnr}       Get WebElements    ${all_pnr}
    ${len}      Get Length    ${pnr}
    FOR    ${counter}    IN RANGE    1    ${len}+1
       ${actual_txt}      Get Text    ${all_pnr}
       Should Be Equal As Strings    ${actual_txt}    ${my_dict.Airline_PNR}
    END

Create Save Filter Label
    ${random_name}      Generate Random String
    Input Text Into Alert    ${random_name}     action=ACCEPT
    Set Test Variable    ${random_name}

Clear All Saved Filter Labels From Manage Cart Page
    ${len}      SeleniumLibrary.Get Element Count    ${total_filter_labels}
    FOR    ${counter}    IN RANGE    1     ${len}+1
        Log    ${counter}
        ${cnt}      Convert To String    ${counter}
        Wait Until Element Is Visible    (//div[@class="quick_filter"]/div/span)[1]        7s
        Click Element       (//div[@class="quick_filter"]/div/span)[1]
        Sleep    3s
    END

Click On Save Filter As Tag Checkbox
    Wait Until Element Is Visible    ${save_filter_as_tag_checkbox}         20s
    Sleep    3s
    Click Element    ${save_filter_as_tag_checkbox}

Verify User Cant Create More Than 5 Save Filter Labels
    ${total_filter_count}          SeleniumLibrary.Get Element Count    ${total_filter_labels}
    ${total_filter_count}       Convert To String    ${total_filter_count}
    Should Be Equal As Strings    ${total_filter_count}     5

Create More Than 5 Save Filter Labels On Manage Cart page
    FOR    ${counter}    IN RANGE    1   6
        Sleep    3s
        Wait Until Element Is Enabled    ${search_btn}          30s
        Click Element    ${search_btn}
        Create Save Filter Label
    END

Verify Save Filter As Label
    Reload Page
    Wait Until Element Is Visible    //button[normalize-space()="${random_name}"]           25s
    Click Element    //button[normalize-space()="${random_name}"]
    Verify Successful Search By Booking Id on Manage Cart Page
