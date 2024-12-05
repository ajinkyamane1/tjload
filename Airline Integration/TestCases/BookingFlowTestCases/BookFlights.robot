*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    DataDriver  ../../TestData/Staging/testdata.xlsx    sheet_name=Sheet2  #Trial     #Sheet2    #booking_data
Resource    ../../Master/Commonkeywords/Login/login_keywords.robot
Resource    ../../Master/Commonkeywords/SearchFlights/search_flights_keywords.robot
Resource    ../../Master/Commonkeywords/BookingSummary/booking_summary_keywords.robot
Resource    ../../Master/Commonkeywords/SeatMapWindow/seat_map_window_keywords.robot
Resource    ../../Master/Commonkeywords/AirlineIntegration/airline_integration_keywords.robot
Library     ../../Master/CustomKeywords/process_testdata_keywords.py


Test Setup    Open Air Application
Test Teardown   Close Browser
Test Template    TC_01 Without SSR booking

*** Variables ***
${booking_td}=        ${CURDIR}${/}..${/}..${/}TestData${/}Staging${/}testdata.xlsx
${sheet_name}=    Sheet2         #booking_data
*** Test Cases ***

TC_01 Without SSR booking ${TC_ID}
    [Tags]      Booking-Summary

*** Keywords ***
TC_01 Without SSR booking
    [Arguments]    ${TC_ID}
    ${booking_data}=    Fetch Testdata By Id    ${booking_td}   ${sheet_name}    ${TC_ID}
#    Login With Valid Agent Username And Password    ${booking_data}
    ${my_dict}    Create Dictionary   &{booking_data}
    Login With Valid Admin Username And Password    ${booking_data}
    Wait Until Element Is Visible    //a[text()='Flight']
    Click Element    //a[text()='Flight']
#    Run Keyword And Ignore Error    Login With Valid Admin Username And Password    ${booking_data}
#    Emulate To User Id    ${booking_data}
    Search Flight According to TestData    ${booking_data}
#    IF    '${my_dict.SelectFareType}' == 'Null'
#        Select One Stop Filter
#    END
    Check Flights Are Available On Search Page
#    Click On Book Button with Cancellation Charge Applied
#    Click Book Button
#    ${review_details}    ${review_contact_number}    Verify Passenger Details Till Booking Page    ${booking_data}
#    Append Id To Excel Sheet    ${booking_data}
