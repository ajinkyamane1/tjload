*** Settings ***
Library    SeleniumLibrary
Library    XML
Library    DateTime
Library    String
Library    Collections
Library     OperatingSystem
Library     Process
Library    CSVLibrary
Library    ../../Commonkeywords/CustomKeywords/user_keywords.py
Library    ../../Commonkeywords/CustomKeywords/manage_deposit_requests_keywords.py
Variables  ../../../Environment/environments.py
Variables    ../../PageObjects/ManageAmendments/manage_amendments_locators.py

*** Keywords ***
Select Manage Amendments Menu | Admin
    Wait Until Element Is Visible    ${manage_amendments_field}
    Click Element    ${manage_amendments_field}
    Sleep    2

Click On Search Button
    Wait Until Element Is Enabled    ${search_btn}  timeout=30s
    Click Element    ${search_btn}

Select Search Filter | Admin
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    Wait Until Element Is Visible    ${dashboard_nav_btn}    10s
    Wait Until Element Is Visible    ${search_btn}    10s
    Wait Until Element Is Enabled    ${to_close_icon}
    IF  "${my_dict.From}" != "Null"
        Wait Until Element Is Enabled    ${from_date_input}
        Click Element    ${from_date_input}
        Input Date Using Testdata     ${my_dict.From}
        Input Time Using Testdata     ${my_dict.TimeFrom}
    END
    IF  "${my_dict.To}" != "Null"
        Wait Until Element Is Enabled    ${to_date_input}
        Click Element    ${to_date_input}
        Input Date Using Testdata     ${my_dict.To}
        Input Time Using Testdata     ${my_dict.TimeTo}
    END
    IF  "${my_dict.AmendmentType}" != "Null"
        Wait Until Element Is Enabled    ${amendments_type}    timeout=30s
        Click Element    ${amendments_type}
        Click Element    //div[text()="${my_dict.AmendmentType}"]
    END
    IF  "${my_dict.AmendmentStatus}" != "Null"
        Wait Until Element Is Enabled    ${amendments_status}  timeout=30s
        Click Element    ${amendments_status}
        Click Element      (//div[text()="${my_dict.AmendmentStatus}" and @role="option"])
    END
    IF  "${my_dict.AssignedUser}" != "Null"
        Wait Until Element Is Enabled    ${assigned_user_field}   timeout=30s
        Click Element    ${assigned_user_field}
        Input Text    ${assigned_user_input}    ${my_dict.AssignedUser}
        Wait Until Element Is Enabled    (//div[contains(text(),"${my_dict.AssignedUser}") and @role="option"])     timeout=30s
        ${assigned_user}=    Get Text    (//div[contains(text(),"${my_dict.AssignedUser}") and @role="option"])
        Click Element      (//div[contains(text(),"${my_dict.AssignedUser}") and @role="option"])
    END
    Wait Until Element Is Visible    ${search_btn}    10s
    Click Element        ${save_filter_checkbox}
    Click Element    ${search_btn}
    Sleep    2s

Input Date Using Testdata
    [Arguments]     ${from_field_date}
    Wait Until Element Is Visible    ${calendar_container}
    Log    ${from_field_date}
    @{date_list}    Convert Input To Date    ${from_field_date}
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

Verify manage amendments after Click on Reset Button
    ${user_id_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${user_id}
    ${no_data_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${no_data_found_text}
    IF    ${no_data_visible}
        Log    No data found! Test case terminated.
        Pass Execution    No data found! Test case terminated.
    END

Get Search Card Data
    ${my_dict}=    Create Dictionary
    Wait Until Element Is Visible    ${search_card_thead_count}    10s
    ${card_column_count}=    SeleniumLibrary.Get Element Count    ${search_card_thead_count}
    Wait Until Element Is Visible    ${search_card_tbody_count}    10s
    ${card_row_count}=    SeleniumLibrary.Get Element Count    ${search_card_tbody_count}
    Log    ${card_row_count}
    ${const}=    Set Variable    1
    FOR    ${card_row_count}    IN RANGE    1    ${card_row_count}+1
        Exit For Loop If    ${card_row_count}==10
        FOR    ${card_column_count}    IN RANGE    1    ${card_column_count}+1
        ${cnt}=     Convert To String    ${card_column_count}
        ${text_column_head}=      Get Text    //thead[contains(@class,'theader')]/tr/td[${cnt}]
        ${text_coloumn_data}=    Get Text    //tbody[contains(@class,'table')]/tr[${card_row_count}]/td[${cnt}]
        Set To Dictionary    ${my_dict}    ${text_column_head}${const}=${text_coloumn_data}
        END
        ${const}=    Evaluate    ${const}+1
    END
    Log    ${my_dict}
    [Return]    ${my_dict}

Verify From And To date on search Results
     [Arguments]     ${search_data}
     ${my_dict}=    Create Dictionary   &{search_data}
     ${search_card_data}    Get Search Card Data
     ${From_Date}    Get Value       ${from_date_input}
     ${To_date}    Get Value       ${to_date_input}
     ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
     FOR    ${counter}    IN RANGE    1    ${row_count}+1
         Exit For Loop If    ${counter}==10
         Log    ${counter}
         ${date_to_check}    Extract Date    ${search_card_data['Generation Time${counter}']}
         ${from_d}    Extract Date Only        ${From_Date}
         ${to_d}    Extract Date Only        ${To_Date}
         Log    ${from_d}
         Log    ${to_d}
         ${result}   Is Date In Range    ${from_d}    ${to_d}    ${date_to_check}
         IF    ${result}
             Log    Date in Given Range
         ELSE
             Fail
         END
     END

Verify Amendment Type On Search Card
    [Arguments]     ${manageamendment_data}      ${search_card_data}
    ${my_dict}=    Create Dictionary   &{manageamendment_data}
    Wait Until Element Is Visible    ${expand_button}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Exit For Loop If    ${counter}==10
        Log    ${counter}
        Should Be Equal As Strings    ${search_card_data['Type${counter}']}   ${my_dict.AmendmentType.upper()}
    END

Verify Amendment Status On Search Card
    [Arguments]     ${manageamendment_data}      ${search_card_data}
    ${my_dict}=    Create Dictionary   &{manageamendment_data}
    Wait Until Element Is Visible    ${expand_button}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Exit For Loop If    ${counter}==10
        Log    ${counter}
        Should Be Equal As Strings    ${search_card_data['Status${counter}']}   ${my_dict.AmendmentStatus}
    END

Verify Assigned User
    [Arguments]    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Assigned User
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    IF    "${is_no_data}" == "True"
        Log    No Data Found
    ELSE
        ${all_assigned_user_details}       Get WebElements    //tbody/tr/td[${column_index}]
        ${len}      Get Length    ${all_assigned_user_details}
        FOR    ${counter}    IN RANGE    1    ${len}+1
            ${actual_txt}      Get Text    //tbody/tr[${counter}]/td[${column_index}]
            Should Contain    ${actual_txt}   	${final_name}
        END
    END

Click on Customize Button
    Wait Until Element Is Visible    ${customize_btn}   timeout=30s
    Click Element    ${customize_btn}

search results after click on deselect all
    Wait Until Element Is Visible    ${deselect_all_btn}    timeout=30s
    Click Element    ${deselect_all_btn}
    Click Element    ${save_btn}
    ${after_deselect_rows}=   Get Text    ${after_deselect_rows_count}
    ${split_result}=    Split String    ${after_deselect_rows}    ${SPACE}
    ${first_number}=    Get From List    ${split_result}    1
    Should Contain    ${after_deselect_rows}    ${first_number}
    Element Should Be Visible    ${after_deselect_rows_count}

Verify manage amendment after Click on Reset Button
    ${user_id_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${user_id}
    ${no_data_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${no_data_found_text}
    IF    ${no_data_visible}
        Log    No data found! Test case terminated.
        Pass Execution    No data found! Test case terminated.
    ELSE
        Wait Until Element Is Visible    ${reset_btn}   timeout=30s
        Click Element    ${reset_btn}
        Element Should Be Visible    ${popup_reset_btn}
        Click Element    ${popup_reset_btn}
    END

search results after click on deselect three option
    Wait Until Element Is Visible    ${deselect_all_btn}    timeout=30s
    Click Element    ${download_generation_checkbox}
    Click Element    ${download_departure_checkbox}
    ${generation_text}=    Get Text    ${generation_checkbox_text}
    ${departure_text}=    Get Text    ${departure_checkbox_text}
    Click Element    ${save_btn}
    Page Should Not Contain    ${generation_text}
    Page Should Not Contain    ${departure_text}

Navigate To Download Button
    Wait Until Element Is Visible    ${download_button}
    Click Element    ${download_button}
    Wait Until Element Is Visible    ${save_preferences_button}
    Wait Until Element Is Visible    ${download_file_button}
    ${download_created_on_text_value}=  Get Text    ${generation_checkbox_text}
    Set Test Variable    ${download_created_on_text_value}
    Click Element    ${save_preferences_button}
    Click Element    ${download_file_button}

Verify File Is Downloaded
    ${now}  Get Time  epoch
    Sleep    5
    ${res}  Check Download   ${now}
    Log    ${res}
    Should Contain    ${res}    .csv
    File Should Exist    ${res}
    RETURN  ${res}

Verify Data In Downloaded File
    [Arguments]  ${filepath}
    ${headers}  Get Csv Headers For Amendment    ${filepath}
    ${row}  Set Variable  1
    ${row}  Convert To Number  ${row}
    FOR    ${header}    IN    @{headers}
        ${data}  Get Data By Header Row    ${filepath}    ${header}    ${row}
        Should Not Be Equal  ${data}    ${null}
    END

Cancel Icons on Search Filter
    Wait Until Element Is Visible    ${search_btn}   timeout=10s
    Sleep    1
    Click Element    ${clear_date_field}
    Click Element    ${clear_date_field}
    Click Element    ${clear_user_role_field}
    Wait Until Element Is Visible    ${search_btn}

Select Search Filter For Manage User | Admin
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    Wait Until Element Is Visible    ${dashboard_nav_btn}    10s
    Click Element    ${dashboard_nav_btn}
    Wait Until Element Is Visible    ${show_more_button}    10s
    Click Element    ${show_more_button}
    Wait Until Element Is Visible    ${search_btn}    10s
    IF  "${my_dict.User_id}" != "Null"
        Log    ${my_dict.User_id}
        Wait Until Element Is Visible    ${user_id_field}    10s
        Input Text    ${user_id_field}    ${my_dict.User_id}
        Wait Until Element Is Visible    ${select_user_id}    10s
        Sleep    2s
        Click Element    ${select_user_id}
    END
    Click Element    ${search_btn}
    Sleep    2s

Get Search Card Data For Manage Amendment| Admin
    ${my_dict}=    Create Dictionary
    Wait Until Element Is Visible    ${search_card_thead_count}    10s
    ${card_column_count}=    SeleniumLibrary.Get Element Count    ${search_card_thead_count}
    Wait Until Element Is Visible    ${search_card_tbody_count}    10s
    ${card_row_count}=    SeleniumLibrary.Get Element Count    ${search_card_tbody_count}
    Log    ${card_row_count}
    ${const}=    Set Variable    1
    FOR    ${card_row_count}    IN RANGE    1    10
        FOR    ${card_column_count}    IN RANGE    1    ${card_column_count}+1
        ${cnt}=     Convert To String    ${card_column_count}
        ${text_column_head}=      Get Text    //thead[contains(@class,'theader')]/tr/td[${cnt}]
        ${text_coloumn_data}=    Get Text    //tbody[contains(@class,'table')]/tr[1]/td[${cnt}]
        Set To Dictionary    ${my_dict}    ${text_column_head}${const}=${text_coloumn_data}
        END
        ${const}=    Evaluate    ${const}+1
    END
    Log    ${my_dict}
    [Return]    ${my_dict}

Verify User Id In Search Card For Manage User
    [Arguments]     ${manageamendment_data}      ${search_card_data}
    ${my_dict}=    Create Dictionary   &{manageamendment_data}
    Wait Until Element Is Visible    ${customize_button}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Exit For Loop If    ${counter}==10
        Log    ${counter}
        ${user_id}    Convert To String    ${my_dict.User_id}
        Should Contain    ${search_card_data['User Id${counter}']}    ${user_id}
        ${user_id_text}    Get Text    //tbody[contains(@class,'table')]/tr[1]/td[3]
        ${split_string}=    Split String    ${user_id_text}    (
        ${name}=    Set Variable    ${split_string}[0]
        ${final_name}    Strip String    ${name}
        Set Global Variable    ${final_name}
    END

Verify Download Invoice Button & File
    Verify Manage Amendment After Click On Reset Button
    Execute Javascript    window.scrollBy(0,500);
    Sleep    5
    Click Element    ${invoice_text}
    Scroll Element Into View   ${select_all_checkbox}
    Click Element    ${select_all_checkbox}
    ${booking_id}    Get Text    (//tbody[contains(@class,'table')]/tr/td[7])[1]
    ${amendnment_id}    Get Text    (//tbody[contains(@class,'table')]/tr/td[5])[1]
    ${invoice_date}    Get Text    (//tbody[contains(@class,'table')]/tr/td[1])[1]
    Capture Page Screenshot
    ${formatted_date}=   Convert Date For Pdf    ${invoice_date}
    ${printed_details}=    Create Dictionary    booking_id=${booking_id}    amendment_id=${amendnment_id}    formatted_date=${formatted_date}
    [Return]    ${printed_details}

Verify Details On Print Page
    [Arguments]    ${printed_details}
    Scroll Element Into View    ${download_invoice}
    Click Element    ${download_invoice}
    Sleep    5s
    ${file_booking_id}    Get Text    //span[@class="tj-bookingId amendmentInvoice-subheader-tjid-positionHandle"]
    ${split_booking_id}    Split String    ${file_booking_id}    :
    ${display_booking_id}=  Replace String    ${split_booking_id}[1]    ${SPACE}    ${EMPTY}
    ${file_invoice_date}    Get Text    //span[@class="atj-bookingId amendmentInvoice-subheader-atjid-positionHandle"]
    ${final_invoice_date}    Split String    ${file_invoice_date}    :
    ${display_invoice_date}=  Replace String    ${final_invoice_date}[1]    ${SPACE}    ${EMPTY}
    ${amendment_no}    Get Text    //span[@class="atj-bookingId amendmentInvoice-subheader-atjid-positionHandle"]
    ${final_amendment_no}    Split String        ${amendment_no}    :
    ${display_amendment_no}=  Replace String    ${final_amendment_no}[1]    ${SPACE}    ${EMPTY}
    ${printed_details}=    Create Dictionary    booking_id=${display_booking_id}    amendment_id=${display_amendment_no}    formatted_date=${display_invoice_date}
    [Return]    ${printed_details}

Check for the Save Filter checkbox
    Execute Javascript    window.scrollTo(0, 300);
    Wait Until Element Is Visible    ${toggle_button}
    Click Element    ${toggle_button}
    Sleep    2s
    ${alert_text}=    Handle Alert    action=accept
    Log    Alert Text: ${alert_text}
