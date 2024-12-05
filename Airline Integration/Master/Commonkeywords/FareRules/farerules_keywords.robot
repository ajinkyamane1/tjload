*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../Commonkeywords/CustomKeywords/user_keywords.py
Variables    ../../PageObjects/FareRules/farerules_locators.py
Variables    ../../PageObjects/SearchResults/search_results_locators.py

*** Keywords ***
Add Fare Rule For Mandatory Fields
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Execute JavaScript    window.scrollBy(0,-400)
    Wait Until Element Is Visible    ${add_fare_rule_icon}
    Click Element    ${add_fare_rule_icon}
    Wait Until Element Is Enabled    ${fare_description}    timeout=15s
    Run Keyword If    '${my_dict.Description}'!='empty'   Input Text    ${fare_description}    ${my_dict.Description}
    Run Keyword If    '${my_dict.Priority}'!='empty'   Input Text    ${fare_priority}    ${my_dict.Priority}
    Wait Until Element Is Enabled    ${fare_select_air_type}
    Click Element        ${fare_select_air_type}
    ${air_type}   Convert To Upper Case    ${my_dict.AirType}
    Wait Until Element Is Visible    //option[@data-option-id='${air_type}']
    Click Element    //option[@data-option-id='${air_type}']
    Run Keyword If    '${my_dict.Airline}'!='empty'  Input Text    ${airline_input_field}    ${my_dict.Airline}
    Wait Until Element Is Visible    ${airline_dropdown_list}     timeout=15s
    Click Element    ${airline_dropdown_option}
    Wait Until Element Is Enabled    ${fare_enabled_checkbox}
    Select Checkbox    ${fare_enabled_checkbox}
    ${input_airline_value}    Get Text    ${input_airline}
    Log    ${input_airline_value}
    Set Test Variable    ${input_airline_value}
    Execute JavaScript    window.scrollBy(0,400)
    Wait Until Element Is Enabled    ${fare_user_ids}
    Input Text    ${fare_user_ids}    ${my_dict.UserIds}
    Click Element    ${add_cancellation_button}
    Wait Until Element Is Enabled    ${cancellation_amount}
    Run Keyword If    '${my_dict.CancellationAmount}'!='empty'    Input Text    ${cancellation_amount}    ${my_dict.CancellationAmount}
    Run Keyword If    '${my_dict.CancellationAmount}'!='empty'    Input Text    ${cancellation_additional_fee}    ${my_dict.CancellationAdditionalFee}
    Run Keyword If    '${my_dict.CancellationAmount}'!='empty'    Input Text    ${cancellation_from}    ${my_dict.CancellationFrom}
    Run Keyword If    '${my_dict.CancellationAmount}'!='empty'    Input Text    ${cancellation_to}    ${my_dict.CancellationTo}
    Run Keyword If    '${my_dict.CancellationAmount}'!='empty'    Input Text    ${cancellation_policy_info}    ${my_dict.CancellationPolicyInfo}
    Click Element    ${add_date_change_button}
    Wait Until Element Is Enabled    ${date_change_amount}
    Run Keyword If    '${my_dict.DateChangeAmount}'!='empty'    Input Text    ${date_change_amount}    ${my_dict.DateChangeAmount}
    Run Keyword If    '${my_dict.DateChangeAmount}'!='empty'    Input Text    ${date_change_additional_fee}    ${my_dict.DateChangeAdditionalFees}
    Run Keyword If    '${my_dict.DateChangeAmount}'!='empty'    Input Text    ${date_change_from}    ${my_dict.DateChangeFrom}
    Run Keyword If    '${my_dict.DateChangeAmount}'!='empty'    Input Text    ${date_change_to}    ${my_dict.DateChangeTo}
    Run Keyword If    '${my_dict.DateChangeAmount}'!='empty'    Input Text    ${date_change_policy_info}    ${my_dict.DateChangePolicyInfo}

Add Fare Rule For Seat Chargeable
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Click Element    ${add_seat_chargeable_button}
    Wait Until Element Is Enabled    ${add_seat_chargeable_button}
    Input Text    ${seat_chargeable_amount}    ${my_dict.SeatChargeableAmount}
    Input Text    ${seat_chargeable_additional_fee}   ${my_dict.SeatChargeableAdditionalFee}
    Input Text    ${seat_chargeable_from}    ${my_dict.SeatChargeableFrom}
    Input Text    ${seat_chargeable_to}     ${my_dict.SeatChargeableTo}
    Input Text    ${seat_chargeable_policy_info}   ${my_dict.SeatChargeablePolicyInfo}

Add Fare Rule For No Show
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Click Element    ${add_no_show_button}
    Wait Until Element Is Enabled    ${add_no_show_button}
    Input Text    ${no_show_amount}    ${my_dict.NoShowAmount}
    Input Text    ${no_show_additional_fee}  ${my_dict.NoShowAdditionalFee}
    Input Text    ${no_show_from}    ${my_dict.NoShowFrom}
    Input Text    ${no_show_to}    ${my_dict.NoShowTo}
    Input Text    ${no_show_policy_info}  ${my_dict.NoShowPolicyInfo}

Add Baggage Fare Rule
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Input Text    ${adult_handbaggage_field}    ${my_dict.AdultHandBaggage}
    Input Text    ${child_handbaggage_field}    ${my_dict.ChildHandBaggage}
    Input Text    ${infant_handbaggage_field}   ${my_dict.InfantHandBaggage}
    Input Text    ${adult_checkin_field}    ${my_dict.AdultCheckInBaggage}
    Input Text    ${child_checkin_field}    ${my_dict.ChildCheckInBaggage}
    Input Text    ${infant_checkin_field}   ${my_dict.InfantCheckInBaggage}
    
Click on Fare Rule Search Button
    ${indexing}    Set Variable    0
    Wait Until Element Is Enabled    ${fare_rule_search_button}
    ${status}    Run Keyword And Return Status    Wait Until Page Contains    rows found !
    WHILE   ${status}==False
         IF    ${indexing}<3
             Click Element    ${fare_rule_search_button}
             ${status}    Run Keyword And Return Status    Wait Until Page Contains    rows found !
         ELSE
             BREAK
         END
         ${indexing}    Evaluate    ${indexing} + 1
    END

Add Fare Rule For Meal Indicator
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Scroll Element Into View    ${select_meal_indicator}
    Click Element    ${select_meal_indicator}
    ${status}  Run Keyword And Return Status    Should Be Equal As Strings    ${my_dict.MealIndicator}   Yes
    IF   ${status}
            Wait Until Element Is Visible    ${true_option}
            Click Element    ${true_option}
    ELSE
        Wait Until Element Is Visible    ${false_option}
        Click Element    ${false_option}
    END

Add Fare Rule For Baggage Indicator
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Scroll Element Into View    ${hand_baggage_indicator}
    Click Element    ${hand_baggage_indicator}
    ${status}  Run Keyword And Return Status    Should Be Equal As Strings    ${my_dict.BaggageIndicator}   Yes
    IF   ${status}
            Wait Until Element Is Visible    ${true_option}
            Click Element    ${true_option}
    ELSE
        Wait Until Element Is Visible    ${false_option}
        Click Element    ${false_option}
    END

Add Fare Rule For Refundable
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Scroll Element Into View    ${select_refundable_type}
    Click Element    ${select_refundable_type}
    ${status}  Run Keyword And Return Status    Should Be Equal As Strings    ${my_dict.RefundableType}   Refundable
    ${status_non_refundable}  Run Keyword And Return Status    Should Be Equal As Strings    ${my_dict.RefundableType}   Non-Refundable
    IF   ${status}
            Wait Until Element Is Visible    ${refundable_text}
            Click Element    ${refundable_text}
    ELSE IF   ${status_non_refundable}
        Wait Until Element Is Visible    ${non_refundable_text}
        Click Element    ${non_refundable_text}
    ELSE
        Wait Until Element Is Visible    ${partial_refundable_text}
        Click Element    ${partial_refundable_text}
    END

Add Fare Rule For Travel Period Inclusion/Exclusion
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Scroll Element Into View    ${add_travel_period_button}
    Click Element    ${add_travel_period_button}
    Click Element    ${travel_period_from}
    ${current_date}    Get Text    ${current_date_text}
    Double Click Element   ${next_month_button}
    Click Element    //div[contains(@class,'react-datepicker__day') and text()='${my_dict.Date}']
    Click Element    //li[text()='${my_dict.InclusionFrom}']
    Click Element    ${travel_period_to}
    Execute JavaScript   document.querySelector(".react-datepicker__time-list").scrollBy(0,350)
    Wait Until Element Is Visible    //li[text()='${my_dict.InclusionTo}']
    Click Element    //li[text()='${my_dict.InclusionTo}']
    Scroll Element Into View    ${exclusion_travel_period_button}
    Click Element    ${exclusion_travel_period_button}
    Click Element    ${travel_from_exclusion}
    ${current_date}    Get Text    ${current_date_text}
    Double Click Element   ${next_month_button}
    Click Element    //div[contains(@class,'react-datepicker__day') and text()='${my_dict.Date}']
    Execute JavaScript   document.querySelector(".react-datepicker__time-list").scrollBy(0, 350)
    Scroll Element Into View    //li[text()='${my_dict.ExclusionFrom}']
    Click Element    //li[text()='${my_dict.ExclusionFrom}']
    Click Element    ${travel_to_exclusion}
    Execute JavaScript   document.querySelector(".react-datepicker__time-list").scrollBy(0, 850)
    Scroll Element Into View    //li[text()='${my_dict.ExclusionTo}']
    Click Element    //li[text()='${my_dict.ExclusionTo}']

Add Fare Rule For Booking Period Inclusion/Exclusion
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Scroll Element Into View    ${add_booking_period_button}
    Click Element    ${add_booking_period_button}
    Click Element    ${booking_period_from}
    ${current_date}    Get Text    ${current_date_text}
    Double Click Element   ${next_month_button}
    Click Element    //div[text()='${current_date}' and not(contains(@class,'react-datepicker__day--outside-month'))]
    Click Element    //li[text()='${my_dict.InclusionFrom}']
    Click Element    ${booking_period_to}
    Execute JavaScript   document.querySelector(".react-datepicker__time-list").scrollBy(0,350)
    Wait Until Element Is Visible    //li[text()='${my_dict.InclusionTo}']
    Click Element    //li[text()='${my_dict.InclusionTo}']
    Scroll Element Into View    ${exclusion_booking_period_button}
    Click Element    ${exclusion_booking_period_button}
    Click Element    ${booking_from_exclusion}
    ${current_date}    Get Text    ${current_date_text}
    Double Click Element   ${next_month_button}
    Click Element    //div[text()='${current_date}' and not(contains(@class,'react-datepicker__day--outside-month'))]
    Execute JavaScript   document.querySelector(".react-datepicker__time-list").scrollBy(0, 350)
    Scroll Element Into View    //li[text()='${my_dict.ExclusionFrom}']
    Click Element    //li[text()='${my_dict.ExclusionFrom}']
    Click Element    ${booking_to_exclusion}
    Execute JavaScript   document.querySelector(".react-datepicker__time-list").scrollBy(0, 850)
    Scroll Element Into View    //li[text()='${my_dict.ExclusionTo}']
    Click Element    //li[text()='${my_dict.ExclusionTo}']

Add Fare Rule For Sector Inclusion/Exclusion
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Input Text    ${sector_inclusion_field}    ${my_dict.SectorInclusion}
    Input Text    ${sector_exclusion_field}    ${my_dict.SectorExclusion}

Add Fare Rule For Fare Type Inclusion/Exclusion
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Scroll Element Into View    ${fare_type_inclusion_field}
    Click Element    ${fare_types_inclusion_select}
    Input Text    ${fare_type_inclusion_field}   ${my_dict.InclusionFareType}
    Wait Until Element Is Visible    ${fare_type_option}
    Click Element    ${fare_type_option}
    Click Element    ${fare_types_exclusion_select}
    Input Text    ${fare_type_exclusion_field}    ${my_dict.ExclusionFareType}
    Wait Until Element Is Visible    ${fare_type_option}
    Click Element    ${fare_type_option}

Add Fare Rule For Inclusion/Exclusion Of Source
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Wait Until Element Is Visible    ${source_inclusion_select}
    Click Element    ${source_inclusion_select}
    Input Text    ${source_inclusion_field}        ${my_dict.SourceInclusion}
    Wait Until Element Is Visible    ${source_option}
    Click Element    ${source_option}
    Wait Until Element Is Visible    ${source_exclusion_select}
    Click Element    ${source_exclusion_select}
    Input Text    ${source_exclusion_field}       ${my_dict.SourceExclusion}
    Wait Until Element Is Visible    ${source_option}
    Click Element    ${source_option}

    
Verify Fare Rule For Inclusion/Exclusion Of Fare Type
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Scroll Element Into View    //span[text()='${my_dict.InclusionFareType}']/ancestor::li[contains(@class,'tile__element')]/descendant::span[@class='fa fa-info-circle edit-icon-tiles']
    Wait Until Element Is Visible    //span[text()='${my_dict.InclusionFareType}']/ancestor::li[contains(@class,'tile__element')]/descendant::span[@class='fa fa-info-circle edit-icon-tiles']
    Click Element    //span[text()='${my_dict.InclusionFareType}']/ancestor::li[contains(@class,'tile__element')]/descendant::span[@class='fa fa-info-circle edit-icon-tiles']
    Sleep    1
    Wait Until Element Is Visible    ${fare_rule_id_text}
    ${fare_rule_id_searchpage}     Get Text    ${fare_rule_id_text}
    Should Be Equal    ${fare_rule_id}      ${fare_rule_id_searchpage}
    Sleep    1
    Click Element    //span[text()='${my_dict.ExclusionFareType}']/ancestor::li[contains(@class,'tile__element')]/descendant::span[@class='fa fa-info-circle edit-icon-tiles']
    Wait Until Element Is Visible    //span[text()='${my_dict.ExclusionFareType}']/ancestor::li[contains(@class,'tile__element')]/descendant::span[@class='fa fa-info-circle edit-icon-tiles']
    Click Element    //span[text()='${my_dict.ExclusionFareType}']/ancestor::li[contains(@class,'tile__element')]/descendant::span[@class='fa fa-info-circle edit-icon-tiles']
    Sleep    1
    ${fare_rule_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${fare_rule_id_text}
    IF    ${fare_rule_status}
         ${fare_rule_id_searchpage}     Get Text    ${fare_rule_id_text}
         Should Not Be Equal    ${fare_rule_id}      ${fare_rule_id_searchpage}
    END
    ${status}  Run Keyword And Return Status    Element Should Be Visible    ${airline_info}
    Run Keyword If  ${status}=='True'    Click Element    ${airline_info}

Click On Submit Fare Rule Button
    Scroll Element Into View      ${fare_rule_submit_button}
    Wait Until Element Is Visible   ${fare_rule_submit_button}
    Click Element    ${fare_rule_submit_button}

Get Fare Rule ID Using Fare Description
    [Arguments]    ${fare_rules_data}
    Click On Fare Rule Search Button
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Wait Until Element Is Visible    (//td[text()='${my_dict.Description}']/following-sibling::td)[11]      timeout=10
    Scroll Element Into View    (//td[text()='${my_dict.Description}']/following-sibling::td)[11]
    ${fare_rule_id}     Get Text     (//td[text()='${my_dict.Description}']/following-sibling::td)[11]
    Set Global Variable    ${fare_rule_id}

Click On Fare Rule Menu
    Wait Until Element Is Visible    ${fare_rule_menu}
    Execute JavaScript    window.document.getElementById(id="bs-sidebar-collapse-1").scrollBy(0,800);
    Click Element    ${fare_rule_menu}
    Sleep    2s

Create New Fare Rule
    Wait Until Page Contains Element    ${create_rule_icon}    timeout=20
    Click Element    ${create_rule_icon}

Verify Airline Field Should Not Be Left Empty
    [Arguments]    ${fare_data}
    ${mydict}=    Create Dictionary    &{fare_data}
    Input Text    ${fare_description}    ${mydict.Description}
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Click Button    ${fare_rule_submit_button}
    Page Should Contain    Airline can not be blank.

Verify Error message For Empty Priority Field
    Clear Element Text    ${fare_priority_filed}
    ${entered_priority}   Get Value    ${fare_priority_filed}
    Log   ${entered_priority}
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Click Button    ${fare_rule_submit_button}
    Sleep    1s
    Capture Page Screenshot
    Wait Until Page Contains    Priority can not be blank.


Verify Error message For Empty Cancellation Field
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Click Button    ${fare_rule_submit_button}
    Wait Until Page Contains     fareRuleInformation.fareRuleInfo : Both amount and policy info cannot be left empty for cancellation in fare rule

Verify Error Message For Empty Date Change Field
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Click Button    ${fare_rule_submit_button}
    Wait Until Page Contains     fareRuleInformation.fareRuleInfo : Both amount and policy info cannot be left empty for date change in fare rule

Verify Cancellation Fare Rule Information Should Not Be Empty
    [Arguments]    ${fare_data}
    ${mydict}=    Create Dictionary    &{fare_data}
    Input Text    ${fare_description}    ${mydict.Description}
    Select From List By Value    ${fare_select_air_type}    ${mydict.AirType}
    Input Text    ${select_airline_input}    ${mydict.Airline}
    Sleep    4
    Click Element    ${select_airline}   ENTER
    Input Text    ${fare_priority}    ${mydict.priority}
    Click Element    ${fare_enabled_checkbox}
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Click Element    ${add_date_change_button}
    Input Text    ${date_change_amount}    ${mydict.date_change_amount}
    Input Text    ${date_change_to}    ${mydict.date_change_to}
    Input Text    ${date_change_policy_info}    ${mydict.date_change_policy_info}
    Click Button    ${fare_rule_submit_button}
    Sleep    2
    Wait Until Page Contains     fareRuleInformation.fareRuleInfo : Both amount and policy info cannot be left empty for cancellation in fare rule

Verify Date Change Fare Rule Information Should Not Be Empty
    [Arguments]    ${fare_data}
    ${mydict}=    Create Dictionary    &{fare_data}
    Input Text    ${fare_description}    ${mydict.Description}
    Select From List By Value    ${fare_select_air_type}    ${mydict.AirType}
    Input Text    ${select_airline_input}    ${mydict.Airline}
    Sleep    4
    Click Element    ${select_airline}   ENTER
    Click Element    ${select_airline}
    Input Text    ${fare_priority}    ${mydict.priority}
    Click Element    ${fare_enabled_checkbox}
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Click Element    ${add_cancellation_button}
    Input Text    ${cancellation_amount}     ${mydict.cancellation_amount}
    Input Text    ${cancellation_to}    ${mydict.cancellation_to}
    Input Text    ${cancellation_policy_info}    ${mydict.policy_info}
    Click Button    ${fare_rule_submit_button}
    Sleep    4
    Page Should Contain    fareRuleInformation.fareRuleInfo : Both amount and policy info cannot be left empty for date change in fare rule

Verify Fare Rule Can Be Deleted
    [Arguments]    ${fare_data}
    ${mydict}=    Create Dictionary    &{fare_data}
    Scroll Element Into View    //tbody//tr/td[text()="${mydict.Description}"]/following-sibling::td[12]
    ${get_id}    Get Text    //tbody//tr/td[text()="${mydict.Description}"]/following-sibling::td[12]
    Click Element    //td[@title='${get_id}']/preceding-sibling::td/descendant::i[contains(@class,'fa-trash')]
    Click Button    ${delete_button}
    Wait Until Page Contains    Successfully Deleted !    timeout=10
    Wait Until Element Is Visible    ${hide_show_button}    timeout=10
    Click Element    ${hide_show_button}
    Page Should Not Contain Element    ${get_id}

Verify Already Created Fare Rule Can Be Enabled
    [Arguments]    ${fare_data}
    ${mydict}=    Create Dictionary    &{fare_data}
    ${id_get}=    Get Text    ${enable_checked_box}
    Click Element    //td[@title='${id_get}']/preceding-sibling::td/descendant::input[@type='checkbox' and not(@checked)]
    Wait Until Page Contains    Successfully Saved !
    Click Element    ${status_field}
    ${status}=    Replace Variables    (//div[@class="form__field form__field--one-third"])[3]//descendant::ul//li//child::span[text()="${mydict.Status}"]
    Click Element    ${status}
    Click On Fare Rule Search Button
    Page Should Contain    ${id_get}

Verify Already Created Fare Rule Can Be Disabled
    [Arguments]    ${fare_data}
    ${mydict}=    Create Dictionary    &{fare_data}
    ${id_get}=    Get Text    ${enable_checked_box}
    Click Element    //td[@title='${id_get}']/preceding-sibling::td/descendant::input[@type='checkbox'][@checked]
    Wait Until Page Contains    Successfully Saved !
    Execute JavaScript    window.scrollBy(0, -150);
    Click Element    ${status_field}
    ${status}=    Replace Variables    (//div[@class="form__field form__field--one-third"])[3]//descendant::ul//li//child::span[text()="${mydict.Status}"]
    Click Element    ${status}
    Click On Fare Rule Search Button
    Page Should Contain    ${id_get}

Verify Row Count For The Displayed Search Result
    Click Element    ${hide_show_button}
    ${expected_count}=   SeleniumLibrary.Get Element Count    ${display_table}
    ${element_text}=    Get Text    ${display_rows_count}
    ${expected_count_str}=    Convert To String    ${expected_count}
    Should Contain    ${element_text}    ${expected_count_str}

Verify Maximize Button On Fare Rule Page
    Click Element    ${full_screen_table}
    Wait Until Element Is Not Visible    ${full_screen_table}

Verify The Fare Rule With All/Enabled/Disabled status
    [Arguments]    ${fare_data}
    ${mydict}=    Create Dictionary    &{fare_data}
    Click Element    ${status_field}
    ${status}=    Replace Variables    (//div[@class="form__field form__field--one-third"])[3]//descendant::ul//li//child::span[text()="${mydict.Status}"]
    Click Element    ${status}
    Click On Fare Rule Search Button
    Click Element    ${hide_show_button}
    IF   "${mydict.Status}"=="Enabled"
       Page Should Contain Element    ${checked_checkbox}
    ELSE IF   "${mydict.Status}"=="Disabled"
       Page Should Contain Element    ${unchecked_box}
    ELSE
        Page Should Contain Element    ${checked_checkbox}
        Page Should Contain Element    ${unchecked_box}
    END

Verify The Search Filter For Air Type - All/International/Domestic
    [Arguments]    ${fare_data}
    ${mydict}=    Create Dictionary    &{fare_data}
    @{air_types}=  Create List  All  International  Domestic
    Click Element    ${search_air_type}
    ${air_type_uppercase}        Convert To Upper Case    ${mydict.AirType}
    ${air_type}=    Replace Variables    (//div[@class="form__field form__field--one-third"])[1]//descendant::ul//li[@data-option-id="${air_type_uppercase}"]
    ${air_type}=    Replace Variables    (//div[@class="form__field form__field--one-third"])[1]//descendant::ul//li[@data-option-id="${air_type_uppercase}"]//span
    Sleep    1
    Click Element    ${air_type}
    Click On Fare Rule Search Button
    Click Element    ${hide_show_button}
    IF    "${mydict.AirType}"=="ALL"
        FOR    ${air_type}    IN    @{air_types}
           ${verify_airtype}=    Replace Variables    //table[@class='table credit-card__container-content-details']//tbody//tr//td[1][@title = "@{air_types}"]
           ${element_present}=   Run Keyword And Return Status    Element Should Be Visible    ${verify_airtype}
           Run Keyword If  ${element_present}  Log  "${air_type} is present in the table"  ELSE  Log  "${air_type} is not present in the table"
        END
    ELSE IF  "${mydict.AirType}"=="DOMESTIC"
        ${verify_airtype}=    Replace Variables    //table[@class='table credit-card__container-content-details']//tbody//tr//td[1][@title = "${mydict.AirType}"]
        ${element_present}=    Run Keyword And Return Status    Element Should Be Visible    ${verify_airtype}
        Run Keyword If  ${element_present}  Log  "${air_type} is present in the table"  ELSE  Log  "${air_type} is not present in the table"
    ELSE
        ${verify_airtype}=    Replace Variables    //table[@class='table credit-card__container-content-details']//tbody//tr//td[1][@title = "${mydict.AirType}"]
        ${element_present}=    Run Keyword And Return Status    Element Should Be Visible    ${verify_airtype}
        Run Keyword If  ${element_present}  Log  "${air_type} is present in the table"  ELSE  Log  "${air_type} is not present in the table"
    END

Delete Fare Rule For High Priority
    Click On Fare Rule Search Button
    Sleep    2
    ${priority_delete_icon_count}    SeleniumLibrary.Get Element Count    ${delete_icon_for_priority_value}
    Log    ${priority_delete_icon_count}
    WHILE    ${priority_delete_icon_count} > 0
          Sleep    3
          Run Keyword And Ignore Error    Scroll Element Into View    ${delete_icon_for_priority_value}
          Run Keyword And Ignore Error    Click Element    ${delete_icon_for_priority_value}
          Run Keyword And Ignore Error    Wait Until Element Is Visible    ${delete_button}
          Run Keyword And Ignore Error    Click Button    ${delete_button}
          ${priority_delete_icon_count}    Evaluate    ${priority_delete_icon_count}- 1
          Log    ${priority_delete_icon_count}
    END
    Sleep    3s

Delete Fare Rule By Description
    [Arguments]    ${fare_data}
    ${mydict}=    Create Dictionary    &{fare_data}
    Click On Fare Rule Search Button
    Sleep    2
    ${description_delete_icon_count}    SeleniumLibrary.Get Element Count    //td[text()='${my_dict.Description}']/following-sibling::td/descendant::i[contains(@class,'fa fa-trash')]
     WHILE    ${description_delete_icon_count} > 0
              Sleep    3
              Run Keyword And Ignore Error    Scroll Element Into View    //td[text()='${my_dict.Description}']/following-sibling::td/descendant::i[contains(@class,'fa fa-trash')]
              Run Keyword And Ignore Error    Click Element    //td[text()='${my_dict.Description}']/following-sibling::td/descendant::i[contains(@class,'fa fa-trash')]
              Run Keyword And Ignore Error    Wait Until Element Is Visible    ${delete_button}
              Run Keyword And Ignore Error    Click Button    ${delete_button}
              ${description_delete_icon_count}    Evaluate    ${description_delete_icon_count}- 1
     END
     Sleep    3s

Switch Back And Go To Fare Rule
    Sleep    2s
    Execute JavaScript    window.scrollBy(0,-500)
    Sleep    2s
    Wait Until Element Is Visible    ${switch_back_button}
    Click Element    ${switch_back_button}
    Click On Fare Rule Menu

Enable/Disable Fare Rule By ID
    Click On Fare Rule Search Button
    Wait Until Element Is Visible    //td[text()='${fare_rule_id}']/preceding-sibling::td/input
    Click Element    //td[text()='${fare_rule_id}']/preceding-sibling::td/input

Delete Fare Rule By ID
    Click On Fare Rule Search Button
    Wait Until Element Is Visible    //td[text()='${fare_rule_id}']/preceding-sibling::td/descendant::i[contains(@class,'fa fa-trash')]
    Click Element    //td[text()='${fare_rule_id}']/preceding-sibling::td/descendant::i[contains(@class,'fa fa-trash')]
    Wait Until Element Is Visible    ${delete_button}
    Click Element    ${delete_button}

Verify Fare Rule Search For Selected Airline
    Wait Until Element Is Visible    //div[text()='Airline']/../descendant::input
    Input Text    //div[text()='Airline']/../descendant::input    Indigo
    Wait Until Element Is Visible    //div[@role='option']
    Click Element        //div[@role='option']
    Click Element    ${fare_rule_search_button}
    ${airline_code}    Get Text    //div[contains(@class,'react-select__single-value')]
    Wait Until Element Is Visible    //td[2][@class='ellipses']
    Execute Javascript    window.scrollBy(0,600)
    ${farerule_airlines}    Get Webelements    //td[5][@class='ellipses']
    FOR    ${airline_name}    IN    @{farerule_airlines}
        ${airline_name}  Get Text    ${airline_name}
        Should Be Equal As Strings    ${airline_code}    ${airline_name}
    END

Verify Meal Indicator On Search Page
    [Arguments]    ${fare_data}
    ${mydict}=    Create Dictionary    &{fare_data}
    ${status}  Run Keyword And Return Status    Should Be Equal As Strings    ${my_dict.MealIndicator}   Yes
    IF   ${status}
        Wait Until Element Is Visible    ${meal_indicator_text}
        ${meal_indicators}    Get Webelements    ${meal_indicator_text}
        FOR    ${indicator_text}    IN    @{meal_indicators}
            ${indicator_text}  Get Text    ${indicator_text}
            Should Contain    ${indicator_text}    Free Meal
        END
    ELSE
        Wait Until Element Is Visible    ${meal_indicator_text}
        ${meal_indicators}    Get Webelements    ${meal_indicator_text}
        FOR    ${indicator_text}    IN    @{meal_indicators}
            ${indicator_text}  Get Text    ${indicator_text}
            Should Not Contain    ${indicator_text}    Free Meal
        END
    END

Verify Hand Baggage Indicator On Search Page
    [Arguments]    ${fare_data}
    ${mydict}=    Create Dictionary    &{fare_data}
    ${status}  Run Keyword And Return Status    Should Be Equal As Strings    ${my_dict.BaggageIndicator}   Yes
    IF   ${status}
        Wait Until Element Is Visible    ${hand_baggage_indicator_text}
        ${hand_baggage_indicators}    Get Webelements    ${hand_baggage_indicator_text}
        FOR    ${indicator_text}    IN    @{hand_baggage_indicators}
            ${indicator_text}  Get Text    ${indicator_text}
            Should Contain    ${indicator_text}    Handbaggage Fare
        END
    ELSE
        Wait Until Element Is Visible    ${hand_baggage_indicator_text}
        ${hand_baggage_indicators}    Get Webelements    ${hand_baggage_indicator_text}
        FOR    ${indicator_text}    IN    @{hand_baggage_indicators}
            ${indicator_text}  Get Text    ${indicator_text}
            Should Not Contain    ${indicator_text}    Handbaggage Fare
        END
    END
    Click Element    ${book_button}
    Wait Until Page Contains    You have selected Hand baggage fare
    Click Element    ${continue_btn}

Verify Refundable Indicator On Search Page
    [Arguments]    ${fare_data}
    ${mydict}=    Create Dictionary    &{fare_data}
    ${status}  Run Keyword And Return Status    Should Be Equal As Strings    ${my_dict.RefundableType}   Refundable
    ${status_non_refundable}  Run Keyword And Return Status    Should Be Equal As Strings    ${my_dict.RefundableType}   Non-Refundable
    IF   ${status}
        Wait Until Element Is Visible    ${refundable_indicator}
        ${hand_baggage_indicators}    Get Webelements    ${refundable_indicator}
        FOR    ${indicator_text}    IN    @{hand_baggage_indicators}
            ${indicator_text}  Get Text    ${indicator_text}
            Should Contain    ${indicator_text}    Refundable
        END
    ELSE IF   ${status_non_refundable}
        Wait Until Element Is Visible    ${non_refundable_indicator}
        ${hand_baggage_indicators}    Get Webelements    ${non_refundable_indicator}
        FOR    ${indicator_text}    IN    @{hand_baggage_indicators}
            ${indicator_text}  Get Text    ${indicator_text}
            Should Contain    ${indicator_text}    Non Refundable
        END
    ELSE
        Wait Until Element Is Visible    ${refundable_indicator}
        ${hand_baggage_indicators}    Get Webelements    ${refundable_indicator}
        FOR    ${indicator_text}    IN    @{hand_baggage_indicators}
            ${indicator_text}  Get Text    ${indicator_text}
            Should Contain    ${indicator_text}    Partial Refundable
        END
    END

Verify Created Fare Rule
    [Arguments]    ${fare_rules_data}
    Wait Until Element Is Enabled    ${fare_rule_search_button}
    Double Click Element    ${fare_rule_search_button}
    Click On Fare Rule Search Button
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Wait Until Element Is Visible    (//td[text()='${my_dict.Description}']/following-sibling::td)[11]      timeout=10
    Scroll Element Into View    (//td[text()='${my_dict.Description}']/following-sibling::td)[11]
    ${fare_rule_id}     Get Text     (//td[text()='${my_dict.Description}']/following-sibling::td)[11]
    Set Global Variable    ${fare_rule_id}
    Log    ${fare_rule_id}
    ${fare_rule_air_type}    Get Text    (//td[text()='${my_dict.Description}']/preceding-sibling::td)[1]
    Should Be Equal    ${fare_rule_air_type}    ${my_dict.AirType}
    ${search_card_fare_rule_description}    Get Text   (//td[text()='${my_dict.Description}'])
    Should Be Equal    ${search_card_fare_rule_description}    ${my_dict.Description}
    ${search_card_fare_rule_priority}    Get Text    (//td[text()='${my_dict.Description}']/preceding-sibling::td)[6]
    ${search_card_fare_rule_priority}    Convert To Integer    ${search_card_fare_rule_priority}
    Should Be Equal    ${search_card_fare_rule_priority}    ${my_dict.Priority}
    ${search_card_fare_rule_airline}    Get Text    (//td[text()='${my_dict.Description}']/preceding-sibling::td)[5]
    Should Be Equal    ${search_card_fare_rule_airline}    ${input_airline_value}
    ${search_card_fare_rule_user_id}    Get Text    //td[text()='${my_dict.Description}']//following::span[5]
    ${search_card_fare_rule_user_id}    Extract Fare Rule User Id    ${search_card_fare_rule_user_id}
    Capture Page Screenshot
    ${search_card_fare_rule_user_id}    Convert To Integer    ${search_card_fare_rule_user_id}
    Should Be Equal    ${search_card_fare_rule_user_id}    ${my_dict.UserIds}


Verify Air Type Is All Using Fare Description
    [Arguments]    ${fare_rules_data}
    Click On Fare Rule Search Button
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Wait Until Element Is Visible    (//td[text()='${my_dict.Description}']/following-sibling::td)[11]      timeout=10
    Scroll Element Into View    (//td[text()='${my_dict.Description}']/following-sibling::td)[11]
    ${fare_rule_id}     Get Text     (//td[text()='${my_dict.Description}']/following-sibling::td)[11]
    Set Global Variable    ${fare_rule_id}
    Log    ${fare_rule_id}
    ${fare_rule_air_type}    Get Text    (//td[text()='${my_dict.Description}']/preceding-sibling::td)[1]
    Should Be Equal    ${fare_rule_air_type}    ${my_dict.AirType}

Verify Air Type Is Domestic Using Fare Description
    [Arguments]    ${fare_rules_data}
    Click On Fare Rule Search Button
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Wait Until Element Is Visible    (//td[text()='${my_dict.Description}']/following-sibling::td)[11]      timeout=10
    Scroll Element Into View    (//td[text()='${my_dict.Description}']/following-sibling::td)[11]
    ${fare_rule_air_type}    Get Text    (//td[text()='${my_dict.Description}']/preceding-sibling::td)[1]
    Should Be Equal    ${fare_rule_air_type}    ${my_dict.AirType}

Verify Air Type Is International Using Fare Description
    [Arguments]    ${fare_rules_data}
    Click On Fare Rule Search Button
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Wait Until Element Is Visible    (//td[text()='${my_dict.Description}']/following-sibling::td)[11]      timeout=10
    Scroll Element Into View    (//td[text()='${my_dict.Description}']/following-sibling::td)[11]
    ${fare_rule_air_type}    Get Text    (//td[text()='${my_dict.Description}']/preceding-sibling::td)[1]
    Should Be Equal    ${fare_rule_air_type}    ${my_dict.AirType}

Verify Air Type Is Soto Using Fare Description
    [Arguments]    ${fare_rules_data}
    Click On Fare Rule Search Button
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Wait Until Element Is Visible    (//td[text()='${my_dict.Description}']/following-sibling::td)[11]      timeout=10
    Scroll Element Into View    (//td[text()='${my_dict.Description}']/following-sibling::td)[11]
    ${fare_rule_air_type}    Get Text    (//td[text()='${my_dict.Description}']/preceding-sibling::td)[1]
    Should Be Equal    ${fare_rule_air_type}    ${my_dict.AirType}

Verify Fare Rule Details For Every Created Fare Rule Are Not Displayed When Eye Icon Is In Closed/Open State
    Click Element    ${fare_rule_eye_icon}
    Page Should Not Contain Element    Inclusion Criteria
    Page Should Not Contain Element    CheckedIn Baggage
    Click Element    ${fare_rule_eye_icon}
    Wait Until Page Contains    CheckedIn Baggage    10
    Page Should Contain    CheckedIn Baggage
    Page Should Contain    Hand Baggage

Verify Created Fare Rule Can Be Edited
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Wait Until Element Is Visible    (//td[text()='${my_dict.Description}']/following::span)[1]      timeout=10
    Scroll Element Into View   (//td[text()='${my_dict.Description}']/following::span)[1]
    Click Element    (//td[text()='${my_dict.Description}']/following::span)[1]

Edit And Verify The Fare Rule
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Wait Until Element Is Enabled    ${fare_description}    timeout=15s
    Input Text    ${fare_description}    ${my_dict.Description}
    Execute JavaScript    window.scrollBy(0,400)
    Input Text    ${cancellation_amount}    ${my_dict.CancellationAmount}
    Input Text    ${cancellation_additional_fee}    ${my_dict.CancellationAdditionalFee}
    Input Text    ${date_change_amount}    ${my_dict.DateChangeAmount}
    Input Text    ${date_change_additional_fee}    ${my_dict.DateChangeAdditionalFees}
    Click On Submit Fare Rule Button
    Click On Fare Rule Search Button
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Wait Until Element Is Visible    (//td[text()='${my_dict.Description}']/following-sibling::td)[11]      timeout=10
    Scroll Element Into View    (//td[text()='${my_dict.Description}']/following-sibling::td)[11]
    ${search_card_fare_rule_description}    Get Text   (//td[text()='${my_dict.Description}'])
    Should Be Equal    ${search_card_fare_rule_description}    ${my_dict.Description}

Verify Fare Rule Id For Exclusion
    [Arguments]    ${fare_rules_data}       ${search_data}
    ${my_dict}    Create Dictionary   &{fare_rules_data}
    ${my_dict1}    Create Dictionary   &{search_data}
    Wait Until Element Is Visible    ${fare_id_i_button}
    Sleep    1
    Click Element    ${fare_id_i_button}
    Wait Until Element Is Visible    ${fare_rule_id_text}
    ${fare_rule_id_searchpage}     Get Text    ${fare_rule_id_text}
    IF    '${my_dict1.ReturnDate}' != 'Null'
          Click Element    //i[@class='fa fa-share-alt']/following::span[@class='fa fa-info-circle edit-icon-tiles']
          Wait Until Element Is Visible    (${fare_rule_id_text})[2]
          ${fare_rule_id_roundtrip}     Get Text    (${fare_rule_id_text})[2]
          Should Be Equal    ${fare_rule_id}      ${fare_rule_id_roundtrip}
    END
    Should Not Be Equal    ${fare_rule_id}      ${fare_rule_id_searchpage}
    Sleep    1
    Click Element    (${fare_id_i_button})[1]
    ${status}  Run Keyword And Return Status    Element Should Be Visible    //button[@class='airlineInfo__headerButton']
    Run Keyword If  ${status}=='True'    Click Element    //button[@class='airlineInfo__headerButton']

Verify Description Field Should Not Be Left Empty
    [Arguments]    ${fare_data}
    ${mydict}=    Create Dictionary    &{fare_data}
    Select From List By Value    ${fare_select_air_type}    ${mydict.AirType}
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Click Button    ${fare_rule_submit_button}
    Page Should Contain    Description can not be blank.

Add Fare Rule User ID For Exclusion
    [Arguments]    ${fare_rules_data}
    ${my_dict}=    Create Dictionary   &{fare_rules_data}
    Wait Until Element Is Enabled    ${exclusion_fare_user_id}
    Input Text    ${exclusion_fare_user_id}    ${my_dict.ExclusionUserId}

Verify Error Message For Travel Period Date
   Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
   Click Button    ${fare_rule_submit_button}
   Wait Until Page Contains    End time can not be less then start time

Verify Fare Rule Is Not Applied
    [Arguments]    ${fare_rules_data}
    ${my_dict}    Create Dictionary   &{fare_rules_data}
    Wait Until Element Is Visible    ${fare_id_i_button}
    Sleep    1
    Click Element    ${fare_id_i_button}
    ${fare_rule_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${fare_rule_id_text}
    IF    ${fare_rule_status}
         ${fare_rule_id_searchpage}     Get Text    ${fare_rule_id_text}
         Should Not Be Equal    ${fare_rule_id}      ${fare_rule_id_searchpage}
    END
    ${status}  Run Keyword And Return Status    Element Should Be Visible    //button[@class='airlineInfo__headerButton']
    Run Keyword If  ${status}=='True'    Click Element    //button[@class='airlineInfo__headerButton']
