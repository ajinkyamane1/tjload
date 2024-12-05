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
Library     ../../../Environment/environments.py
Library    ../CustomKeywords/user_keywords.py
Resource    ../../Commonkeywords/ManageCart/Manage_cart_keywords.robot
Variables    ../../PageObjects/Dashboard/download_report_locators.py
Variables    ../../PageObjects/ManageCart/manage_cart_locators.py

*** Keywords ***
Navigate To Dashboard And Click On Download Report Link
    Wait Until Element Is Visible    ${dashboard_link}
    Click Element    ${dashboard_link}
    Execute JavaScript    window.document.getElementById(id="bs-sidebar-collapse-1").scrollBy(0,1600);
    Sleep    5s
#    Run Keyword And Ignore Error    Scroll Element Into View    ${cms_link}
    Wait Until Element Is Visible    ${download_report_link}
    Click Element    ${download_report_link}
    Wait Until Element Is Visible    ${search_button}

Click On Search And Then Click On Submit
    Wait Until Element Is Visible    ${search_button}
    Click Element    ${search_button}
    Execute Javascript  window.scrollTo(0,200)
    Wait Until Element Is Visible    ${submit_button}
    Click Element    ${submit_button}

Verify By Default Airline Sales Report Is Selected
    Wait Until Element Is Visible    ${report_type_airline_sales}   timeout=30
    
Verify File Is Downloaded
    ${now}  Get Time  epoch
    Sleep    15s
    ${res}  Check Download   ${now}
    Log    ${res}
    Should Contain    ${res}    .csv
    File Should Exist    ${res}
    RETURN  ${res}

Select Booking Transaction In Report Type
    Wait Until Element Is Visible    ${report_type_field}
    Click Element    ${report_type_field}
    Sleep   2
    Wait Until Element Is Visible    ${booking_transaction_dropdown}
    Click Element    ${booking_transaction_dropdown}

Select Report Type
    [Arguments]    ${search_data}
    ${my_dict}       Create Dictionary   &{search_data}
    Wait Until Element Is Visible    ${report_type_field}
    Click Element    ${report_type_field}
    Sleep   1
    ${option}=  Replace String    ${report_type_dropdown}    Report_Type    ${my_dict.report_type}
    Wait Until Element Is Visible    ${option}
    Click Element    ${option}

Enter details in Report Download Form as per report type
    [Arguments]     ${data}
     ${my_dict}=         Create Dictionary   &{data}
     Set Test Variable    ${my_dict}
     IF    "${my_dict.From}" != "Null"
          Click Element    ${from_date_input}
          Input From Date using testdata modified version     1

           IF    "${my_dict.TimeFrom}" != "Null"
            Input Time Using testdata     ${my_dict.TimeFrom}
          END
     END
#     IF    "${my_dict.To}" != "Null"
#          Click Element    ${to_date_input}
#          Input To Date using testdata modified version current Date
#          IF    "${my_dict.TimeTo}" != "Null"
#            Input Time Using testdata     ${my_dict.TimeTo}
#          END
#     END
     IF    "${my_dict.User_id}" != "Null"
         Click Element    ${user_id_field}
         Input Text    ${user_id_field}    ${my_dict.User_id}
     END
     IF    "${my_dict.User_role}" != "Null"
         Click Element    ${user_roles}
         Click Element    ${agent}
     END
     IF    "${my_dict.select_rows}" != "Null"
         Sleep    4s
         Click Element    ${select_rows}
         Sleep    4s
         Click Element    ${all_rows}
     END
     IF    "${my_dict.From_departure}" != "Null"
         sleep    1s
          Click Element    ${from_departure}
          sleep    1s
          Pick the date    previous    30days

#           IF    "${my_dict.TimeFrom_departure}" != "Null"
#            Input Time Using testdata     ${my_dict.TimeFrom_departure}
#          END
     END
     IF    "${my_dict.To_departure}" != "Null"
         sleep    1s
          Click Element    ${to_departure}
          sleep    1s
#           Input To Date using testdata modified version current Date
            Pick the date    post    15days

#          IF    "${my_dict.TimeTo_departure}" != "Null"
#            Input Time Using testdata     ${my_dict.TimeTo_departure}
#          END
     END
     IF    "${my_dict.From_bookingDate}" != "Null"
         sleep    1s
          Click Element    ${from_booking}
          sleep    1s
#          Pick the date    previous    30days
          Input To Date using testdata modified version current Date

           IF    "${my_dict.TimeFrom_bookingDate}" != "Null"
            Input Time Using testdata     ${my_dict.TimeFrom_bookingDate}
          END
     END
     IF    "${my_dict.To_bookingDate}" != "Null"
         sleep    1s
          Click Element    ${to_booking}
          sleep    1s
#          Input To Date using testdata modified version current Date
            Pick the date    post    15days
          IF    "${my_dict.TimeTo_bookingDate}" != "Null"
            Input Time Using testdata     ${my_dict.TimeTo_bookingDate}
          END
     END
     IF    "${my_dict.Airline_codes}" != "Null"
         Click Element    ${airline_codes}
         Input Text    ${airline_codes}    ${my_dict.Airline_codes}
         Sleep    2s
         Click Element    //div[@role="option"][1]
     END

Select Daily sales report In Report Type
    Wait Until Element Is Visible    ${report_type_field}
    Click Element    ${report_type_field}
    Sleep    2s
    Click Element    ${daily_sales_report_dropdown}
    Sleep    2s

Select Airline Transaction In Report Type
    Wait Until Element Is Visible    ${report_type_field}
    Click Element    ${report_type_field}
    Sleep    2s
    Click Element    ${airline_transaction_dropdown}
    Sleep    2s

Verify Data In Downloaded File
    [Arguments]  ${filepath}
    ${headers}  Get Csv Headers  ${filepath}
#    ${row}  Set Variable  1
    ${row}  Convert To Integer    1
    FOR    ${header}    IN    @{headers}
        ${data}  Get Data By Header Row    ${filepath}    ${header}    ${row}
        Should Not Be Equal  ${data}  ${null}
    END


Click on search button
    Wait Until Element Is Visible    ${search_button}
    Click Element    ${search_button}
    Sleep    2
    Execute Javascript  window.scrollTo(0,300)
    Sleep    2

Exclude some fields
    Wait Until Element Is Visible    (${inclusion_fields})[1]    10s
    ${label1}    Get Text    (${inclusion_fields})[1]
    Click Element    (${inclusion_fields})[1]
    ${label2}    Get Text    (${inclusion_fields})[3]
    Click Element    (${inclusion_fields})[3]
    ${excluded_labels}    Create List    ${label1}    ${label2}
    Sleep    2s
    Click Element    ${exclude_button}
    Sleep    5s
    Set Test Variable   ${excluded_labels}
    ${inclusion_labels}=    Get list of all inclusion list
    Set Test Variable   ${inclusion_labels}


Get list of all inclusion list
    ${labels_in_inclusion_box}=    Create List
    ${count}    Get Element Count    ${inclusion_fields}
    FOR    ${element}    IN RANGE    1    ${count}+1
        ${label}=    Get Text       (${inclusion_fields})[${element}]
        Append To List    ${labels_in_inclusion_box}    ${label}
    END
    Log    ${labels_in_inclusion_box}
    Set Test Variable    ${labels_in_inclusion_box}
    [Return]    ${labels_in_inclusion_box}


Verify fields are added in exclusion box
    ${labels_in_exclusion_box}=    Create List
    ${count}    Get Element Count    ${exclusion_fields}
    FOR    ${element}    IN RANGE    1    ${count}+1
        ${label}=    Get Text       (${exclusion_fields})[${element}]
        Append To List    ${labels_in_exclusion_box}    ${label}
    END
    Log    ${labels_in_exclusion_box}
    Set Test Variable    ${labels_in_exclusion_box}
    Lists Should Be Equal    ${excluded_labels}    ${labels_in_exclusion_box}
    [Return]    ${labels_in_exclusion_box}


Click on Submit button
    Maximize Browser Window
    Execute Javascript  window.scrollTo(0, document.body.scrollHeight);
    Sleep    2s
    Wait Until Element Is Visible    ${submit_button}
    Sleep    2s
    Click Element    ${submit_button}


Verify all fields present in downloaded file which are present in inclusion
    [Arguments]  ${filepath}
    ${headers_in_file}  Get Csv Headers  ${filepath}
    Lists Should Be Equal    ${inclusion_labels}    ${headers_in_file}


Click on "Save for Later" button
    Click Element    ${save_for_later_button}
    
Refresh Page
    Reload Page

Verify Fields are Saved in inclusion and exclusion
    ${save_later_inclusion}    Get list of all inclusion list
    Lists Should Be Equal    ${save_later_inclusion}    ${inclusion_labels}
    ${save_later_exclusion}    Verify fields are added in exclusion box
    Lists Should Be Equal    ${save_later_exclusion}    ${labels_in_exclusion_box}

Enter User ID and dates
    [Arguments]     ${data}
     ${my_dict}=         Create Dictionary   &{data}
     IF    "${my_dict.From}" != "Null"
          Click Element    ${from_date_input}
          Input From Date using testdata modified version     1

           IF    "${my_dict.TimeFrom}" != "Null"
            Input Time Using testdata     ${my_dict.TimeFrom}
          END
     END
     Click Element    ${user_id_field}
     Input Text    ${user_id_field}    ${my_dict.User_id}
     Sleep    2s


Verify UserID match with Reseller ID
    [Arguments]  ${filepath}    ${testdata}     
     ${my_dict}=         Create Dictionary   &{testdata}
    ${headers}  Get Csv Headers  ${filepath}
    ${row}  Convert To Integer    1
    ${User_ID}    Convert To Integer    ${my_dict.User_id}
    FOR    ${header}    IN    @{headers}
        IF    '${header}'=='Reseller Id'
            ${Reseller_ID}  Get Data By Header Row    ${filepath}    ${header}    ${row}
            Should Be Equal    ${User_ID}    ${Reseller_ID}
            Exit For Loop
        END
    END
    
    
Pick the date
    [Arguments]    ${type}    ${days}
    ${current_date}=    DateTime.Get Current Date    result_format=%Y-%m-%d
    ${current_date_str}=    DateTime.Convert Date    date=${current_date}    result_format=%Y-%m-%d
    IF    "${type}"=="previous"
        ${previous_date}=    Subtract Time From Date    ${current_date_str}    ${days}    result_format=%Y-%m-%d
        Log    Previous 10 days date: ${previous_date}
        ${date}=    DateTime.Convert Date    date=${previous_date}    result_format=%Y-%B-%d
        Set Test Variable    ${date}
    ELSE IF   "${type}"=="post"
        ${post_date}=    Add Time To Date    ${current_date_str}    ${days}    result_format=%Y-%m-%d
        Log    Previous 10 days date: ${post_date}
        ${date}=    DateTime.Convert Date    date=${post_date}    result_format=%Y-%B-%d
        Set Test Variable    ${date}
    END
    
    ${date_list}=    Split String    ${date}    -
    Log    ${date_list}
    Wait Until Element Is Visible    ${calendar_container}
    ${day}      Get From List    ${date_list}    2
    ${month}      Get From List    ${date_list}    1
    ${year}      Get From List    ${date_list}    0
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


    