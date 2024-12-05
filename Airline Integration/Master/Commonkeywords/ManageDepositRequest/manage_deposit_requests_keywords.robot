*** Settings ***
Library    SeleniumLibrary
Library    XML
Library    Collections
Library    String
Library    OperatingSystem
Library    ../../Commonkeywords/CustomKeywords/manage_deposit_requests_keywords.py
Resource    ../../Commonkeywords/Login/login_keywords.robot
Resource    ../../Commonkeywords/AddDepositRequest/add_deposit_requests_keywords.robot
Variables  ../../../Environment/environments.py
Variables   ../../PageObjects/ManageDepositRequest/manage_deposit_requests_locators.py

*** Variables ***
${download_path}    ${CURDIR}${/}..${/}..${/}Download${/}csv_files

*** Keywords ***
Login To The Application And Enter "From" Field Details
    [Arguments]    ${user_data}    ${data}
    Login With Valid Admin Username And Password   ${user_data}
    Click On Manage Deposit Requests Tab
    Input From Field    ${data}
    Input To Field    ${data}

Click On Manage Deposit Requests Tab
    Execute JavaScript    window.document.getElementById(id="bs-sidebar-collapse-1").scrollBy(0,800);
    Wait Until Element Is Enabled    ${manage_deposit_request_tab}
    Click Element    ${manage_deposit_request_tab}
    
Click On Search Button
    Wait Until Element Is Enabled    ${search_btn}  timeout=30s
    Click Element    ${search_btn}

Input From Field
    [Arguments]    ${search_data}
    Log    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Sleep    2s
    Wait Until Element Is Enabled    ${to_close_icon}
    Click Element    ${to_close_icon}
    Sleep    5
    Log    ${my_dict.From}
    IF    "${my_dict.From}" != "Null"
        Wait Until Element Is Enabled    ${from_date_input}
        Click Element    ${from_date_input}
        Input Date Using Testdata     ${my_dict.From}
        Input Time Using Testdata     ${my_dict.TimeFrom}
    END

Input To Field
    [Arguments]    ${search_data}
    Log    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    IF    "${my_dict.To}" != "Null"
        Wait Until Element Is Enabled    ${to_date_input}
        Click Element    ${to_date_input}
        Input Date Using Testdata     ${my_dict.To}
        Input Time Using Testdata     ${my_dict.TimeTo}
    END

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

Verify From And To date on search Results
    [Arguments]    ${search_data}
    Verify deposit requests after Click on Reset Button
    ${my_dict}    Create Dictionary   &{search_data}
    ${from_date}   Set Variable     ${my_dict.From}
    ${from_date}    Convert To Standard Date Format    ${from_date}
    IF    "${my_dict.To}" != "Null"
        ${to_date}   Set Variable     ${my_dict.To}
        ${to_date}    Convert To Standard Date Format    ${to_date}
    END
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Created On
    ${total_rows}        Get WebElements    (//tbody/tr/td[${column_index}]/div/span)
    ${len}      Get Length    ${total_rows}
    FOR    ${counter}    IN RANGE    1    ${len}
        Log    ${counter}
        ${cnt}      Convert To String    ${counter}
        ${date_text}        Get Text    (//tbody/tr/td[${column_index}]/div/span)[${cnt}]
        ${given_date}    Convertdate Reverse    ${date_text}
        IF    "${my_dict.To}" != "Null"
            ${status}       Is Date Between    ${from_date}    ${to_date}    ${given_date}
        ELSE
            ${status}       Is Date Start From    ${from_date}    ${given_date}
        END
        Should Be True    ${status}
    END

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

Get Manage Deposit Details
    [Arguments]     ${fieldName}
    ${dic}      Set Indexes For Search Table
    IF    "${fieldName}" == "Created On"
        ${column_index}        Get From Dictionary    ${dic}    Created On
        ${field_value_index}       Convert To String    ${column_index}
    END
    IF    "${fieldName}" == "DR ID"
        ${column_index}        Get From Dictionary    ${dic}    DR ID
        ${field_value_index}       Convert To String    ${column_index}
    END
    IF    "${fieldName}" == "Requested Amount"
        ${column_index}        Get From Dictionary    ${dic}    Requested Amount
        ${field_value_index}       Convert To String    ${column_index}
    END
    IF    "${fieldName}" == "Status"
        ${column_index}        Get From Dictionary    ${dic}    Status
        ${field_value_index}       Convert To String    ${column_index}
    END
    IF    "${fieldName}" == "Type"
        ${column_index}        Get From Dictionary    ${dic}    Type
        ${field_value_index}       Convert To String    ${column_index}
    END
    IF    "${fieldName}" == "Summary"
        ${column_index}        Get From Dictionary    ${dic}    Summary
        ${field_value_index}       Convert To String    ${column_index}
    END
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    Log    ${is_no_data}
    IF    "${is_no_data}" == "True"
        Log    No Data Found!
    ELSE
        Sleep    5
        ${data}=    Get Text    //tbody/tr[1]/td[${field_value_index}]
        RETURN    ${data}
    END

Select Deposit Status
    [Arguments]    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Wait Until Element Is Enabled    ${deposit_status_locator}  timeout=30s
    Click Element    ${deposit_status_locator}
    Input Text    ${deposit_status_input}    ${my_dict.DepositStatus}
    Click Element      (//div[text()="${my_dict.DepositStatus}" and @role="option"])
    Click On Search Button
    Sleep    10

Verify Deposit Status in Search Result
    [Arguments]     ${mydic}
    Verify deposit requests after Click on Reset Button
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    Log    ${is_no_data}
    IF    "${is_no_data}" == "True"
        Log    No Data Found
    ELSE
        ${my_dict}=         Create Dictionary   &{mydic}
        ${actual_data}      Get Manage Deposit Details      Status
        Should Be Equal As Strings    ${actual_data}    ${my_dict.DepositStatus}
        ${all_deposit_status}       Get WebElements    //tbody/tr/td[4]/span[text()="${my_dict.DepositStatus}"]
        ${len}      Get Length    ${all_deposit_status}
        FOR    ${counter}    IN RANGE    1    ${len}+1
            Log    ${counter}
             ${actual_txt}      Get Text    //tbody/tr/td[4]/span[text()="${my_dict.DepositStatus}"]
             Should Be Equal As Strings    ${my_dict.DepositStatus}    ${actual_txt}
        END
    END

Select Deposit Type
    [Arguments]    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Wait Until Element Is Enabled    ${deposit_type_locator}    timeout=30s
    Click Element    ${deposit_type_locator}
    Click Element    //div[text()="${my_dict.DepositType}"]
    Click On Search Button

Verify Deposit Type in Search Result
    [Arguments]     ${mydic}
    Sleep    2
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    IF    "${is_no_data}" == "True"
        Log    No Data Found
    ELSE
        ${my_dict}=         Create Dictionary   &{mydic}
        ${actual_data}      Get Manage Deposit Details      Type
        IF    '${my_dict.DepositType}' == 'Cash at Headoffice'
            ${my_dict.DepositType}    Set Variable    Cash Deposited
        END
        IF    '${my_dict.DepositType}' == 'Online Transaction'
            ${my_dict.DepositType}    Set Variable    Online Trans
        END
        Should Be Equal As Strings    ${actual_data}    ${my_dict.DepositType}
        ${all_deposit_types}       Get WebElements    //tbody/tr/td[7]/div/span[text()="${my_dict.DepositType}"]
        ${len}      Get Length    ${all_deposit_types}
        FOR    ${counter}    IN RANGE    1    ${len}+1
            Log    ${counter}
             ${actual_txt}      Get Text    //tbody/tr/td[7]/div/span[text()="${my_dict.DepositType}"]
             Should Be Equal As Strings    ${my_dict.DepositType}    ${actual_txt}
        END
    END

Verify Search Results Are Filtered According To RC Number
    [Arguments]    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Input Text    ${rc_number_input}    ${my_dict.RCNumber}
    Click On Search Button
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Summary
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    IF    "${is_no_data}" == "True"
        Log    No Data Found
    ELSE
        ${all_summary_details}       Get WebElements    ${summary_row_data}
        ${len}      Get Length    ${all_summary_details}
        FOR    ${counter}    IN RANGE    1    ${len}+1
            ${actual_txt}      Get Text    //tbody/tr[${counter}]/td[${column_index}]
            ${rc_number}    Fetch Rc Number    ${actual_txt}
            Should Be Equal As Strings    ${my_dict.RCNumber}    ${rc_number}
        END
    END

Verify DR ID
    [Arguments]    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Input Text    ${dr_id_input}    ${my_dict.DRId}
    Click On Search Button
    ${is_no_data}=    Run Keyword And Return Status    Wait Until Page Contains    No Data Found!
    Log    ${is_no_data}
    Capture Page Screenshot    
    IF    "${is_no_data}" == "True"
        Log    No Data Found!
    ELSE
        ${actual_data}      Get Manage Deposit Details      DR ID
        Should Be Equal As Strings    ${actual_data}    ${my_dict.DRId}
    END

Verify DR Amount
    [Arguments]    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Input Text    ${dr_amount_input}    ${my_dict.DRAmount}
    Click On Search Button
    ${is_no_data}=    Run Keyword And Return Status    Wait Until Page Contains    No Data Found!
    IF    "${is_no_data}" == "True"
        Log    No Data Found
    ELSE
        ${actual_data}      Get Manage Deposit Details      Requested Amount
        ${dic}      Set Indexes For Search Table
        ${index}        Get From Dictionary    ${dic}    Requested Amount
        ${actual_data}    Update The String    ${actual_data}
        ${my_dict.DRAmount}    Convert To String    ${my_dict.DRAmount}
        ${my_dict.DRAmount}    Update The String    ${my_dict.DRAmount}
        Should Be Equal As Numbers    ${actual_data}    ${my_dict.DRAmount}
        ${web_dr_amounts}    Get Webelements    //tbody/tr/td[${index}]
        FOR    ${element}    IN    @{web_dr_amounts}
            ${actual_dr_amount}    Get Text    ${element}
            ${actual_data}    Update The String    ${actual_dr_amount}
            ${my_dict.DRAmount}    Convert To String    ${my_dict.DRAmount}
            ${my_dict.DRAmount}    Update The String    ${my_dict.DRAmount}
            Should Be Equal As Strings    ${actual_data}    ${my_dict.DRAmount}
        END
    END

Select Assigned User
    [Arguments]    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Wait Until Element Is Enabled    ${assigned_user_locator}   timeout=30s
    Click Element    ${assigned_user_locator}
    Input Text    ${assigned_user_input}    ${my_dict.AssignedUser}
    Wait Until Element Is Enabled    (//div[contains(text(),"${my_dict.AssignedUser}") and @role="option"])     timeout=30s
    Click Element      (//div[contains(text(),"${my_dict.AssignedUser}") and @role="option"])
    Click On Search Button

Verify Assigned User
    [Arguments]    ${search_data}
    Verify deposit requests after click On cancel button of Reset Button
    ${my_dict}    Create Dictionary   &{search_data}
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    Assigned User
    ${is_no_data}=    Run Keyword And Return Status    Wait Until Page Contains    No Data Found!
    IF    "${is_no_data}" == "True"
        Log    No Data Found
    ELSE
        ${all_assigned_user_details}       Get WebElements    //tbody/tr/td[${column_index}]
        ${len}      Get Length    ${all_assigned_user_details}
        FOR    ${counter}    IN RANGE    1    ${len}+1
            ${actual_txt}      Get Text    //tbody/tr[${counter}]/td[${column_index}]
            ${my_dict.AssignedUser}    Convert To String    ${my_dict.AssignedUser}
            Should Contain    ${actual_txt}    ${my_dict.AssignedUser}
        END
    END

Verify Click Full Screen Icon
    Wait Until Element Is Visible    ${reset_btn}   timeout=30s
    Click Element    ${reset_btn}
    Element Should Be Visible    ${popup_reset_btn}
    Click Element    ${popup_reset_btn}
    Wait Until Element Is Visible    ${half_screen_deposit_data}    timeout=30s
    ${half_screen_deposit_data_value}=      Get WebElement    ${half_screen_deposit_data}
    Wait Until Element Is Visible    ${full_screen_icon}
    Click Element    ${full_screen_icon}
    Wait Until Element Is Not Visible    ${full_screen_icon}    timeout=30s
    ${full_screen_deposit_data_value}=      Get WebElement    ${full_screen_deposit_data}
    Should Be Equal As Strings    ${half_screen_deposit_data_value}    ${full_screen_deposit_data_value}

Verify User Is Able To Navigate On User Details Screen
    ${dic}      Set Indexes For Search Table
    ${column_index}        Get From Dictionary    ${dic}    User Id
    Wait Until Element Is Enabled    //tbody/tr/td[${column_index}]/a
    ${actual_user_id}    Get Text    //tbody/tr/td[${column_index}]/a
    Click Element    //tbody/tr/td[${column_index}]/a
    Wait Until Page Contains    USER DETAILS    timeout=20s
    ${user_id}    Get Text    ${breadcrumbs_userid_field}
    Should Contain    ${actual_user_id}    ${user_id}

Verify Is Update Details Popup After Click On Edit
    Click on Customize Button
    Select Any Three Field Names Under Customize Button
    ${dic}      Set Indexes For Search Table
    ${edit_index}        Get From Dictionary    ${dic}    Edit
    Wait Until Element Is Enabled    //tbody/tr[1]/td[${edit_index}]
    Click Element    //tbody/tr[1]/td[${edit_index}]
    Element Should Contain    ${update_details_edit_popup}    UPDATE DETAILS
    Element Should Contain    ${update_button_edit_popup}    UPDATE

Click on Customize Button
    Wait Until Element Is Visible    ${customize_btn}   timeout=30s
    Click Element    ${customize_btn}
   

Verify Popup Title After Click On Customize button
    Wait Until Page Contains    Rearrange Column    timeout=30s

Select Any Three Field Names Under Customize Button
    Wait Until Element Is Visible    ${deselect_all_btn}    timeout=30s
    Click Element    ${deselect_all_btn}
    Click Element    ${created_on_checkbox}
    Click Element    ${edit_checkbox}
    Wait Until Element Is Enabled   ${summary_checkbox}
    Click Element    ${summary_checkbox}
    Click Element    ${save_btn}
    Element Should Be Visible    ${created_on_text}
    Element Should Be Visible    ${edit_text}
    Element Should Be Visible    ${summary_text}

Verify View Icon for Manage Deposit
    Wait Until Element Is Visible    ${reset_btn}   timeout=30s
    Click Element    ${reset_btn}
    Element Should Be Visible    ${popup_reset_btn}     timeout=30s
    Click Element    ${popup_reset_btn}
    Wait Until Element Is Visible    ${user_id}     timeout=30s
    ${user_id_value}=     Get Text    ${user_id}
    ${splitted_user_id}=    Split String    ${user_id_value}    (
    ${extracted_user_id}=    Get From List    ${splitted_user_id}    1
    ${cleaned_user_id}=    Replace String    ${extracted_user_id}    )    ${EMPTY}
    Element Should Be Visible    ${view_icon}       timeout=30s
    Click Element    ${view_icon}
    Wait Until Element Is Visible    ${user_id_manage_user_page}    timeout=30s
    ${user_id_manage_user_page_value}=  Get Text    ${user_id_manage_user_page}
    Should Be Equal As Strings    ${cleaned_user_id}    ${user_id_manage_user_page_value}
    RETURN  ${cleaned_user_id}

Verify History Link for Manage Deposit
    Wait Until Element Is Visible    ${reset_btn}   timeout=30s
    Click Element    ${reset_btn}
    Element Should Be Visible    ${popup_reset_btn}     timeout=30s
    Click Element    ${popup_reset_btn}
    Sleep    2s
    Wait Until Element Is Visible    ${user_id}     timeout=30s
    ${user_id_value}=     Get Text    ${user_id}
    ${splitted_user_id}=    Split String    ${user_id_value}    (
    ${extracted_user_id}=    Get From List    ${splitted_user_id}    1
    ${cleaned_user_id}=    Replace String    ${extracted_user_id}    )    ${EMPTY}
    Execute JavaScript    window.scrollTo(0, 1500)
    Wait Until Element Is Visible    ${history_link}    timeout=30s
    Click Element    ${history_link}
    Wait Until Element Is Visible    ${popup_user_id}   timeout=30s
    ${popup_user_id_value}=     Get Text    ${popup_user_id}
    Should Be Equal As Strings    ${cleaned_user_id}    ${popup_user_id_value}

Verify search results after click on deselect all
    Wait Until Element Is Visible    ${deselect_all_btn}    timeout=30s
    Click Element    ${deselect_all_btn}
    Click Element    ${save_btn}
    ${after_deselect_rows}=   Get Text    ${after_deselect_rows_count}
    ${split_result}=    Split String    ${after_deselect_rows}    ${SPACE}
    ${first_number}=    Get From List    ${split_result}    1
    Should Contain    ${after_deselect_rows}    ${first_number}
    Element Should Be Visible    ${after_deselect_rows_count}

Verify deposit requests after Click on Reset Button
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
        Element Should Be Visible    ${view_icon}
    END

Verify deposit requests after Click On Cancel button of Reset Button
     Wait Until Element Is Visible    ${reset_btn}   timeout=30s
    Click Element    ${reset_btn}
    Element Should Be Visible    ${popup_reset_btn}     timeout=30s
    Click Element    ${popup_reset_btn}
    Wait Until Element Is Visible    ${user_id}     timeout=30s
    ${before_user_id_value}=     Get Text    ${user_id}
    ${splitted_user_id}=    Split String    ${before_user_id_value}    (
    ${extracted_user_id}=    Get From List    ${splitted_user_id}    1
    ${before_cleaned_user_id}=    Replace String    ${extracted_user_id}    )    ${EMPTY}
    Log     ${before_cleaned_user_id}
    Wait Until Element Is Visible    ${reset_btn}   timeout=30s
    Click Element    ${reset_btn}
    Wait Until Element Is Visible    ${reset_cancel_btn}    timeout=30s
    Click Button    ${reset_cancel_btn}
    ${after_user_id_value}=     Get Text    ${user_id}
    ${splitted_user_id}=    Split String    ${after_user_id_value}    (
    ${extracted_user_id}=    Get From List    ${splitted_user_id}    1
    ${after_cleaned_user_id}=    Replace String    ${extracted_user_id}    )    ${EMPTY}
    Should Be Equal As Strings    ${before_cleaned_user_id}    ${after_cleaned_user_id}
    Log     ${after_cleaned_user_id}

Verify results after selecting any two field names under Customize Button
    Wait Until Element Is Visible    ${deselect_all_btn}    timeout=30s
    Click Element    ${deselect_all_btn}
    Click Element    ${edit_checkbox}
    Click Element    ${history_checkbox}
    Click Element    ${save_btn}
    Wait Until Element Is Visible    ${edit_text}    timeout=30s
    Element Should Be Visible    ${edit_text}
    Element Should Be Visible    ${history_text}

Verify Popup Title After Click On Download Button
    Wait Until Element Is Enabled    ${download_button}     timeout=30s
    Click Element    ${download_button}
    Page Should Contain    Rearrange Column
    Page Should Contain Element    ${save_preferences_button}

Verify The Downloaded File After Click On Deselect All
    Verify Popup Title After Click On Download Button
    ${file_path}=    Set Variable    ${download_path}${/}manage-deposit-request.csv
    ${file_exists}=    Run Keyword And Return Status    File Should Exist    ${file_path}
    Run Keyword If    ${file_exists}    Remove File    ${file_path}
    Wait Until Element Is Visible    ${deselect_all_btn}    timeout=30s
    Click Element    ${deselect_all_btn}
    Click Element    ${save_preferences_button}
    Click Element    ${download_file_button}
    Wait Until Keyword Succeeds    30s    1s    File Should Exist    ${download_path}${/}manage-deposit-request.csv
    ${file_contents}=    Get File    ${file_path}
    ${cleaned_contents}=    Set Variable    ${file_contents.replace('\ufeff', '').strip()}
    Log    ${cleaned_contents}
    Should Be Empty    ${cleaned_contents}

Verify The Downloaded File After Click On Deselect All And Select Any Two Fields
    Verify Popup Title After Click On Download Button
    ${file_path}=    Set Variable    ${download_path}${/}manage-deposit-request.csv
    ${file_exists}=    Run Keyword And Return Status    File Should Exist    ${file_path}
    Run Keyword If    ${file_exists}    Remove File    ${file_path}
    Wait Until Element Is Visible    ${deselect_all_btn}    timeout=30s
    Click Element    ${deselect_all_btn}
    ${download_created_on_text_value}=  Get Text    ${download_created_on_text}
    Log    ${download_created_on_text_value}
    Click Element    ${download_created_on_checkbox}
    Click Element    ${download_dr_id_checkbox}
    Click Element    ${save_preferences_button}
    Click Element    ${download_file_button}
    Wait Until Keyword Succeeds    30s    1s    File Should Exist    ${file_path}
    ${file_contents}=    Get File    ${file_path}
    Should Contain    ${file_contents}    ${download_created_on_text_value}

Verify File Download After Click On Download File Button Without Giving File Name
    Verify Popup Title After Click On Download Button
    #    Change this download path according to the system
    ${file_path}=    Set Variable    ${download_path}
    ${file_exists}=    Run Keyword And Return Status    File Should Exist    ${file_path}
    Run Keyword If    ${file_exists}    Remove File    ${file_path}
    Click Element    ${download_file_button}
    Wait Until Keyword Succeeds    30s    1s    File Should Exist    ${file_path}${/}manage-deposit-request.csv
    ${file_contents}=    Get File    ${file_path}${/}manage-deposit-request.csv

Verify File Download After Click On Download File Button By Giving File Name
    [Arguments]     ${login_data}
    ${my_dict}    Create Dictionary   &{login_data}
    Verify Popup Title After Click On Download Button
    Wait Until Element Is Visible    ${file_name_input_text}
    Input Text    ${file_name_input_text}    ${my_dict.FileName}
    ${file_path}=    Set Variable    ${download_path}${/}${my_dict.FileName}.csv
    ${file_exists}=    Run Keyword And Return Status    File Should Exist    ${file_path}
    Run Keyword If    ${file_exists}    Remove File    ${file_path}
    Click Element    ${download_file_button}
    Sleep    5s
    Wait Until Keyword Succeeds    30s    1s    File Should Exist    ${file_path}
    ${file_contents}=    Get File    ${file_path}

Click On Switch Back Button
    Wait Until Element Is Visible    ${switch_back_btn}
    Click Element    ${switch_back_btn}

Verify Search Results Of Manage User And Emulate
    [Arguments]    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Wait Until Element Is Enabled    //input[@id="react-select-3-input"]    timeout=50s
    Sleep    3
    Input Text    //input[@id="react-select-3-input"]    ${my_dict.UserId}
    Sleep    8
    Press Key   //input[@id="react-select-3-input"]    \\13
    Wait Until Element Is Enabled    //button[@class="btn sign_btn "]    timeout=30s
    Click Element    //button[@class="btn sign_btn "]
    Wait Until Element Is Enabled    //a[text()='Emulate']    timeout=30s
    Click Element    //a[text()='Emulate']
    Wait Until Page Contains    Book flights and explore the world with us.

Add Deposit Requests Details From Agents Account
    [Arguments]    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Wait Until Element Is Visible    ${balance_locator}
    ${balance_text}    Get Text    ${balance_locator}
    Log    ${balance_text}
    ${balance}    Split String By Colon   ${balance_text}
    ${balance}    Update The String    ${balance}
    Redirect To Add Deposit Requests Tab
    Verify Deposit Request Is Added    ${my_dict}
    Verify Account Is Switch Back To Admin    ${my_dict}    ${balance}
    
Enter Username And Other Mandatory Fields
    [Arguments]    ${my_dict}
    Wait Until Element Is Enabled    ${username_locator}
    Click Element    ${username_locator}
    Input Text    ${username_input}    ${my_dict.UserId}
    Click Element      (//div[contains(text,"${my_dict.UserId}") and @role="option"])
    Wait Until Element Is Enabled    ${to_close_icon}
    Click Element    ${to_close_icon}

Verify Account Is Switch Back To Admin
    [Arguments]    ${my_dict}    ${balance}
    Click On Switch Back Button
    Wait Until Page Contains Element    ${dashboard_nav_btn}     timeout=30s
    Click On Manage Deposit Requests Tab
    Enter Username And Other Mandatory Fields    ${my_dict}
    Click On Search Button

Verify Deposit Details Updated With Entered RC Number
    [Arguments]    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    ${popup_rc_number}    Get Text    ${rc_number_edit_input}
    ${popup_dh_number}    Get Text    ${dh_number_edit_input}
    IF    "${popup_rc_number}" == "Null" and "${popup_dh_number}" == "Null"
        Input Text    ${rc_number_edit_input}    ${my_dict.RCNumber}
        Input Text    ${dh_number_edit_input}    ${my_dict.DHNumber}
        Capture Page Screenshot
        Click Element    ${update_button_edit_popup}
        IF    "${popup_rc_number}" == "${my_dict.RCNumber}"
            Page Should Contain    Details already updated
        ELSE
            ${dic}      Set Indexes For Search Table
            ${column_index}        Get From Dictionary    ${dic}    Summary
            ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
            IF    "${is_no_data}" == "True"
                Log    No Data Found
            ELSE
                ${all_summary_details}       Get WebElements    ${summary_row_data}
                ${len}      Get Length    ${all_summary_details}
                FOR    ${counter}    IN RANGE    1    ${len}+1
                    ${actual_txt}      Get Text    //tbody/tr[${counter}]/td[${column_index}]
                    ${rc_number}    Fetch Rc Number    ${actual_txt}
                    Log    ${rc_number}
                END
            END
        END
    END

Verify Deposit Details Updated With Entered RC Number And DH Number
    [Arguments]    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    ${popup_rc_number}    Get Text    ${rc_number_edit_input}
    Log    ${popup_rc_number}
    ${popup_dh_number}    Get Text    ${dh_number_edit_input}
    Log    ${popup_dh_number}
    Sleep    7s
    IF    "${popup_rc_number}" == "Null" and "${popup_dh_number}" == "Null"
        Input Text    ${rc_number_edit_input}    ${my_dict.RCNumber}
        Input Text    ${dh_number_edit_input}    ${my_dict.DHNumber}
        Capture Page Screenshot
        Sleep    7s
        Click Element    ${update_button_edit_popup}
        Sleep    7s
        IF    "${popup_rc_number}" == "${my_dict.RCNumber}"
            Page Should Contain    Details already updated
        ELSE
            ${dic}      Set Indexes For Search Table
            ${column_index}        Get From Dictionary    ${dic}    Summary
            ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
        END
    END
