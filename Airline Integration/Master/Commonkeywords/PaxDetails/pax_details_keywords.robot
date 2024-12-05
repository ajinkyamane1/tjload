*** Settings ***
Library     ../CustomKeywords/user_keywords.py
#Library     ../../Commonkeywords/CustomKeywords/user_keywords.py
Library    SeleniumLibrary
Library    XML
Library    Collections
Library    String
Library    OperatingSystem
Variables     ../../../Environment/environments.py
Variables     ../../PageObjects/PaxDetails/pax_details_locators.py
Resource    ../FlightItinerary/flight_itinerary_keywords.robot
Resource    ../Payment/payment_keywords.robot
Resource    ../Review/review_keywords.robot

*** Variables ***
${corporate_document_upload}=    ${CURDIR}${/}..${/}..${/}Uploads${/}Corporate${/}upload.jpg

*** Keywords ***
Add Passenger
#     Handle popup
    ${passangers_name_list}=   Create List
    Set Test Variable    ${passangers_name_list}
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Execute Javascript     window.scrollBy(0, 800);
    Wait Until Element Is Visible    ${add_passengers_btn}     timeout=20s
#     Handle popup
    Handle All Popups And Update Data
#    Sleep    100s
    ${is_fare_changed}    Run Keyword And Return Status    Page Should Contain    Fare have changed
    IF    ${is_fare_changed}
        Click Element    ${fare_have_changed_continue_button}
        Sleep    3
    END
    Handle Consent Message Popup
    Handle All Popups And Update Data
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Click Element       ${add_passengers_btn}
    ${toggle_button_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${toggle_btn}
    Run Keyword If    ${toggle_button_visible}    Click Element    ${toggle_btn}
    ${passenger_name}=     Create List
    ${indexing}=    Set Variable    1
    ${total_adult_passenger_count}    SeleniumLibrary.Get Element Count    ${adult_first_name_field}
    WHILE      ${indexing} <= ${total_adult_passenger_count}
        Execute Javascript      window.scrollTo(0,200);
        ${adult_first_name}    Random Name
        ${adult_last_name}    Random Name
        ${adult_dob}   Generate Adult Birth Date
        Wait Until Page Contains Element    (${adult_title_dropdown})[${indexing}]     timeout=20
        Execute Javascript      window.scrollTo(0,250);
        Run Keyword And Ignore Error    Scroll Element Into View    (${adult_title_dropdown})[${indexing}]
        Run Keyword And Ignore Error    Scroll Element Into View    (${adult_title_dropdown})[${indexing}]
        Run Keyword And Ignore Error    Scroll Element Into View    (${adult_title_dropdown})[${indexing}]
        Run Keyword And Ignore Error    Scroll Element Into View    (${adult_title_dropdown})[${indexing}]
        Run Keyword And Ignore Error    Scroll Element Into View    (${adult_title_dropdown})[${indexing}]
        Click Element   (${adult_title_dropdown})[${indexing}]
        ${title}=   Get Text    (${adult_title_mr})[${indexing}]
        Wait Until Page Contains Element    (${adult_title_mr})[${indexing}]
        Click Element   (${adult_title_mr})[${indexing}]
        Wait Until Element Is Visible    (${adult_first_name_field})[${indexing}]
        Input Text    (${adult_first_name_field})[${indexing}]  ${adult_first_name}
        Execute Javascript     window.scrollBy(0, 500);
        ${dob}=  Run Keyword And Return Status     Page Should Contain Element    (${adult_dob_field})[${indexing}]
#        ${passport_section}=    Run Keyword And Return Status    Page Should Contain Element    (${total_passport_info_tab})[${indexing}]
        Run Keyword If     ${dob}   Input Text    (${adult_dob_field})[${indexing}]    ${adult_dob}
        Wait Until Element Is Visible    (${adult_last_name_field})[${indexing}]   timeout=20s
        Click Element    (${adult_last_name_field})[${indexing}]
        Input Text    (${adult_last_name_field})[${indexing}]    ${adult_last_name}
        ${full_name_with_title}=     Set Variable  ${title} ${adult_first_name} ${adult_last_name} (A)
        IF    ${dob}
            ${full_name_with_title}=    Set Variable        ${full_name_with_title} ${adult_dob}
        END
#        IF    ${passport_section}
#            ${passport_no}=    generate_passport_number1
#            ${issue_date}=    generate_passport_issue_date
#            Enter passport details    ${passport_no}    ${issue_date}        ${dob}
#        END
        Append To List    ${passangers_name_list}    ${full_name_with_title}
        ${indexing}=  Evaluate   ${indexing} + 1
        Set Test Variable    ${adult_first_name}
        Set Test Variable    ${adult_last_name}
    END
    ${indexing}=    Set Variable    1
    ${total_child_passenger_count}    SeleniumLibrary.Get Element Count    ${child_first_name_field}
    WHILE      ${indexing} <= ${total_child_passenger_count}
        Execute Javascript      window.scrollBy(0,200);
        ${child_first_name}    Random Name
        ${child_last_name}    Random Name
        ${child_dob}    Generate Child Birth Date
        Scroll Element Into View    (${child_title_dropdown})[${indexing}]
        Wait Until Page Contains Element    (${child_title_dropdown})[${indexing}]     timeout=20
        Click Element   (${child_title_dropdown})[${indexing}]
        Wait Until Page Contains Element    (${child_title_master})[${indexing}]
        ${title}    Get Text     (${child_title_master})[${indexing}]
        Click Element   (${child_title_master})[${indexing}]
        Wait Until Element Is Visible    (${child_first_name_field})[${indexing}]
        Input Text    (${child_first_name_field})[${indexing}]  ${child_first_name}
        Execute Javascript     window.scrollBy(0, 500);
        ${dob}=  Run Keyword And Return Status     Page Should Contain Element    (${child_dob_field})[${indexing}]
        Run Keyword If     ${dob}   Input Text    (${child_dob_field})[${indexing}]    ${child_dob}
        Wait Until Element Is Visible    (${child_last_name_field})[${indexing}]   timeout=20s
        Click Element    (${child_last_name_field})[${indexing}]
        Input Text    (${child_last_name_field})[${indexing}]    ${child_last_name}
        ${full_name_with_title}=     Set Variable  ${title} ${child_first_name} ${child_last_name} (C)
        IF    ${dob}
            ${full_name_with_title}=    Set Variable        ${full_name_with_title} ${child_dob}
        END
        Append To List    ${passangers_name_list}    ${full_name_with_title}
        ${indexing}=  Evaluate   ${indexing} + 1
        Set Test Variable    ${child_first_name}
        Set Test Variable    ${child_last_name}
    END
    ${indexing}=    Set Variable    1
    ${total_infant_passenger_count}    SeleniumLibrary.Get Element Count    ${infant_first_name_field}
    WHILE      ${indexing} <= ${total_infant_passenger_count}
        Execute Javascript      window.scrollBy(0,200);
        ${infant_first_name}    Random Name
        ${infant_last_name}    Random Name
        ${infant_dob}    Generate Infant Birth Date
        Scroll Element Into View    (${infant_title_dropdown})[${indexing}]
        Wait Until Page Contains Element    (${infant_title_dropdown})[${indexing}]     timeout=20
        Click Element   (${infant_title_dropdown})[${indexing}]
        Wait Until Page Contains Element    (${infant_title_ms})[${indexing}]
        ${title}    Get Text     (${infant_title_ms})[${indexing}]
        Click Element   (${infant_title_ms})[${indexing}]
        Wait Until Element Is Visible    (${infant_first_name_field})[${indexing}]
        Input Text    (${infant_first_name_field})[${indexing}]  ${infant_first_name}
        Execute Javascript     window.scrollBy(0, 500);
        ${dob}=  Run Keyword And Return Status     Page Should Contain Element    (${infant_dob_field})[${indexing}]
        Run Keyword If     ${dob}   Input Text    (${infant_dob_field})[${indexing}]    ${infant_dob}
        Wait Until Element Is Visible    (${infant_last_name_field})[${indexing}]   timeout=20s
        Click Element    (${infant_last_name_field})[${indexing}]
        Input Text    (${infant_last_name_field})[${indexing}]    ${infant_last_name}
        ${full_name_with_title}=     Set Variable  ${title} ${infant_first_name} ${infant_last_name} (I)
        IF    ${dob}
            ${full_name_with_title}=    Set Variable        ${full_name_with_title} ${infant_dob}
        END
        Append To List    ${passangers_name_list}    ${full_name_with_title}
        ${indexing}=  Evaluate   ${indexing} + 1
        Set Test Variable    ${infant_first_name}
        Set Test Variable    ${infant_last_name}
    END
    Add Passport Details On Pax Details Page From Booking Summary
    RETURN    ${passangers_name_list}


Navigate to Flight Itinerary
    Wait Until Element Is Visible    ${book_button}     timeout=20s
    Click Button    ${book_button}
    Handle All Popups    ${False}  ${False}    ${False}    ${False}
#    Handle Consent Message Popup
    #    Wait Until Page Contains Element    ${markup_icon}      timeout=80s
#    Handle All Popups And Update Data


Expand All Toggle Button
    Handle popup
    ${passangers_name_list}=   Create List
    Set Test Variable    ${passangers_name_list}
    Execute Javascript     window.scrollBy(0, 800);
    Handle popup
    Wait Until Element Is Visible    ${add_passengers_btn}     timeout=20s
    Click Element       ${add_passengers_btn}
    ${toggle_button_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${toggle_btn}
    IF    ${toggle_button_visible}
        Click Element    ${toggle_btn}
    END
    ${passenger_details_form}   Get Element Count    ${arrow_for_toggle}
    ${up_arrow_count}    Get Element Count    ${up_arrow_btn}
    Should Be Equal    ${passenger_details_form}   ${up_arrow_count}


#Enter Passanger Details Using Pax Search History
#     Wait Until Element Is Visible    //input[@placeholder='Select from History' and contains(@name,'ADULT')]
#     Input Text    //input[@placeholder='Select from History' and contains(@name,'ADULT')]      Ankit
#     Wait Until Element Is Visible    //li[@id='react-autowhatever-1--item-0']
#     Click Element    //li[@id='react-autowhatever-1--item-0']
#     sleep  10


Verify PAX Missing Name Format
    Click Element    ${adult_first_name_field}
    Wait Until Element Contains    ${missing_box_div}    MISSING
    Wait Until Element Contains    ${missing_box_div}    Airline Name
    Wait Until Element Contains    ${missing_box_div}    Disclaimer: Please contact airline to confirm the Missing Name format !!


Click On Verify Save Passenger Detail Check Box
    Wait Until Element Is Visible   //span[text()='Save Passenger Details']/preceding-sibling::div[@class='al-indiv']
    Click Element    //span[text()='Save Passenger Details']/preceding-sibling::div[@class='al-indiv']


Add baggage to all passangers
    ${meal_baggage_service_section}   Run Keyword And Return Status    Click Element    //span[text()='Add Baggage, Meal & Other Services to Your Travel']/following-sibling::span/i[@class='fa fa-angle-down']
    ${baggage_section}     Run Keyword And Return Status    Element Should Be Visible    //label[text()='Baggage Information']/following-sibling::select[@class='main-select main-select-positionHandle']
    ${indexing}=    Set Variable    1
    ${total_passenger_count}    SeleniumLibrary.Get Element Count    //label[text()='Baggage Information']/following-sibling::i[@class='fa fa-angle-down fonticon-caret fonticon-caret-positionHandle']
    WHILE    '${baggage_section}'== 'True' and '${meal_baggage_service_section}'== 'True'
        Wait Until Element Is Enabled    (//label[text()='Baggage Information']/following-sibling::select[@class='main-select main-select-positionHandle'])[${indexing}]
        Click Element    (//label[text()='Baggage Information']/following-sibling::select[@class='main-select main-select-positionHandle'])[${indexing}]
        Wait Until Element Is Enabled    (//label[text()='Baggage Information']/following-sibling::select[@class='main-select main-select-positionHandle']/option)[2]
        Click Element   (//label[text()='Baggage Information']/following-sibling::select[@class='main-select main-select-positionHandle']/option)[2]
        ${indexing}=  Evaluate   ${indexing} + 1
        Execute Javascript     window.scrollBy(0, 200);
    END


Skip Refundable Booking
    Run Keyword And Ignore Error    Scroll Element Into View    (//span[contains(text(),'No,')])[1]
    Run Keyword And Ignore Error    Scroll Element Into View    (//span[contains(text(),'No,')])[1]
#    Execute Javascript  window.scrollTo(0,2900)
    Run Keyword And Ignore Error    Click Element    (//span[contains(text(),'No,')])[1]
    Run Keyword And Ignore Error    Click Element    (//span[contains(text(),'No,')])[1]
    Execute Javascript  window.scrollTo(0,3000)
    Click Element   ${radio_btn}
    Wait Until Element Is Enabled    ${radio_btn}


Enter Contact Details
    ${mobile}    Generate Random Phone Number
    #    Wait Until Element Is Visible    ${phone_no}    timeout=20s
    Run Keyword And Ignore Error    Scroll Element Into View    ${phone_no}
#    Execute Javascript    window.scrollBy(0,600);
    Wait Until Element Is Visible    ${phone_no}    10s
    Skip Refundable Booking
    Sleep    3s
    Input Text    ${phone_no}    ${mobile}
    Scroll Element Into View    ${passenger_email}
    ${email}=    Get Value   ${passenger_email}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    ${Contact_details}=    Create Dictionary    mobile=${mobile}    email=${email}
    Set Test Variable    ${Contact_details}
    Enter Passenger Destination Address If Available
    [Return]    ${Contact_details}


Verify Error On Duplicate Passengers Name
    Add Passengers With same name
    Skip Refundable Booking
    Enter Contact Details
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Wait Until Element Is Visible    ${proceed_to_review_button}
    Scroll Element Into View    ${proceed_to_review_button}
    Click Button    ${proceed_to_review_button}
    Wait Until Page Contains    Any two passengers can't have same name     timeout=30s
    Page Should Contain    Any two passengers can't have same name


Validate Invalid DOB | More Than
    Add Passengers With Wrong DOB
    Skip Refundable Booking
    Enter Contact Details
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Wait Until Element Is Visible    ${proceed_to_review_button}
    Scroll Element Into View    ${proceed_to_review_button}
    Click Button    ${proceed_to_review_button}
    Page Should Contain    DOB cannot be more than 100 years from the last travel date


Enter Wrong Contact Details
   ${mobile}    Random Wrong Mobile Number
   Input Text    ${phone_no}    ${mobile}
#    Execute Javascript     window.scrollBy(0, 500);
   ${email}=    Get Text    ${passenger_email}
   Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);


Click proceed to Review button
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Wait Until Element Is Visible    ${proceed_to_review_button}    timeout=90s
    Scroll Element Into View    ${proceed_to_review_button}
    Click Button    ${proceed_to_review_button}
    #Wait Until Element Is Visible    ${review_page_title}    timeout=90s


Write Markup in Review Page
    Wait Until Element Is Visible    ${review_page_title}    timeout=30s
    Click Element    ${markup_icon}
    ${markup_price}=    Random Number
    Input Text    ${markup_text}    ${markup_price}
    Click Button    ${markup_update_btn}
    Wait Until Element Is Not Visible    ${markup_text}
    Click Element    ${markup_icon}
    Wait Until Element Is Visible    ${markup_text}
    ${review_markup_price}=     Get Value    ${markup_text}
    Set Test Variable    ${review_markup_price}


Retrive Markup in Pax Details Page
    Execute Javascript     window.scrollBy(0, 1500);
    Click Element    ${back_btn}
    Wait Until Element Is Visible    ${markup_icon}
    Click Element    ${markup_icon}
    ${pax_markup_price}=    Get Value    ${markup_text}
    Should Be Equal As Strings    ${pax_markup_price}    ${review_markup_price}


Write Markup in Pax Details Page
    ${markup_price}=    Random Number
    Input Text    ${markup_text}    ${markup_price}
    ${pax_markup_price}=     Get Value    ${markup_text}
    Should Be Equal As Strings    ${markup_price}    ${pax_markup_price}
    Click Button    ${markup_update_btn}


Wrong Data Entered
   Page Should Not Contain Element    ${review_page_title}


Verify Expand Button
   ${toggle_button_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${toggle_btn}
   IF    ${toggle_button_visible}
       Element Should Be Enabled    ${toggle_btn}
       Click Element    ${toggle_btn}
   END
   Log    Expand button is verified


Verify Proceed To Pay Button
   Skip Refundable Booking
   Enter Contact Details
   Click proceed to Review button
   Wait Until Element Is Visible    ${review_page_title}       timeout=30s
   Element Should Be Visible    ${review_page_title}


Verify Back Button Of PAX details
   # clicks the back button of review page
   Execute Javascript     window.scrollBy(0, 1500);
   Scroll Element Into View    ${back_button_pax}
   Wait Until Element Is Visible    ${back_button_pax}
   Click Button    ${back_button_pax}
   Execute Javascript     window.scrollBy(0, 1500);
   Scroll Element Into View    ${back_button_pax}
   Wait Until Element Is Visible    ${back_button_pax}
   Click Button    ${back_button_pax}
   Execute Javascript     window.scrollBy(0, 1500);
   Scroll Element Into View    ${back_button_pax}
   Wait Until Element Is Visible    ${back_button_pax}
   Click Button    ${back_button_pax}
   Wait Until Element Is Visible    ${book_btn}    timeout=30s
   Element Should Be Visible    ${book_btn}


Verify continue Button
   Click Button    ${continue_btn}
   Wait Until Element Is Visible    ${toggle_btn}
   Page Should Contain    Flight


Enter GST Fields
    ${GST_field_status}    Run Keyword And Return Status    Page Should Contain    GST not applicable on this booking
    IF    "${GST_field_status}"== "False"
        ${no}=    Convert To String       27AAGCT9458C1Z1
        ${name}     Random Name
        ${email}        Generate Random Email
        ${phone}        Generate Random Phone Number
        ${address}      Generate Random Address
        Execute Javascript     window.scrollBy(0, 500);
        Input Text    ${gst_no}    ${no}
        Input Text    ${gst_name}    ${name}
        Input Text    ${gst_email}    ${email}
        Input Text    ${gst_phone_no}    ${phone}
        Input Text    ${gst_address}    ${address}
        ${gst_details}    Create Dictionary    gst_no=${no}    name=${name}
        RETURN    ${gst_details}
    ELSE
        RETURN    ${GST_field_status}
    END

Enter GST Fields | Invalid
   ${no}       Generate Random Gst Number
   ${name}     Generate Random Company Name
   ${email}        Generate Random Email
   ${phone}        Generate Random Phone Number
   ${address}      Generate Random Address
   Execute Javascript     window.scrollBy(0, 500);
   Wait Until Element Is Visible    ${gst_no}
   Input Text    ${gst_no}    ${no}
   Input Text    ${gst_name}    ${name}
   Input Text    ${gst_email}    ${email}
   Input Text    ${gst_phone_no}    ${phone}
   Input Text    ${gst_address}    ${address}




Add Passengers With same name
   Handle All Popups And Update Data
   Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
   Click Element       ${add_passengers_btn}
   Wait Until Element Is Enabled    ${add_passengers_btn}     timeout=20s
   ${toggle_button_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${toggle_btn}
   Run Keyword If    ${toggle_button_visible}    Click Element    ${toggle_btn}
   ${passenger_name}=     Create List
   ${indexing}=    Set Variable    1
   ${total_adult_passenger_count}    SeleniumLibrary.Get Element Count    ${adult_first_name_field}
   WHILE      ${indexing} <= ${total_adult_passenger_count}
       ${first}=      Set Variable     Saloni
       ${last}=       Set Variable      Rajput
       ${adult_dob}   Generate Adult Birth Date
       Wait Until Page Contains Element    (${adult_title_dropdown})[${indexing}]     timeout=20
       Click Element   (${adult_title_dropdown})[${indexing}]
       ${title}=   Get Text    (${adult_title_dropdown})[${indexing}]
       Wait Until Page Contains Element    (${adult_title_mr})[${indexing}]
       Click Element   (${adult_title_mr})[${indexing}]
       Wait Until Element Is Visible    (${adult_first_name_field})[${indexing}]
       Input Text    (${adult_first_name_field})[${indexing}]  ${first}
       ${dob}=  Run Keyword And Return Status     Page Should Contain Element    (${adult_dob_field})[${indexing}]
       Run Keyword If     ${dob}   Input Text    (${adult_dob_field})[${indexing}]    ${adult_dob}
       Execute Javascript     window.scrollBy(0, 500);
       ${full_name_with_title}=     Set Variable  ${title} ${first} ${last} (A)
       IF    ${dob}
           ${full_name_with_title}=    Set Variable        ${full_name_with_title} ${adult_dob}
       END
       Wait Until Element Is Visible    (${adult_last_name_field})[${indexing}]   timeout=20s
       Click Element    (${adult_last_name_field})[${indexing}]
       Input Text    (${adult_last_name_field})[${indexing}]    ${last}
       ${indexing}=  Evaluate   ${indexing} + 1
   END
   ${indexing}=    Set Variable    1
   ${total_child_passenger_count}    SeleniumLibrary.Get Element Count    ${child_first_name_field}
   WHILE      ${indexing} <= ${total_child_passenger_count}
       ${first}=      Set Variable     Gorakh
       ${last}=       Set Variable       Sawant
       ${child_dob}    Generate Child Birth Date
       Wait Until Page Contains Element    (${child_title_dropdown})[${indexing}]     timeout=20
       Click Element   (${child_title_dropdown})[${indexing}]
       Wait Until Page Contains Element    (${child_title_master})[${indexing}]
       Click Element   (${child_title_master})[${indexing}]
       Wait Until Element Is Visible    (${child_first_name_field})[${indexing}]
       Input Text    (${child_first_name_field})[${indexing}]  ${first}
       ${dob}=  Run Keyword And Return Status     Page Should Contain Element    (${child_dob_field})[${indexing}]
       Run Keyword If     ${dob}   Input Text    (${child_dob_field})[${indexing}]    ${child_dob}
       Execute Javascript     window.scrollBy(0, 500);
       ${full_name_with_title}=     Set Variable  ${title}    ${first_name}    ${last_name} (C)
       IF    ${dob}
           ${full_name_with_title}=    Set Variable    ${full_name_with_title}    ${child_dob}
       END
       Wait Until Element Is Visible    (${child_last_name_field})[${indexing}]   timeout=20s
       Click Element    (${child_last_name_field})[${indexing}]
       Input Text    (${child_last_name_field})[${indexing}]    ${last}
       ${indexing}=  Evaluate   ${indexing} + 1
   END
   ${indexing}=    Set Variable    1
   ${total_infant_passenger_count}    SeleniumLibrary.Get Element Count    ${infant_first_name_field}
   WHILE      ${indexing} <= ${total_infant_passenger_count}
       ${first}=      Set Variable     utkarsh
       ${last}=       Set Variable       sonawar
       ${infant_dob}    Generate Infant Birth Date
       Wait Until Page Contains Element    (${infant_title_dropdown})[${indexing}]     timeout=20
       Click Element   (${infant_title_dropdown})[${indexing}]
       ${title}    Get Text     (${infant_title_ms})[${indexing}]
       Wait Until Page Contains Element    (${infant_title_ms})[${indexing}]
       Click Element   (${infant_title_ms})[${indexing}]
       Wait Until Element Is Visible    (${infant_first_name_field})[${indexing}]
       Input Text    (${infant_first_name_field})[${indexing}]  ${first}
       ${dob}=  Run Keyword And Return Status     Page Should Contain Element    (${infant_dob_field})[${indexing}]
       Run Keyword If     ${dob}   Input Text    (${infant_dob_field})[${indexing}]    ${infant_dob}
       Execute Javascript     window.scrollBy(0, 500);
       ${full_name_with_title}=     Set Variable  ${title}    ${first}    ${last} (I)
       IF    ${dob}
           ${full_name_with_title}=    Set Variable    ${full_name_with_title}    ${infant_dob}
       END
       Wait Until Element Is Visible    (${infant_last_name_field})[${indexing}]   timeout=20s
       Click Element    (${infant_last_name_field})[${indexing}]
       Input Text    (${infant_last_name_field})[${indexing}]    ${last}
       ${indexing}=  Evaluate   ${indexing} + 1
   END


Validate Error Message for Invalid DOB
   Add Passengers With Wrong DOB
   Skip Refundable Booking
   Enter Contact Details
   Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
   Wait Until Element Is Visible    ${proceed_to_review_button}
   Scroll Element Into View    ${proceed_to_review_button}
   Click Button    ${proceed_to_review_button}
   Wait Until Page Contains    DOB
   Page Should Contain    DOB cannot be more than 100 years from the last travel date


Validate Error Message For Invalid GST Details
   Add Passenger
   Skip Refundable Booking
   Enter GST Fields | Invalid
   Enter Contact Details
   Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
   Wait Until Element Is Visible    ${proceed_to_review_button}
   Scroll Element Into View    ${proceed_to_review_button}
   Click Button    ${proceed_to_review_button}
   Wait Until Page Contains    Gst number    timeout=30s
   Page Should Contain    Gst number (GSTIN) should be 15 characters only and valid GST


Validate Error Message For Invalid Contact Details
   Add Passenger
   Skip Refundable Booking
   Enter Wrong Contact Details
   Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
   Wait Until Element Is Visible    ${proceed_to_review_button}
   Scroll Element Into View    ${proceed_to_review_button}
   Click Button    ${proceed_to_review_button}
   Page Should Contain    Please enter valid Mobile Number


Verify Entered GST Details Can Be Cleared
   Add Passenger
   Skip Refundable Booking
   ${GST_field_status}    Enter GST Fields
   Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
   IF    "${GST_field_status}"== "False"
       Wait Until Element Is Visible    ${gst_clear_btn}
       Click Element    ${gst_clear_btn}
       Verify Entered GST Number
   END


Verify Search History Of Pax Details
   Handle add passenger button
   Input Text    ${pax_search_field}    mr
   Wait Until Element Is Visible    ${search_field_div}    10
   Click Element   ${first_passenger_from_search}
   ${first_name}=     Get Value    ${adult_first_name_field}
   ${last_name}=      Get Value    ${adult_last_name_field}
   ${search_list}=    Create List     ${first_name}   ${last_name}
   Should Not Be Equal As Strings    ${search_list}    ${null}


Verify Markup Value On Pax Details Page
   Add Passenger
   Skip Refundable Booking
   Enter Contact Details
   Click proceed to Review button
   Write Markup in Review Page
   Retrive Markup in Pax Details Page
   Write Markup in Pax Details Page


Handle add passenger button
   Execute Javascript     window.scrollBy(0, 800);
   ${farechanged}=  Run Keyword And Return Status     Page Should Contain Element     ${continue_btn}
   Run Keyword If     ${farechanged}   Click Element    ${continue_btn}
   Wait Until Element Is Enabled    ${add_passengers_btn}   timeout=30
   ${farechanged}=  Run Keyword And Return Status     Page Should Contain Element    ${continue_btn}
   Run Keyword If     ${farechanged}   Click Element    ${continue_btn}
   Execute Javascript     window.scrollBy(0, 800);
   Click Element       ${add_passengers_btn}
   ${toggle_button_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${toggle_btn}
   Run Keyword If    ${toggle_button_visible}    Click Element    ${toggle_btn}


Book the flight
   Click Save Passengers Details Button
   Skip Refundable Booking
   Enter Contact Details
   Click proceed to Review button
   Wait Until Element Is Visible    ${review_page_title}    timeout=30s
   Proceed To Pay
   Payment from Deposit


Click Save Passengers Details Button
   ${adult_count}    SeleniumLibrary.Get Element Count    ${adult_first_name_field}
   ${child_count}    SeleniumLibrary.Get Element Count    ${child_first_name_field}
   ${infant_count}   SeleniumLibrary.Get Element Count    ${infant_first_name_field}
   ${total_passangers}=        Evaluate    ${adult_count}+${child_count}+${infant_count}
   Click Element    ${scroll_bar}
   FOR    ${count}    IN RANGE    1  ${total_passangers}+1
       Execute Javascript    window.scrollBy(0,200);
       Click Element    (${save_pax_details_btn})[${count}]
   END


Verify check box saving the pax details
   Handle add passenger button
#     Wait Until Element Is Visible    locator
   Input Text    ${adult_search_field}    ${adult_first_name}
   ${prev_list}=       Create List    ${adult_first_name}    ${adult_last_name}
   Wait Until Element Is Visible    ${first_adult_from_search}
   Click Element   ${first_adult_from_search}
   ${first_name}=     Get Value    ${adult_first_name_field}
   ${last_name}=      Get Value    ${adult_last_name_field}
   ${search_list}=    Create List     ${first_name}   ${last_name}
   Should Not Be Equal As Strings    ${search_list}    ${prev_list}
   ${child_present}=    Run Keyword And Return Status    Element Should Be Visible    ${child_first_name_field}
   IF    ${child_present}
       Execute Javascript    window.scrollBy(0,500);
       Input Text    ${child_search_field}    ${child_first_name}
       ${prev_list}=       Create List    ${child_first_name}    ${child_last_name}
       Wait Until Element Is Visible    ${first_child_from_search}
       Click Element   ${first_child_from_search}
       ${first_name}=     Get Value    ${child_first_name_field}
       ${last_name}=      Get Value    ${child_last_name_field}
       ${search_list}=    Create List     ${first_name}   ${last_name}
       Should Not Be Equal As Strings    ${search_list}    ${prev_list}
   END
   ${infant_present}=     Run Keyword And Return Status    Element Should Be Visible    ${infant_first_name_field}
   IF    ${infant_present}
       Execute Javascript    window.scrollBy(0,500);
       Input Text    ${infant_search_field}    ${infant_first_name}
       ${prev_list}=       Create List    ${infant_first_name}    ${infant_last_name}
       Wait Until Element Is Visible    ${first_infant_from_search}
       Click Element   ${first_infant_from_search}
       ${first_name}=     Get Value    ${infant_first_name_field}
       ${last_name}=      Get Value    ${infant_last_name_field}
       ${search_list}=    Create List     ${first_name}   ${last_name}
       Should Not Be Equal As Strings    ${search_list}    ${prev_list}
   END


Verify Search History Of GST Details
   Skip Refundable Booking
   ${GST_field_status}    Run Keyword And Return Status    Page Should Contain    GST not applicable on this booking
   IF    "${GST_field_status}"== "False"
       Input Text    ${gst_search_field}    27ABHFA2711Q1Z8
       Verify Entered GST Number
   END


Verify Entered GST Number
   Wait Until Element Is Visible    ${gst_no}
   ${gst_no_text}=  Get Value    ${gst_no}
   ${gst_company_name_txt}=    Get Value    ${gst_name}
   ${gst_email_txt}=   Get Value    ${gst_email}
   ${gst_phone_txt}=   Get Value    ${gst_phone_no}
   ${gst_add_txt}=     Get Value    ${gst_address}
   ${gst_list}=    Create List     ${gst_no_text}  ${gst_company_name_txt} ${gst_email_txt}    ${gst_phone_txt}    ${gst_add_txt}
   Should not Be Equal As Strings    ${gst_list}    ${null}


click save gst btn
   Click Element    ${save_gst_btn}
   Wait Until Element Is Enabled    ${save_gst_btn}


Verify With Clear Button Gst Details Are Cleared
   Click Element    ${gst_clear_btn}
   ${gst_no_text}=  Get Value    ${gst_no}
   ${gst_company_name_txt}=    Get Value    ${gst_name}
   ${gst_email_txt}=   Get Value    ${gst_email}
   ${gst_phone_txt}=   Get Value    ${gst_phone_no}
   ${gst_add_txt}=     Get Value    ${gst_address}
   ${gst_list}=    Create List    ${gst_no_text}    ${gst_company_name_txt}    ${gst_email_txt}  ${gst_phone_txt}    ${gst_add_txt}
   ${counter}    Set Variable    1
   FOR    ${counter}    IN    @{gst_list}
       Should Be Empty    ${counter}
       Log    ${counter}
   END


Verify Invalid Voucher
   ${is_VoucherVisible}      Run Keyword And Return Status    Element Should Be Visible    ${voucher_code}
   IF    ${is_VoucherVisible}
       Input Text    ${voucher_code}    500
       Click Button    ${apply_btn}
       Wait Until Element Is Enabled    ${apply_btn}
       Page Should Contain    No Discount applicable on this voucher
   END


Return Number Greater Than Argument
    [Arguments]    ${input_number}
    ${greater_number}=    Evaluate    ${input_number} + 1
    [Return]    ${greater_number}


Verify Invalid TJ Cash
   ${user_tj_cash}=    Get Text    ${dashboard_tj_cash}
   ${tj_cash_text}=    Return Number Greater Than Argument    ${user_tj_cash}
   Input Text    ${tj_cash}    ${tj_cash_text}
   Click Button    ${redeem_btn}
   Wait Until Element Is Enabled    ${redeem_btn}
   Page Should Contain    Insufficient Points Balance.


Enter passport details
   [Arguments]     ${passport_no}      ${issue_date}        ${dob}
   Wait Until Element Is Visible    ${passport_number}
   Click Element    ${nationality_dropdown}
   Click Element    ${nationality_india}
   Input Text    ${passport_number}    ${passport_no}
   Input Text    ${passport_issue_date}    ${issue_date}
#   Input Text    ${passport_expiry_date}    ${exp_date}
   Input Text    ${passenger_dob}    ${dob}


Verify Invalid Passport Number
   Execute Javascript  window.scrollBy(0,500);
   Click Button    ${proceed_to_review_button}
   Element Should Not Be Visible    ${review_page_title}       timeout=20s


Verify Invalid expiry date
   Execute Javascript  window.scrollBy(0,500);
   Click Button    ${proceed_to_review_button}
   Element Should Not Be Visible    ${review_page_title}        timeout=20s


Verify DOB in passport
   Execute Javascript  window.scrollBy(0,500);
   Click Button    ${proceed_to_review_button}
   Element Should Not Be Visible    ${review_page_title}        timeout=20s


Add Passengers With Wrong DOB
   Handle popup
   ${passangers_name_list}=   Create List
   Set Test Variable    ${passangers_name_list}
   Execute Javascript     window.scrollBy(0, 800);
   Click Element       ${add_passengers_btn}
   ${toggle_button_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${toggle_btn}
   Run Keyword If    ${toggle_button_visible}    Click Element    ${toggle_btn}
   ${passenger_name}=     Create List
   ${indexing}=    Set Variable    1
   ${total_adult_passenger_count}    SeleniumLibrary.Get Element Count    ${adult_first_name_field}
   WHILE      ${indexing} <= ${total_adult_passenger_count}
       Execute Javascript      window.scrollTo(0,200);
        ${first_name}    Random Name
       ${last_name}    Random Name
       ${adult_dob}   Generate wrong Adult Birth Date
       Wait Until Page Contains Element    (${adult_title_dropdown})[${indexing}]     timeout=20
       Click Element   (${adult_title_dropdown})[${indexing}]
       ${title}=   Get Text    (${adult_title_mr})[${indexing}]
       Wait Until Page Contains Element    (${adult_title_mr})[${indexing}]
       Click Element   (${adult_title_mr})[${indexing}]
       Wait Until Element Is Visible    (${adult_first_name_field})[${indexing}]
       Input Text    (${adult_first_name_field})[${indexing}]  ${first_name}
       Execute Javascript     window.scrollBy(0, 500);
       ${dob}=  Run Keyword And Return Status     Page Should Contain Element    (${adult_dob_field})[${indexing}]
       Run Keyword If     ${dob}   Input Text    (${adult_dob_field})[${indexing}]    ${adult_dob}
       Wait Until Element Is Visible    (${adult_last_name_field})[${indexing}]   timeout=20s
       Click Element    (${adult_last_name_field})[${indexing}]
       Input Text    (${adult_last_name_field})[${indexing}]    ${last_name}
       ${full_name_with_title}=     Set Variable  ${title} ${first_name} ${last_name} (A)
       IF    ${dob}
           ${full_name_with_title}=    Set Variable        ${full_name_with_title} ${adult_dob}
       END
       Append To List    ${passangers_name_list}    ${full_name_with_title}
       ${indexing}=  Evaluate   ${indexing} + 1
   END
   ${indexing}=    Set Variable    1
   ${total_child_passenger_count}    SeleniumLibrary.Get Element Count    ${child_first_name_field}
   WHILE      ${indexing} <= ${total_child_passenger_count}
       Execute Javascript      window.scrollBy(0,200);
       ${first_name}    Random Name
       ${last_name}    Random Name
       ${child_dob}    Generate Wrong Child Birth Date
       Wait Until Page Contains Element    (${child_title_dropdown})[${indexing}]     timeout=20
       Click Element   (${child_title_dropdown})[${indexing}]
       Wait Until Page Contains Element    (${child_title_master})[${indexing}]
       ${title}    Get Text     (${child_title_master})[${indexing}]
       Click Element   (${child_title_master})[${indexing}]
       Wait Until Element Is Visible    (${child_first_name_field})[${indexing}]
       Input Text    (${child_first_name_field})[${indexing}]  ${first_name}
       Execute Javascript     window.scrollBy(0, 500);
       ${dob}=  Run Keyword And Return Status     Page Should Contain Element    (${child_dob_field})[${indexing}]
       Run Keyword If     ${dob}   Input Text    (${child_dob_field})[${indexing}]    ${child_dob}
       Wait Until Element Is Visible    (${child_last_name_field})[${indexing}]   timeout=20s
       Click Element    (${child_last_name_field})[${indexing}]
       Input Text    (${child_last_name_field})[${indexing}]    ${last_name}
       ${full_name_with_title}=     Set Variable  ${title} ${first_name} ${last_name} (C)
       IF    ${dob}
           ${full_name_with_title}=    Set Variable        ${full_name_with_title} ${child_dob}
       END
       Append To List    ${passangers_name_list}    ${full_name_with_title}
       ${indexing}=  Evaluate   ${indexing} + 1
   END
   ${indexing}=    Set Variable    1
   ${total_infant_passenger_count}    SeleniumLibrary.Get Element Count    ${infant_first_name_field}
   WHILE      ${indexing} <= ${total_infant_passenger_count}
       Execute Javascript      window.scrollBy(0,200);
       ${first_name}    Random Name
       ${last_name}    Random Name
       ${infant_dob}    Generate Wrong Infant Birth Date
       Wait Until Page Contains Element    (${infant_title_dropdown})[${indexing}]     timeout=20
       Click Element   (${infant_title_dropdown})[${indexing}]
       Wait Until Page Contains Element    (${infant_title_ms})[${indexing}]
       ${title}    Get Text     (${infant_title_ms})[${indexing}]
       Click Element   (${infant_title_ms})[${indexing}]
       Wait Until Element Is Visible    (${infant_first_name_field})[${indexing}]
       Input Text    (${infant_first_name_field})[${indexing}]  ${first_name}
       Execute Javascript     window.scrollBy(0, 500);
       ${dob}=  Run Keyword And Return Status     Page Should Contain Element    (${infant_dob_field})[${indexing}]
       Run Keyword If     ${dob}   Input Text    (${infant_dob_field})[${indexing}]    ${infant_dob}
       Wait Until Element Is Visible    (${infant_last_name_field})[${indexing}]   timeout=20s
       Click Element    (${infant_last_name_field})[${indexing}]
       Input Text    (${infant_last_name_field})[${indexing}]    ${last_name}
       ${full_name_with_title}=     Set Variable  ${title} ${first_name} ${last_name} (I)
       IF    ${dob}
           ${full_name_with_title}=    Set Variable        ${full_name_with_title} ${infant_dob}
       END
       Append To List    ${passangers_name_list}    ${full_name_with_title}
       ${indexing}=  Evaluate   ${indexing} + 1
   END


Verify Frequent Flier Details
    ${frequent_flier_status}    Run Keyword And Return Status    Page Should Contain Element    ${frequent_flier_field}
    IF    ${frequent_flier_status}
       Scroll Element Into View    ${frequent_flier_field}
       ${total_adult_passenger_count}    SeleniumLibrary.Get Element Count    ${adult_first_name_field}
       ${is_frequent_flier_Visible}      Run Keyword And Return Status    Element Should Be Visible    ${frequent_flier_number}
       ${indexing}=    Set Variable    1
       ${total_adult_passenger_count}    SeleniumLibrary.Get Element Count    ${adult_first_name_field}
       ${total_child_passenger_count}=    SeleniumLibrary.Get Element Count    ${child_first_name_field}
       IF    ${is_frequent_flier_Visible}
           FOR   ${index}    IN RANGE    ${indexing}    ${total_adult_passenger_count}+1
               ${frequent_flier_input}=    Replace Variables    (//input[@placeholder='FF Number'])[${index}]
               ${freq_flier_no}=    Replace Variables    (//h5[@class='apt-addpassport review-heading']//child::span)[${index}]
               Click Element    ${freq_flier_no}
               Input Text    ${frequent_flier_input}    JALSA
               ${index}=  Evaluate   ${index} + 1
           END
           FOR   ${index}    IN RANGE    ${indexing}    ${total_child_passenger_count}+1
               ${frequent_flier_input}=    Replace Variables    (//input[@placeholder='FF Number'])[${index}]
               ${freq_flier_no}=    Replace Variables    (//h5[@class='apt-addpassport review-heading']//child::span)[${index}]
               Click Element    ${freq_flier_no}
               Input Text    ${frequent_flier_input}    JALSA
               ${index}=  Evaluate   ${index} + 1
           END
        END
    END


Make Booking Refundable
#    Total amt before adding the refund
   ${flight_details_total_amount}=     Get Text    ${flight_details_total_amt}
   ${splitted_flight_total_amount}=    Split String    ${flight_details_total_amount}      ₹
   ${splitted_flight_total_amount_amt}     Get From List    ${splitted_flight_total_amount}    1
   ${final_total_amt}    Replace String    ${splitted_flight_total_amount_amt}    ,    ${EMPTY}
   Execute Javascript  window.scrollTo(0,900)
   Click Element    ${refundable_btn}
   Wait Until Element Is Enabled    ${refundable_btn}
   ${refundable_amt} =     Get Text    ${refundable_btn}
   ${amount}=    Split String    ${refundable_amt}      ₹
   ${amount2}=     Get From List    ${amount}    1
   ${amount_string}=   Convert To String    ${amount2}
   ${amount_only}=     Split String    ${amount_string}
   ${amount1}=     Get From List    ${amount_only}    0
   ${final_refund_amt}    Replace String    ${amount1}    ,    ${EMPTY}
#    Total amt after adding the refund
   ${total_amt_after_refund}=  Evaluate    ${final_total_amt} + ${final_refund_amt}
   ${flight_details_total_amount}=     Get Text    ${flight_details_total_amt}
   ${splitted_flight_total_amount}=    Split String    ${flight_details_total_amount}      ₹
   ${splitted_flight_total_amount_amt}     Get From List    ${splitted_flight_total_amount}    1
   ${final_total_amt}    Replace String    ${splitted_flight_total_amount_amt}    ,    ${EMPTY}
   Should Be Equal As Numbers    ${total_amt_after_refund}    ${final_total_amt}




View Detail Element Verification
   Wait Until Element Is Visible    ${stops_selector}  timeout=40s
   Click Element    ${stops_selector}
   Click Button    ${view_details_button}
   Element Should Be Visible    ${flight_details}
   Wait Until Element Is Visible    ${flight_source_destination_city}  timeout=7s
   ${flight_source_destination_city_value}     Get Text    ${flight_source_destination_city}
   Set Test Variable    ${flight_source_destination_city_value}
   ${flight_source_destination_city_value_stripped}    Set Variable    ${flight_source_destination_city_value.strip()}
   Set Test Variable    ${flight_source_destination_city_value_stripped}
   Wait Until Element Is Visible    ${flight_source_destination_date}  timeout=7s
   ${flight_source_destination_date_value}       Get Text    ${flight_source_destination_date}
   Set Test Variable    ${flight_source_destination_date_value}
   Execute Javascript  window.scrollTo(0,0)
   Click Element    ${book_button}
   Wait Until Page Contains    Flight Details
   Handle Consent Message Popup


Verify Seat Selection Panel
   Execute Javascript  window.scrollTo(0,600)
   ${is_seat_map_button_available}    Run Keyword And Return Status    Page Should Contain Element    ${show_seat_map_btn}
   IF    ${is_seat_map_button_available}
       Element Should Be Visible    ${show_seat_map_btn}
       ${seat_map_src_dest_value}    Get Text    ${seat_map_source_dest}
       ${seat_map_date_value}  Get Text    ${seat_map_date}
       ${converted_source_dest_date}=    Format Date For Seat Map    ${flight_source_destination_date_value}
       ${converted_seat_map_date}=    Extract On Text    ${seat_map_date_value}
       ${flight_source_destination_city_value_stripped_no_whitespace}=    Set Variable    ${flight_source_destination_city_value_stripped.replace('->', '->').replace(' ', '')}
       ${seat_map_src_dest_value_no_whitespace}=    Set Variable    ${seat_map_src_dest_value.replace('->', '->').replace(' ', '')}
       Should Be Equal As Strings    ${flight_source_destination_city_value_stripped_no_whitespace}    ${seat_map_src_dest_value_no_whitespace}
       Should Be Equal As Strings    ${converted_source_dest_date}    ${converted_seat_map_date}
   ELSE
       Log    seat map button is not available on page
   END


Handle popup
   Wait Until Element Is Visible    ${add_passengers_btn}  30s
   Sleep    8
   ${is_popupVisbile}    Run Keyword And Return Status    Element Should Be Visible    ${continue_btn}
   IF    ${is_popupVisbile}
       Click Button    ${continue_btn}
   END




Enter Passenger Details And Navigate to Review Page
   Add Passenger
   Validate The Final Amount With Expected Amount & Stored In Dictonary
   Skip Refundable Booking
   Enter Contact Details
   Click Proceed To Review Button


Validate The Final Amount With Expected Amount & Stored In Dictonary
   Wait Until Element Is Visible    ${base_fare_price}
   ${base_price}    Get Text    ${base_fare_price}
   ${base_tax_price}    Get Text    ${taxes_fees_price}
   ${tj_flex_fee_pax}    Set Variable    0
   ${tj_flex_present}    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_fee}
   IF    ${tj_flex_present}
       ${tj_flex_fee_pax}    Get Text    ${tj_flex_fee}
       ${tj_flex_fee_pax}    Extract Final Fare As String    ${tj_flex_fee_pax}
#    ELSE
#        ${tj_flex_fee_pax}    Set Variable    0
   END
#    Wait Until Element Is Visible    ${amount_to_pay_price}
   ${base_totol_price}    Get Text    ${amount_to_pay_price}
#    ${remove_ruppes_sign}    Replace String    ${base_price}    ₹    ${EMPTY}
#    ${final_base_fare}    Replace String    ${remove_ruppes_sign}    ,    ${EMPTY}
   ${final_base_fare}    Extract Final Fare As String    ${base_price}
   ${final_tax_fees}    Extract Final Fare As String    ${base_tax_price}
   ${final_totol_amount}    Extract Final Fare As String    ${base_totol_price}
   ${expected_amount}    Evaluate    ${final_base_fare} + ${final_tax_fees} + ${tj_flex_fee_pax}
   # validate
   Should Be Equal As Numbers    ${expected_amount}    ${final_totol_amount}
   ${passenger_totals}    Create Dictionary    base_fare=${final_base_fare}    tax_n_fare=${final_tax_fees}    tj_flex=${tj_flex_fee_pax}    totol_amt=${final_totol_amount}
   Set Global Variable    ${passenger_total_amt}    ${passenger_totals}


Get Fare Details Review Page, Stored And Validate With PAX
   ${base_price}    Get Text    ${base_fare_price}
   ${base_tax_price}    Get Text    ${taxes_fees_price}
   ${tj_flex_fee_pax}    Set Variable    0
   ${tj_flex_present}    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_fee}
   IF    ${tj_flex_present}
       ${tj_flex_fee_pax}    Get Text    ${tj_flex_fee}
       ${tj_flex_fee_pax}    Extract Final Fare As String    ${tj_flex_fee_pax}
   END
   ${base_totol_price}    Get Text    ${amount_to_pay_price}
   ${final_base_fare}    Extract Final Fare As String    ${base_price}
   ${final_tax_price}    Extract Final Fare As String    ${base_tax_price}
   ${final_totol_price}    Extract Final Fare As String    ${base_totol_price}
   [Return]    ${final_base_fare}    ${final_tax_price}    ${final_totol_price}
   ${review_page_totol_amt_dict}=    Create Dictionary    base_fare=${final_base_fare}    tax_n_fare=${final_tax_price}    tj_flex=${tj_flex_fee_pax}    totol_amt=${final_totol_price}
   Set Test Variable    ${review_page_totol_amt_dict}
   Should Be Equal As Strings    ${passenger_total_amt}    ${review_page_totol_amt_dict}


Select Baggege For Pax Details
   Execute Javascript    window.scrollBy(0, 500)
   ${baggage_meal_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${add_baggage_meal_section}
   Run Keyword If    ${baggage_meal_visible}    Click Element    ${add_baggage_meal_section}
   ${indexing}=    Set Variable    1
   ${total_adult_passenger_count}=    SeleniumLibrary.Get Element Count    ${adult_first_name_field}
   Sleep    5
   ${baggage_dict}    Create Dictionary
   ${baggage_info_list}  Create List
   Set Test Variable    ${baggage_dict}
   FOR    ${i}    IN RANGE    ${indexing}    ${total_adult_passenger_count}+1
       Sleep    5
        ${cnt}    Convert To String    ${i}
        ${add_baggage_dropdown}=    Replace Variables    (//label[text()='Baggage Information']//following-sibling::select[@class='main-select main-select-positionHandle'])[${i}]
        ${add_baggage_dropdown_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${add_baggage_dropdown}
        IF    ${add_baggage_dropdown_visible}==True
            Click Element    ${add_baggage_dropdown}
            Wait Until Element Is Visible    (//label[text()='Baggage Information']//following-sibling::select/option[contains(@value,'ADULT${cnt}')])[2]
            Click Element    (//label[text()='Baggage Information']//following-sibling::select/option[contains(@value,'ADULT${cnt}')])[2]
            ${baggage_price}    Get Text    (//label[text()='Baggage Information']//following-sibling::select/option[contains(@value,'ADULT${cnt}')])[2]
            ${split_values}    Split String    ${baggage_price}    @
            ${baggage_fee}    Get From List    ${split_values}    1
            ${baggage_info}    Get From List    ${split_values}    0
            ${adult_baggage_fee}    Extract Final Fare As String    ${baggage_fee}
            Set To Dictionary    ${baggage_dict}    adult${i}=adult_baggage_fee=${adult_baggage_fee}
            ${baggage_info}=   Strip String    ${baggage_info}
            Append To List  ${baggage_info_list}  ${baggage_info}
        END
   END
   ${total_child_passenger_count}=    SeleniumLibrary.Get Element Count    ${child_first_name_field}
   FOR    ${i}    IN RANGE    ${indexing}    ${total_child_passenger_count}+1
       ${cnt}    Convert To String    ${i}
       ${add_baggage_dropdown}=    Replace Variables    (//label[text()='Baggage Information']//following-sibling::select[@class='main-select main-select-positionHandle'])[${i}]
       IF    ${add_baggage_dropdown_visible}==True
           Click Element    ${add_baggage_dropdown}
           Wait Until Element Is Visible    (//label[text()='Baggage Information']//following-sibling::select/option[contains(@value,'CHILD${cnt}')])[2]
           Click Element    (//label[text()='Baggage Information']//following-sibling::select/option[contains(@value,'CHILD${cnt}')])[2]
           ${baggage_price}    Get Text    (//label[text()='Baggage Information']//following-sibling::select/option[contains(@value,'CHILD${cnt}')])[2]
           ${split_values}    Split String    ${baggage_price}    @
           ${baggage_fee}    Get From List    ${split_values}    1
           ${child_baggage_fee}    Extract Final Fare As String    ${baggage_fee}
           ${baggage_info}  Get From List    ${split_values}    0
           Set To Dictionary    ${baggage_dict}    child${i}=child_baggage_fee=${child_baggage_fee}
           ${baggage_info}=   Strip String    ${baggage_info}
           Append To List    ${baggage_info_list}  ${baggage_info}
       END
    END
    RETURN    ${baggage_dict}  ${baggage_info_list}


Calculate Totol Baggege Fee In Pax Details
   [Arguments]    ${baggage_dict}
   ${total_baggage}=    Calculate Total Sum    ${baggage_dict}
   RETURN    ${total_baggage}


Select Meal For Pax Details
   ${indexing}=    Set Variable    1
   ${total_adult_passenger_count}=    SeleniumLibrary.Get Element Count    ${adult_first_name_field}
   ${meal_dict}    Create Dictionary
   ${meal_info_list}  Create List
   Set Test Variable    ${meal_dict}
   FOR    ${i}    IN RANGE    ${indexing}    ${total_adult_passenger_count}+1
        ${cnt}    Convert To String    ${i}
        ${add_meal_dropdown}=    Replace Variables    (//label[text()='Select Meal']//following-sibling::select[@class='main-select'])[${i}]
        ${add_meal_dropdown_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${add_meal_dropdown}
        IF    ${add_meal_dropdown_visible}
            Click Element    ${add_meal_dropdown}
            Capture Page Screenshot
            Wait Until Element Is Visible    (//label[text()='Select Meal']//following-sibling::select/option[contains(@value,'ADULT${cnt}')])[2]
            Click Element     (//label[text()='Select Meal']//following-sibling::select/option[contains(@value,'ADULT${cnt}')])[2]
            ${meal_price}    Get Text     (//label[text()='Select Meal']//following-sibling::select/option[contains(@value,'ADULT${cnt}')])[2]
            ${split_values}    Split String    ${meal_price}    @
            ${split_values_length}    Get Length    ${split_values}
            IF    ${split_values_length}> 2
                ${meal_fee}    Get From List    ${split_values}    1
                ${meal_info}=  Get From List    ${split_values}    0
                ${adult_meal_fee}    Extract Final Fare As String    ${meal_fee}
                Set To Dictionary    ${meal_dict}    adult${i}=adult_meal_fee=${adult_meal_fee}
            ELSE
                ${meal_info}    Get From List    ${split_values}    0
            END
            ${meal_info}=  Strip String    ${meal_info}
            Append To List    ${meal_info_list}    ${meal_info}
        END
   END
   ${total_child_passenger_count}=    SeleniumLibrary.Get Element Count    ${child_first_name_field}
   FOR    ${i}    IN RANGE    ${indexing}    ${total_child_passenger_count}+1
       ${cnt}    Convert To String    ${i}
       ${add_meal_dropdown}=    Replace Variables   (//label[text()='Select Meal']//following-sibling::select[@class='main-select'])[${i}]
       IF    ${add_meal_dropdown_visible}
           Click Element    ${add_meal_dropdown}
           Capture Page Screenshot
           Wait Until Element Is Visible    (//label[text()='Select Meal']//following-sibling::select/option[contains(@value,'CHILD${cnt}')])[2]
           Click Element    (//label[text()='Select Meal']//following-sibling::select/option[contains(@value,'CHILD${cnt}')])[2]
           ${meal_price}    Get Text    (//label[text()='Select Meal']//following-sibling::select/option[contains(@value,'CHILD${cnt}')])[2]
           ${split_values}    Split String    ${meal_price}    @
           ${split_values_length}    Get Length    ${split_values}
           IF    ${split_values_length}> 2
               ${meal_fee}    Get From List    ${split_values}    1
               ${meal_info}=  Get From List    ${split_values}    0
               ${child_meal_fee}    Extract Final Fare As String    ${meal_fee}
               Set To Dictionary    ${meal_dict}    child${i}=child_meal_fee=${child_meal_fee}
           ELSE
               ${meal_info}    Get From List    ${split_values}    0
           END
           ${meal_info}=  Strip String    ${meal_info}
           Append To List    ${meal_info_list}  ${meal_info}
       END
    END
    RETURN    ${meal_dict}  ${meal_info_list}


Calculate Totol Meal Fee In Pax Details
   [Arguments]    ${meal_dict}
   ${total_meal}=    Calculate Total Sum    ${meal_dict}
   RETURN    ${total_meal}


Validate The Totol Baggage Price With Fare Summary Price
   [Arguments]    ${total_baggage}    ${total_meal}
   Sleep    5
   Execute Javascript    window.scrollBy(0, -document.body.scrollHeight);
   Sleep    5
   ${baggage_meal_fare_visible}    Run Keyword And Return Status    Click Element    ${baggage_meal_fare}
   ${baggage_is_present}    Run Keyword And Return Status    Page Should Contain Element    (//label[text()="Baggage Information"])[1]
   IF    ${baggage_meal_fare_visible}
       IF    ${baggage_is_present}
           Wait Until Element Is Visible    ${baggage_fare_price}    timeout=10
           ${fare_baggege}    Get Text    ${baggage_fare_price}
           ${fare_baggege}    Extract Final Fare As String    ${fare_baggege}
           Should Be Equal As Numbers    ${fare_baggege}    ${total_baggage}
           ${calculated_total_baggage_meal_fare}    Set Variable    ${fare_baggege}
           Sleep    30s
           ${meal_fare_price_status}    Run Keyword And Return Status    Page Should Contain Element    ${meal_fare_price}
           IF    ${meal_fare_price_status}
               ${fare_meal}    Get Text    ${meal_fare_price}
               ${fare_meal}    Extract Final Fare As String    ${fare_meal}
               Should Be Equal As Numbers    ${fare_meal}    ${total_meal}
               ${calculated_total_baggage_meal_fare}    Evaluate    ${fare_baggege}+${fare_meal}
           END
           Log    ${calculated_total_baggage_meal_fare}
           ${total_baggage_meal_fare}    Get Text    //span[text()='Meal, Baggage & Seat']/parent::div//i/following-sibling::span[@class='pull-right fareSummary-prices-positionHandle']
           ${total_baggage_meal_fare}    Extract Final Fare As String    ${total_baggage_meal_fare}
           Should Be Equal As Numbers    ${total_baggage_meal_fare}    ${calculated_total_baggage_meal_fare}
       ELSE
           ${fare_meal}    Get Text    (//div[@class='tax-dropdown airline-gst-print']//child::span[@class='pull-right fareSummary-prices-positionHandle'])[1]
           ${fare_meal}    Extract Final Fare As String    ${fare_meal}
           Should Be Equal As Numbers    ${fare_meal}    ${total_meal}
#            ${calculated_total_baggage_meal_fare}    Evaluate    ${fare_baggege}+${fare_meal}
#            Log    ${calculated_total_baggage_meal_fare}
           ${total_baggage_meal_fare}    Get Text    //span[text()='Meal, Baggage & Seat']/parent::div//i/following-sibling::span[@class='pull-right fareSummary-prices-positionHandle']
           ${total_baggage_meal_fare}    Extract Final Fare As String    ${total_baggage_meal_fare}
           Should Be Equal As Numbers    ${total_baggage_meal_fare}    ${fare_meal}
       END
   END
   RETURN    ${baggage_is_present}


Navigate to Passenger Details
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Wait Until Element Is Visible    ${add_passengers_btn}    20
    Click Element       ${add_passengers_btn}


Verify Show Seat Map Button
    Execute Javascript   window.scrollBy(0, 500);
    ${seat_map_button_status}    Run Keyword And Return Status    Page Should Contain Element    ${show_seat_map_button}
    IF    ${seat_map_button_status}
        Wait Until Page Contains Element    ${show_seat_map_button}    timeout=15
        Click Element    ${show_seat_map_button}
        Wait Until Page Contains    Select Seats
    END

Fetch Contact Details From Passenger Details Page
    ${pax_mobile_number}=    Get Value    ${phone_no}
    Scroll Element Into View    ${passenger_email}
    ${pax_email}=    Get Value   ${passenger_email}
    ${pax_contact_details}=    Create Dictionary    mobile=${pax_mobile_number}    email=${pax_email}
    Set Test Variable    ${pax_contact_details}
    [Return]    ${pax_contact_details}


Verify contact details (country code, mobile no., email id, emergency contact no.(If applicable) )
    Execute JavaScript    window.scroll(0, 2000)
    ${mobile_number}=    Get Text    ${review_mobile_number}
    ${email}=    Get Text   ${review_email}
    ${review_contact_details}=    Create Dictionary    mobile=${mobile_number}    email=${email}
    [Return]    ${review_contact_details}
#    Dictionaries Should Be Equal    ${pax_contact_details}    ${review_contact_details}


Verify TJ Flex on Passenger Details Page
    [Arguments]    ${fare_summary}
    Execute Javascript   window.scroll(0,600)
    IF    "${fare_summary.is_fare_jump}"
        ${total}=    Get Text    ${total_amount}
        ${pax_total}=    Set Variable    ${total.replace("₹", "").replace(",", "")}
        Set Test Variable    ${pax_total}
        Should Be Equal As Numbers      ${pax_total}      ${fare_summary.total_fare_price}
    ELSE
        Wait Until Page Contains Element    ${base_fare}    30s
        ${base}=    Get Text  ${base_fare}
        ${taxes}=    Get Text    ${taxes_and_fees}
        ${tj_flex}=    Get Text    ${tj_flex_fee}
        ${total}=    Get Text    ${total_amount}
        ${base}=    Set Variable    ${base.replace("₹", "").replace(",", "")}
        ${taxes}=    Set Variable    ${taxes.replace("₹", "").replace(",", "")}
        ${tj_flex}=    Set Variable    ${tj_flex.replace("₹", "").replace(",", "")}
        ${total}=    Set Variable    ${total.replace("₹", "").replace(",", "")}
        Should Be Equal As Numbers      ${base}        ${fare_summary.base_fare}
        Should Be Equal As Numbers      ${taxes}       ${fare_summary.taxes}
        Should Be Equal As Numbers      ${tj_flex}    ${fare_summary.tj_flex}
        Should Be Equal As Numbers      ${total}      ${fare_summary.total_fare_price}
    END




Verify TJ Flex on Review Page
    Wait Until Element Is Visible    ${base_fare_price}
    ${review_base_price}    Get Text    ${base_fare_price}
    ${review_base_tax_price}    Get Text    ${taxes_fees_price}
    ${review_tj_flex_fee_pax}    Set Variable    0
    ${review_tj_flex_present}    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_fee}
    IF    ${review_tj_flex_present}
        ${review_tj_flex_fee_pax}    Get Text    ${tj_flex_fee}
        ${review_tj_flex_fee_pax}    Extract Final Fare As String    ${review_tj_flex_fee_pax}
    END
    ${review_base_total_price}    Get Text    ${amount_to_pay_price}
    ${review_final_base_fare}    Extract Final Fare As String    ${review_base_price}
    ${review_final_tax_fees}    Extract Final Fare As String    ${review_base_tax_price}
    ${review_final_total_amount}    Extract Final Fare As String    ${review_base_total_price}
    ${review_expected_amount}    Evaluate    ${review_final_base_fare} + ${review_final_tax_fees} + ${review_tj_flex_fee_pax}
    Should Be Equal As Numbers    ${review_expected_amount}    ${review_final_total_amount}
    ${passenger_totals}    Create Dictionary    base_fare=${review_final_base_fare}    tax_n_fare=${review_final_tax_fees}    tj_flex=${review_tj_flex_fee_pax}    total_amt=${review_final_total_amount}
    Set Global Variable    ${passenger_total_amt}    ${passenger_totals}


Verify TJ Flex on Payment Page
    Wait Until Element Is Visible    ${base_fare_price}
    ${payment_base_price}    Get Text    ${base_fare_price}
    ${payment_base_tax_price}    Get Text    ${taxes_fees_price}
    ${payment_tj_flex_fee_pax}    Set Variable    0
    ${payment_tj_flex_present}    Run Keyword And Return Status    Page Should Contain Element    ${tj_flex_fee}
    IF    ${payment_tj_flex_present}
        ${payment_tj_flex_fee_pax}    Get Text    ${tj_flex_fee}
        ${payment_tj_flex_fee_pax}    Extract Final Fare As String    ${payment_tj_flex_fee_pax}
    END
    ${payment_base_total_price}    Get Text    ${amount_to_pay_price}
    ${payment_final_base_fare}    Extract Final Fare As String    ${payment_base_price}
    ${payment_final_tax_fees}    Extract Final Fare As String    ${payment_base_tax_price}
    ${payment_final_total_amount}    Extract Final Fare As String    ${payment_base_total_price}
    ${payment_expected_amount}    Evaluate    ${payment_final_base_fare} + ${payment_final_tax_fees} + ${payment_tj_flex_fee_pax}
    Should Be Equal As Numbers    ${payment_expected_amount}    ${payment_final_total_amount}
    ${passenger_totals}    Create Dictionary    base_fare=${payment_final_base_fare}    tax_n_fare=${payment_final_tax_fees}    tj_flex=${payment_tj_flex_fee_pax}    total_amt=${payment_final_total_amount}
    Set Global Variable    ${passenger_total_amt}    ${passenger_totals}


Deselect TJ Flex And Navigate To Flight Itinerary
    Wait Until Element Is Visible    ${book_button}     timeout=20s
    ${flight_with_tj_flex}=    Run Keyword And Return Status    Element Should Be Visible    ${flight_without_tj_flex}
    Run Keyword If    '${flight_with_tj_flex}' == 'True'    Click Element    ${flight_without_tj_flex}
    Capture Page Screenshot
    Click Button    ${book_button}
    Run Keyword Unless    '${flight_with_tj_flex}' == 'True'    Click Button    ${book_button}
    Handle All Popups    ${False}  ${False}    ${False}    ${False}
#    Handle Consent Message Popup


Verify TJ Flex Radio Button And Verify Fare Summary
    Scroll Element Into View    ${base_fare_summary}
    ${base}=    Get Text  ${base_fare_summary}
    ${taxes}=    Get Text    ${taxes_fees_summary}
    ${total}=    Get Text    ${amount_to_pay}
    ${base}=    Extract Final Fare As String    ${base}
    ${taxes}=   Extract Final Fare As String   ${taxes}
    ${total}=   Extract Final Fare As String    ${total}
    Scroll Element Into View    ${passenger_email}
    #    Scroll Element Into View    ${book_with_tj_flex_button}
    ${tj_flex_button_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${book_with_tj_flex_button}
    IF    ${tj_flex_button_visible}
        Scroll Element Into View    ${book_with_tj_flex_button}
    #    ...    ELSE    Fail    TJ flex radio button is not visible, hence test case failed.
        ${tj_flex_radio_button_value}=    Get Text    ${tj_flex_radio_button_amount}
        ${tj_flex_radio_button_value}    Extract Final Fare As String    ${tj_flex_radio_button_value}
        log    ${tj_flex_radio_button_value}
        Click Element    ${book_with_tj_flex_button}
        ${new_total_amount_to_pay}    Evaluate       ${total}+${tj_flex_radio_button_value}
        Log    ${new_total_amount_to_pay}
        Execute JavaScript    window.scrollTo(0, 0)
        ${updated_total_amount_to_pay}  Get Text    ${amount_to_pay}
        ${updated_total_amount_to_pay}  extract_final_fare_as_string  ${updated_total_amount_to_pay}
        Should Be Equal As Numbers    ${new_total_amount_to_pay}    ${updated_total_amount_to_pay}
    END


Navigate to Flight Itinerary Without Selecting Airline
    Wait Until Element Is Visible    ${book_button}     timeout=20s
    Click Button    ${book_button}
    Handle All Popups    ${False}  ${False}    ${False}    ${False}
#    Handle Consent Message Popup
    #    Wait Until Page Contains Element    ${markup_icon}      timeout=80s
#    Handle All Popups And Update Data


Click On Airline For Passport
    Run Keyword And Ignore Error    Scroll Element Into View    //span[contains(text(),'Airlines')]/parent::p/child::i
    Run Keyword And Ignore Error    Scroll Element Into View    //span[@class="flight__airline__name"][text()="Oman Aviation"]
    Run Keyword And Ignore Error    Scroll Element Into View    //span[@class="flight__airline__name"][text()="Saudi Arabian Airlines"]
    #   Run Keyword And Ignore Error    Scroll Element Into View    //span[@class="flight__airline__name"][text()="Saudi Arabian Airlines"]
    Run Keyword And Ignore Error    Scroll Element Into View    //span[@class="flight__airline__name"][text()="Air India"]
    #   Run Keyword And Ignore Error    Scroll Element Into View    //span[@class="flight__airline__name"][text()="Emirates Airlines"]
    Click Element    //span[@class="flight__airline__name"][text()="Saudi Arabian Airlines"]/following-sibling::span[@class="pull-right"]/descendant::i[@class="fa fa-check"]


Verify PAX Detail
    ${passenger_list}    Add Passenger
    Execute Javascript    window.scrollBy(0,300);
    #    The below keyword is commented as the passport field is not visible
    #    ${passport_detail_list}    Add Passport Details On Pax Details Page
    Skip Refundable Booking
    ${Contact_details}   Enter Contact Details
    Click Proceed To Review Button
    Wait Until Element Is Visible    ${review_page_title}    timeout=30s
    Verify Passenger Details And Contact Details On Review Page   ${passenger_list}    ${Contact_details}
    #    ${passport_details_on_review}    Verify Passport Details On Review Page    ${passport_detail_list}
    #    RETURN    ${passport_details_on_review}


Verify Passport Details Entered
    ${passenger_list}    Add Passenger
    Execute Javascript    window.scrollBy(0,300);
    ${passport_detail_list}    Add Passport Details On Pax Details Page
    Log To Console    ${passport_detail_list}
    Skip Refundable Booking
    ${Contact_details}    Enter Contact Details
    Sleep    20s
    Click proceed to Review button
    ${passport_details_on_review}    Verify Passport Details On Review Page    ${passport_detail_list}
    Sleep    10s
    RETURN    ${passport_details_on_review}


Add Passport Details On Pax Details Page
    ${passport_detail_list}=     Create List
    ${indexing}=    Set Variable    1
    ${total_adult_passenger_count}    SeleniumLibrary.Get Element Count    ${adult_first_name_field}
    WHILE      ${indexing} <= ${total_adult_passenger_count}
    #        Click Element    (//span[contains(text(),"ADULT")]/parent::h5/child::span[contains(@class,"-arrow paxdetails")])[${indexing}]
        Scroll Element Into View    (//select[contains(@name,"pNat")])[${indexing}]
        Execute Javascript    window.scrollBy(0,200);
        Click Element    (//select[contains(@name,"pNat")])[${indexing}]
        Click Element    //option[@value="IN"]
        ${Nationality}    Get Value    //option[@value="IN"]
        ${adult_passport_number}    Generate Passport Number
        Log To Console    ${adult_passport_number}
        Input Text    //input[@name="ADULT${indexing}_pNum"]    ${adult_passport_number}
        ${adult_passport_issue_date}    Generate Passport Issue Date
        Wait Until Element Is Visible    //select[@name="ADULT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]
        Input Text    //select[@name="ADULT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]    ${adult_passport_issue_date}
        ${adult_passport_expiry_date}    Get Value    //select[@name="ADULT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Expiry Date *"]
        Log    ${adult_passport_expiry_date}
        ${full_passport_detail}=     Set Variable  ${Nationality} ${adult_passport_number} ${adult_passport_issue_date} ${adult_passport_expiry_date}
        Append To List    ${passport_detail_list}    ${full_passport_detail}
        ${indexing}=  Evaluate   ${indexing} + 1
    END
    ${indexing}=    Set Variable    1
    ${total_child_passenger_count}    SeleniumLibrary.Get Element Count    ${child_first_name_field}
    WHILE      ${indexing} <= ${total_child_passenger_count}
        Scroll Element Into View    //select[@name="CHILD${indexing}_pNat"]
        Execute Javascript    window.scrollBy(0,200);
        Click Element    //select[@name="CHILD${indexing}_pNat"]
        Wait Until Element Is Visible    //select[@name="CHILD${indexing}_pNat"]
        Click Element    //option[@value="IN"]
        ${Nationality}    Get Value    //option[@value="IN"]
        ${child_passport_number}    Generate Passport Number
        Log To Console    ${child_passport_number}
        Input Text    //input[@name="CHILD${indexing}_pNum"]    ${child_passport_number}
        ${child_passport_issue_date}    Generate Passport Issue Date
        Wait Until Element Is Visible    //select[@name="CHILD${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]
        Input Text    //select[@name="CHILD${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]    ${child_passport_issue_date}
        ${child_passport_expiry_date}    Get Value    //select[@name="CHILD${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Expiry Date *"]
        ${full_passport_detail}=     Set Variable  ${Nationality} ${child_passport_number} ${child_passport_issue_date} ${child_passport_expiry_date}
        Append To List    ${passport_detail_list}    ${full_passport_detail}
        ${indexing}=  Evaluate   ${indexing} + 1
    END
    ${indexing}=    Set Variable    1
    ${total_infant_passenger_count}    SeleniumLibrary.Get Element Count    ${infant_first_name_field}
    WHILE      ${indexing} <= ${total_infant_passenger_count}
        Scroll Element Into View    //select[@name="INFANT${indexing}_pNat"]
        Execute Javascript    window.scrollBy(0,200);
        Click Element    //select[@name="INFANT${indexing}_pNat"]
        Wait Until Element Is Visible    //select[@name="INFANT${indexing}_pNat"]
        Click Element    //option[@value="IN"]
        ${Nationality}    Get Value    //option[@value="IN"]
        ${infant_passport_number}    Generate Passport Number
        Log To Console    ${infant_passport_number}
        Input Text    //input[@name="INFANT${indexing}_pNum"]    ${infant_passport_number}
        ${infant_passport_issue_date}    Generate Passport Issue Date
        Wait Until Element Is Visible    //select[@name="INFANT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]
        Input Text    //select[@name="INFANT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Issue Date *"]    ${infant_passport_issue_date}
        ${infant_passport_expiry_date}    Get Value    //select[@name="INFANT${indexing}_pNat"]/ancestor::div[@class="col-sm-2 clearfix"]/following-sibling::div[@class="paxdetails-inputsize"]/descendant::input[@placeholder="Expiry Date *"]
        ${full_passport_detail}=     Set Variable  ${Nationality} ${infant_passport_number} ${infant_passport_issue_date} ${infant_passport_expiry_date}
        Append To List    ${passport_detail_list}    ${full_passport_detail}
        ${indexing}=  Evaluate   ${indexing} + 1
    END
    RETURN    ${passport_detail_list}


Verify Passport Details On Review Page
    [Arguments]    ${passport_detail_list}
    Log    ${passport_detail_list}
    ${passport_details_from_pax}    Create List
    ${passport_details_on_review}    Create List
    ${passenger_names}    SeleniumLibrary.Get Element Count    ${passenger_name}
    FOR    ${indexing}  IN RANGE    1    ${passenger_names}+1
        ${passport_detail}    Get Text    (//span[@class="pax-passportSize"])[${indexing}]
        Log To Console    ${passport_detail}
        Append To List    ${passport_details_on_review}    ${passport_detail}
    END
    ${count}=    Get Length    ${passport_detail_list}
    Log To Console    ${count}
    FOR    ${element}    IN RANGE    0   ${count}
        Log    ${element}
        ${index}    Set Variable    ${passport_detail_list}[${element}]
        ${key} =    Set Variable    ${index}
        ${value} =    Set Variable    PP :${index.split(' ')[1]} N :${index.split(' ')[0]} ID :${index.split(' ')[2]} ED :${index.split(' ')[3]}
        Append To List    ${passport_details_from_pax}    ${value}
    END
    Log To Console    ${passport_details_from_pax}
    Lists Should Be Equal    ${passport_details_from_pax}    ${passport_details_on_review}
    RETURN    ${passport_details_on_review}


Click Proceed to Review Button GDS
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Wait Until Element Is Visible    ${proceed_to_review_button}
    Scroll Element Into View    ${proceed_to_review_button}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Run Keyword And Ignore Error    Scroll Element Into View    //div[@class='footer__mainWrap']
    Click Element        ${proceed_to_review_button}
    Wait Until Element Is Visible    ${review_page_title}    timeout=30s

Add Passenger Details For Corporate
    ${passangers_name_list}=   Create List
    Set Test Variable    ${passangers_name_list}
    Execute Javascript     window.scrollBy(0, 800);
    Wait Until Element Is Visible    ${add_passengers_btn}     timeout=20s
    #     Handle popup
    Handle All Popups And Update Data
    Scroll Element Into View    ${add_passengers_btn}
    Click Element       ${add_passengers_btn}
    ${toggle_button_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${toggle_btn}
    Run Keyword If    ${toggle_button_visible}    Click Element    ${toggle_btn}
    ${passenger_name}=     Create List
    ${indexing}=    Set Variable    1
    ${total_adult_passenger_count}    SeleniumLibrary.Get Element Count    ${adult_first_name_field}
    WHILE      ${indexing} <= ${total_adult_passenger_count}
        Execute Javascript      window.scrollTo(0,500);
        ${adult_first_name}    Random Name
        ${adult_last_name}    Random Name
        ${adult_dob}   Generate Adult Birth Date
        Wait Until Page Contains Element    (${adult_title_dropdown})[${indexing}]     timeout=20
        Click Element   (${adult_title_dropdown})[${indexing}]
        ${title}=   Get Text    (${adult_title_mr})[${indexing}]
        Wait Until Page Contains Element    (${adult_title_mr})[${indexing}]
        Click Element   (${adult_title_mr})[${indexing}]
        Wait Until Element Is Visible    (${adult_first_name_field})[${indexing}]
        Input Text    (${adult_first_name_field})[${indexing}]  ${adult_first_name}
        Execute Javascript     window.scrollBy(0, 800);
        ${dob}=  Run Keyword And Return Status     Page Should Contain Element    (${adult_dob_field})[${indexing}]
        Run Keyword If     ${dob}   Input Text    (${adult_dob_field})[${indexing}]    ${adult_dob}
        Wait Until Element Is Visible    (${adult_last_name_field})[${indexing}]   timeout=20s
        Click Element    (${adult_last_name_field})[${indexing}]
        Input Text    (${adult_last_name_field})[${indexing}]    ${adult_last_name}
        ${full_name_with_title}=     Set Variable  ${title} ${adult_first_name} ${adult_last_name} (A)
        IF    ${dob}
            ${full_name_with_title}=    Set Variable        ${full_name_with_title} ${adult_dob}
        END
        Append To List    ${passangers_name_list}    ${full_name_with_title}
        Set Test Variable    ${adult_first_name}
        Set Test Variable    ${adult_last_name}
        Wait Until Element Is Visible    (//input[@placeholder='Email'])[${indexing}]
        ${corporate_email}    Generate Random Email
        Input Text    (//input[@placeholder='Email'])[${indexing}]     ${corporate_email}
        ${corporate_mobile}    Generate Random Phone Number
        Input Text    (//input[@placeholder='Mobile'])[${indexing}]   ${corporate_mobile}
        Input Text    (//input[@placeholder='Employee Id'])[${indexing}]       ID-45715
        Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
        ${normalize_corporate_document_upload}    Normalize Path    ${corporate_document_upload}
        Scroll Element Into View    (//span[text()='Save Profile'])[${indexing}]
        Scroll Element Into View    //input[@type='file']
        Choose File    //input[@type='file']       ${normalize_corporate_document_upload}
        Wait Until Element Is Visible    //span[text()='Upload']
        Click Element    //span[text()='Upload']
        ${indexing}=  Evaluate   ${indexing} + 1
    END
    ${indexing}=    Set Variable    1
    ${total_child_passenger_count}    SeleniumLibrary.Get Element Count    ${child_first_name_field}
    WHILE      ${indexing} <= ${total_child_passenger_count}
        Execute Javascript      window.scrollBy(0,500);
        ${child_first_name}    Random Name
        ${child_last_name}    Random Name
        ${child_dob}    Generate Child Birth Date
        Wait Until Page Contains Element    (${child_title_dropdown})[${indexing}]     timeout=20
        Click Element   (${child_title_dropdown})[${indexing}]
        Wait Until Page Contains Element    (${child_title_master})[${indexing}]
        ${title}    Get Text     (${child_title_master})[${indexing}]
        Click Element   (${child_title_master})[${indexing}]
        Wait Until Element Is Visible    (${child_first_name_field})[${indexing}]
        Input Text    (${child_first_name_field})[${indexing}]  ${child_first_name}
        Execute Javascript     window.scrollBy(0, 500);
        ${dob}=  Run Keyword And Return Status     Page Should Contain Element    (${child_dob_field})[${indexing}]
        Run Keyword If     ${dob}   Input Text    (${child_dob_field})[${indexing}]    ${child_dob}
        Wait Until Element Is Visible    (${child_last_name_field})[${indexing}]   timeout=20s
        Click Element    (${child_last_name_field})[${indexing}]
        Input Text    (${child_last_name_field})[${indexing}]    ${child_last_name}
        ${full_name_with_title}=     Set Variable  ${title} ${child_first_name} ${child_last_name} (C)
        IF    ${dob}
            ${full_name_with_title}=    Set Variable        ${full_name_with_title} ${child_dob}
        END
        Append To List    ${passangers_name_list}    ${full_name_with_title}
        ${indexing}=  Evaluate   ${indexing} + 1
        Set Test Variable    ${child_first_name}
        Set Test Variable    ${child_last_name}
    END
    ${indexing}=    Set Variable    1
    ${total_infant_passenger_count}    SeleniumLibrary.Get Element Count    ${infant_first_name_field}
    WHILE      ${indexing} <= ${total_infant_passenger_count}
        Execute Javascript      window.scrollBy(0,500);
        ${infant_first_name}    Random Name
        ${infant_last_name}    Random Name
        ${infant_dob}    Generate Infant Birth Date
        Wait Until Page Contains Element    (${infant_title_dropdown})[${indexing}]     timeout=20
        Click Element   (${infant_title_dropdown})[${indexing}]
        Wait Until Page Contains Element    (${infant_title_ms})[${indexing}]
        ${title}    Get Text     (${infant_title_ms})[${indexing}]
        Click Element   (${infant_title_ms})[${indexing}]
        Wait Until Element Is Visible    (${infant_first_name_field})[${indexing}]
        Input Text    (${infant_first_name_field})[${indexing}]  ${infant_first_name}
        Execute Javascript     window.scrollBy(0, 500);
        ${dob}=  Run Keyword And Return Status     Page Should Contain Element    (${infant_dob_field})[${indexing}]
        Run Keyword If     ${dob}   Input Text    (${infant_dob_field})[${indexing}]    ${infant_dob}
        Wait Until Element Is Visible    (${infant_last_name_field})[${indexing}]   timeout=20s
        Click Element    (${infant_last_name_field})[${indexing}]
        Input Text    (${infant_last_name_field})[${indexing}]    ${infant_last_name}
        ${full_name_with_title}=     Set Variable  ${title} ${infant_first_name} ${infant_last_name} (I)
        IF    ${dob}
            ${full_name_with_title}=    Set Variable        ${full_name_with_title} ${infant_dob}
        END
        Append To List    ${passangers_name_list}    ${full_name_with_title}
        ${indexing}=  Evaluate   ${indexing} + 1
        Set Test Variable    ${infant_first_name}
        Set Test Variable    ${infant_last_name}
    END
    Add Passport Details On Pax Details Page From Booking Summary
    RETURN    ${passangers_name_list}

Enter Passenger Destination Address If Available
    ${destination_address_present}    Run Keyword And Return Status    Page Should Contain Element    ${passenger_destination_address}
    IF    ${destination_address_present}
#        Scroll Element Into View    ${destination_address_present}
        Input Text    ${passenger_destination_address}    Pune
    END

Handle Consent Message Popup
    Sleep    5
    ${consent_message_status}    Run Keyword And Return Status    Page Should Contain Element    ${consent_message_popup}
    IF    ${consent_message_status}
        Click Element    ${continue_btn}
        Sleep    3
    END
