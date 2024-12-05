*** Settings ***
Library    SeleniumLibrary
Library    XML
Variables  ../../../Environment/environments.py
Variables  ../../PageObjects/Dashboard/manage_user_locators.py
Variables    ../../PageObjects/SearchFlights/search_page_locators.py
Library    ../../Commonkeywords/CustomKeywords/date_conversion_keywords.py
Library    ../../Commonkeywords/CustomKeywords/user_keywords.py
Library    Collections

*** Keywords ***
Emulate To Agent ID
    Input Text    ${user_id_field}
    Click Element    ${search_button}
    Wait Until Element Is Visible    ${emulate_linktext}
    Click Element    ${emulate_linktext}
    Wait Until Element Is Visible    ${oneway_button}
