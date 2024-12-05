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
Variables     ../../../Environment/environments.py
Variables    ../../PageObjects/ImportPnr/import_pnr_locators.py
Variables    ../../PageObjects/ManageSource/manage_source_locators.py
Variables    ../../PageObjects/Payment/payment_locators.py
Resource     ../../CommonKeywords/ManageCart/Manage_cart_keywords.robot
Resource    ../../CommonKeywords/Payment/payment_keywords.robot
Resource    ../BookingSummaryMoreOptions/booking_summary_more_options_keywords.robot

*** Keywords ***
Get Details of First Booking To Import
    Execute Javascript  window.scrollTo(0,200)
    Sleep    2s
    Wait Until Element Is Visible    ${first_booking_id}    10s
    ${booking_id}=  Get Text    ${first_booking_id}
    Click Element    ${first_booking_id}
    Wait Until Page Contains    Booking Details    30s
    ${user_id}    Get userid to emulate user
    [Return]    ${user_id}

Get userid to emulate user
    Sleep    2s
    ${userid_text}=     get text    (//a[contains(@href, '/manage-user/user-detail')])[2]
    ${matches}=    Get Regexp Matches    ${userid_text}    \\d+
    ${user_id}=    Set Variable    ${matches[0]}
    Log    ${user_id}
    [Return]    ${user_id}

Get Booking Details
    Wait Until Element Is Visible    ${get_airline_name}
    Sleep    5
    ${airline_name_elements}=  Get WebElements    ${get_airline_name}
    ${booking_details}=  Create Dictionary
    ${temp_counter}=  Set Variable  1
    FOR    ${airline_name}    IN    @{airline_name_elements}
        ${name}=  Get Text    ${airline_name}
        Set To Dictionary    ${booking_details}  airline_name${temp_counter}=${name}
        ${temp_counter}=  Evaluate    ${temp_counter}+1
    END
    ${segment_info_elements}=  Get WebElements    ${get_segment_info}
    ${temp_counter}=  Set Variable  1
    FOR    ${segment_info}    IN    @{segment_info_elements}
        ${info}=  Get Text    ${segment_info}
        Set To Dictionary    ${booking_details}  segment_info${temp_counter}=${info}
        ${temp_counter}=  Evaluate    ${temp_counter}+1
    END
    ${base_fare_elements}=  Get WebElements    ${get_base_fare}
    ${temp_counter}=  Set Variable  1
    FOR    ${base_fare}    IN    @{base_fare_elements}
        ${fare}=  Get Value    ${base_fare}
        Set To Dictionary    ${booking_details}  base_fare${temp_counter}=${fare}
        ${temp_counter}=  Evaluate    ${temp_counter}+1
    END
    ${tax_fare_elements}=  Get WebElements    ${get_taxes}
    ${temp_counter}=  Set Variable  1
    FOR    ${taxes}    IN    @{tax_fare_elements}
        ${tax}=  Get Value    ${taxes}
        ${tax}=  Strip String	${tax}
        Set To Dictionary    ${booking_details}  tax${temp_counter}=${tax}
        ${temp_counter}=  Evaluate    ${temp_counter}+1
    END
    ${pnr}=  Get Value    ${get_pnr}
    ${gds}=  Get Value    ${get_gds}
    ${status}  Run Keyword And Return Status    Wait Until Page Contains Element    ${get_supplier_name}  timeout=30
    IF    ${status}
        ${supplier}=  Get Value    ${get_supplier_name}
        Set To Dictionary    ${booking_details}  pnr=${pnr}  gds=${gds}  supplier=${supplier}
    ELSE
        Set To Dictionary    ${booking_details}  pnr=${pnr}  gds=${gds}
    END
    Log    ${booking_details}
    RETURN  ${booking_details}

Import Lcc Pnr
    [Arguments]  ${booking_details}    ${user_id}
#    ${my_dict}       Create Dictionary   &{search_data}
    ${supplier_name}=  Set Variable  ${booking_details.supplier}
    Wait Until Element Is Visible    ${import_pnr_link}
    Click Element    ${import_pnr_link}
    Sleep    2
    Wait Until Element Is Visible    ${supplier_field}
    Click Element    ${supplier_field}
    ${supplier}    Replace String    ${select_supplier}    Supplier    ${supplier_name}
    #    Input Text    ${supplier_field}    ${supplier_name}
    #    Sleep    2
    Scroll Element Into View    ${airasia_source}
    Wait Until Element Is Visible    ${supplier}    10s
    Click Element    ${supplier}
    Click Element    ${supplier_field_arrow}
    Input Text    ${user_id_field}    ${user_id}
    Wait Until Element Is Visible    ${user_id_dropdown}
    Click Element    ${user_id_dropdown}
    Wait Until Element Is Visible    ${input_pnr_new}
    Input Text    ${input_pnr_new}    ${booking_details.pnr}
    Click Element    ${new_edit_import_button}
    Wait Until Element Is Visible    ${segment_detail_heading}  timeout=30

Import Gds Pnr
    [Arguments]  ${booking_details}    ${User_id}
#    ${my_dict}       Create Dictionary   &{search_data}
    Go Back
    ${supplier_name}=  Set Variable  ${booking_details.supplier}
    Wait Until Element Is Visible    ${import_pnr_link}
    Click Element    ${import_pnr_link}
    Sleep    2
    Wait Until Element Is Visible    ${supplier_field}
    Click Element    ${supplier_field}
    ${supplier}    Replace String    ${select_supplier}    Supplier    ${supplier_name}
    #    Input Text    ${supplier_field}    ${supplier_name}
    Sleep    2
    Scroll Element Into View    ${airasia_source}
    Wait Until Element Is Visible    ${supplier}    10s
    Click Element    ${supplier}
    Click Element    ${supplier_field_arrow}
    Input Text    ${user_id_field}    ${User_id}
    Wait Until Element Is Visible    ${user_id_dropdown}
    Click Element    ${user_id_dropdown}
    Wait Until Element Is Visible    ${input_pnr_new}
    Input Text    ${input_pnr_new}    ${booking_details.gds}
    Click Element    ${new_edit_import_button}
    Wait Until Element Is Visible    ${segment_detail_heading}      30s    No booking found with mentioned pnr

Import Gds Pnr Through Old Import
    [Arguments]  ${booking_details}    ${User_id}
#    ${my_dict}       Create Dictionary   &{search_data}
    Go Back
    ${supplier_name}=  Set Variable    ${booking_details.supplier}
    Wait Until Element Is Visible    ${import_pnr_link}
    Click Element    ${import_pnr_link}
    Sleep    4
    Wait Until Element Is Visible    ${supplier_field_old_pnr}
    Click Element    ${supplier_field_old_pnr}
    ${supplier}    Replace String    ${select_supplier}    Supplier    ${supplier_name}
    #    Input Text    ${supplier_field}    ${supplier_name}
    #    Sleep    2
    Scroll Element Into View    ${airasia_source}
    Wait Until Element Is Visible    ${supplier}    10s
    Click Element    ${supplier}
    Click Element    ${old_supplier_field_arrow}
    Input Text    ${user_id_field_old_pnr}    ${User_id}
    Wait Until Element Is Visible    ${user_id_dropdown}
    Click Element    ${user_id_dropdown}
    Wait Until Element Is Visible    ${input_pnr_old}
    Input Text    ${input_pnr_old}    ${booking_details.gds}
    Click Element    ${old_import_pnr_button}
    Sleep  15
    Switch Window  NEW

Select Fare Type For GDS Import
    Execute Javascript  window.scrollTo(0,400)
    ${fare_elements}=  Get Webelements    ${fare_type}
    FOR    ${each_fare}    IN    @{fare_elements}
        Click Element    ${each_fare}
        Scroll Element Into View    ${select_corporate_lite}
        Wait Until Element Is Visible    ${select_economy_fare}
        Click Element    ${select_economy_fare}
    END

Get Booking Data From Pnr Page
    #    Sleep    2
    Execute Javascript  window.scrollTo(0,200)
    ${booking_details_ipnr_page}=  Create Dictionary
    ${source_elements}  Get WebElements    ${get_source_ipnr}
    ${temp_counter}=  Set Variable  1
    FOR    ${each_source}    IN    @{source_elements}
        ${source}  Get Text    ${each_source}
        Set To Dictionary    ${booking_details_ipnr_page}  source${temp_counter}=${source}
        ${temp_counter}=  Evaluate    ${temp_counter}+1
    END
    ${destination_elements}  Get WebElements    ${get_destination}
    ${temp_counter}=  Set Variable  1
    FOR    ${each_destination}    IN    @{destination_elements}
        ${destination}  Get Text    ${each_destination}
        Set To Dictionary    ${booking_details_ipnr_page}  destination${temp_counter}=${destination}
        ${temp_counter}=  Evaluate    ${temp_counter}+1
    END
    ${departure_elements}  Get WebElements    ${get_departure_time}
    ${temp_counter}=  Set Variable  1
    FOR    ${each_departure}    IN    @{departure_elements}
        ${departure}  Get Value    ${each_departure}
        Set To Dictionary    ${booking_details_ipnr_page}  departure${temp_counter}=${departure}
        ${temp_counter}=  Evaluate    ${temp_counter}+1
    END
    ${arrival_elements}  Get WebElements    ${get_arrival_time}
    ${temp_counter}=  Set Variable  1
    FOR    ${each_arrival}    IN    @{arrival_elements}
        ${arrival}  Get Value    ${each_arrival}
        Set To Dictionary    ${booking_details_ipnr_page}  arrival${temp_counter}=${arrival}
        ${temp_counter}=  Evaluate    ${temp_counter}+1
    END
    RETURN  ${booking_details_ipnr_page}

Verify Both Booking Details
    [Arguments]  ${booking_details}  ${booking_details_from_pnr}
    ${key_mapping}=    Create Dictionary    segment_info1=source1  segment_info2=destination1
    ${result}=    Verify Partial Equality    ${booking_details}    ${booking_details_from_pnr}    ${key_mapping}
    Should Be True    ${result}

Enter Mobile And Email And Click On Submit Button
    [Arguments]    ${search_data}
    ${my_dict}       Create Dictionary   &{search_data}
    #     Execute Javascript  window.scrollTo(0,500)
    #      ${count}  Get Element Count    //label[text()='Refundable Type']//preceding-sibling::input
        ${segment_count}    Get Element Count   //label[text()='Accounting Code']
        FOR    ${element}    IN RANGE    1    ${segment_count}+1 
#            Click Element    (//label[text()='Accounting Code']//preceding-sibling::input)[${element}]
            Sleep    2s
           Clear Element Text    (//label[text()='Accounting Code']//preceding-sibling::input)[${element}]
        END
       ${count}  Get Element Count    ${refundable_type_dropdown}
       
      FOR    ${element}    IN RANGE    1    ${count}+1
          Scroll Element Into View   (${pnr_dropdown})[${element}]

          Click Element  (${cabin_class_dropdown})[${element}]
          Wait Until Element Is Visible      ${select_first_element_from_dropdown}   timeout=10
          Click Element      ${select_first_element_from_dropdown}

          Input Text  (${fare_basis_dropdown})[${element}]  RCIP

          Click Element  (${refundable_type_dropdown})[${element}]
          Wait Until Element Is Visible  ${select_first_element_from_dropdown}  timeout=10
          Click Element      ${select_first_element_from_dropdown}
            
#          Click Element    (//label[text()='Supplier Commission']//preceding-sibling::input)[${element}]
            Sleep    2s
          Clear Element Text    (//label[text()='Supplier Commission']//preceding-sibling::input)[${element}]

      END
    #     ${refundable_elements}  Get Webelements     //label[text()='Refundable Type']//preceding-sibling::input
    #     FOR    ${element}    IN    @{refundable_elements}
    #         Scroll Element Into View   ${element}
    #         Click Element  ${element}
    #         Wait Until Element Is Visible  (//ul[@class="select-box-list select-box-list--open"]/li)[1]  timeout=10
    #         Click Element      (//ul[@class="select-box-list select-box-list--open"]/li)[1]
    ##         Execute Javascript  window.scrollTo(0,300)
    #     END
    #     ${cabin_elements}  Get Webelements     //label[text()='Cabin Class']//preceding-sibling::input
    #     FOR    ${element}    IN    @{cabin_elements}
    #         Scroll Element Into View   ${element}
    #         Click Element    ${element}
    #         Wait Until Element Is Visible  (//ul[@class="select-box-list select-box-list--open"]/li)[1]  timeout=10
    #         Click Element  (//ul[@class="select-box-list select-box-list--open"]/li)[1]
    ##         Execute Javascript  window.scrollTo(0,300)
    #     END
    #     ${fare_basis_elements}  Get Webelements     //label[text()='Fare Basis']//preceding-sibling::input
    #     FOR    ${element}    IN    @{fare_basis_elements}
    #         Scroll Element Into View   ${element}
    #         Click Element    ${element}
    #         Wait Until Element Is Visible  (//ul[@class="select-box-list select-box-list--open"]/li)[1]  timeout=10
    #         Click Element  (//ul[@class="select-box-list select-box-list--open"]/li)[1]
    ##         Execute Javascript  window.scrollTo(0,300)
    #     END
    Maximize Browser Window
    Execute Javascript  window.scrollTo(0,800)
    Sleep    1
    Clear Element Text    ${mobile_number_field}
    Sleep    1
    Clear Element Text    ${email_field_ipnr}
    Sleep    1
    Input Text    ${mobile_number_field}    ${my_dict.mobile_number}
    Input Text    ${email_field_ipnr}    ${my_dict.email}
    Scroll Element Into View    ${submit_button_ipnr}
    Click Element    ${submit_button_ipnr}
    #    Sleep  2
    Wait Until Element Is Visible    ${booking_generate_popup}  timeout=30

Get Generated Booking Details And Hold The Booking
    ${booking_id}  Get Text    ${generated_booking_id}
    ${temp_list}  Split String    ${booking_id}    Id
    ${booking_id}  Get From List    ${temp_list}    1
    ${booking_id}  Strip String    ${booking_id}
    ${total_fare}  Get Text    ${generated_total_fare}
    ${special_fare}  Get Text    ${generated_special_fare}
    ${generated_booking_data}  Create Dictionary  booking_id=${booking_id}  total_fare=${total_fare}  special_fare=${special_fare}
    Click Element    ${on_hold_button}
    Wait Until Element Is Visible    ${on_hold_status}  timeout=30
    RETURN  ${generated_booking_data}

Emulate User
    [Arguments]    ${user_id}
#    ${my_dict}       Create Dictionary   &{search_data}
    Wait Until Element Is Visible    ${dashboard_link}
    Click Element    ${dashboard_link}
    Sleep    2s
    Wait Until Element Is Visible    ${user_id_field}    10s
    Input Text    ${user_id_field}    ${user_id}
    Wait Until Element Is Visible    ${user_id_dropdown}    10s
    Sleep    1
    Click Element    ${user_id_dropdown}
    Click Element    ${search_button}
    Wait Until Element Is Visible    ${emulate_link}  timeout=30
    Sleep    2
    Click Element    ${emulate_link}
    Sleep    5

Navigate To Manage Cart And Search Booking
    [Arguments]  ${generated_booking_data}
    Sleep    2
    Wait Until Element Is Visible    ${dashboard_link}    10s
    Click Element    ${dashboard_link}
    Navigate To Manage Cart Section
    Input Text    ${input_booking_id}    ${generated_booking_data.booking_id}
    Sleep    2
    Click Element    ${date_close_button}
    Sleep    2
    Click Element    ${date_close_button}
    Sleep    2
    Click Element    ${search_button}
    Execute Javascript  window.scrollTo(0,200)
    Sleep    2s
    Wait Until Element Is Visible    ${first_booking_id}  timeout=30

Click The Booking And Proceed The Payment
    Click Element    ${first_booking_id}
    Wait Until Page Contains    Booking Details
    Execute Javascript  window.scrollTo(0,-200)
    Wait Until Element Is Visible    ${more_option_link}
    Click Element    ${more_option_link}
    Wait Until Page Contains Element  ${pay_now_button_link}  timeout=30
    Click Element    ${pay_now_button_link}
    Verify Terms And Conditions Check Box On Payment Page
    Wait Until Page Contains Element  ${pay_now_button}  timeout=30
    Click Pay Now Button
    Wait Until Element Is Visible    ${continue_button}    timeout=30s
    Click Button    ${continue_button}
    Wait Until Page Contains Element    ${booking_status_pending}  timeout=60

Verify The Payment And New Booking Details
    #    [Arguments]  ${booking_details}
    Click Element    ${first_booking_id}
    Wait Until Page Contains    Booking Details
    Execute Javascript  window.scrollTo(0,600)
    Sleep    2
    Scroll Element Into View    ${expand_arrow}
    Sleep    2
    Click Element    ${expand_arrow}
    Wait Until Page Contains Element    ${success_text}
    ${payment_medium}    Get Text    ${payment_medium_value}
    Set Test Variable    ${payment_medium}
    #    ${new_booking_details}=  Get Booking Details
    #    Dictionaries Should Be Equal    ${booking_details}    ${new_booking_details}
    #    RETURN  ${new_booking_details}

Assign The Booking To Self
    Execute Javascript  window.scrollTo(0,-600)
    Wait Until Element Is Visible    ${assignme_icon}
    Click Element    ${assignme_icon}
    Execute Javascript  window.scrollTo(0,400)
    ${save_buttons}=  Get WebElements    ${save_button}
    FOR    ${save}    IN    @{save_buttons}
        Click Element    ${save}
        Wait Until Page Contains    Successfully Saved !    30s
    END

Verify New Booking Status
    Sleep    2
    FOR    ${temp_counter}    IN RANGE    0    5
       ${status}=  Run Keyword And Return Status        Wait Until Page Contains Element    ${status_success}  timeout=5
       IF    ${status}
            Page Should Contain Element   ${status_success}
            Exit For Loop
       ELSE
            Reload Page
       END
    END
    Wait Until Page Contains Element    ${status_success}  timeout=30

Get Flight Details And Fare Summary
    Sleep  10
    Switch Window   NEW
    ${flight_details}  Get Flight Details    ${flight_name_itinerary}  ${departure_itinerary}   ${destination_itinerary}    ${flight_duration_flight_type_review}
    ${fare_summary}  Get Fare Summary From Booking Summary Page
    RETURN  ${flight_details}  ${fare_summary}

Import Pnr Through Agent
    [Arguments]  ${booking_details}    ${search_data}
    ${my_dict}       Create Dictionary   &{search_data}
    ${Status}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${booking_details}    supplier
    IF    ${Status}

        ${supplier_name}=  Set Variable  ${booking_details.supplier}
    ELSE
        ${supplier_name}=  Set Variable  ${my_dict.supplier}
    END
    Scroll Element Into View    ${import_pnr_link}
    Wait Until Element Is Visible    ${import_pnr_link}    30s
    Click Element    ${import_pnr_link}
    Sleep    2
    Wait Until Element Is Visible    ${supplier_field}
    Click Element    ${supplier_field}
    ${supplier}    Replace String    ${select_supplier}    Supplier    ${supplier_name}
    #    Input Text    ${supplier_field}    ${supplier_name}
    #    Sleep    2
    #    Scroll Element Into View    ${airasia_source}
    Wait Until Element Is Visible    ${supplier}    10s
    Click Element    ${supplier}
    Click Element    ${supplier_field_arrow}
    #    Input Text    ${user_id_field}    111250
    #    Wait Until Element Is Visible    ${user_id_dropdown}
    #    Click Element    ${user_id_dropdown}
    Wait Until Element Is Visible    ${input_pnr_new}
    Input Text    ${input_pnr_new}    ${booking_details.gds}
    Click Element    ${import_pnr_button}
    #    Wait Until Element Is Visible    ${segment_detail_heading}  timeout=30

Click on Logout
    Click Element    ${logout_button}
    Sleep    5

Click on Generation Time
    Sleep    2s
    Wait Until Element Is Visible    ${generation_time}    10s
    Click Element    ${generation_time}
    Sleep    3s

Verify Payment Mode
    [Arguments]    ${payment_mode}
    Should Be Equal    ${payment_medium}    ${payment_mode}

Click on Continue button
    Wait Until Element Is Visible    ${continue_button}    timeout=30s
    Click Button    ${continue_button}
    Wait Until Page Contains Element    ${booking_status_pending}  timeout=60
    Wait Until Page Contains    Booking Pending    60

Get Booking ID
    ${id}  Get Text   ${booking_id_value}
    ${split_text}  Split String    ${id}  ID
    ${booking_id}  Get From List    ${split_text}  1
    ${booking_id}  Strip String    ${booking_id}
    ${generated_booking_data}  Create Dictionary  booking_id=${booking_id}
    [Return]    ${generated_booking_data}
