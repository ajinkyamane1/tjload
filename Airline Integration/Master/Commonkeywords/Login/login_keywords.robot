*** Settings ***
Library    SeleniumLibrary
Variables  ../../../Environment/environments.py
Variables  ../../PageObjects/Login/login_locators.py
Variables  ../../Download/Downloads.py

*** Keywords ***
Open Air Application
    ${options} =  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    ${prefs}  Create Dictionary  download.default_directory=${default_download_path}
    Call Method  ${options}  add_experimental_option  prefs  ${prefs}
    Call Method  ${options}  add_argument  --headless
    Open Browser     ${air_application_url}    ${browser}  options=${options}
    Set Window Size    ${window_height}    ${window_width}
    Wait Until Page Contains Element    ${email_field}    timeout=10
    
Login With Valid Agent Username And Password
    [Arguments]     ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Sleep    2
    Input Text    ${email_field}    ${my_dict.Username}
    Wait Until Element Is Enabled    ${password_field}
    Input Text    ${password_field}    ${my_dict.Password}
    Click Element    ${login_button}
    Wait Until Page Contains Element    ${dashboard_nav_btn}     timeout=90
    Sleep    2

Verify Eye Icon Button
    [Arguments]     ${search_data}
    ${my_dict}      Create Dictionary   &{search_data}
    Input Text    ${email_field}    ${my_dict.Username}
    Input Text    ${password_field}    ${my_dict.Password}
    Click Element    ${pass_eye_icon_btn}
    ${pass}    get value    ${password_field}
    ${actual_password}   Convert To String    ${my_dict.Password}
    should be equal    ${pass}   ${actual_password}
    Click Element   ${pass_eye_icon_btn}

Logout From The Application
    Wait Until Element Is Enabled    ${logout_btn}
    Click Element    ${logout_btn}
    Wait Until Element Is Visible    ${login_button}

Login With Valid Admin Username And Password
    [Arguments]     ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Input Text    ${email_field}    ${my_dict.Username}
    Wait Until Element Is Enabled    ${password_field}
    Input Text    ${password_field}    ${my_dict.Password}
    Click Element    ${login_button}
    Sleep    3s
    Wait Until Element Is Visible    //h1[text()='Login to your account']
    Wait Until Element Is Visible    //input[@type='email']
    Input Text        //input[@type='email']    ${my_dict.Username}
    Wait Until Element Is Visible    //input[@type='password']
    Input Text        //input[@type='password']    ${my_dict.Password}
    Click Element    //button[text()='Submit']  
    Run Keyword And Ignore Error     Wait Until Element Is Visible    //a[text()='Dashboard']    30s
    Run Keyword And Ignore Error     Click Element    //a[text()='Dashboard']
    Wait Until Page Contains Element    ${manage_user_text}     timeout=30

Login With Invalid Agent Username And Password
    [Arguments]     ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Sleep    2
    Input Text    ${email_field}    ${my_dict.Username}
    Wait Until Element Is Enabled    ${password_field}
    Input Text    ${password_field}    ${my_dict.Password}
    Click Element    ${login_button}
    Wait Until Element Is Visible    ${error_msg}    timeout=30
    Page Should Contain Element     ${error_msg}

Login With Invalid Agent Username And Password Multiple Times
    [Arguments]     ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Sleep    2
    FOR    ${element}    IN RANGE    1    6
        Wait Until Element Is Visible    ${email_field}
        Reload Page
        Wait Until Element Is Visible    ${email_field}
        Input Text    ${email_field}    ${my_dict.Username}
        Wait Until Element Is Enabled    ${password_field}
        Input Text    ${password_field}    ${my_dict.Password${element}}
        Click Element    ${login_button}
        IF    ${element}!= 6
            Wait Until Element Is Visible    ${error_msg}    timeout=30
            Page Should Contain Element     ${error_msg}
        END
    END
    Wait Until Element Is Visible    ${suspended_account_msg}    timeout=30
    Page Should Contain Element     ${suspended_account_msg}
