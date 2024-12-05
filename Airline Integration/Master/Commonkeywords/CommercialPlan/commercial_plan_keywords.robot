*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Variables  ../../PageObjects/Login/login_locators.py
Variables  ../../PageObjects/SearchResults/search_results_locators.py
Variables  ../../../Environment/environments.py
Variables  ../../PageObjects/CommercialPlan/commercial_plan.py
Library    OperatingSystem
Library    ../../Commonkeywords/CustomKeywords/user_keywords.py

*** Variables ***
${manage_commercial_td}=    ${CURDIR}${/}..${/}..${/}TestData${/}CommercialPlan${/}commercial_plan_data.xlsx

*** Keywords ***
#Create New Commercial Plan
#    [Arguments]    ${commercial_plan_td}
##    ${my_dict}       Create Dictionary   &{commercial_plan_td}
##    Wait Until Element Is Visible    ${add_commercial_plan_icon}    10s
##    Click Element    ${add_commercial_plan_icon}
##    Wait Until Element Is Visible    ${commercial_plan_name_input}
##    ${plan}=    Random Name
##    Set Test Variable    ${plan}
##    Input Text    ${commercial_plan_name_input}    ${plan}    #${my_dict.Commercial_plan}
##    ${commercial_rule}=    Replace String    ${select_commercial_rule_from_exclusion}    com_rule    ${my_dict.Commercial_Rule_Description}
##    Sleep    2s
#    ${Description}=    Replace String    ${get_commercial_plan_description}    Com_plan    ${my_dict.Commercial_plan}    #${plan}
#    Wait Until Element Is Visible       ${Description}    10s
#    Scroll Element Into View    ${Description}
#    ${commercial_plan1_edit}=      Replace String    ${edit_commercial_plan}    Edit     ${my_dict.Commercial_plan}    #${plan}    #
#    Wait Until Element Is Visible    ${commercial_plan1_edit}
#    Set Test Variable    ${commercial_plan_id}
#    Scroll Element Into View    ${commercial_rule}
#    Execute JavaScript    window.scrollBy(0,200)
#    Wait Until Element Is Visible       ${commercial_rule}    10s
#    Scroll Element Into View    ${commercial_rule}
#    Click Element    ${commercial_rule}
#    Click Element    ${commercial_rule_include_button}
#    Click Element    ${submit_button}
#    ${status}=    Run Keyword And Return Status    Element Should Be Visible    //span[text()='Successfully Saved !')
#    #    IF    ${status} != ${True}
#    #        Click Element    ${cancel_button}
#    #        Edit Commercial Plan    ${commercial_plan_td}
#    ##        Create New Commercial Plan    ${commercial_plan_td}
#    #    END

Get Commercial Plan Id
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    ${Description}=    Replace String    ${get_commercial_plan_description}    Com_plan    ${my_dict.Commercial_plan}    #${plan}
    Wait Until Element Is Visible       ${Description}    10s
    Scroll Element Into View    ${Description}
    ${commercial_plan1_id}=      Replace String    ${get_commercial_plan_id}    Com_plan     ${my_dict.Commercial_plan}    #${plan}
    ${commercial_plan_id}=    Get Text    ${commercial_plan1_id}
    Log    ${commercial_plan_id}
    Set Test Variable    ${commercial_plan_id}

Navigate To Commercial Plan Page
    Wait Until Element Is Visible    ${commercial_plan}
    Run Keyword And Ignore Error    Scroll Element Into View    //a[text()='Manage Inventory']
    Click Element    ${commercial_plan}
    Wait Until Element Is Visible    //p[text()='Air']    8s

Navigate To Dashboard
    Sleep    5s
    Wait Until Element Is Visible    ${dashboard_link}
    Click Element    ${dashboard_link}
    Sleep    5s

Edit Commercial Plan
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    ${Description}=    Replace String    ${get_commercial_plan_description}    Com_plan    ${my_dict.Commercial_plan}
    Run Keyword And Ignore Error    Scroll Element Into View    ${Description}
    Wait Until Element Is Visible       ${Description}    10s
    Execute Javascript      window.scroll(0,-150)
    Scroll Element Into View    ${Description}
    ${commercial_plan_edit}=      Replace String    ${edit_commercial_plan}    Com_plan     ${my_dict.Commercial_plan}
    Run Keyword And Ignore Error    Scroll Element Into View    ${commercial_plan_edit}
    Wait Until Element Is Visible    ${commercial_plan_edit}
    Click Element    ${commercial_plan_edit}
    Sleep    5s
    ${total_rules}=    SeleniumLibrary.Get Element Count    ${total_included_commercial_rule}
    Log    ${total_rules}
    Capture Page Screenshot
    FOR    ${i}    IN RANGE    ${total_rules}
       ${i}=     Evaluate    ${i}+1
       ${i}    Convert To String    ${i}
       ${commercial_rule}=    Replace String    ${select_total_commercial_rule}    index     ${i}
       Wait Until Element Is Visible    ${commercial_rule}
       Click Element    ${commercial_rule}
       Capture Page Screenshot
       Click Element    ${commercial_rule_exclude_button}
    END
    ${commercial_rule}=    Replace String    ${select_commercial_rule_from_exclusion}    com_rule    ${my_dict.Commercial_Rule_Description}
    Sleep    2s
    Scroll Element Into View    ${commercial_rule}
    Execute JavaScript    window.scrollBy(0,200)
    Wait Until Element Is Visible       ${commercial_rule}    10s
    Scroll Element Into View    ${commercial_rule}
    Click Element    ${commercial_rule}
    Click Element    ${commercial_rule_include_button}
    Sleep    4s
    Wait Until Element Is Visible        ${submit_button}
    Click Element    ${submit_button}

Navigate To Manage User Page
    Run Keyword And Ignore Error    Scroll Element Into View    //a[text()='Import Booking']
    Wait Until Element Is Visible    ${manage_user}
    Scroll Element Into View    ${manage_user}
    Click Element    ${manage_user}
    Wait Until Element Is Visible    //div[contains(@class,'css-ievs3x react-select__val')]    8s

Emulate Agent
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    #    Navigate Back To Manage User Dashboard
    IF  "${my_dict.User_id}" != "Null"
       Wait Until Element Is Visible    ${user_id_field}    10s
       Input Text    ${user_id_field}    ${my_dict.User_id}
       Sleep    3s
       Click Element    ${select_user_id}
    END
    Wait Until Element Is Visible    ${search_button}    10s
    Click Element    ${search_button}
    Sleep    3s
    Click Element    ${reset_button}
    Click Button    ${reset_pop_up_button}
    Wait Until Element Is Visible    ${emulate_user_link}    10s
    Click Element    ${emulate_user_link}
    Sleep    2s
    Page Should Contain Element    ${dashboard_nav_btn}

Click On User Id On Manage User To Config Agent
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Navigate To Manage User Page
    IF  "${my_dict.User_id}" != "Null"
       Wait Until Element Is Visible    ${user_id_field}    10s
       Input Text    ${user_id_field}    ${my_dict.User_id}
       Sleep    2s
       Click Element    ${select_user_id}
    END
    Wait Until Element Is Visible    ${search_button}    10s
    Click Element    ${search_button}
    Sleep    2s
    Click Element    ${reset_button}
    Click Button    ${reset_pop_up_button}
    Wait Until Element Is Visible    ${user_id_link_to_config}
    Click Element    ${user_id_link_to_config}

Navigate TO User Config
    Wait Until Element Is Visible    ${user_config_link}
    Click Element    ${user_config_link}
    Wait Until Element Is Visible    ${update_commercial_plan_icon}


Config Commercial Plan For Agent
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Create and Update Commercial Plan    ${commercial_plan_td}
    #    Create Sales Relationship    ${commercial_plan_td}
    #    Create New User Policy    ${commercial_plan_td}
    #    Add Manage Product Access    ${commercial_plan_td}
    #    Navigate Back To Manage User Dashboard


Create and Update Commercial Plan
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Cancel Previous Plan If Present
    ${i}=    Set Variable    1
    ${j}=    Set Variable    2
    ${k}=    Set Variable    1
    IF    "${my_dict.Domestic_Product}" != "Null"
       Click Element    ${update_commercial_plan_icon}
       ${i}=    Convert To String    ${i}
       ${j}=    Convert To String    ${j}
       ${k}=    Convert To String    ${k}
       ${product}=    Replace String    ${product_field}    index    ${i}
       Wait Until Element Is Visible    ${product}
       Click Element    ${product}
       Capture Page Screenshot
       ${domestic_product}=    Replace String    ${select_domestic_product}    index     ${k}
       Click Element    ${domestic_product}
       ${plan1}=    Replace String    ${commercial_plan_field}    index    ${j}
       Wait Until Element Is Visible    ${plan1}
       Click Element    ${plan1}
       ${commercial_plan}=    Replace String    ${select_commercial_plan}    index        ${j}
       ${commercial_plan}=    Replace String    ${commercial_plan}    commercial        ${my_dict.Commercial_plan}    #${plan}
       Wait Until Element Is Visible    ${commercial_plan}
       Click Element    ${commercial_plan}
       ${i}=    Evaluate    ${i}+2
       ${j}=    Evaluate    ${j}+2
       ${k}=    Evaluate    ${k}+1
    END
    Sleep    1s
    IF    "${my_dict.International_Product}" != "Null"
       Click Element    ${update_commercial_plan_icon}
       ${i}=    Convert To String    ${i}
       ${j}=    Convert To String    ${j}
       ${k}=    Convert To String    ${k}
       ${product}=    Replace String    ${product_field}    index    ${i}
       Wait Until Element Is Visible    ${product}
       Execute JavaScript    window.scrollBy(0,200)
       Click Element    ${product}
    #        Capture Page Screenshot
       ${international_product}=    Replace String    ${select_international_product}    index     ${k}
       Click Element    ${international_product}
       ${plan1}=    Replace String    ${commercial_plan_field}    index    ${j}
       Wait Until Element Is Visible    ${plan1}
       Click Element    ${plan1}
       ${commercial_plan}=    Replace String    ${select_commercial_plan}    index        ${j}
       ${commercial_plan}=    Replace String    ${commercial_plan}    commercial        ${my_dict.Commercial_plan}    #${plan}
       Wait Until Element Is Visible    ${commercial_plan}
       Click Element    ${commercial_plan}
       ${i}=    Evaluate    ${j}+2
       ${j}=    Evaluate    ${j}+2
    END
    Scroll Element Into View        ${update_plan_button}
    Click Element    ${update_plan_button}
    Wait Until Element Is Visible    //span[text()='Successfully Saved !']
    Sleep    5s

Navigate Back To Manage User Dashboard
    Execute JavaScript    window.scrollBy(0,-1400)
    Wait Until Element Is Visible    ${manage_user_on_user_config}
    Click Element    ${manage_user_on_user_config}
    Wait Until Element Is Visible    //div[contains(@class,'css-ievs3x react-select__val')]    8s

Add Manage Product Access
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Wait Until Element Is Visible    ${remove_product_access_icon}
    Click Element    ${remove_product_access_icon}
    Click Element    ${product_input_field}
    Click Element    ${select_product_input_for_air}
    Click Element    //h3[text()='Manage Product Access']
    Click Element    ${update_product_access}

Create Sales Relationship
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Click Element    ${sales_relation_icon}
    Click Element    ${user_relation_field}
    ${sales}=    Replace String    ${select_sales_user_relation}   sales    ${my_dict.User_Relation}
    Wait Until Element Is Visible    ${sales}
    Click Element    ${sales}
    Click Element    ${update_sales_relation}

Create New User Policy
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Click Element    ${assign_new_policy_link}
    Execute JavaScript    window.scrollBy(0,300)
    Sleep    1s
    Click Element    ${credit_policy_field}
    Capture Page Screenshot
    Sleep    1s
    ${policy}=    Replace String    ${select_credit_policy}    credit_policy    ${my_dict.Credit_policy}
    Click Element    ${policy}
    Sleep    3s
    Click Element    ${search_policy_button}
    Sleep    3s
    Click Element    ${submit_policy}

Verify Commercial rule For Oneway Trip
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Reload Page
    Wait Until Element Is Visible    ${id_i_button}    40s
    Capture Page Screenshot
    Sleep    10s
    Click Element    ${id_i_button}
    Wait Until Element Is Visible    ${commercial_id_text}
    ${commercial_id_searchpage}     Get Text    ${commercial_id_text}
    Log    ${commercial_id_searchpage}
    Should Be Equal    ${commercial_id_searchpage}      ${commercial1_rule_id}

Verify BCM On Search Page
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Wait Until Element Is Visible    ${id_i_button}
    Sleep    1
    Click Element    ${id_i_button}
    ${BCM}=    Get Text    ${bcm_id_text}
    ${search_date}    Split String   ${BCM}
    ${BCM_searchPage}   Convert To String    ${search_date}[2]
    Should Be Equal    ${BCM_searchPage}    ${my_dict.}

Verify PLB on Search Page
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Wait Until Element Is Visible    ${id_i_button}
    Sleep    1
    Click Element    ${id_i_button}
    ${PLB}=    Get Text    ${plb_id_text}
    ${search_date}    Split String   ${PLB}
    ${PLB_searchpage}   Convert To String    ${search_date}[2]
    Should Be Equal    ${PLB_searchpage}    ${my_dict.PLB}

Verify Segment Money On Search Page
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Wait Until Element Is Visible    ${id_i_button}
    Sleep    1
    Click Element    ${id_i_button}
    ${sm}=    Get Text    ${sm_id_text}
    ${search_date}    Split String   ${sm}
    ${sm_searchpage}   Convert To String    ${search_date}[2]
    Should Be Equal    ${sm_searchpage}    ${my_dict.}

Verify Meal Comission
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}

Get Comission On Flight Itinerary
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Wait Until Element Is Visible    ${amount_to_pay_dragdown_icon}
    Click Element    ${amount_to_pay_dragdown_icon}   # ${commission_on_flight_itinerary}
    Capture Page Screenshot
    ${commission}=    Get Text    ${commission_text}
    ${split_commission}=    Split String    ${commission}
    Log    ${split_commission}
    ${commission_on_itinerary}=    extract_digits_after_rupee    ${commission}
    Set Test Variable    ${commission_on_itinerary}

Cancel Previous Plan If Present
    Capture Page Screenshot
    FOR    ${i}    IN RANGE    1     4
       ${status}=    Run Keyword And Return Status    Element Should Be Visible    ${remove_commercial_plan_icon}
       IF    "${status}" == "${True}"
           Click Element    ${remove_commercial_plan_icon}
       ELSE
           Exit For Loop
       END
    END
    Capture Page Screenshot

Get and Verify Commission For Meal
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Wait Until Element Is Visible    ${amount_to_pay_dragdown_icon}
    Click Element    ${amount_to_pay_dragdown_icon}   # ${commission_on_flight_itinerary}
    ${commission}=    Get Text    ${commission_text}
    ${split_commission}=    Split String    ${commission}
    Log    ${split_commission}
    ${commission_on_pax}=    extract_digits_after_rupee    ${commission}
    ${meal_commission}=    Evaluate    ${commission_on_pax}-${commission_on_itinerary}
    Should Be Equal    ${meal_commission}    ${my_dict.Meal_commission}

Get and Verify Commission For Baggage
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Wait Until Element Is Visible    ${amount_to_pay_dragdown_icon}
    Click Element    ${amount_to_pay_dragdown_icon}   # ${commission_on_flight_itinerary}
    ${commission}=    Get Text    ${commission_text}
    ${split_commission}=    Split String    ${commission}
    Log    ${split_commission}
    ${commission_on_pax}=    extract_digits_after_rupee    ${commission}
    ${baggage_commission}=    Evaluate    ${commission_on_pax}-${commission_on_itinerary}
    Should Be Equal    ${meal_commission}    ${my_dict.Baggage_commission}

Get and Verify Commission For Seat
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Wait Until Element Is Visible    ${amount_to_pay_dragdown_icon}    10s
    Click Element    ${amount_to_pay_dragdown_icon}   # ${commission_on_flight_itinerary}
    Capture Page Screenshot
    ${commission}=    Get Text    ${commission_text}
    ${split_commission}=    Split String    ${commission}
    Log    ${split_commission}
    ${commission_on_pax}=    extract_digits_after_rupee    ${commission}
    ${seat_commission}=    Evaluate    ${commission_on_pax}-${commission_on_itinerary}
    Should Be Equal    ${seat_commission}    ${my_dict.Seat_commission}

Create New Commercial Plan
    [Arguments]    ${commercial_plan_td}
    ${my_dict}       Create Dictionary   &{commercial_plan_td}
    Edit Commercial Plan    ${commercial_plan_td}
 