*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    DateTime
Library    ../../Commonkeywords/CustomKeywords/user_keywords.py
Library    ../../Commonkeywords/CustomKeywords/manage_deposit_requests_keywords.py
Library    ../../Commonkeywords/CustomKeywords/billing_info_keywords.py
Variables  ../../../Environment/environments.py
Variables    ../../PageObjects/BillingInfo/billing_info.py

*** Keywords ***
Select Billing Info Filter | Admin
    Wait Until Element Is Visible    ${billing_info_field}
    Execute JavaScript    window.document.getElementById(id="bs-sidebar-collapse-1").scrollBy(0,800);
    Click Element    ${billing_info_field}
    Sleep    2

Click On Search Button
    Wait Until Element Is Enabled    ${search_btn}  timeout=30s
    Click Element    ${search_btn}
    Sleep    5s

Select Search Filter | Admin
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    Wait Until Element Is Visible    ${search_btn}    10s
    IF  "${my_dict.From}" != "Null"
        Wait Until Element Is Enabled    ${generated_from_date}
        Click Element    ${generated_from_date}
        Input Date Using Testdata     ${my_dict.From}
    END
    IF  "${my_dict.To}" != "Null"
        Wait Until Element Is Enabled    ${generated_to_date}
        Click Element    ${generated_to_date}
        Input Date Using Testdata     ${my_dict.To}
    END
    IF  "${my_dict.Lock_From}" != "Null"
        Wait Until Element Is Enabled    ${lock_from_date}
        Click Element    ${lock_from_date}
        Input Date Using Testdata    ${my_dict.Lock_From}
        Input Time Using Testdata         ${my_dict.Lock_Time_From}
    END
    IF  "${my_dict.Lock_To}" != "Null"
        Wait Until Element Is Enabled    ${lock_to_date}
        Click Element    ${lock_to_date}
        Input Date Using Testdata    ${my_dict.Lock_To}
        Input Time Using Testdata         ${my_dict.Lock_Time_From}
    END
    IF  "${my_dict.Payment_Due_Date_From}" != "Null"
        Wait Until Element Is Enabled    ${payment_due_date_from}
        Click Element    ${payment_due_date_from}
        Input Date Using Testdata    ${my_dict.Payment_Due_Date_From}
        Input Time Using Testdata         ${my_dict.Payment_Time_From}
    END
    IF  "${my_dict.Payment_Due_Date_From}" != "Null"
        Wait Until Element Is Enabled    ${payment_due_date_from}
        Click Element    ${payment_due_date_from}
        Input Date Using Testdata    ${my_dict.Payment_Due_Date_From}
        Input Time Using Testdata         ${my_dict.Payment_Time_From}
    END
    IF  "${my_dict.Payment_Time_To}" != "Null"
        Wait Until Element Is Enabled    ${payment_due_date_to}
        Click Element    ${payment_due_date_to}
        Input Date Using Testdata    ${my_dict.Payment_Due_Date_To}
        Input Time Using Testdata         ${my_dict.Payment_Time_To}
    END
    IF  "${my_dict.Bill_No}" != "Null"
        Input Text    ${bill_number}    ${my_dict.Bill_No}
    END
    IF  "${my_dict.Policy}" != "Null"
        Wait Until Element Is Enabled    ${credit_policy}    timeout=30s
        #Click Element    ${credit_policy}
        Input Text    ${credit_policy_input}    ${my_dict.Policy}
        Wait Until Element Is Enabled    //div[@role="option"]
        Click Element    //div[@role="option"]
    END
    IF  "${my_dict.Billing_Username}" != "Null"
        Wait Until Element Is Enabled    ${username}   timeout=30s
        Click Element    ${username}
        Input Text    ${username_input}     ${my_dict.Billing_Username}
        Wait Until Element Is Enabled    //div[contains(text(),'${my_dict.Billing_Username}') and contains(@id,'react-select')]    timeout=10
        Click Element    //div[contains(text(),'${my_dict.Billing_Username}') and contains(@id,'react-select')]
    END
    IF  "${my_dict.Sales_Id}" != "Null"
        Wait Until Element Is Enabled    ${sales_id}   timeout=30s
        Click Element    ${sales_id}
        Input Text    ${sales_input}    ${my_dict.Sales_Id}
        Wait Until Element Is Enabled    ${sales_selected_id}
        Click Element    ${sales_selected_id}
    END
    IF  "${my_dict.Minimum_age}" != "Null"
        Input Text    ${minimum_age}    ${my_dict.Minimum_age}
    END
    IF  "${my_dict.Maximum_age}" != "Null"
        Input Text    ${maximum_age}    ${my_dict.Maximum_age}
    END
    Wait Until Element Is Visible    ${search_btn}    10s
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

Verify From And To Lock date on search Results
    [Arguments]     ${search_data}
    ${my_dict}=    Create Dictionary   &{search_data}
    ${search_card_data}    Get Search Card Data
    ${From_Date}    Get Value       ${lock_from_date}
    ${To_date}    Get Value       ${lock_to_date}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    Log    ${is_no_data}
    IF    "${is_no_data}" == "True"
        Log    No Data Found!
        Fail
    ELSE
        FOR    ${counter}    IN RANGE    1    ${row_count}+1
            Exit For Loop If    ${counter}==10
            Log    ${counter}
            ${date_to_check}    Extract Date    ${search_card_data['Lock Date${counter}']}
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
    END

Verify Payment Due Date From-To On Search Result
    [Arguments]     ${search_data}
    ${my_dict}=    Create Dictionary   &{search_data}
    ${search_card_data}    Get Search Card Data
    ${From_Date}    Get Value       ${payment_due_date_from}
    ${To_date}    Get Value       ${payment_due_date_to}
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    Log    ${is_no_data}
    IF    "${is_no_data}" == "True"
        Log    No Data Found!
        Fail
    ELSE
        FOR    ${counter}    IN RANGE    1    ${row_count}+1
            Exit For Loop If    ${counter}==10
            Log    ${counter}
            ${date_to_check}    Extract Date    ${search_card_data['Payment Due Date${counter}']}
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
    END

Verify Bill Number
    [Arguments]    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    ${search_card_data}    Get Search Card Data
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    Log    ${is_no_data}
    IF    "${is_no_data}" == "True"
        Log    No Data Found!
        Fail
    ELSE
        FOR    ${counter}    IN RANGE    1    ${row_count}+1
            Exit For Loop If    ${counter}==10
            Log    ${counter}
            Should Be True        ${search_card_data['Bill Number${counter}']}==${my_dict.Bill_No}
        END
    END

Verify Credit Policy in Search Result
    [Arguments]     ${mydic}
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    IF    "${is_no_data}" == "True"
        Log    No Data Found
    ELSE
        ${my_dict}=         Create Dictionary   &{mydic}
        ${search_card_data}    Get Search Card Data
        ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}

        FOR    ${counter}    IN RANGE    1    ${row_count}+1
              Exit For Loop If    ${counter}==10
              Log    ${counter}
              ${actual_policy}=    Set Variable    ${search_card_data['Policy${counter}']}
              Should Be Equal    ${actual_policy}    ${my_dict.Policy}
        END
    END

Calculate Totol Pending Amount
    ${search_card_data}    Get Search Card Data
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    ${total_amount}    Set Variable    0
    FOR    ${counter}    IN RANGE    1    ${row_count}+1
        Log    ${counter}
        ${pending_amount}    Remove Currency Symbols        ${search_card_data['Pending Amount${counter}']}
        ${pending_amount_exists}    Run Keyword And Return Status    Should Not Be Empty    ${pending_amount}
        IF    '${pending_amount_exists}' == 'True'
             ${total_amount}=    Evaluate    ${total_amount} + ${pending_amount}
        END
    END
    [Return]    ${total_amount}

Verify Expected Totol Pending Amount With Display Amount
    [Arguments]    ${search_data}
    ${total_amount}    Calculate Totol Pending Amount
    ${pending_amt}=    Get Text    ${display_total_amt}
    ${total_displayed_amount}    Remove Currency Symbols    ${pending_amt}
    ${final_total_amount}    Convert Number Format    ${total_amount}
    ${final_display_amount}    Convert Number Format    ${total_displayed_amount}
    Should Be Equal    ${final_total_amount}    ${final_display_amount}

Verify the Search filter for System UsersName
    [Arguments]     ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    ${search_card_data}    Get Search Card Data
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    IF    "${is_no_data}" == "True"
        Log    No Data Found
        Fail
    ELSE
        FOR    ${counter}    IN RANGE    1    ${row_count}+1
            Exit For Loop If    ${counter}==10
            Log    ${counter}
            ${display_username}    Convert To String    ${my_dict.Billing_Username}
            Should Contain    ${search_card_data['USER ID${counter}']}    ${display_username}
        END
    END

Verify Sales ID in Search Result
    [Arguments]     ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    ${search_card_data}    Get Search Card Data
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    IF    "${is_no_data}" == "True"
        Log    No Data Found
        Fail
    ELSE
        FOR    ${counter}    IN RANGE    1    ${row_count}+1
            Exit For Loop If    ${counter}==10
            Log    ${counter}
            Should Be True        ${search_card_data['Sales Id${counter}']}==${my_dict.Sales_Id}
        END
    END

Get Search Card Data
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
        Fail
    ELSE
        FOR    ${card_row_count}    IN RANGE    1    ${card_row_count}+1
            FOR    ${card_column_count}    IN RANGE    1    ${card_column_count}+1
            ${cnt}=     Convert To String    ${card_column_count}
            ${text_column_head}=      Get Text    //thead[contains(@class,'theader')]/tr/td[${cnt}]
            ${text_coloumn_data}=    Get Text    //tbody[contains(@class,'table')]/tr[${card_row_count}]/td[${cnt}]
            Set To Dictionary    ${my_dict}    ${text_column_head}${const}=${text_coloumn_data}
            END
            ${const}=    Evaluate    ${const}+1
        END
        Log    ${my_dict}
        RETURN    ${my_dict}
    END

Verify Minium Ageing in Search Result
    [Arguments]     ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    ${search_card_data}    Get Search Card Data
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    IF    "${is_no_data}" == "True"
        Log    No Data Found!
        Fail
    ELSE
        FOR    ${counter}    IN RANGE    1    ${row_count}+1
            Exit For Loop If    ${counter}==10
            Log    ${counter}
            Should Be True        ${search_card_data['Ageing${counter}']}>=${my_dict.Minimum_age}
        END
    END

Verify Maximum Ageing in Search Result
    [Arguments]    ${search_data}
    ${my_dict}=    Create Dictionary   &{search_data}
    ${search_card_data}    Get Search Card Data
    ${row_count}=    SeleniumLibrary.Get Element Count    ${search_card_row_count}
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    IF    "${is_no_data}" == "True"
        Log    No Data Found!
        Fail
    ELSE
        FOR    ${counter}    IN RANGE    1    ${row_count}+1
            Exit For Loop If    ${counter}==10
            Log    ${counter}
            Should Be True         ${search_card_data['Ageing${counter}']}<=${my_dict.Maximum_age}
        END
    END

Validate the Bill Number Data & Redirection
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    ${dic}      Set Indexes For Search Table
    ${column_index}    Get From Dictionary    ${dic}   Bill Number
    ${bill_index}    Get From Dictionary    ${dic}     Bill Amount
    ${display_bill_number}    Get Webelements    //tbody/tr/td[${column_index}]/a[text()="${mydict.Bill_No}"]
    ${len}    Get Length    ${display_bill_number}
    FOR    ${counter}    IN RANGE    1   ${len}+1
#        ${bill_amount_text}    Get Text    //tbody/tr/td[${bill_index}]
        Click Element     //tbody/tr/td[${column_index}]/a[text()="${mydict.Bill_No}"]
        Sleep    3
        Wait Until Element Is Visible    (//ol[@class="breadcrumb-arrow"]//li//span)[2]    timeout=10s
        ${bill_number_text}    Get Text    (//ol[@class="breadcrumb-arrow"]//li//span)[2]
        Should Be Equal As Strings    ${bill_number_text}    ${mydict.Bill_No}
#        ${debit_amount_text}    Get Text     //tbody/tr/td[6]
#        Should Be Equal As Strings    ${debit_amount_text}    ${bill_amount_text}
    END

Click On Customize Button
    Run Keyword And Ignore Error    Scroll Element Into View    ${customize_btn}
    Execute Javascript      window.scroll(0,150)
    Wait Until Element Is Visible    ${customize_btn}
    Click Element    ${customize_btn}

Select Option After Deselect All
    Wait Until Element Is Visible    ${deselect_all_btn}    timeout=30s
    Click Element    ${deselect_all_btn}
    Click Element    ${bill_number_checkbox}
    Click Element    ${settled_amt_checkbox}
    Click Element    ${settled_date_checkbox}
    Click Element    ${bill_amount}
    Click Element    ${history_checkbox}
    Click Element    ${save_btn}

Click on History to validate the history created for bills
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    ${dic}      Set Indexes For Search Table
    ${column_index}    Get From Dictionary    ${dic}   Settled Date
    ${display_settled_date}    Get Webelements    //tbody/tr/td[${column_index}]
    ${len}    Get Length    ${display_settled_date}
    FOR    ${counter}    IN RANGE    1    ${len}+1
        Wait Until Element Is Visible    //td//a[text()="History"]    timeout=10s
        Sleep    2s
        Click Element   //td//a[text()="History"]
        Wait Until Element Is Visible    (//div[@class="card-body"])[2]    timeout=10s
        Sleep    3s
        Page Should Contain    Modified On
        Page Should Contain    Ip Address
        Page Should Contain    Changed By/User Id
    END
    Click Element    ${cross_icon}

Verify Billing Info after Click on Reset Button
     Wait Until Element Is Visible    ${reset_btn}   timeout=30s
     Click Element    ${reset_btn}
     Element Should Be Visible    ${popup_reset_btn}    timeout=10s
     Click Element    ${popup_reset_btn}

Input Date For Update Lock Date
    [Arguments]     ${next_month}
    Wait Until Element Is Visible    ${calendar_container}
    @{date_list}        select_next_30_days_from_current_date
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
        Click Element    ${next_month_btn}
        END
    END

Verify Edit Button & Update Lock Date Box
    [Arguments]     ${mydic}
    ${my_dict}=         Create Dictionary   &{mydic}
    ${is_no_data}=    Run Keyword And Return Status    Page Should Contain    No Data Found!
    Log    ${is_no_data}
    IF    "${is_no_data}" == "True"
        Log    No Data Found!
        Fail
    ELSE
        Click Element    ${edit_link}
        Wait Until Element Is Visible    ${new_lock_date}
        Click Element    ${new_lock_date}
        Input Date For Update Lock Date    1
        Input Time Using Testdata         ${my_dict.TimeFrom}
        Sleep    1s
        ${updated_lock_date_time_text}    Get Value   ${new_lock_date}
        ${updated_lock_date}    Convert Lock Date Format    ${updated_lock_date_time_text}
        Click Element    ${update_button}
        Sleep    3s
        Wait Until Element Is Visible    ${lock_date}
        ${updated_final_date}    Get Text    ${lock_date}
        Should Be Equal As Strings    ${updated_lock_date}     ${updated_final_date}
    END




