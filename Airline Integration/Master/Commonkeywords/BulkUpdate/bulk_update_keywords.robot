*** Settings ***
Library    SeleniumLibrary
Library    XML
Library    ../../Commonkeywords/CustomKeywords/user_keywords.py
Library    String
Library    Collections
Library     OperatingSystem
Library    DateTime
Library     Process
Library     random
Library    ExcelLibrary
Variables  ../../../Environment/environments.py
Variables    ../../PageObjects/BulkUpdate/bulk_update_locators.py
Variables    ../../PageObjects/ManageCart/manage_cart_locators.py

*** Variables ***
${download_path}=    ${CURDIR}${/}..${/}..${/}Download${/}csv_files
#${manual_order_file}    manual_order.xlsx

*** Keywords ***
Click on Bulk Update Menu
    Set Browser Implicit Wait    30s
    Execute JavaScript    window.document.getElementById(id="bs-sidebar-collapse-1").scrollBy(0,1500);
    Click Element    ${bulk_update_label}

Select option from dropdown
    [Arguments]    ${data}
    ${test_data}=         Create Dictionary   &{data}
    Select From List By Label    ${type_droupdown}    ${test_data.Type1}

Select 'Notification' option from dropdown
    [Arguments]    ${data}
    ${test_data}=         Create Dictionary   &{data}
    Select From List By Label    ${type_droupdown}    ${test_data.Type2}

Upload file
    [Arguments]    ${file_path}
    ${normalize_path}    Normalize Path    ${file_path}
    Choose File    ${browse_file}    ${normalize_path}
    Wait Until Element Is Visible    ${uploaded_file_name}    10s
    Click Element    ${upload_button}
    Capture Page Screenshot

Verify file uploaded successfully
    Wait Until Element Is Visible    ${file_upload_success_msg}    20s
    Element Should Contain    ${file_upload_success_msg}    Failure : 0
    ${submitted_date_time}=    DateTime.Get Current Date    result_format=%d-%m-%Y %H:%M
    Set Test Variable    ${submitted_date_time}

Click on Manage Carts
    Execute JavaScript    window.document.getElementById(id="bs-sidebar-collapse-1").scrollBy(0,-1500);
    Click Element    ${manage_cart_link}

Click on Search button
    Wait Until Element Is Visible    ${search_button}    10s
    Sleep    2s
    Click Element    ${search_button}

Verify Booking status is on hold for the passenger in Manage Carts section
    [Arguments]    ${file_path}
    Wait Until Element Is Visible    ${generation_time_column_heading}
    Click Element    ${generation_time_column_heading}
    sleep    2s
    ${status}=    Get Text    ${on_hold_status}
    ${passenger_name_excel}     Get passenger name From Excel    ${file_path}
    IF    "${status}"=="On Hold"
        ${date_time}=    Get Text    ${generation_time}
        ${generated_date_time}=    Evaluate    datetime.datetime.strptime($date_time, "%b %d, %Y %I:%M %p").strftime("%d-%m-%Y %H:%M")
        Log    Converted Date: ${generated_date_time}
        Should Be Equal    ${submitted_date_time}    ${generated_date_time}
        ${passenger_name_actual}    Get Text        ${passenger_name}
        Log    ${passenger_name_actual}
        Element Should Contain    ${passenger_name}    ${passenger_name_excel}
    END

Get passenger name From Excel
    [Arguments]    ${file_path}
    Open Excel Document    ${file_path}    Passenger Details
    ${passenger_name_excel}    Read Excel Cell    2     5    Passenger Details
    Log    ${passenger_name_excel}
    Close All Excel Documents
    [Return]    ${passenger_name_excel}

Click on Sample Document button
    [Arguments]    ${data}
    ${test_data}=         Create Dictionary   &{data}
    Remove File    ${download_path}/${test_data.DownloadedFileName}
    Sleep    2s
    Click Element    ${sample_document_button}
    sleep    2s

Verify Sample document downloaded successfully
    [Arguments]    ${data}
    ${test_data}=         Create Dictionary   &{data}
    File Should Exist    ${download_path}/${test_data.DownloadedFileName}    File not downloaded successfully

Verify error message "Invalid sheet uploaded. Refer Sample Document."
    Wait Until Element Is Visible    ${invalid_sheet_upload_msg}    10s
    Element Should Contain    ${invalid_sheet_upload_msg}    ${text_invalid_sheet_upload_msg}
