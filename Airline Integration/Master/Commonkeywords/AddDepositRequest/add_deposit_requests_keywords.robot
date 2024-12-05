*** Settings ***
Library    SeleniumLibrary
Library    XML
Library     ../../../Master/CustomKeywords/user_keywords.py
Resource    ../../CommonKeywords/ManageDepositRequest/manage_deposit_requests_keywords.robot
Variables  ../../../Environment/environments.py
Variables    ../../PageObjects/AddDepositRequest/add_deposit_requests_locators.py

*** Keywords ***
Click On Dashboard Tab
    Wait Until Element Is Enabled    ${dashboard_tab}
    Click Element    ${dashboard_tab}
    
Redirect To Add Deposit Requests Tab
    Click On Dashboard Tab
    Wait Until Element Is Enabled    ${add_deposit_request_tab}    timeout=30s
    Click Element    ${add_deposit_request_tab}
    ${status}    Run Keyword And Return Status    Page Should Contain Element    ${deposit_request_note_close_button}
    IF    ${status} == False
    Wait Until Element Is Enabled    ${deposit_request_note_close_button}    timeout=30s
    Click Element    ${deposit_request_note_close_button}
    END
    Wait Until Element Is Enabled    ${other_bank_details_tab}    10
    Sleep    2
    Click Element    ${other_bank_details_tab}

Click On Submit Button
    Wait Until Element Is Enabled    ${submit_btn}    10
    Scroll Element Into View    ${submit_btn}
    Click Element    ${submit_btn}

Verify Deposit Request Is Added
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    Add Deposit Requests Details    ${my_dict}

Add Deposit Requests Details
    [Arguments]    ${my_dict}
    Wait Until Element Is Visible    ${add_deposit_type_locator}    timeout=20s
    Click Element    ${add_deposit_type_locator}
    Wait Until Element Is Visible    //span[text()="${my_dict.DepositType}"]    timeout=60s
    Sleep    2
    Click Element    //span[text()="${my_dict.DepositType}"]
    Input Text    ${deposit_amount}    ${my_dict.DepositAmount}
    IF    "${my_dict.DepositType}" == "Online Transfer" or "${my_dict.DepositType}" == "Cash in Bank"
#        not required for staging environment
#        Input Text    ${deposit_agent_bank_name}    ${my_dict.AgentBankName}
#        Input Text    ${deposit_agent_deposit_branch}    ${my_dict.AgentDepositBranch}
        Input Text    ${atlas_bank_name_input}    ${my_dict.AtlasBankName}
        Sleep    2
        Click Element    //div[contains(@class, 'react-select__menu')]/div[contains(@class, 'react-select__menu-list')]/div[text()='${my_dict.AtlasBankName}']
        Input Text    ${atlas_account_number}    ${my_dict.AtlasAccountNumber}
        Wait Until Element Is Visible    //div[contains(@class, 'react-select__menu')]/descendant::div[text()='${my_dict.AtlasAccountNumber}']
        Click Element    //div[contains(@class, 'react-select__menu')]/descendant::div[text()='${my_dict.AtlasAccountNumber}']
        Input Text    ${deposit_transaction_id}    ${my_dict.TransactionId}
#        Input Text    ${deposit_mobile}    ${my_dict.MobileNumber}
    END
    IF    "${my_dict.DepositType}" == "Cheque Deposit"
        Input Text    ${atlas_bank_name_input}    ${my_dict.AtlasBankName}
        Click Element    //div[contains(@class, 'react-select__menu')]/div[contains(@class, 'react-select__menu-list')]/div[text()='${my_dict.AtlasBankName}']
        Input Text    ${atlas_account_number}    ${my_dict.AtlasAccountNumber}
        Wait Until Element Is Visible    //div[contains(@class, 'react-select__menu')]/descendant::div[text()='${my_dict.AtlasAccountNumber}']
        Click Element    //div[contains(@class, 'react-select__menu')]/descendant::div[text()='${my_dict.AtlasAccountNumber}']
        Input Text    ${deposit_transaction_id}    ${my_dict.TransactionId}
        Input Text    ${deposit_mobile}    ${my_dict.MobileNumber}
        Input Text    ${deposit_cheque_draw_on_bank}    ${my_dict.ChequeDrawOnBank}
        Wait Until Element Is Enabled    ${deposit_cheque_issue_date}
        Click Element    ${deposit_cheque_issue_date}
        Input Date Using Testdata     ${my_dict.ChequeIssueDate}
        Input Text    ${deposit_cheque_number}    ${my_dict.ChequeNumber}
    END
    IF     "${my_dict.DepositType}" == "Cash at Headoffice"
        Input Text    ${deposit_transaction_id}    ${my_dict.TransactionId}
#        Input Text    ${deposit_mobile}    ${my_dict.MobileNumber}
    END
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Scroll Element Into View   ${submit_btn}
    Click On Submit Button
    ${status}    Run Keyword And Return Status    Wait Until Page Contains    Form is submitted successfully
    IF    ${status} == False
        ${isDuplicate}    Run Keyword And Return Status    Wait Until Page Contains    Duplicate request.
        IF    ${isDuplicate} == True
            Sleep    5
            ${transactionId}    Generate Random Gst Number
            Add Details With Random Number    ${my_dict}    ${transactionId}
        ELSE
#            Page Should Contain    Please provide Transaction ID
            Page Should Contain    Please provide Bank
        END
    END

Add Details With Random Number
    [Arguments]    ${my_dict}    ${transactionId}
    ${my_dict.TransactionId}    Set Variable    ${transactionId}
    Add Deposit Requests Details    ${my_dict}

Verify User Is Able To View Error Messages
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary    &{data}
    Wait Until Element Is Visible    ${add_deposit_type_locator}
    Click Element    ${add_deposit_type_locator}
    Wait Until Element Is Visible    //span[text()="${my_dict.DepositType}"]
    Click Element    //span[text()="${my_dict.DepositType}"]
    Sleep    2
    Click On Submit Button
    Log    ${my_dict.DepositType}
    IF     "${my_dict.DepositType}" == "Online Transfer"
        Page Should Contain    Please provide deposit Amount
#        for QA
#        Page Should Contain    Please provide Deposit Bank
        Page Should Contain    Please provide Bank
#        Page Should Contain    Please provide Deposit Branch
        Page Should Contain    Please provide Branch
#        Page Should Contain    Please provide Atlas Bank Name
        Page Should Contain    Please provide Bank
#        Page Should Contain    Please provide Transaction ID
        Page Should Contain    Please provide Account Number
#        Page Should Contain    Please provide Mobile No.
        Page Should Contain    Please provide Mobile
    ELSE IF    "${my_dict.DepositType}" == "Cheque Deposit"
        Page Should Contain    Please provide deposit Amount
#        Page Should Contain    Please provide Atlas Bank Name
        Page Should Contain    Please provide Bank
#        Page Should Contain    Please provide Transaction ID
        Page Should Contain    Please provide Account Number
#        Page Should Contain    Please provide Mobile No.
        Page Should Contain    Please provide Mobile
#        Page Should Contain    Please provide ChequeDrawOnBank
        Page Should Contain    Please provide Cheque Drawn on Bank
#        Page Should Contain    Please provide ChequeIssueDate
        Page Should Contain    Please provide Cheque Issue Date
#        Page Should Contain    Please provide ChequeNumber
        Page Should Contain    Please provide Cheque Number
    ELSE IF    "${my_dict.DepositType}" == "Cash in Bank"
        Page Should Contain    Please provide deposit Amount
#        Page Should Contain    Please provide Atlas Bank Name
        Page Should Contain    Please provide Bank
#        Page Should Contain    Please provide Transaction ID

        Page Should Contain    Please provide Account Number
    ELSE
        Page Should Contain    Please provide deposit Amount
    END
