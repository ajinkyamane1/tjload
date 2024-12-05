*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    ../../../CommonKeywords/CustomKeywords/user_keywords.py
Variables  ../../../PageObjects/Login/login_locators.py
Variables  ../../../PageObjects/SearchResults/search_results_locators.py
Variables  ../../../../Environment/environments.py
Variables  ../../../PageObjects/ManageUser/manage_user_locators.py
Library    OperatingSystem
Library    XML

*** Keywords ***
Customize card as per test data | Admin
    [Arguments]    ${manageuser_td}
    ${my_dict}    Create Dictionary   &{manageuser_td}
    Wait Until Element Is Visible    ${customize_button}    10s
    Click Element    ${customize_button}
    Wait Until Element Is Visible    ${de_select_button}
    Click Element    ${de_select_button}
    IF    "${my_dict.CB_address_line}" != "Null"
        ${select_address_line}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_address_line}
        Wait Until Page Contains Element    ${select_address_line}
        Click Element    ${select_address_line}
    END
    IF    "${my_dict.CB_pin_code}" != "Null"
        ${select_pin_code}     Replace String    ${select_customize_checkbox}    replace    ${my_dict.CB_pin_code}
        Wait Until Page Contains Element    ${select_pin_code}
        Click Element    ${select_pin_code}
    END
    IF    "${my_dict.CB_user_id}" != "Null"
        ${select_user_id}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_user_id}
        Wait Until Page Contains Element    ${select_user_id}
        Click Element    ${select_user_id}
    END
    IF    "${my_dict.CB_email_mobile}" != "Null"
        ${select_email_mobile}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_email_mobile}
        Wait Until Page Contains Element    ${select_email_mobile}
        Click Element    ${select_email_mobile}
    END
    IF    "${my_dict.CB_view_bill}" != "Null"
        ${select_view_bill}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_view_bill}
        Wait Until Page Contains Element    ${select_view_bill}
        Click Element    ${select_view_bill}
    END
    IF    "${my_dict.CB_role}" != "Null"
        ${select_role}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_role}
        Wait Until Page Contains Element    ${select_role}
        Click Element    ${select_role}
    END
    IF    "${my_dict.CB_total_balance}" != "Null"
        ${select_total_balance}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_total_balance}
        Wait Until Page Contains Element    ${select_total_balance}
        Click Element    ${select_total_balance}
    END
    IF    "${my_dict.CB_credit_balance}" != "Null"
        ${select_credit_balance}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_credit_balance}
        ${status}    Run Keyword And Return Status    Wait Until Page Contains Element    ${select_credit_balance}
        IF    ${status}
            Wait Until Page Contains Element    ${select_credit_balance}
            Click Element    ${select_credit_balance}
        END
    END
    IF    "${my_dict.CB_status}" != "Null"
        ${select_status}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_status}
        Wait Until Page Contains Element    ${select_status}
        Click Element    ${select_status}
    END
    IF    "${my_dict.CB_created_on}" != "Null"
        ${select_created_on}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_created_on}
        Wait Until Page Contains Element    ${select_created_on}
        Click Element    ${select_created_on}
    END
    IF    "${my_dict.CB_policy}" != "Null"
        ${select_policy}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_policy}
        Wait Until Page Contains Element    ${select_policy}
        Click Element    ${select_policy}
    END
    IF     "${my_dict.CB_last_login}" != "Null"
        ${select_last_login}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_last_login}
        Wait Until Page Contains Element    ${select_last_login}
        Click Element    ${select_last_login}
    END
    IF    "${my_dict.CB_last_transaction}" != "Null"
        ${select_last_transaction}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_last_transaction}
        Wait Until Page Contains Element    ${select_last_transaction}
        Click Element    ${select_last_transaction}
    END
    IF    "${my_dict.CB_accounting_code}" != "Null"
        ${select_accounting_code}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_accounting_code}
        Wait Until Page Contains Element    ${select_accounting_code}
        Click Element    ${select_accounting_code}
    END
    IF    "${my_dict.CB_commission_plan}"!= "Null"
        ${select_commission_plan}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_commission_plan}
        Wait Until Page Contains Element    ${select_commission_plan}
        Click Element    ${select_commission_plan}
    END
    IF    "${my_dict.CB_fund_transfer}" != "Null"
        ${select_fund_transfer}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_fund_transfer}
        Wait Until Page Contains Element    ${select_fund_transfer}
        Click Element    ${select_fund_transfer}
    END
    IF    "${my_dict.CB_emulate_user}" != "Null"
        ${select_emulate_user}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_emulate_user}
        Wait Until Page Contains Element    ${select_emulate_user}
        Click Element    ${select_emulate_user}
    END
    IF    "${my_dict.CB_group}" != "Null"
        ${select_group}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_group}
        Wait Until Page Contains Element    ${select_group}
        Click Element    ${select_group}
    END
    IF    "${my_dict.CB_actions}" != "Null"
        ${select_actions}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_actions}
        Wait Until Page Contains Element    ${select_actions}
        Click Element    ${select_actions}
    END
    IF    "${my_dict.CB_parent_id}" != "Null"
        ${select_parent_id}     Replace String    ${select_customize_checkbox}   replace    ${my_dict.CB_parent_id}
        Wait Until Page Contains Element    ${select_parent_id}
        Click Element    ${select_parent_id}
    END
    Wait Until Element Is Visible    ${save_button}    10s
    Click Element    ${save_button}

Select Search Filter | Admin
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    Wait Until Element Is Visible    ${dashboard_nav_btn}    10s
    Click Element    ${dashboard_nav_btn}
    Wait Until Element Is Visible    ${show_more_button}    10s
    Click Element    ${show_more_button}
    Cancel Icons on Search Filter
    Wait Until Element Is Visible    ${search_button}    10s
    IF  "${my_dict.User_id}" != "Null"
        Log    ${my_dict.User_id}
        Wait Until Element Is Visible    ${user_id_field}    10s
        Input Text    ${user_id_field}    ${my_dict.User_id}
        Wait Until Element Is Visible    ${select_user_id}    10s
        Sleep    2s
        Click Element    ${select_user_id}
    END
    IF    "${my_dict.From_day}" != "Null"
        ${day}=     Convert To String    ${my_dict.From_day}
        Click Element    ${date_field_from_created_at}
        Wait Until Page Contains Element    ${previous_month_button}     timeout=10
        FOR    ${counter}    IN RANGE    0      ${my_dict.No_of_months_from}
            Click Element   ${previous_month_button}
        END
        ${day}=    Set Variable    (//div[contains(@class,'react-datepicker__day') and text()='${day}'])[1]
        Wait Until Page Contains Element     ${day}     timeout=10
        Click Element       ${day}
    END
    IF    "${my_dict.To_day}" != "Null"
        Sleep    1s
        ${day}=     Convert To String    ${my_dict.To_day}
        Wait Until Element Is Visible    ${date_field_to_created_at}    10s
        Click Element    ${date_field_to_created_at}
        Wait Until Page Contains Element    ${previous_month_button}     timeout=10
        FOR    ${counter}    IN RANGE    0      ${my_dict.No_of_months_to}
            Click Element   ${previous_month_button}
        END
        ${day}=    Set Variable    (//div[contains(@class,'react-datepicker__day') and text()='${day}'])[1]
        Wait Until Page Contains Element     ${day}     timeout=10
        Click Element       ${day}
    END
    IF  "${my_dict.User_role}" != "Null"
        Log    ${my_dict.User_role}
        IF    "${my_dict.User_role}" != "Null"
#            Click Element    ${cancel_role_icon}
            Wait Until Element Is Visible    ${role_field}    10s
            Input Text    ${role_field}    ${my_dict.User_role}
            Click Element    ${select_role}
            Click Element    ${role_field}
        END
    END
    IF  "${my_dict.User_status}" != "Null"
        Log    ${my_dict.User_status}
        Wait Until Element Is Visible    ${status_field}    10s
        Input Text    ${status_field}    ${my_dict.User_status}
        Click Element    ${select_status}
    END
    IF  "${my_dict.User_email}" != "Null"
        Log    ${my_dict.User_email}
        Wait Until Element Is Visible    ${email_input_field}    10s
        Input Text    ${email_input_field}    ${my_dict.User_email}
    END
    IF  "${my_dict.User_mobile}" != "Null"
        Log    ${my_dict.User_mobile}
        Wait Until Element Is Visible    ${mobile_input_field}    10s
        Input Text    ${mobile_input_field}    ${my_dict.User_mobile}
    END
    IF  "${my_dict.User_group}" != "Null"
        Log    ${my_dict.User_group}
        Wait Until Element Is Visible    ${user_group_field}    10s
        Click Element    ${user_group_field}
        ${group}    Replace String    ${select_user_group}    Group    ${my_dict.User_group}
        Wait Until Element Is Visible    ${group}    10s
        Click Element    ${group}
    END
    IF  "${my_dict.User_distributor_id}" != "Null"
        Log    ${my_dict.User_distributor_id}
        Wait Until Element Is Visible    ${distributor_id_field}    10s
        Input Text    ${distributor_id_field}    ${my_dict.User_distributor_id}
        Wait Until Element Is Visible    ${select_distributor_id}    10s
        Click Element    ${select_distributor_id}
    END
    Wait Until Element Is Visible    ${search_button}    10s
    Click Element    ${search_button}
    Sleep    2s
    Wait Until Element Is Visible    ${reset_button}    20s
    Click Element    ${reset_button}
    Wait Until Element Is Visible    ${reset_pop_up_button}
    Click Button    ${reset_pop_up_button}

Verify fund transfer | Admin
    Sleep    30s
    Wait Until Element Is Visible    ${fund_transfer_link}    20s
    Click Element    ${fund_transfer_link}
    Wait Until Element Is Visible    ${fund_transfer_heading}    20s
    Page Should Contain Element        ${fund_transfer_heading}
    Page Should Contain Button        ${submit_button_on_fund_transfer}

Verify Admin can emulate Agent
    [Arguments]    ${manageuser_td}
    ${my_dict}=    Create Dictionary   &{manageuser_td}
    ${user_id_on_card}     Replace String    ${user_id_link_on_search_card}   replace    ${my_dict.User_id}
    Wait Until Element Is Visible    ${user_id_on_card}
    ${user_id_on_card_text}=    Get Text    ${user_id_on_card}
    Wait Until Element Is Visible    ${emulate_user_link}    10s
    Click Element    ${emulate_user_link}
    Wait Until Element Is Visible    ${emulated_user_id_text}    10s
    ${emulated_user_text}=    Get Text    ${emulated_user_id_text}
    Should Contain    ${emulated_user_text}    ${user_id_on_card_text.upper()}

Employee data download validation
    [Arguments]    ${manageuser_td}
    ${my_dict}    Create Dictionary   &{manageuser_td}
    Wait Until Element Is Visible    ${download_emp_data}    10s
    Click Element    ${download_emp_data}
    Sleep    3s
    File Should Exist    ${downloads_path}${/}611252_download.csv

Verify Customize Card Data for De-Select All
    Page Should Not Contain    ${no_of_cols_in_card}

Verify Reset Button for Manage Users
    Wait Until Element Is Visible    ${reset_button}
    Click Element    ${reset_button}
    Wait Until Element Is Visible    ${reset_pop_up_text}
    ${reset_text}=    Get Text    ${reset_pop_up_text}
    Log    ${reset_text}
    IF    "${reset_text}" == "Are you Sure?"
        Wait Until Element Is Visible    ${reset_pop_up_button}
        Click Element    ${reset_pop_up_button}
    ELSE
        Fail
    END
    Wait Until Element Is Visible    ${no_of_cols_in_card}
    Page Should Contain Element    ${no_of_cols_in_card}

Verify Download | Search Card Data
    Wait Until Element Is Visible    ${download_button}    10s
    Click Element    ${download_button}
    Wait Until Element Is Visible    ${de_select_button}    10s
    Click Element    ${de_select_button}
    ${index}=    SeleniumLibrary.Get Element Count    ${select_download_checkbox_count}
    ${in_it}=    Set Variable    1
    FOR    ${i}    IN RANGE        ${in_it}    ${index}
        ${i}=    Convert To String    ${i}
        ${select_prefernces}=    Replace Variables    (//div[@class='draggable']/div/input)[${i}]
        Wait Until Element Is Visible    ${select_prefernces}    10s
        Click Element    ${select_prefernces}
    END
    Wait Until Element Is Visible    ${save_prefernces_button}    10s
    Click Element            ${save_prefernces_button}
    Wait Until Element Is Visible    ${download_file_button}    10s
    Click Element    ${download_file_button}
    Sleep    2s
    File Should Exist    ${downloads_path}${/}manage-user.csv

Get Balance Details from Topbar | Dashboard
    ${my_dict}=    Create Dictionary
    Wait Until Element Is Visible    ${top_bar_my_balance}    10s
    Click Element    ${top_bar_my_balance}
    ${deposit_balance}=    Get Text    ${deposit_balance_text}
    ${credit_balance}=    Get Text    ${credit_balance_text}
    ${dues}=    Get Text    ${dues_text}
    ${wallet_status}=    Get Text    ${wallet_status_text}
    ${credit_status}=    Get Text    ${credit_status_text}
    Set To Dictionary    ${my_dict}     Deposit_Balance=${deposit_balance}
    Set To Dictionary    ${my_dict}     Credit_Balance=${credit_balance}
    Set To Dictionary    ${my_dict}    Dues=${dues}
    Set To Dictionary    ${my_dict}     Wallet_status=${wallet_status}
    Set To Dictionary    ${my_dict}     Credit_status=${credit_status}
    Click Element    ${top_bar_my_balance}
    [Return]    ${my_dict}

Get Balance Details from Topbar | Search Card
    ${my_dict}=    Create Dictionary
    Wait Until Element Is Visible    ${card_total_balance}    10s
    Click Element    ${card_total_balance}
    Wait Until Element Is Visible    ${deposit_balance_text}
    Sleep    5s
    ${deposit_balance}=    Get Text    ${deposit_balance_text}
    Set To Dictionary    ${my_dict}     Deposit_Balance=${deposit_balance}
    ${deposit_balance}=     Extract Final Fare As String    ${deposit_balance}
    ${deposit_balance}=     Remove Spaces    ${deposit_balance}
    ${credit_balance}=    Get Text    ${credit_balance_text}
    ${dues}=    Get Text    ${dues_text}
    ${wallet_status}=    Get Text    ${wallet_status_text}
    ${credit_status}=    Get Text    ${credit_status_text}
    Set To Dictionary    ${my_dict}     Credit_Balance=${credit_balance}
    Set To Dictionary    ${my_dict}    Dues=${dues}
    Set To Dictionary    ${my_dict}     Wallet_status=${wallet_status}
    Set To Dictionary    ${my_dict}     Credit_status=${credit_status}
    Click Element    ${card_total_balance}
    ${total_balance}=   Get Text    ${card_total_balance}
    ${total_balance}=       Extract Final Fare As String    ${total_balance}
    ${total_balance}=       Remove Spaces    ${total_balance}
    Set Test Variable    ${total_balance}
    Should Be Equal As Strings    ${total_balance}    ${deposit_balance}
    Log    ${my_dict}
    [Return]    ${my_dict}

Verify User Id In Search Card
    [Arguments]     ${manageuser_data}      ${search_card_data}
    ${my_dict}=    Create Dictionary   &{manageuser_data}
    Wait Until Element Is Visible    ${customize_button}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Exit For Loop If    ${counter}==10
        Log    ${counter}
        Should Contain    ${search_card_data['User Id${counter}']}    ${my_dict.User_id}
    END

Verify User Role In Search Card
    [Arguments]     ${manageuser_data}      ${search_card_data}
    ${my_dict}=    Create Dictionary   &{manageuser_data}
    Wait Until Element Is Visible    ${customize_button}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Exit For Loop If    ${counter}==10
        Log    ${counter}
        Should Be Equal As Strings    ${search_card_data['Role${counter}']}    ${my_dict.User_role}
    END

Cancel Icons on Search Filter
#Verify Error Message For Search Filter Without Any Criteria
    Wait Until Element Is Visible    ${search_button}   timeout=10s
    Sleep    1
    Click Element    ${clear_date_field}
    Click Element    ${clear_date_field}
    Click Element    ${clear_user_role_field}
    Wait Until Element Is Visible    ${search_button}

Verify User ID | User Details Page
    [Arguments]    ${manageuser_data}
    ${my_dict}=    Create Dictionary    &{manageuser_data}
    Wait Until Element Is Visible       ${card_user_id}       timeout=10s
    ${card_user_id_txt}=        Get Text    ${card_user_id}
    ${card_user_id_txt}=    Replace String    ${card_user_id_txt}    ${whitespace}    ${without_space}
    Should Contain    ${card_user_id_txt}    ${my_dict.User_id}
    Click Element    ${card_user_id}
    Wait Until Page Contains    USER DETAILS    timeout=20s
    Page Should Contain    USER DETAILS
    Page Should Contain Button      ${update_btn}
    Page Should Contain    LOGO UPLOAD
    Page Should Contain    USER STATUS

Verify Billing Info | User Details Page
    Wait Until Element Is Visible    ${billing_info_eye}     timeout=10s
    Click Element    ${billing_info_eye}
    Wait Until Element Is Visible    ${search_button}      timeout=20s
    Page Should Contain Element    ${search_button}

Check Balance Of User From User Details And Search Card
    ${total_balance}=       Get Text    ${card_total_balance}
    ${total_balance}=   Extract Final Fare As String    ${total_balance}
    ${total_balance}=   Remove Spaces    ${total_balance}
#    ${total_balance}=    Round Numbers    ${total_balance}
    ${total_balance}=    Convert To String    ${total_balance}
    Click Element    ${card_user_id}
    Wait Until Element Is Visible    ${user_balance}
    Sleep    5s
    ${user_balance_amount}=    Get Text    ${user_balance}
    ${user_balance_amount}=  Split String    ${user_balance_amount}
    ${user_balance_amount}=     Get From List    ${user_balance_amount}    2
    ${user_balance_amount}=   Replace String    ${user_balance_amount}    ${whitespace}    ${without_space}
    Should Be Equal As Strings    ${total_balance}    ${user_balance_amount}

Verify Submit Button of Fund Transfer | Admin
    Wait Until Element Is Visible    ${fund_transfer_link}    20s
    Click Element       ${fund_transfer_link}
    Sleep    1s
    Wait Until Page Contains Element        ${submit_button_on_fund_transfer}    20s
    Click Button    ${submit_button_on_fund_transfer}
    Wait Until Page Contains     Please provide amount  timeout=10s
    Page Should Contain     Please provide amount

Verify Role Selected With Role Displayed
    ${selected_role}=   Get Text    ${role}
    ${indexing}=     Set Variable    1
    ${total_users}=     Get Text    ${number_of_users}
    ${total_users}=     Split String    ${total_users}
    ${total_users}=     Get From List    ${total_users}    0
    FOR    ${i}    IN RANGE    ${indexing}    ${total_users}+1
        ${card_role}    Replace Variables    (//div[@class="generic-td "])[${i}]
        ${card_role_text}=      Get Text    ${card_role}
        Should Be Equal As Strings    ${card_role_text}    ${selected_role}
    END

Verify Status Selected With Status Displayed
    ${selected_status}=   Get Text    ${status}
    ${indexing}=     Set Variable    1
    ${total_users}=     Get Text    ${number_of_users}
    ${total_users}=     Split String    ${total_users}
    ${total_users}=     Get From List    ${total_users}    0
    FOR    ${i}    IN RANGE    ${indexing}    ${total_users}+1
        ${card_status}    Replace Variables    (//div[@class="generic-td "])[${i}]
        ${card_status_text}=      Get Text    ${card_status}
        Should Be Equal As Strings    ${card_status_text}    ${selected_status}
    END

Get Search Card Data | Admin
    ${my_dict}=    Create Dictionary
    Wait Until Element Is Visible    ${search_card_thead_count}    10s
    ${card_column_count}=    SeleniumLibrary.Get Element Count    ${search_card_thead_count}
    Wait Until Element Is Visible    ${search_card_tbody_count}    10s
    ${card_row_count}=    SeleniumLibrary.Get Element Count    ${search_card_tbody_count}
    Log    ${card_row_count}
    ${const}=    Set Variable    1
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    Log    ${is_no_data}
    IF    "${is_no_data}" == "True"
        Log    No Data Found!
    ELSE
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
        RETURN    ${my_dict}
    END

Compare Search Data | Status
    [Arguments]    ${manageuser_data}    ${search_card_data}
    ${my_dict}=    Create Dictionary    &{search_card_data}
    ${dict}=        Create Dictionary    &{manageuser_data}
    ${len_of_dict}=    Get Length    ${my_dict}
    Log    ${len_of_dict}
    FOR    ${i}    IN RANGE    1    10
        Log    ${my_dict['Status${i}']}
        Should Be Equal As Strings    ${my_dict['Status${i}']}    ${dict.User_status.upper()}
    END

Verify User Status In Search Card
    [Arguments]     ${manageuser_data}      ${search_card_data}
    ${my_dict}=    Create Dictionary   &{manageuser_data}
    Wait Until Element Is Visible    ${customize_button}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Exit For Loop If    ${counter}==10
        Log    ${counter}
        Should Be Equal As Strings    ${search_card_data['Status${counter}']}    ${my_dict.User_status.upper()}
    END

Verify User Email In Search Card
    [Arguments]     ${manageuser_data}      ${search_card_data}
    ${my_dict}=    Create Dictionary   &{manageuser_data}
    Wait Until Element Is Visible    ${customize_button}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Exit For Loop If    ${counter}==10
        Log    ${counter}
        Should Be Equal As Strings    ${search_card_data['Email / Mobile${counter}'].split()}[0]    ${my_dict.User_email}
    END

Verify User Mobile In Search Card
    [Arguments]     ${manageuser_data}      ${search_card_data}
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    Log    ${is_no_data}
    IF    "${is_no_data}" == "True"
        Log    No Data Found!
    ELSE
        ${my_dict}=    Create Dictionary   &{manageuser_data}
        Wait Until Element Is Visible    ${customize_button}
        ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
        FOR    ${counter}    IN RANGE    1    ${row_count}+1
            Exit For Loop If    ${counter}==10
            Log    ${counter}
            Should Be Equal As Strings    ${search_card_data['Email / Mobile${counter}'].split()}[1]    ${my_dict.User_mobile}
        END
    END

Verify User Group In Search Card
    [Arguments]     ${manageuser_data}      ${search_card_data}
    ${my_dict}=    Create Dictionary   &{manageuser_data}
    Wait Until Element Is Visible    ${customize_button}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Exit For Loop If    ${counter}==10
        Log    ${counter}
        Should Be Equal As Strings    ${search_card_data['Group${counter}']}    ${my_dict.User_group}
    END

Verify Distributor Id In Search Card
    [Arguments]     ${manageuser_data}      ${search_card_data}
    ${my_dict}=    Create Dictionary   &{manageuser_data}
    Wait Until Element Is Visible    ${customize_button}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Exit For Loop If    ${counter}==10
        Log    ${counter}
        Should Be Equal As Strings    ${search_card_data['Distributor Id${counter}']}    ${my_dict.Distributor_id}
    END

Make New User Registration
    [Arguments]     ${search_data}
    ${my_dict}=    Create Dictionary   &{search_data}
    Wait Until Element Is Visible    ${add_user_button}
    Click Element    ${add_user_button}
    Wait Until Element Is Visible    ${register_user_page}
    Wait Until Element Is Visible    ${company_name_field}
    Input Text    ${company_name_field}    ${my_dict.Company_name}
    Input Text    ${mobile_phone_field}    ${my_dict.Mobile_phone}
    Input Text    ${user_email_field}    ${my_dict.email}
    Input Text    ${user_password_field}    ${my_dict.password}
    Input Text    ${confirm_password_field}    ${my_dict.Confirm_password}
    ${role}      Replace String    ${select_role_register_page}    role    ${my_dict.Role}
    Click Element    ${role_field_register_page}
    Wait Until Element Is Visible    ${role}
    Click Element    ${role}
    ${country}      Replace String    ${select_country}    country    ${my_dict.Country}
    Click Element    ${country_field}
    Wait Until Element Is Visible    ${country}
    Click Element    ${country}
    ${state}      Replace String    ${select_state}    state    ${my_dict.State}
    Click Element    ${state_field}
    Wait Until Element Is Visible    ${state}
    Click Element    ${state}
    ${city}      Replace String    ${select_city}    city    ${my_dict.City}
    Click Element    ${city_field}
    Wait Until Element Is Visible    ${city}
    Click Element    ${city}
    Input Text    ${address_filed}    ${my_dict.Address}
    Input Text    ${pin_code_field}    ${my_dict.Pincode}

Click User Id From Search Card
    Wait Until Element Is Visible    ${search_card_user_id}     timeout=20s
    Click Element    ${search_card_user_id}

Verify User Details For Selected User
    [Arguments]     ${manageuser_data}      ${search_card_data}
    ${my_dict}      Create Dictionary       &{manageuser_data}
    Wait Until Element Is Visible    ${user_name_on_udp}    timeout=10s
    ${user_id_on_udp_txt}   Get Text    ${user_id_on_udp}
    Should Contain    ${search_card_data['User Id1']}    ${user_id_on_udp_txt}
    ${user_name}    Get Value    ${user_name_on_udp}
    ${user_email}   Get Value    ${user_email_on_udp}
    ${user_phone}   Get Value    ${user_phone_on_udp}
    Should Contain      ${search_card_data['User Id1']}    ${user_name}
    Should Be Equal As Strings      ${user_email}    ${search_card_data['Email / Mobile1'].split()[0]}
    Should Be Equal As Strings      ${user_phone}   ${search_card_data['Email / Mobile1'].split()[1]}

Update User Details For Selected User
    [Arguments]     ${search_data}
    ${my_dict}=    Create Dictionary   &{search_data}
    Wait Until Element Is Visible    ${user_name_on_udp}    timeout=20s
    IF    "${my_dict.update_name}"!="Null"
        Clear Element Text    ${user_name_on_udp}
        Input Text    ${user_name_on_udp}    ${my_dict.update_name}
    END
    IF    "${my_dict.update_email}"!="Null"
        Clear Element Text    ${user_email_on_udp}
        Input Text    ${user_email_on_udp}    ${my_dict.update_email}
    END
    IF    "${my_dict.update_Mobile_phone}"!="Null"
        Clear Element Text    ${user_phone_on_udp}
        Input Text    ${user_phone_on_udp}    ${my_dict.update_Mobile_phone}
    END
    IF    "${my_dict.Update_role}"!="Null"
        ${role}     Replace String    ${select_user_role_on_udp}    role    ${my_dict.Update_role}
        Click Element    ${user_role_on_udp}
        Scroll Element Into View    ${role}
        Wait Until Element Is Visible    ${role}
        Click Element    ${role}
    END
    Click Element    ${update_user_details}
    Sleep    2s

Update User Status For Selected User
    [Arguments]     ${search_data}
    ${my_dict}=    Create Dictionary   &{search_data}
    Wait Until Element Is Visible    ${search_card_user_id}    timeout=20s
    Click Element    ${search_card_user_id}
    ${status}=   Replace String    ${select_user_status_on_udp}    status    ${my_dict.update_status}
    Wait Until Element Is Visible    ${user_status_on_udp}  timeout=10s
    Click Element    ${user_status_on_udp}
    Scroll Element Into View    ${status}
    Wait Until Element Is Visible    ${status}  timeout=10s
    Click Element    ${status}
    Click Element    ${update_user_role}
    Sleep    3s

Verify Address Information For Selected User
    [Arguments]     ${manageuser_data}      ${search_card_data}
    ${my_dict}=    Create Dictionary   &{manageuser_data}
    Wait Until Element Is Visible    ${address_info_link}   timeout=20s
    Click Element    ${address_info_link}
    Wait Until Element Is Visible    ${address_field_on_address_page}  timeout=20s
    ${address}      Get Value    ${address_field_on_address_page}
    ${pincode}      Get Value    ${pincode_field_on_address_page}
    Should Be Equal As Strings    ${search_card_data['Address Line1']}     ${address}
    Should Be Equal As Strings    ${search_card_data['Pin code1']}    ${pincode}

Update Address Information For Selected User
    [Arguments]     ${search_data}
    ${my_dict}=    Create Dictionary   &{search_data}
    Wait Until Element Is Visible    ${search_card_user_id}    timeout=20s
    Click Element    ${search_card_user_id}
    Wait Until Element Is Visible    ${address_info_link}   timeout=20s
    Click Element    ${address_info_link}
    Wait Until Element Is Visible    ${address_field_on_address_page}  timeout=20s
    IF    "${my_dict.update_address}"!="Null"
        Clear Element Text    ${address_field_on_address_page}
        Input Text    ${address_field_on_address_page}    ${my_dict.update_address}
    END
    IF    "${my_dict.update_country}"!="Null"
        Click Element    ${clear_country_field}
        ${country}      Replace String    ${country_field_on_address_page}    Country    ${my_dict.update_country}
        Click Element    ${country_field_on_address_page}
        Wait Until Element Is Visible    ${country}     timeout=10s
        Click Element    ${country}
    END
    IF    "${my_dict.update_state}"!="Null"
        Click Element    ${clear_state_field}
        ${state}      Replace String    ${state_field_on_address_page}    State    ${my_dict.update_state}
        Click Element    ${state_field_on_address_page}
        Wait Until Element Is Visible    ${state}   timeout=10s
        Click Element    ${state}
    END
    IF    "${my_dict.update_city}"!="Null"
        Click Element    ${clear_city_field}
        ${city}      Replace String    ${city_field_on_address_page}    City    ${my_dict.update_city}
        Click Element    ${city_field_on_address_page}
        Wait Until Element Is Visible    ${city}    timeout=10s
        Click Element    ${city}
    END
    IF    "${my_dict.update_pincode}"!="Null"
        Clear Element Text    ${pincode_field_on_address_page}
        Input Text    ${pincode_field_on_address_page}    ${my_dict.update_pincode}
    END
    Click Element    ${update_button_on_address_page}
    Sleep    3

Verify Error Message For Search Filter Without Any Criteria
    Wait Until Element Is Visible    ${search_button}   timeout=10s
    Sleep    1
    Click Element    ${clear_date_field}
    Click Element    ${clear_date_field}
    Click Element    ${clear_user_role_field}
    Wait Until Element Is Visible    ${search_button}
    Click Element    ${search_button}
    Sleep    2
    Page Should Contain    ${error_message_for_role_if_empty}

Verify Error Message For Invalid Data
    Wait Until Element Is Visible    ${customize_button}    timeout=10s
    Page Should Contain    ${error_message_for_invalid_data}

Verify From_To Date In Search Card
    [Arguments]     ${manageuser_data}      ${search_card_data}
    ${my_dict}=    Create Dictionary   &{manageuser_data}
    Wait Until Element Is Visible    ${customize_button}
    ${From_Date}    Get Value       ${date_field_from_created_at}
    ${To_date}    Get Value       ${date_field_to_created_at}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Exit For Loop If    ${counter}==10
        Log    ${counter}
        ${date_to_check}    Extract Date    ${search_card_data['Created On${counter}']}
        Log    ${From_Date}
        Log    ${To_Date}
        ${result}   Is Date In Range    ${From_Date}    ${To_Date}    ${date_to_check}
        IF    ${result}
            Log    Date in Given Range
        ELSE
            Fail
        END
    END