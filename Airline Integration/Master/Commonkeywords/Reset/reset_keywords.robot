*** Settings ***
Library    SeleniumLibrary
Library    XML
Library     ../../CommonKeywords/CustomKeywords/user_keywords.py
Library     ../../CommonKeywords/CustomKeywords/email_helper.py
Library    RPA.Excel.Files
Resource    ../../CommonKeywords/Login/login_keywords.robot
Variables  ../../../Environment/environments.py
Variables    ../../PageObjects/Reset/reset_locators.py


*** Variables ***
${IMAP_SERVER}    imap.gmail.com
${IMAP_PORT}    993
${EMAIL}    tejaswini.ekkaldevi@indexnine.com
${PASSWORD}    qxsh rjgo gaym wbxx
${SUBJECT}    OTP to change Tripjack Account Password


*** Keywords ***
Validate The Email
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary   &{data}
    Click On Reset Button
    Input Text    ${email_mobile_input_field}    ${my_dict.Username}
    ${email_valid}=    Validate Email    ${my_dict.Username}
    Click On Submit Button
    IF    ${email_valid}
        Wait Until Page Contains Element    ${otp_input_field}
    ELSE
        Wait Until Page Contains    Please enter a valid Email or Mobile
    END

Click On Reset Button
    Wait Until Element Is Visible    ${reset_link}
    Click Element    ${reset_link}
    
Click On Submit Button 
    Wait Until Element Is Visible    ${button_submit}
    Click Element    ${button_submit}
    
Add Email To Reset Password
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary   &{data}
    Click On Reset Button 
    Input Text    ${email_mobile_input_field}    ${my_dict.Username}
    Click On Submit Button
    Sleep    5

Update The New Password With Valid OTP
    [Arguments]    ${data}
    Log    data in excel
    Log    ${data}
    ${otp}=    Get Otp From Email    ${IMAP_SERVER}    ${IMAP_PORT}    ${EMAIL}    ${PASSWORD}    ${SUBJECT}
    ${my_dict}    Create Dictionary   &{data}
    Wait Until Element Is Visible    ${otp_input_field}
    Input Text    ${otp_input_field}    ${otp}
    Input Text    ${new_password_input_field}    ${my_dict.Password}
    Input Text    ${confirm_password_input_field}    ${my_dict.Password}
    Click On Submit Button     

Verify User Is Able To Login With New Password
    [Arguments]    ${data}
    Wait Until Element Is Visible    ${clear_here_to_login_link}    timeout=25s
    Click Element    ${clear_here_to_login_link}
    Login With Valid Agent Username And Password   ${data}

Reset To Old Password
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary   &{data}
    Logout From The Application
    ${password}    Set Variable    ${my_dict.OldPassword}
    ${my_dict.Password}    Set Variable    ${password}
    Log    ${my_dict}
    Add Email To Reset Password    ${my_dict}
    Update The New Password With Valid OTP    ${my_dict}
    Wait Until Element Is Visible    ${clear_here_to_login_link}    timeout=30s

Add Email In Email Input Field
    [Arguments]    ${data}
    ${my_dict}    Create Dictionary   &{data}
    Click On Reset Button
    Input Text    ${email_mobile_input_field}    ${my_dict.Username}

Click On Bact To Login Button
    Wait Until Element Is Visible    ${button_back_to_login}
    Click Element    ${button_back_to_login}

Verify User Is Able To Redirect To Login Page
    Click On Bact To Login Button
    Wait Until Page Contains Element    ${login_page}     timeout=30





    

