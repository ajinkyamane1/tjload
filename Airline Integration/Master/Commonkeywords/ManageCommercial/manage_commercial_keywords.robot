*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Variables  ../../PageObjects/Login/login_locators.py
Variables  ../../../Environment/environments.py
Variables  ../../PageObjects/ManageCommercial/manage_commercial.py
Library    OperatingSystem
Library    ../../Commonkeywords/CustomKeywords/user_keywords.py

*** Keywords ***
Create New Commercial Rule
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    Set Test Variable    ${my_dict}
    Wait Until Element Is Visible    ${add_new_commercial_icon}
    Click Element    ${add_new_commercial_icon}
    Select Mandatory Field       ${manageuser_td}
    Select Inclusion Criteria For Commercial Plan     ${manageuser_td}
    Select Exclusion Criteria For Commercial Plan    ${manageuser_td}
    Select Commercial Info    ${manageuser_td}
    Click Element    ${submit_button}
    Capture Page Screenshot

Get Commercial Rule Id
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    Wait Until Element Is Visible    ${search_button_rule}    10s
    Click Element    ${search_button_rule}
    #    Search Filter    ${manageuser_td}
    Get Commercial Rule ID Using Rule Description    ${manageuser_td}

Search Filter
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    Wait Until Element Is Visible    ${title_commercial}
    IF  "${my_dict.Airline}" != "Null"
       Wait Until Element Is Visible    ${airline_input_field}
       Input Text    ${airline_input_field}    ${my_dict.Airline}
       Wait Until Element Is Visible    ${select_airline}    10s
       Click Element    ${select_airline}
    END
    IF  "${my_dict.Status}" != "Null"
       Wait Until Element Is Visible    ${status_input_field}
       Input Text    ${status_input_field}    ${my_dict.Status}
       Wait Until Element Is Visible    ${select_status}    10s
       Click Element    ${select_status}
    END
    Wait Until Element Is Visible    ${search_button_rule}    10s
    Click Element    ${search_button_rule}

Select Mandatory Field
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    IF  "${my_dict.Commercial_Rule_Description}" != "Null"
       Wait Until Element Is Visible    ${description_input_field}
       Input Text    ${description_input_field}    ${my_dict.Commercial_Rule_Description}
    END
    Execute JavaScript    window.scrollBy(0,-300)
    IF  "${my_dict.Priority}" != "Null"
       Wait Until Element Is Visible    ${priority_input_field}
       Input Text    ${priority_input_field}    ${my_dict.Priority}
    END
    IF  "${my_dict.Airtype}" != "Null"
       Click Element    ${air_type_field}
       ${airtype}=    Replace String    ${select_air_type}    airtype    ${my_dict.Airtype}
       Wait Until Element Is Visible    ${airtype}    10s
       Click Element    ${airtype}
    END
    IF  "${my_dict.SearchType}" != "Null"
    #        Wait Until Element Is Visible    ${search_type_field}
       Click Element    ${search_type_field}
       ${searchtype}=    Replace String    ${select_search_type}    searchtype    ${my_dict.SearchType}
       Wait Until Element Is Visible    ${searchtype}    10s
       Click Element    ${searchtype}
    END
    IF  "${my_dict.AirlineType}" != "Null"
       Wait Until Element Is Visible    ${airline_input_field_to_create_plan}
       Input Text    ${airline_input_field_to_create_plan}    ${my_dict.AirlineType}
       ${airline}=    Replace String    ${select_airline_to_create_commercial}    airline    ${my_dict.AirlineType}
       Wait Until Element Is Visible    ${airline}    5
       Click Element    ${airline}
    END
    Click Element    ${select_enabled_checkbox}
    Scroll Element Into View    ${show_more_button}
    Click Element    ${show_more_button}

Select Inclusion Criteria For Commercial Plan
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    IF    "${my_dict.FromTravelPeriod_Inclusion}" != "Null"
       Click Element    ${inclusion_travel_period_icon}
       Click Element    ${inclusion_from_travel_period_input}
       Input Travel Period From Date using testdata modified version     ${my_dict.FromTravelPeriod_Inclusion}
       IF    "${my_dict.TimeFromTravelPeriod_Inclusion}" != "Null"
           Input Time Using testdata     ${my_dict.TimeFromTravelPeriod_Inclusion}
       END
    END
    IF    "${my_dict.ToTravelPeriod_Inclusion}" != "Null"
       Click Element    ${inclusion_to_travel_period_input}
       Input Travel Period To Date Using Testdata Modified Version Current Date    ${my_dict.ToTravelPeriod_Inclusion}    ${my_dict.FromTravelPeriod_Inclusion}
       IF    "${my_dict.TimeToTravelPeriod_Inclusion}" != "Null"
           Input Time Using testdata     ${my_dict.TimeToTravelPeriod_Inclusion}
       END
    END
    IF    "${my_dict.FromBookingPeriod_Inclusion}" != "Null"
       Click Element    ${inclusion_booking_period_icon}
       Click Element    ${inclusion_from_booking_period_input}
       Input Booking Period Date using testdata modified version     ${my_dict.FromBookingPeriod_Inclusion}    ${my_dict.FromBookingPeriod_Inclusion}
       IF    "${my_dict.TimeFromBookingPeriod_Inclusion}" != "Null"
           Input Time Using testdata     ${my_dict.TimeFromBookingPeriod_Inclusion}
       END
    END
    IF    "${my_dict.ToBookingPeriod_Inclusion}" != "Null"
       Click Element    ${inclusion_to_booking_period_input}
       Input Booking Period Date using testdata modified version     ${my_dict.ToBookingPeriod_Inclusion}    ${my_dict.FromBookingPeriod_Inclusion}
       IF    "${my_dict.TimeToBookingPeriod_Inclusion}" != "Null"
           Input Time Using testdata     ${my_dict.TimeToBookingPeriod_Inclusion}
       END
    END
    Click Element    //td[text()='Flight Numbers']
    IF  "${my_dict.FlightNumbers_Inclusion}" != "Null"
       Input Text    ${flight_numbers_inclusive_input_field}    ${my_dict.FlightNumbers_Inclusion}
    END
    IF  "${my_dict.SupplierIds_Inclusion}" != "Null"
       Input Text    ${flight_numbers_inclusive_input_field}    ${my_dict.SupplierIds_Inclusion}
       Click Element    ${select_supplier_ids}
    END
    IF  "${my_dict.Sector_Inclusion}" != "Null"
       Input Text    ${sector_inclusive_input_field}    ${my_dict.Sector_Inclusion}
    END
    IF  "${my_dict.Destinations_Inclusion}" != "Null"
       Input Text    ${destination_inclusive_input_field}    ${my_dict.Destinations_Inclusion}
    END
    IF  "${my_dict.Airlines_Inclusion}" != "Null"
       Input Text    ${airlines_inclusive_input_field}    ${my_dict.Airlines_Inclusion}
    END
    IF  "${my_dict.FareBasis_Inclusion}" != "Null"
       Input Text    ${fare_basis_inclusive_input_field}    ${my_dict.FareBasis_Inclusion}
    END
    IF  "${my_dict.BookingClass_Inclusion}" != "Null"
       Input Text    ${booking_class_inclusive_input_field}    ${my_dict.BookingClass_Inclusion}
    END
    IF  "${my_dict.OperatingCarrier_Inclusion}" != "Null"
       Input Text    ${operating_carrier_inclusive_input_field}    ${my_dict.OperatingCarrier_Inclusion}
    END
    IF  "${my_dict.PrivateAccountCode_Inclusion}" != "Null"
       Input Text    ${private_account_code_inclusive_input_field}    ${my_dict.PrivateAccountCode_Inclusion}
    END
    IF  "${my_dict.UserId_Inclusion}" != "Null"
       Input Text    ${user_id_inclusive_input_field}    ${my_dict.UserId_Inclusion}
#       Wait Until Element Is Visible    ${select_user_id_inclusion}    10s   # QA env
#       Click Element    ${select_user_id_inclusion}        #QA env
    END
    IF  "${my_dict.PaxTypes_Inclusion}" != "Null"
       Input Text    ${pax_type_inclusive_input_field}    ${my_dict.PaxTypes_Inclusion}
       Wait Until Element Is Visible    ${select_pax_type}    10s
       Click Element    ${select_pax_type}
    END
    IF  "${my_dict.PriceRange_Inclusion}" != "Null"
       Input Text    ${private_account_code_inclusive_input_field}    ${my_dict.PriceRange_Inclusion}
    END
    IF  "${my_dict.CabinClasses_Inclusion}" != "Null"
       Input Text    ${cabin_classes_inclusive_input_field}    ${my_dict.CabinClasses_Inclusion}
       Wait Until Element Is Visible    ${select_cabin_classes}    10s
       Click Element    ${select_cabin_classes}
    END
    IF  "${my_dict.AllowDaysOfWeek_Inclusion}" != "Null"
       Input Text    ${allow_days_of_week_inclusive_input_field}    ${my_dict.AllowDaysOfWeek_Inclusion}
       Wait Until Element Is Visible    ${select_allow_days}    10s
       Click Element    ${select_allow_days}
    END
    IF  "${my_dict.Source_Inclusion}" != "Null"
       Input Text    ${source_inclusive_input_field}    ${my_dict.Source_Inclusion}
       Wait Until Element Is Visible    ${select_source}    10s
       Click Element    ${select_source}
    END
    IF  "${my_dict.FareTypes_Inclusion}" != "Null"
       Input Text    ${fare_type_inclusive_input_field}    ${my_dict.FareTypes_Inclusion}
       Wait Until Element Is Visible    ${select_fare_type}    10s
       Click Element    ${select_fare_type}
    END


Select Exclusion Criteria For Commercial Plan
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    Sleep    2s
    Execute JavaScript    window.scrollBy(0,-900)
    Sleep    1s
    IF    "${my_dict.FromTravelPeriod_Exclusion}" != "Null"
       Click Element    ${exclusion_travel_period_icon}
       Click Element    ${exclusion_from_travel_period_input}
       Input Travel Period From Date using testdata modified version     ${my_dict.FromTravelPeriod_Exclusion}
       IF    "${my_dict.TimeFromTravelPeriod_Exclusion}" != "Null"
           Input Time Using testdata     ${my_dict.TimeFromTravelPeriod_Exclusion}
       END
    END
    IF    "${my_dict.ToTravelPeriod_Exclusion}" != "Null"
       Click Element    ${exclusion_to_travel_period_input}
       Input Travel Period To Date Using Testdata Modified Version Current Date    ${my_dict.ToTravelPeriod_Exclusion}    ${my_dict.FromTravelPeriod_Exclusion}
       IF    "${my_dict.TimeToTravelPeriod_Exclusion}" != "Null"
           Input Time Using testdata     ${my_dict.TimeToTravelPeriod_Exclusion}
       END
    END
    IF    "${my_dict.FromBookingPeriod_Exclusion}" != "Null"
       Click Element    ${exclusion_booking_period_icon}
       Click Element    ${booking_period_exclusive_from_date_field}
       Input Travel Period From Date using testdata modified version     ${my_dict.FromBookingPeriod_Exclusion}
       IF    "${my_dict.TimeFromBookingPeriod_Exclusion}" != "Null"
           Input Time Using testdata     ${my_dict.TimeFromBookingPeriod_Exclusion}
       END
    END
    IF    "${my_dict.ToBookingPeriod_Exclusion}" != "Null"
       Click Element    ${booking_period_exclusive_to_date_field}
       Input Travel Period From Date using testdata modified version     ${my_dict.ToBookingPeriod_Exclusion}
       IF    "${my_dict.TimeToBookingPeriod_Exclusion}" != "Null"
           Input Time Using testdata     ${my_dict.TimeToBookingPeriod_Exclusion}
       END
    END
    Click Element    //td[text()='Flight Numbers']
    IF  "${my_dict.FlightNumbers_Exclusion}" != "Null"
       Input Text    ${flight_numbers_exclusive_input_field}    ${my_dict.FlightNumbers_Exclusion}
    END
    IF  "${my_dict.SupplierIds_Exclusion}" != "Null"
       Input Text    ${flight_numbers_exclusive_input_field}    ${my_dict.SupplierIds_Exclusion}
       Click Element    ${select_supplier_ids}
    END
    IF  "${my_dict.Sector_Exclusion}" != "Null"
       Input Text    ${sector_exclusive_input_field}    ${my_dict.Sector_Exclusion}
    END
    IF  "${my_dict.Destinations_Exclusion}" != "Null"
       Input Text    ${destination_exclusive_input_field}    ${my_dict.Destinations_Exclusion}
    END
    IF  "${my_dict.Airlines_Exclusion}" != "Null"
       Input Text    ${airlines_exclusive_input_field}    ${my_dict.Airlines_Exclusion}
    END
    IF  "${my_dict.FareBasis_Exclusion}" != "Null"
       Input Text    ${fare_basis_exclusive_input_field}    ${my_dict.FareBasis_Exclusion}
    END
    IF  "${my_dict.BookingClass_Exclusion}" != "Null"
       Input Text    ${booking_class_exclusive_input_field}    ${my_dict.BookingClass_Exclusion}
    END
    IF  "${my_dict.OperatingCarrier_Exclusion}" != "Null"
       Input Text    ${operating_carrier_exclusive_input_field}    ${my_dict.OperatingCarrier_Exclusion}
    END
    IF  "${my_dict.PrivateAccountCode_Exclusion}" != "Null"
       Input Text    ${private_account_code_exclusive_input_field}    ${my_dict.PrivateAccountCode_Exclusion}
    END
    IF  "${my_dict.UserId_Exclusion}" != "Null"
       Input Text    ${user_id_exclusive_input_field}    ${my_dict.UserId_Exclusion}
#       Wait Until Element Is Visible    ${select_user_id_inclusion}        # QA env
#       Click Element    ${select_user_id_inclusion}            #AQ env
    END
    IF  "${my_dict.PaxTypes_Exclusion}" != "Null"
       Input Text    ${pax_type_exclusive_input_field}    ${my_dict.PaxTypes_Exclusion}
       Wait Until Element Is Visible    ${select_pax_type}    10s
       Click Element    ${select_pax_type}
    END
    IF  "${my_dict.PriceRange_Exclusion}" != "Null"
       Input Text    ${private_account_code_exclusive_input_field}    ${my_dict.PriceRange_Exclusion}
    END
    IF  "${my_dict.CabinClasses_Exclusion}" != "Null"
       Input Text    ${cabin_classes_exclusive_input_field}    ${my_dict.CabinClasses_Exclusion}
       Wait Until Element Is Visible    ${select_cabin_classes}    10s
       Click Element    ${select_cabin_classes}
    END
    IF  "${my_dict.AllowDaysOfWeek_Exclusion}" != "Null"
       Input Text    ${allow_days_of_week_exclusive_input_field}    ${my_dict.AllowDaysOfWeek_Exclusion}
       Wait Until Element Is Visible    ${select_allow_days}    10s
       Click Element    ${select_allow_days}
    END
    IF  "${my_dict.Source_Exclusion}" != "Null"
       Input Text    ${source_exclusive_input_field}    ${my_dict.Source_Exclusion}
       Wait Until Element Is Visible    ${select_source}    10s
       Click Element    ${select_source}
    END
    IF  "${my_dict.FareTypes_Exclusion}" != "Null"
       Input Text    ${fare_type_exclusive_input_field}    ${my_dict.FareTypes_Exclusion}
       Wait Until Element Is Visible    ${select_fare_type}    10s
       Click Element    ${select_fare_type}
    END


Select Commercial Info
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    ${i}=    Set Variable    1
    ${i}=    Convert To String    ${i}
    IF    "${my_dict.IATA_Commission}" != "Null"
       ${commercial_icon}=    Replace String    ${commercial_info_plus_icon}    index    ${i}
       Wait Until Element Is Visible    ${commercial_icon}
       Click Element    ${commercial_icon}
       ${commission}=    Replace String    ${iata_commission}    index    ${i}
       Click Element    ${commission}
       ${input_field}=    Replace String    ${example_input_field}    index    ${i}
       Input Text    ${input_field}    ${my_dict.IATA_Commission}
       ${ApplicableOnInfant}=    Replace String    ${select_infant_applicable_checkox}    index    ${i}
       Click Element    ${ApplicableOnInfant}
       ${ApplicableOnall}=    Replace String    ${select_applicable_on_all_segment_checkbox}    index    ${i}
       Click Element    ${ApplicableOnall}
       ${ApplicableOnBooking}=    Replace String    ${select_applicable_on_booking}    index    ${i}
       Click Element    ${ApplicableOnBooking}
       ${i}=    Evaluate    ${i}+1
    END
    IF    "${my_dict.PLB_Commission}" != "Null"
       ${i}=    Convert To String    ${i}
       ${commercial_icon}=    Replace String    ${commercial_info_plus_icon}    index    ${i}
       Wait Until Element Is Visible    ${commercial_icon}
       Click Element    ${commercial_icon}
       ${commission}=    Replace String    ${plb_commission}    index    ${i}
       Click Element    ${commission}
       ${input_field}=    Replace String    ${example_input_field}    index    ${i}
       Input Text    ${input_field}    ${my_dict.PLB_Commission}
       ${ApplicableOnInfant}=    Replace String    ${select_infant_applicable_checkox}    index    ${i}
       Click Element    ${ApplicableOnInfant}
       ${ApplicableOnall}=    Replace String    ${select_applicable_on_all_segment_checkbox}    index    ${i}
       Click Element    ${ApplicableOnall}
       ${ApplicableOnBooking}=    Replace String    ${select_applicable_on_booking}    index    ${i}
       Click Element    ${ApplicableOnBooking}
       ${i}=    Evaluate    ${i}+1
    END
    IF    "${my_dict.SegmentMoney_Comission}" != "Null"
       ${i}=    Convert To String    ${i}
       ${commercial_icon}=    Replace String    ${commercial_info_plus_icon}    index    ${i}
       Wait Until Element Is Visible    ${commercial_icon}
       Click Element    ${commercial_icon}
       ${commission}=    Replace String    ${segment_money}    index    ${i}
       Click Element    ${commission}
       ${input_field}=    Replace String    ${example_input_field}    index    ${i}
       Input Text    ${input_field}    ${my_dict.SegmentMoney_Comission}
       ${ApplicableOnInfant}=    Replace String    ${select_infant_applicable_checkox}    index    ${i}
       Click Element    ${ApplicableOnInfant}
       ${ApplicableOnall}=    Replace String    ${select_applicable_on_all_segment_checkbox}    index    ${i}
       Click Element    ${ApplicableOnall}
       ${ApplicableOnBooking}=    Replace String    ${select_applicable_on_booking}    index    ${i}
       Click Element    ${ApplicableOnBooking}
       ${i}=    Evaluate    ${i}+1
    END
    IF    "${my_dict.Markup_comission}" != "Null"
       ${i}=    Convert To String    ${i}
       ${commercial_icon}=    Replace String    ${commercial_info_plus_icon}    index    ${i}
       Wait Until Element Is Visible    ${commercial_icon}
       Click Element    ${commercial_icon}
       ${commission}=    Replace String    ${markup_commission}    index    ${i}
       Click Element    ${commission}
       ${input_field}=    Replace String    ${example_input_field}    index    ${i}
       Input Text    ${input_field}    ${my_dict.Markup_comission}
       ${ApplicableOnInfant}=    Replace String    ${select_infant_applicable_checkox}    index    ${i}
       Click Element    ${ApplicableOnInfant}
       ${ApplicableOnall}=    Replace String    ${select_applicable_on_all_segment_checkbox}    index    ${i}
       Click Element    ${ApplicableOnall}
       ${ApplicableOnBooking}=    Replace String    ${select_applicable_on_booking}    index    ${i}
       Click Element    ${ApplicableOnBooking}
       ${i}=    Evaluate    ${i}+1
    END
    IF    "${my_dict.Seat_commission}" != "Null"
       ${i}=    Convert To String    ${i}
       ${commercial_icon}=    Replace String    ${commercial_info_plus_icon}    index    ${i}
       Wait Until Element Is Visible    ${commercial_icon}
       Click Element    ${commercial_icon}
       ${commission}=    Replace String    ${markup_commission}    index    ${i}
       Click Element    ${commission}
       ${input_field}=    Replace String    ${example_input_field}    index    ${i}
       Input Text    ${input_field}    ${my_dict.Seat_commission}
       ${ApplicableOnInfant}=    Replace String    ${select_infant_applicable_checkox}    index    ${i}
       Click Element    ${ApplicableOnInfant}
       ${ApplicableOnall}=    Replace String    ${select_applicable_on_all_segment_checkbox}    index    ${i}
       Click Element    ${ApplicableOnall}
       ${ApplicableOnBooking}=    Replace String    ${select_applicable_on_booking}    index    ${i}
       Click Element    ${ApplicableOnBooking}
       ${i}=    Evaluate    ${i}+1
    END
    IF    "${my_dict.Baggage_commission}" != "Null"
       ${i}=    Convert To String    ${i}
       ${commercial_icon}=    Replace String    ${commercial_info_plus_icon}    index    ${i}
       Wait Until Element Is Visible    ${commercial_icon}
       Click Element    ${commercial_icon}
       ${commission}=    Replace String    ${markup_commission}    index    ${i}
       Click Element    ${commission}
       ${input_field}=    Replace String    ${example_input_field}    index    ${i}
       Input Text    ${input_field}    ${my_dict.Baggage_commission}
       ${ApplicableOnInfant}=    Replace String    ${select_infant_applicable_checkox}    index    ${i}
       Click Element    ${ApplicableOnInfant}
       ${ApplicableOnall}=    Replace String    ${select_applicable_on_all_segment_checkbox}    index    ${i}
       Click Element    ${ApplicableOnall}
       ${ApplicableOnBooking}=    Replace String    ${select_applicable_on_booking}    index    ${i}
       Click Element    ${ApplicableOnBooking}
       ${i}=    Evaluate    ${i}+1
    END
    IF    "${my_dict.Meal_commission}" != "Null"
       ${i}=    Convert To String    ${i}
       ${commercial_icon}=    Replace String    ${commercial_info_plus_icon}    index    ${i}
       Wait Until Element Is Visible    ${commercial_icon}
       Click Element    ${commercial_icon}
       ${commission}=    Replace String    ${markup_commission}    index    ${i}
       Click Element    ${commission}
       ${input_field}=    Replace String    ${example_input_field}    index    ${i}
       Input Text    ${input_field}    ${my_dict.Meal_commission}
       ${ApplicableOnInfant}=    Replace String    ${select_infant_applicable_checkox}    index    ${i}
       Click Element    ${ApplicableOnInfant}
       ${ApplicableOnall}=    Replace String    ${select_applicable_on_all_segment_checkbox}    index    ${i}
       Click Element    ${ApplicableOnall}
       ${ApplicableOnBooking}=    Replace String    ${select_applicable_on_booking}    index    ${i}
       Click Element    ${ApplicableOnBooking}
       ${i}=    Evaluate    ${i}+1
    END
    IF    "${my_dict.Markup_commission}" != "Null"
       ${i}=    Convert To String    ${i}
       ${commercial_icon}=    Replace String    ${commercial_info_plus_icon}    index    ${i}
       Wait Until Element Is Visible    ${commercial_icon}
       Click Element    ${commercial_icon}
       ${commission}=    Replace String    ${markup_commission}    index    ${i}
       Click Element    ${commission}
       ${input_field}=    Replace String    ${example_input_field}    index    ${i}
       Input Text    ${input_field}    ${my_dict.Markup_commission}
       ${ApplicableOnInfant}=    Replace String    ${select_infant_applicable_checkox}    index    ${i}
       Click Element    ${ApplicableOnInfant}
       ${ApplicableOnall}=    Replace String    ${select_applicable_on_all_segment_checkbox}    index    ${i}
       Click Element    ${ApplicableOnall}
       ${ApplicableOnBooking}=    Replace String    ${select_applicable_on_booking}    index    ${i}
       Click Element    ${ApplicableOnBooking}
       ${i}=    Evaluate    ${i}+1
    END
    IF    "${my_dict.ManagementFee_commission}" != "Null"
       ${i}=    Convert To String    ${i}
       ${commercial_icon}=    Replace String    ${commercial_info_plus_icon}    index    ${i}
       Wait Until Element Is Visible    ${commercial_icon}
       Click Element    ${commercial_icon}
       ${commission}=    Replace String    ${markup_commission}    index    ${i}
       Click Element    ${commission}
       ${input_field}=    Replace String    ${example_input_field}    index    ${i}
       Input Text    ${input_field}    ${my_dict.ManagementFee_commission}
       ${ApplicableOnInfant}=    Replace String    ${select_infant_applicable_checkox}    index    ${i}
       Click Element    ${ApplicableOnInfant}
       ${ApplicableOnall}=    Replace String    ${select_applicable_on_all_segment_checkbox}    index    ${i}
       Click Element    ${ApplicableOnall}
       ${ApplicableOnBooking}=    Replace String    ${select_applicable_on_booking}    index    ${i}
       Click Element    ${ApplicableOnBooking}
       ${i}=    Evaluate    ${i}+1
    END


Input Travel Period From Date Using Testdata Modified Version
    [Arguments]     ${months_back}
    Log    ${months_back}
    Wait Until Element Is Visible    ${calendar_container}
    @{date_list}        extract_date_component       ${months_back}
    ${day}      Get From List    ${date_list}    0
    ${day}=    Convert To String    ${day}
    ${month}      Get From List    ${date_list}    1
    ${month_name}=    get_month_name    ${month}
    ${year}      Get From List    ${date_list}    2
    ${year}=    Convert To String    ${year}
    ${my_date1}      Replace String    ${select_inclusive_date}    replaceday   ${day}
    ${my_date2}      Replace String    ${my_date1}    replacemonth   ${month_name}
    ${my_from_date_final_inclusive}      Replace String    ${my_date2}    replaceyear   ${year}
    Set Test Variable    ${my_from_date_final_inclusive}
    #    ${month}=    Convert To String    ${months_back}
    ${month_button}=    compare_dates    ${months_back}
    ${month_button}=    Convert To String    ${month_button}
    FOR    ${counter}    IN RANGE    1    12
       ${status}       Run Keyword And Return Status    Wait Until Element Is Visible    ${my_from_date_final_inclusive}    1s
       IF    "${status}" == "${True}"
           Click Element    ${my_from_date_final_inclusive}
           Exit For Loop
       ELSE IF    "${month_button}" == "1"
           Click Element    ${next_month_button}
       ELSE IF    "${month_button}" == "2"
           Click Element    ${back_month_button}
       END
    END


Input Time Using Testdata
    [Arguments]     ${time_dic}
    ${time}     Replace String    ${time_to_replace}    timetoreplace    ${time_dic}
    Run Keyword And Ignore Error       Scroll Element Into View    ${time}
    Click Element    ${time}


Input Booking Period To Date Using Testdata Modified Version Current Date
    Wait Until Element Is Visible    ${calendar_container}
    @{date_list}        extract_date_component      ${months_back}
    ${day}      Get From List    ${date_list}    0
    ${day}=    Convert To String    ${day}
    ${month}      Get From List    ${date_list}    1
    ${month}=    get_month_name    ${month}
    Log    ${month}
    ${month}=    Convert To String    ${month}
    ${year}      Get From List    ${date_list}    2
    ${year}=    Convert To String    ${year}
    ${my_date1}      Replace String    ${select_inclusive_date}    replaceday   ${day}
    ${my_date2}      Replace String    ${my_date1}    replacemonth   ${month}
    ${my_from_date_final_inclusive}      Replace String    ${my_date2}    replaceyear   ${year}
    Set Test Variable    ${my_to_date_final}
    FOR    ${counter}    IN RANGE    1    12
       ${status}       Run Keyword And Return Status    Wait Until Element Is Visible    ${my_from_date_final_inclusive}    1s
       IF    "${status}" == "${True}"
           Click Element    ${my_from_date_final_inclusive}
           Exit For Loop
       ELSE
       Click Element    ${back_month_button}
       END
    END

Input Booking Period Date Using Testdata Modified Version
    [Arguments]     ${months_back}    ${FromTravelPeriod_Inclusion}
    Wait Until Element Is Visible    ${calendar_container}
    @{date_list}        extract_date_component       ${months_back}
    ${day}      Get From List    ${date_list}    0
    ${day}=    Convert To String    ${day}
    ${month}      Get From List    ${date_list}    1
    ${month}=    get_month_name    ${month}
    Log    ${month}
    ${month}=    Convert To String    ${month}
    ${year}      Get From List    ${date_list}    2
    ${year}=    Convert To String    ${year}
    ${my_date1}      Replace String    ${select_inclusive_date}    replaceday   ${day}
    ${my_date2}      Replace String    ${my_date1}    replacemonth   ${month}
    ${my_from_date_final_inclusive}      Replace String    ${my_date2}    replaceyear   ${year}
    ${month_button}=    compare_dates        ${months_back}
    ${month_button}=    Convert To String    ${month_button}
    FOR    ${counter}    IN RANGE    1    12
       ${status}       Run Keyword And Return Status    Wait Until Element Is Visible    ${my_from_date_final_inclusive}    1s
       IF    "${status}" == "${True}"
           Click Element    ${my_from_date_final_inclusive}
           Exit For Loop
       ELSE IF    "${month_button}" == "1"
           Click Element    ${next_month_button}
       ELSE IF    "${month_button}" == "2"
           Click Element    ${back_month_button}
       END
    END

Input Travel Period To Date Using Testdata Modified Version Current Date
    [Arguments]    ${months_back}    ${FromTravelPeriod_Inclusion}
    Wait Until Element Is Visible    ${calendar_container}
    @{date_list}        extract_date_component       ${months_back}
    ${day}      Get From List    ${date_list}    0
    ${day}=    Convert To String    ${day}
    ${month}      Get From List    ${date_list}    1
    ${month}=    get_month_name    ${month}
    Log    ${month}
    ${month}=    Convert To String    ${month}
    ${year}      Get From List    ${date_list}    2
    ${year}=    Convert To String    ${year}
    ${my_date1}      Replace String    ${select_inclusive_date}    replaceday   ${day}
    ${my_date2}      Replace String    ${my_date1}    replacemonth   ${month}
    ${my_from_date_final_inclusive}      Replace String    ${my_date2}    replaceyear   ${year}
    Set Test Variable    ${my_from_date_final_inclusive}
    ${month_button}=    compare_dates_for_to    ${FromTravelPeriod_Inclusion}    ${months_back}
    ${month_button}=    Convert To String    ${month_button}
    FOR    ${counter}    IN RANGE    1    12
       ${status}       Run Keyword And Return Status    Wait Until Element Is Visible    ${my_from_date_final_inclusive}    1s
       IF    "${status}" == "${True}"
           Click Element    ${my_from_date_final_inclusive}
           Exit For Loop
       ELSE IF    "${month_button}" == "1"
           Click Element    ${next_month_button}
       ELSE IF    "${month_button}" == "2"
           Click Element    ${back_month_button}
       END
    END

Get Commercial Rule ID Using Rule Description
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    Wait Until Element Is Visible    ${id_header}
    Click Element    ${id_header}
    Click Element    ${id_header}
    ${Description}=    Replace String    ${get_description}    description    ${my_dict.Commercial_Rule_Description}
    Run Keyword And Ignore Error    Scroll Element Into View    ${Description}
    Run Keyword And Ignore Error    Scroll Element Into View    ${Description}
    Wait Until Element Is Visible       ${Description}    10s
    Scroll Element Into View    ${Description}
    ${commercial_rule1_id}=      Replace String    ${commercial_rule_id}    description     ${my_dict.Commercial_Rule_Description}
    ${commercial1_rule_id}=    Get Text    ${commercial_rule1_id}
    Log    ${commercial1_rule_id}
    Set Test Variable    ${commercial1_rule_id}

Navigate To Manage Comemrcial Page
    #    Wait Until Element Is Visible    //a[text()='Manage User']
    Wait Until Element Is Visible    ${manage_commercial}
    #    Scroll Element Into View    ${manage_commercial}
    Run Keyword And Ignore Error    Scroll Element Into View    //a[text()='Air Configurator']
    Click Element    ${manage_commercial}
    Wait Until Element Is Visible    //p[text()='Air']    8s

Navigate To Dashboard
    Wait Until Element Is Visible    ${dashboard_link}
    Click Element    ${dashboard_link}
    Sleep    2s

Delete Commercial Rule If Present
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    Click Element    ${search_button_rule}
    Wait Until Element Is Visible    ${id_header}    10s
    Click Element    ${id_header}
    Click Element    ${id_header}
    ${Description}=    Replace String    ${get_description}    description    ${my_dict.Commercial_Rule_Description}
    Run Keyword And Ignore Error     Scroll Element Into View    ${Description}
    ${status}=    Run Keyword And Return Status    Element Should Contain    ${description}    ${my_dict.Commercial_Rule_Description}
    IF    "${status}" == "${True}"
       ${delete}=    Replace String    ${delete_icon}    description     ${my_dict.Commercial_Rule_Description}
       Wait Until Element Is Visible    ${delete}
       Click Element    ${delete}
       Wait Until Element Is Visible    ${delete_button}
       Click Element    ${delete_button}
    END

Verify Commercial Rule
    [Arguments]    ${manageuser_td}
    ${my_dict}       Create Dictionary   &{manageuser_td}
    Wait Until Element Is Visible    ${search_button_rule}
    Click Element    ${search_button_rule}
    #    Click Element    ${search_button_rule}
    Capture Page Screenshot
    Wait Until Element Is Visible    //thead[@class='credit_info--header-container ']    10s
    ${Description}=    Replace String    ${get_description}    description    ${my_dict.Commercial_Rule_Description}
    Run Keyword And Ignore Error     Scroll Element Into View    ${Description}
    Run Keyword And Ignore Error     Scroll Element Into View    ${Description}
    Element Should Contain    ${Description}    ${my_dict.Commercial_Rule_Description}

Open Meal Section
    Sleep    2s
    Execute Javascript    window.scrollBy(0, 500)
    ${baggage_meal_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${add_baggage_meal_section}
    Run Keyword If    ${baggage_meal_visible}    Click Element    ${add_baggage_meal_section}
