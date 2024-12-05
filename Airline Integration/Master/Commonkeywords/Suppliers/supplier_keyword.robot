*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Variables    ../../PageObjects/Suppliers/supplier_locator.py
Library     ../../CommonKeywords/CustomKeywords/supplier_keyword.py

*** Keywords ***
Select Supplier Filter | Admin
    Wait Until Element Is Visible    ${supplier_menu}
    Execute JavaScript    window.document.getElementById(id="bs-sidebar-collapse-1").scrollBy(0,800);
    Click Element    ${supplier_menu}
    Sleep    2s

Verify Supplier Name in Search Card
    [Arguments]     ${manageuser_data}      ${search_card_data}
    ${my_dict}=    Create Dictionary   &{manageuser_data}
    Wait Until Element Is Visible    ${expand_button}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Exit For Loop If    ${counter}==10
        Log    ${counter}
        Should Be Equal As Strings    ${search_card_data['name${counter}']}   ${my_dict.SupplierName}
    END


Verify History Button After Supplier Search
    Click Element    ${history_button}
    Page Should Contain Element    ${history_popup}
    Sleep    2
    ${rows_coloumn_count}=    SeleniumLibrary.Get Element Count    ${history_popup_rows}
    ${display_count_rows_coloum}    Get Text    ${display_count}
    ${split_msg}    Split String    ${display_count_rows_coloum}    ${SPACE}
    ${number}    Split String    ${split_msg[0]}    /
    ${first_number}=    Set Variable    ${number[0]}
    ${second_number}=    Set Variable    ${number[1]}
    Should Be Equal As Numbers    ${first_number}    ${rows_coloumn_count}
    Should Be Equal As Numbers    ${second_number}    ${rows_coloumn_count}
    Page Should Contain    Modified On
    Page Should Contain    Ip Address
    Page Should Contain    Changed By/User Id
    Click Element    ${popup_expand_button}

Verify Edit Button After Source Search
    Click Element    ${edit_icon}
    ${random_username}=    Generate Random String    5    [UPPER]
    Input Text    ${supplier_user_name}    ${random_username}
    ${new_username}=    Get Value        ${supplier_user_name}
    Click Element    ${submit_button}
    Sleep    5s
    Click Button    ${search_button}
    Wait Until Element Is Visible    //tbody//tr[1]//td[4]
    ${updated_user_name}    Get Text    //tbody//tr[1]//td[4]
    Should Be Equal As Strings    ${updated_user_name}    ${new_username}

Verify Source Name in Search Card
    [Arguments]     ${manageuser_data}      ${search_card_data}
    ${my_dict}=    Create Dictionary   &{manageuser_data}
    Wait Until Element Is Visible    ${expand_button}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Exit For Loop If    ${counter}==10
        Log    ${counter}
        Should Be Equal As Strings    ${search_card_data['Source${counter}']}   ${my_dict.Source}
    END

Verify The Total Rows Count
    ${display_count}=    Get Text    ${display_rows_count}
    ${expected_count}=   SeleniumLibrary.Get Element Count    ${total_rows}
    ${expected_count_str}=    Convert To String    ${expected_count}
    Should Contain    ${display_count}    ${expected_count_str}

Select Search Filter | Admin
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    Wait Until Element Is Visible    ${dashboard_nav_btn}    10s
    Wait Until Element Is Visible    ${search_button}    10s
    IF  "${my_dict.SupplierName}" != "Null"
        Log    ${my_dict.SupplierName}
        Click Element    ${suppliers_field}
        Input Text    ${suppliers_field}    ${my_dict.SupplierName}
        Click Element    ${select_supplier}
        Click Element    ${supplier_heading}
    END
    IF  "${my_dict.Source}" != "Null"
        Log    ${my_dict.Source}
        Wait Until Element Is Visible    ${source_field}    10s
        Input Text    ${source_field}    ${my_dict.Source}
        Click Element    ${select_supplier}
    END
    IF  "${my_dict.Status}" != "Null"
        Wait Until Element Is Visible    ${status_field}    10s
        Click Element    ${status_field}
        ${status}=    Replace Variables    //div[@class="form__field form__field--one-third"]//ul//li//span[contains(text(),'${my_dict.Status}')]
        Wait Until Element Is Enabled    ${status}
        Click Element    ${status}
    END
    Wait Until Element Is Visible    ${search_button}    10s
    Click Element    ${search_button}
    Sleep    2s

Get Search Card Data | Admin
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
            ${text_column_head}=      Get Text    //thead[contains(@class,'credit_info--header-container ')]//tr//td[${cnt}]
            ${text_coloumn_data}=    Get Text    //tbody[contains(@class,'table')]/tr[1]/td[${cnt}]
            Set To Dictionary    ${my_dict}    ${text_column_head}${const}=${text_coloumn_data}
        END
        ${const}=    Evaluate    ${const}+1
    END
    Log    ${my_dict}
    [Return]    ${my_dict}

Verify User Status In Search Card
    [Arguments]     ${manageuser_data}      ${search_card_data}
    ${my_dict}=    Create Dictionary   &{manageuser_data}
    Wait Until Element Is Visible   ${expand_button}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Exit For Loop If    ${counter}==10
        Log    ${counter}
        IF    "${mydict.Status}" == "Enabled"
            ${enabled_checkbox}    Get Webelements    //tbody//tr[${counter}]/td[7]//input[@type='checkbox' and @checked]
            Page Should Contain Element     //tbody//tr[${counter}]/td[7]//input[@type='checkbox' and @checked]
            Page Should Not Contain Element    //tbody//tr[${counter}]/td[7]//input[@type='checkbox' and not(@checked)]
        ELSE IF    "${mydict.Status}" == "Disabled"
            ${disabled_checkbox}    Get Webelements    //tbody//tr[${counter}]/td[7]//input[@type='checkbox' and not(@checked)]
            Page Should Contain Element    //tbody//tr[${counter}]/td[7]//input[@type='checkbox' and not(@checked)]
            Page Should Not Contain    //tbody//tr[${counter}]/td[7]//input[@type='checkbox' and @checked]
        ELSE
            ${enabled_checkbox}    Get Webelements    //tbody//tr[${counter}]/td[7]//input[@type='checkbox' and @checked]
            ${disabled_checkbox}    Get Webelements    //tbody//tr[${counter}]/td[7]//input[@type='checkbox' and not(@checked)]
            Page Should Contain Element    //tbody//tr[${counter}]/td[7]//input[@type='checkbox' and @checked] | //tbody//tr[${counter}]/td[7]//input[@type='checkbox' and not(@checked)]
        END
    END

Create New Supplier Using Add New Icon
    Wait Until Element Is Visible    ${add_new_icon}
    Click Element    ${add_new_icon}
    Page Should Contain Element    ${supplier_popup}    timeout=10

Add New Information After Click On Add New Icon
    [Arguments]    ${supplier_data}
    ${mydict}=    Create Dictionary    &{supplier_data}
    Click Element    ${supplier_source_field}
    Click Element    ${selected_source}
    Input Text    ${supplier_name}    ${mydict.SupplierName}
    Input Text    ${supplier_url}    ${mydict.Supplierurl}
    Input Text    ${supplier_user_name}    ${mydict.supplier_username}
    Input Text    ${supplier_password}    ${mydict.supplier_password}
    Input Text    ${supplier_domain}    ${mydict.domain}
    Input Text    ${supplier_organisation}    ${mydict.organisationcode}
    Input Text    ${supplier_accounting}    ${mydict.Accountingcode}

Add New Unique Information After Click On Add New Icon
    ${unique_supplier_name}=    Generate Random Name
    ${unique_supplier_url}=    Generate Random Url
    ${unique_supplier_user_name}=    Generate Random Username
    ${unique_supplier_password}=    Generate Random Password
    ${unique_supplier_domain}=    Generate Random Domain
    ${unique_supplier_organisation}=    Generate Random Organization Code
    ${unique_supplier_accounting}=    Generate Random Accounting Code
    Input Text    ${supplier_name}    ${unique_supplier_name}
    Input Text    ${supplier_url}    ${unique_supplier_url}
    Input Text    ${supplier_user_name}    ${unique_supplier_user_name}
    Input Text    ${supplier_password}    ${unique_supplier_password}
    Input Text    ${supplier_domain}    ${unique_supplier_domain}
    Input Text    ${supplier_organisation}   ${unique_supplier_organisation}
    Input Text    ${supplier_accounting}    ${unique_supplier_accounting}

Check Enable Checkbox & Submit Button
    Click Element    ${enabled_checkbox}
    #    Click Element    ${submit_button}

Enter Duplicate Data
    [Arguments]    ${supplier_data}
    ${mydict}=    Create Dictionary    &{supplier_data}
    Click Element    ${supplier_source_field}
    Click Element    ${selected_source}
    Input Text    ${supplier_user_name}    ${mydict.supplier_username}
    Click Element    ${submit_button}
    Wait Until Page Contains    Data Already Exists    timeout=10
    Page Should Contain    Data Already Exists

Verify Invalid Data for all filter
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    IF    "${is_no_data}" == "True"
        Log    No Data Found
    ELSE
        Log    Data is Valid
        Pass Execution
    END
