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
Library     ../../CommonKeywords/CustomKeywords/user_keywords.py
Library     ../../../Environment/environments.py
Variables    ../../PageObjects/RatePlan/rate_plan_locators.py

*** Variables ***
${path}=    ${CURDIR}${/}..${/}..${/}Download${/}csv_files

*** Keywords ***

Navigate To Rate Plan Section
    Run Keyword And Ignore Error    Scroll Element Into View    ${download_report_link}
    Wait Until Element Is Visible    ${rate_plan_link}      timeout=30s
    Click Element    ${rate_plan_link}
    Wait Until Element Is Visible    ${search_button}   timeout=30s

Clear From and To Date Field
    Wait Until Element Is Visible    ${clear_date_field}    timeout=30s
    Sleep    1
    Click Element    ${clear_date_field}
    Sleep    1
    Click Element    ${clear_date_field}

Click On Search Button
    Wait Until Element Is Visible    ${search_button}       timeout=30s
    Sleep    1
    Click Element    ${search_button}


Get Search Card Data
    ${my_dict}=    Create Dictionary
    Wait Until Element Is Visible    ${search_card_thead_count}    30s
    ${card_column_count}=    SeleniumLibrary.Get Element Count    ${search_card_thead_count}
    Wait Until Element Is Visible    ${search_card_tbody_count}    30s
    ${card_row_count}=    SeleniumLibrary.Get Element Count    ${search_card_tbody_count}
    Log    ${card_row_count}
    ${const}=    Set Variable    1
    FOR    ${card_row_count}    IN RANGE    1    ${card_row_count}+1
        Exit For Loop If    ${card_row_count}==11
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
    
Verify Rate Plan
    [Arguments]     ${search_card_data}
    Page Should Contain    ${search_card_data['Created On1']}
    Page Should Contain    ${search_card_data['Name1']}


Enter Supplier Name
    [Arguments]     ${search_data}
    ${my_dict}      Create Dictionary       &{search_data}
    Wait Until Element Is Visible    ${supplier_name_field}     timeout=30
    Click Element    ${supplier_name_field}
    Input Text    ${supplier_name_field}    ${my_dict.Supplier_Name}
    Wait Until Element Is Visible    ${select_supplier_name}    timeout=30s
    Click Element    ${select_supplier_name}

Click On Plus Icon Button
    Wait Until Element Is Visible    ${plus_icon_button}    timeout=30s
    Click Element    ${plus_icon_button}
    Wait Until Element Is Visible    ${search_button}       timeout=30s

Create Rate Plan
    [Arguments]     ${search_data}
    ${my_dict}      Create Dictionary       &{search_data}
    Wait Until Element Is Visible    ${submit_button}        timeout=30s
    ${name}     Random Name
    Set Test Variable    ${name}
    IF    "${name}" != "Null"
        Input Text    ${plan_name_field}    ${name}
    END
    IF    "${my_dict.Booking_Class}" != "Null"
        Input Text    ${booking_class_field}    ${my_dict.Booking_Class}
    END
    IF    "${my_dict.Cabin_Class}" != "Null"
        Click Element    ${cabin_class_field}
        ${class}    Replace String    ${select_cabin_class}    CabinClass    ${my_dict.Cabin_Class}
        Wait Until Element Is Visible    ${class}       timeout=30s
        Sleep    1
        Click Element    ${class}
        Sleep    1
    END
    Input Text    ${adult_base_fare_field}    ${my_dict.Adult_Base_Fare}
    Input Text    ${child_base_fare_field}    ${my_dict.Child_Base_Fare}
    Input Text    ${infant_base_fare_field}    ${my_dict.Infant_Base_Fare}


Verify Successful Message For Rate Plan Creation
    Wait Until Page Contains    Rate Plan saved successfully with id:       timeout=50s

Click On Submit Button
    Wait Until Element Is Visible    ${submit_button}       timeout=30s
    Click Element    ${submit_button}

Enter Rate Plan
    Wait Until Element Is Visible    ${rate_plan_name_field}    timeout=30s
    Input Text    ${rate_plan_name_field}    ${name}
    
Search Rate Plan
    [Arguments]     ${search_data}
    ${my_dict}      Create Dictionary       &{search_data}
    Enter Rate Plan
    Click On Search Button
    ${search_card_data}     Get Search Card Data
    Verify Rate Plan    ${search_card_data}
    Should Be Equal    ${search_card_data['Name1']}    ${name}
    Should Be Equal    ${search_card_data['Cabin Class1']}    ${my_dict.Cabin_Class}
    Should Be Equal    ${search_card_data['Booking Class1']}    ${my_dict.Booking_Class}
    Should Be Equal    ${search_card_data['Base Fare1'][8:12]}    ${my_dict.Adult_Base_Fare}
    Should Be Equal    ${search_card_data['Base Fare1'][22:26]}    ${my_dict.Child_Base_Fare}
    Should Be Equal    ${search_card_data['Base Fare1'][37:41]}    ${my_dict.Infant_Base_Fare}

Enter Plan Name
    [Arguments]     ${search _data}
    ${my_dict}      Create Dictionary       &{search _data}
    Wait Until Element Is Visible    ${rate_plan_name_field}    timeout=30s
    Input Text    ${rate_plan_name_field}    ${my_dict.Plan_Name}

Verify Plan Name Filter
    [Arguments]     ${search_data}
    ${my_dict}=    Create Dictionary   &{search_data}
    ${search_card_data}     Get Search Card Data
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_tbody_count}
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Exit For Loop If    ${counter}==10
        Log    ${counter}
        Should Be Equal As Strings    ${search_card_data['Name${counter}']}    ${my_dict.Plan_Name}
    END

Verify Error Messages On Create Rate Plan Page
    Wait Until Element Is Visible    ${plan_name_field}     timeout=30s
    ${plan_name_filed_value}    Get Value    ${plan_name_field}
    ${booking_class_field_value}    Get Value    ${booking_class_field}
    ${cabin_class_field_value}      Get Value    ${cabin_class_field}
    ${adult_base_fare_field_value}      Get Value    ${adult_base_fare_field}
    ${child_base_fare_field_value}      Get Value    ${child_base_fare_field}
    ${infant_base_fare_field_value}     Get Value    ${infant_base_fare_field}
    Click On Submit Button
    ${plan_name_filed_value_status}     Run Keyword And Return Status    Should Be Empty    ${plan_name_filed_value}
    ${plan_name_filed_value_status}     Run Keyword And Return Status    Should Be Empty    ${plan_name_filed_value}
    ${plan_name_filed_value_status}     Run Keyword And Return Status    Should Be Empty    ${plan_name_filed_value}
    IF    ${plan_name_filed_value_status}
        Wait Until Page Contains    ${plan_name_field_error_message}    timeout=50s
    END
    IF    ${plan_name_filed_value_status}
        Wait Until Page Contains    ${booking_class_field_error_message}    timeout=50s
    END
    IF    ${plan_name_filed_value_status}
        Wait Until Page Contains    ${cabin_class_field_error_message}      timeout=50s
    END
    IF    ${adult_base_fare_field_value} == 0
        Wait Until Page Contains    ${base_fare_error_message}
    END
    IF    ${child_base_fare_field_value} == 0
        Wait Until Page Contains    ${base_fare_error_message}
    END    
    IF    ${infant_base_fare_field_value} == 0
        Wait Until Page Contains    ${base_fare_error_message}
    END


Click On Download Button
    Wait Until Element Is Visible    ${download_button}     timeout=30s
    Click Element    ${download_button}

Enter File Name
    [Arguments]     ${search_data}
    ${my_Dict}       Create Dictionary      &{search_data}
    Wait Until Element Is Visible    ${file_name_field}     timeout=30s
    ${download_file_name}     Set Variable      ${my_Dict.Download_File_Name}
    Set Test Variable    ${download_file_name}
    Input Text    ${file_name_field}    ${download_file_name}

Click On Download File Button
    Wait Until Element Is Visible    ${download_file_button}    timeout=30s
    Click Element    ${download_file_button}
    Sleep    3

Verify Downloaded File
    [Arguments]     ${search_data}
    ${my_dict}      Create Dictionary       &{search_data}
    File Should Exist    ${path}/${my_dict.Download_File_Name}.csv

Navigate To Manage Inventory Section
    Run Keyword And Ignore Error    Scroll Element Into View    ${bulk_update_link}
    Wait Until Element Is Visible    ${manage_inventory_link}      timeout=30s
    Click Element    ${manage_inventory_link}
    Wait Until Element Is Visible    ${search_button}   timeout=30s

Click On First Inventory View Link And Verify Rate Plan
    Wait Until Element Is Visible    ${first_inventory_view_link}   timeout=30s
    Click Element    ${first_inventory_view_link}
    Wait Until Element Is Visible    ${first_inventory_update_link}     timeout=30s
    Click Element    ${first_inventory_update_link}
    Wait Until Element Is Visible    ${clear_rate_plan_field}    timeout=30s
    Click Element    ${clear_rate_plan_field}
    Wait Until Element Is Visible    ${inventory_rate_plan_name_field}      timeout=30s
    Click Element    ${inventory_rate_plan_name_field}
    Wait Until Page Contains    ${name}     timeout=30s

Verify Rate Plan In Manage Inventory
    Navigate To Manage Inventory Section
    Click On Search Button
    Click On First Inventory View Link And Verify Rate Plan
