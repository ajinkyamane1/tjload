commercial_plan="//a[text()='Commercial Plan']"
dashboard_link='//a[contains(text(),"Dashboard")]'
manage_user="//a[text()='Manage User']"
manage_user_on_user_config="//a[text()='Manage-user']"
add_commercial_plan_icon="//a[@title='Add commercial plan']"
commercial_plan_name_input="//fieldset[@class='floating-label']/input"
select_commercial_rule_from_exclusion="//div[@class='inner_box exclusion']/descendant::li[text()='com_rule']"
commercial_rule_include_button="//div[@class='button_box']/button[text()='Include']"
submit_button="//button[text()='Submit ']"
cancel_button="//button[text()='Cancel ']"
commercial_rule_exclude_button="//div[@class='button_box']/button[text()='Exclude']"

# Get Commercial Plan Locators
get_commercial_plan_description="//tbody[@class='table__body-list-font']/tr/td[text()='Com_plan']"
get_commercial_plan_id="(//tbody[@class='table__body-list-font']/tr/td[text()='Com_plan']//preceding-sibling::td)[2]"
#
edit_commercial_plan="//tbody[@class='table__body-list-font']/tr/td[text()='Com_plan']//../td[5]/a/span[text()='Edit']"
copy_commercial_plan="//tbody[@class='table__body-list-font']/tr/td[text()='Com_plan']//../td[5]/a/span[text()='Copy']"

# Manage user to emulate agent
user_id_field = "//div[text()='User ID']/../descendant::input[contains(@id,'react-select')]"
select_user_id = "//div[contains(@class,'css-1lhitd')][1]"
search_button = "//button[text()='Search']"
reset_button = "//span[text()='Reset ']/i"
reset_pop_up_text = "//h4[text()='Are you Sure?']"
reset_pop_up_button = "//button[text()='Reset']"
emulate_user_link = "//a[text()='Emulate']"
user_id_link_to_config="(//tbody/tr/td/a)[1]"
user_config_link="//a[text()='User Config']"
update_commercial_plan_icon="(//div[@class='text-right'][1]/button[@class='addmore_gemeric-btn']/i)[1]"
# (//div[@class='text-right'])[index]/button/i
product_field="(//select[@class='input-floating-lebel'])[index]"
select_domestic_product="(//select[1]/option[text()='AIR Domestic'])[index]"
select_international_product="(//select[1]/option[text()='AIR International'])[index]"
commercial_plan_field="(//select[@class='input-floating-lebel'])[index]"    #//select[@id='commPlanMap_0']"
select_commercial_plan="(//div[@class='compplanConfig--container'])[1]/descendant::select[index]/option[text()='commercial']"
# //select[@id='commPlanMap_0']/option[text()='Indexnine']
update_plan_button="(//button[text()='Update'])[2]"
# manage_user_link_on_user_config="//a[text()='Manage-user']"

distributor_field="//div[@class='select-box']/input"
select_distributors="//ul[contains(@class,'select-box-')]/li/span[text()='distributor']"
# //ul[contains(@class,'select-box-')]/li/span[text()='Distributor']
allow_private_fare_checkbox="//label[text()='Allow Private Fare']"
allow_di_checkbox="//label[text()='Allow DI']"
update_user_setting="(//button[text()='Update'])[1]"

#
sales_relation_icon="(//div[@class='text-right'][1]/button[@class='addmore_gemeric-btn']/i)[2]"
user_relation_field="//select[@id='relatedUserId_0']"
select_sales_user_relation="//select[@id='relatedUserId_0']/option[text()='sales']"
# //select[@id='relatedUserId_0']/option[text()='Sales One']
update_sales_relation="(//button[text()='Update'])[3]"

#
assign_new_policy_link="//button[text()='+ Assign new policy']"
credit_policy_field="//input[@id='policyId']"
select_credit_policy="(//ul[contains(@class,'select-box-list')])[2]/li/span[text()='credit_policy']"
# (//ul[contains(@class,'select-box-list')])[2]/li/span[text()='maxLimit test']
search_policy_button="//button[text()='Search']"
submit_policy="//button[text()='Submit']"

# Manage Product Access
# product_input_field="//div[@class='css-1g6gooi']/div/input"
product_input_field="//div[@class='css-311063 react-select__control react-select__control--is-focused']"
select_product_input_for_air="//div[@class='css-15k3avv react-select__menu']/div/div[text()='AIR']"
update_product_access="(//button[text()='Update'])[4]"
remove_product_access_icon="//div[@class='css-1alnv5e react-select__multi-value__remove']"

#  search page
id_i_button = "//span[@class='fa fa-info-circle edit-icon-tiles']"
commercial_id_text="//span[text()='Commercial Id']/../../descendant::a"
bcm_id_text="//div[@class='airlineInfo__footerContainer']/span/span[contains(text(),'BCM')]"
plb_id_text="//div[@class='airlineInfo__footerContainer']/span/span[contains(text(),'PLB')]"
sm_id_text="//div[@class='airlineInfo__footerContainer']/span/span[contains(text(),'SM')]"

# Locators on pax details page
commission_text="//span[text()='Commission']/../span[2]"
amount_to_pay_dragdown_icon="//div[contains(@class,'bold-f')]/i"
remove_commercial_plan_icon="(//div[@class='text-right'][1]/button[@class='remove-btn-generic']/i)[1]"

#
total_included_commercial_rule="//div[@class='inner_box inclusion']/ul/li"
select_total_commercial_rule="//div[@class='inner_box inclusion']/ul/li[index]"