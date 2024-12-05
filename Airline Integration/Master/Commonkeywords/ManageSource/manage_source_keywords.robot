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
#Variables    ../../PageObjects/Dashboard/download_report_locators.py
Variables    ../../PageObjects/ManageSource/manage_source_locators.py
Variables    ../../PageObjects/ManageCart/manage_cart_locators.py

*** Keywords ***
Navigate To Manage Source Section
    Sleep    2
    Run Keyword And Ignore Error    Scroll Element Into View    ${manage_inventory}
    Wait Until Element Is Visible    ${manage_source}
    Click Element    ${manage_source}
    Wait Until Element Is Visible    ${search_button}
    Wait Until Element Is Visible    ${supplier_field}
    Wait Until Element Is Visible    ${source_field}
    Wait Until Element Is Visible    ${status_field}
    Wait Until Element Is Visible    ${plus_button}

Enter Suplier Name
    [Arguments]  ${supplier_name}
    Wait Until Element Is Visible    ${supplier_field}
    Click Element    ${supplier_field}
    ${supplier}    Replace String    ${select_supplier}    Supplier    ${supplier_name}
#    Input Text    ${supplier_field}    ${supplier_name}
#    Sleep    2
    Scroll Element Into View    ${airasia_source}
    Wait Until Element Is Visible    ${supplier}    10s
    Click Element    ${supplier}
    Click Element    ${supplier_field_arrow}

Verify Filterd Result By Supplier Name
    [Arguments]  ${supplier_name}
    ${data}  ${number_of_rows}  Get Search Data From Table
    FOR    ${row}    IN RANGE    1    ${number_of_rows}+1
        ${actual_data}=  Get From Dictionary    ${data}    Supplier${row}
        Should Contain    ${actual_data}    ${supplier_name}
    END

Get Search Data From Table
    ${my_dict}=    Create Dictionary
    Wait Until Element Is Visible    xpath://thead[contains(@class,'credit_info--header-container ')]/tr/td    10s
    ${card_column_count}=    SeleniumLibrary.Get Element Count    xpath://thead[contains(@class,'credit_info--header-container ')]/tr/td
    Wait Until Element Is Visible    xpath://tbody[contains(@class,'table')]/tr    10s
    ${card_row_count}=    SeleniumLibrary.Get Element Count    xpath://tbody[contains(@class,'table')]/tr
    Log    ${card_row_count}
    ${const}=    Set Variable    1
    ${number_of_rows}=  Get Text    ${table_count}
    ${splitted_text}=  Split String  ${number_of_rows}  ${SPACE} 
    ${number_of_rows}=  Get From List    ${splitted_text}    0
    ${number}       Set Variable    1
    FOR    ${card_row_count}    IN RANGE    1  ${number_of_rows}+1
        FOR    ${card_column_count}    IN RANGE    1    ${card_column_count}+1
        ${cnt}=     Convert To String    ${card_column_count}
        ${text_column_head}=      Get Text    //thead[contains(@class,'credit_info--header-container ')]/tr/td[${cnt}]
        ${text_coloumn_data}=    Get Text    //tbody[contains(@class,'table')]/tr[${number}]/td[${cnt}]
        Set To Dictionary    ${my_dict}    ${text_column_head}${const}=${text_coloumn_data}
        END
        ${const}=    Evaluate    ${const}+1
        ${number}       Evaluate    ${number}+2
    END
    Log    ${my_dict}
    RETURN  ${my_dict}  ${number_of_rows}


Enter Source Name
    [Arguments]  ${source_name}
    Wait Until Element Is Visible    ${source_field}
    Click Element    ${source_field}
    ${source}    Replace String    ${select_source}    Source    ${source_name}
#    Input Text    ${source_field}    ${source_name}
#    Sleep    2
    Scroll Element Into View    ${airasia_source}
    Wait Until Element Is Visible    ${source}    10s
    Click Element    ${source}
    Click Element    ${source_field_arrow}

Verify Filterd Result By Source Name
    [Arguments]  ${source_name}
    ${data}  ${number_of_rows}  Get Search Data From Table
    FOR    ${row}    IN RANGE    1    ${number_of_rows}+1
        ${actual_data}=  Get From Dictionary    ${data}    Source${row}
        Should Be Equal    ${actual_data}    ${source_name}
    END

Select Status
    [Arguments]  ${status_type}
    Wait Until Element Is Visible    ${status_field}
    Click Element    ${status_field}
    ${status}    Replace String    ${select_status}    Status    ${status_type}
    Wait Until Element Is Visible    ${status}    10s
    Click Element    ${status}
    Click Element    ${status_field_arrow}

Verify Status In Source Result
    [Arguments]  ${status_type}
    Wait Until Element Is Visible    ${table_count}
    ${checkboxes}=  Get WebElements    ${all_checkboxes}
    FOR    ${checkbox}    IN    @{checkboxes}
        ${status}=    Run Keyword And Return Status    Should Be Equal    ${status_type}  Enabled
        IF    ${status}
            Checkbox Should Be Selected    ${checkbox}
        ELSE
            Checkbox Should Not Be Selected    ${checkbox}
        END
    END

Click On Search Button
    Wait Until Element Is Visible    ${search_button}
    Click Element    ${search_button}
    Wait Until Element Is Visible    ${table_count}  timeout=30

Click On Plus Button
    Wait Until Element Is Visible    ${plus_button}
    Click Element    ${plus_button}

Verify Plus Button
    Wait Until Element Is Visible    ${select_source_field}
    Wait Until Element Is Visible    ${submit_button}

Select Source And Click On Submit Button
    [Arguments]  ${source}
    Wait Until Element Is Visible    ${select_source_field}
    Click Element  ${select_source_field}
    ${option}=  Replace String    ${select_source_option}    Source    ${source}
    Wait Until Element Is Visible    ${option}
    Click Element    ${option}
    Click Element    ${submit_button}

Verify User Is Able To Add New Source Rule
    [Arguments]  ${supplier}
    Wait Until Element Is Visible    ${description_field}    10
    Input Text    ${description_field}    Test Description
    Wait Until Element Is Visible    ${supplier_id_field}    10
    Click Element    ${supplier_id_field}
    ${option}   Replace String    ${select_supplier_id_option}  Supplier  ${supplier}
    Wait Until Element Is Visible    ${option}    20s
    Click Element    ${option}
    Execute Javascript  window.scrollTo(0,600)
    ${status}=  Run Keyword And Return Status    Wait Until Element Is Visible    ${fare_class_field}
    IF    ${status}
        Click Element    ${fare_class_field}
        Wait Until Element Is Visible    ${lowest_fare_class}
        Click Element    ${lowest_fare_class}
    END
    Click Element    ${submit_button}
    Wait Until Page Contains    Successfully Saved !

Click And Verify Hide/Unhide Button
    Wait Until Element Is Visible    ${inclusion_fields}
    Wait Until Element Is Visible    ${hide_unhide_button}
    Click Element    ${hide_unhide_button}
    Element Should Not Be Visible    ${inclusion_fields}
    Click Element    ${hide_unhide_button}
    Element Should Be Visible    ${inclusion_fields}

Verify And Select One Option Of Source List
    [Arguments]  ${source}
    Enter Source Name  ${source}
    Click On Plus Button
    Select Source And Click On Submit Button    ${source}

Verify Submit Button
    Wait Until Element Is Visible    ${description_field}

Verify User Is Able To Edit Rule
    Wait Until Element Is Visible    ${search_button}
    Wait Until Element Is Visible    ${first_edit_button}
    Click Element    ${first_edit_button}
    Wait Until Element Is Visible    ${description_field}
    Input Text    ${description_field}    -edit
    Execute Javascript  window.scrollTo(0,800)
    Click Element    ${submit_button}
    Wait Until Page Contains    Successfully Saved !

Click And Verify History Button
    Wait Until Element Is Visible    ${first_history_button}
    Click Element    ${first_history_button}
    Wait Until Element Is Visible    ${history_popup_table}
    Wait Until Element Is Visible    ${close_button}
    Click Element    ${close_button}

Verify Submit And Cancel Button
    [Arguments]  ${source}
    Click On Plus Button
    Select Source And Click On Submit Button    ${source}
    Wait Until Element Is Visible    ${description_field}
    Execute Javascript  window.scrollTo(0,800)
    Wait Until Element Is Visible    ${submit_button}
    Click Element    ${submit_button}
    Wait Until Page Contains    Supplier Id can not be blank or Editable.
    Click Element    ${cancel_button}
    Execute Javascript  window.scrollTo(0,-800)
    Wait Until Element Is Visible    ${search_button}

Verify Error Message
    [Arguments]  ${source}
    Click On Plus Button
    Select Source And Click On Submit Button    ${source}
    Wait Until Element Is Visible    ${description_field}
    Execute Javascript  window.scrollTo(0,800)
    Wait Until Element Is Visible    ${submit_button}
    Click Element    ${submit_button}
    Wait Until Page Contains    Supplier Id can not be blank or Editable.

Click On Full Screen Button
    Wait Until Element Is Visible    ${full_screen_button}      timeout=30s
    Click Element    ${full_screen_button}
    Wait Until Element Is Visible    ${close_full_screen_button}    timeout=30s

Click On Close Full Screen Button
    Wait Until Element Is Visible    ${close_full_screen_button}    timeout=30s
    Click Element    ${close_full_screen_button}
