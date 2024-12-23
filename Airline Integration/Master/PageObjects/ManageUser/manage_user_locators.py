# Search filter
manager_user_nav_btn = "//a[text()='Manage User']"
user_id_field = "//div[text()='User ID']/../descendant::input[contains(@id,'react-select')]"
cancel_role_icon = "//label[text()='Role']/../../descendant::div[contains(@class,'css-1alnv5e')]"
role_field = "//div[text()='Role']/../descendant::input[contains(@id,'react-select')]"
status_field = "//div[text()='Status']/../descendant::input[contains(@id,'react-select')]"
distributor_id_field = "//div[text()='Distributor ID']/../descendant::input[contains(@id,'react-select')]"
search_button = "//button[text()='Search']"
select_role = "//div[contains(@id,'react-select')][1]"
select_user_id = "//div[contains(@class,'css-1lhitd')][1]"
select_status = "//div[contains(@class,'css-1lhitdy react-select__option')][1]"
user_group_field = "//div[text()='Group']"
select_user_group = "//div[text()='Group']"

# Customize feature
select_customize_checkbox = "//div[contains(text(),'replace')]/input"
customize_button = "//span[text()='Customize ']/i"
de_select_button = "//button[text()='De-select All']"
save_button = "//button[text()='Save']/i"
fund_transfer_link = "//a[text()='Fund Transfer']"
fund_transfer_heading = "//h3[text()='Fund Transfer']"
submit_button_on_fund_transfer = "//button[text()='Submit']"
search_card_user_id = "//a[contains(@href,'/manage-user/user-detail/')][1]"
search_card_user_role = "//span[text()='replace']"
search_card_user_status="//span[text()='replace']"
emulate_user_link = "//a[text()='Emulate']"
emulate_denied_text = "//span[text()='Emulate User on the same role is not allowed']"
reset_button = "//span[text()='Reset ']/i"
reset_pop_up_text = "//h4[text()='Are you Sure?']"
reset_pop_up_button = "//button[text()='Reset']"
download_button = "//span[text()='Download ']/i"
download_emp_data = "//span[@data-tooltip='EMPLOYEE_DATA']/i"
no_of_cols_in_card = "//thead[contains(@class,'theader table__tableHea')]/tr/td"
select_download_checkbox_count = "(//div[@class='draggable']/div/input)"
select_download_checkbox = "(//div[@class='draggable']/div/input)[${index}]"
download_file_button = "//button[text()='Download File']"
save_prefernces_button = "//button[text()='Save Preferences']/i"
top_bar_my_balance = "//span[text()='My Balance']"
card_total_balance = "//td[contains(@class,' click_menu-container balance')]"
user_balance_nav="(//li[@class='topbar__list'])[2]/span"
deposit_balance_text = "//ul[contains(@class,'tableDropdown')]/li[2]/p[1]"
credit_balance_text = "//ul[contains(@class,'tableDropdown')]/li[2]/p[2]"
dues_text = "//ul[contains(@class,'tableDropdown')]/li[2]/p[3]"
wallet_status_text = "//ul[contains(@class,'tableDropdown')]/li[2]/p[4]"
credit_status_text = "//ul[contains(@class,'tableDropdown')]/li[2]/p[5]"
search_card_thead_count="//thead[contains(@class,'theader')]/tr/td"
search_card_tbody_count="//tbody[contains(@class,'table')]/tr"

#  Admin Side locators
date_field_from_created_at = "//input[@id='createdOnAfterDate']"
previous_month_button = "//button[text()='Previous Month']"
date_field_to_created_at = "//input[@id='createdOnBeforeDate']"
date_field_to_created_from_cross_icon = "(//button[@class='react-datepicker__close-icon'])[1]"
clear_date_field="(//button[@class='react-datepicker__close-icon'])[1]"
clear_user_role_field = "//div[contains(@class,'react-select__clear-indicator')]"
date_field_to_created_at_cross_icon = "(//button[@class='react-datepicker__close-icon'])[2]"
group_cross_icon = "(//div[contains(@class,'css-1h4e')])[3]"
show_more_button = "//span[text()='Show More']"
email_input_field = "//input[@id='email']"
mobile_input_field = "//input[@id='mobile']"
group_input_field = "//input[@id='react-select-6-input']"
select_group = "//div[contains(@id,'react-select')][1]"
select_distributor_id = "//div[contains(@id,'react-select')][1]"
user_id_text_in_search_filter = "//label[text()='User ID']/../descendant::div[contains(@class,'css-1izgmon')]"
emulated_user_id_text = "//div[@class='col-sm-8 no-padding']/ul/li[1]"
user_id_link_on_search_card="//a[contains(text(),'replace')]"
space_before = " ("
card_user_id = '(//td[@class="generic-td "])[1]'
whitespace = " "
without_space = ""
update_btn = '//button[@class="btn sign_btn " and text()="Update"]'
billing_info_eye = '//td[@class="generic-td "]/a/i'
user_id_txt = '(//div[@class="css-1izgmon react-select__multi-value__label"])[1]'
user_balance = '(//p[@class="M_0"])[2]'
card_total_balance="//td[contains(@class,' click_menu-container balance')]"
role = '//label[text()="Role"]//following-sibling::div//child::div[@class="css-1izgmon react-select__multi-value__label"]'
number_of_users = '//h3[@class="dash-borderRadius main-heading-tableIcon"]/span'
status = '//label[text()="Status"]//following-sibling::div//child::div[@class="css-1izgmon react-select__multi-value__label"]'
amount_field_fund_transfer = '//input[@data-id="amount"]'
clear_user_role_field = "//div[contains(@class,'react-select__clear-indicator')]"
topbar_user_id = "//ul[@class='topbar']/li[1]"
add_user_button = "//a[@title='Add User']"
search_user_button = "//a[@title='Search User']"
register_user_page = "//li/span[contains(text(),'register-user')]"
company_name_field = "//input[@id='name']"
mobile_phone_field = "//input[@id='mobile']"
user_email_field = "//input[@id='email']"
user_password_field = "//input[@id='password']"
confirm_password_field = "//input[@id='confirm-password']"
role_field_register_page = "//input[@id='role']"
select_role_register_page = "//ul[@class='select-box-list select-box-list--open']/li/span[contains(text(),'role')]"
country_field = "//div[contains(text(),'Country')]"
select_country = "(//div[@role='option' and contains(text(),'country')])[1]"
state_field = "//div[contains(text(),'State')]"
select_state = "(//div[@role='option' and contains(text(),'state')])[1]"
city_field = "//div[contains(text(),'City')]"
select_city = "(//div[@role='option' and contains(text(),'city')])[1]"
address_filed = "//input[@id='address']"
pin_code_field = "//input[@id='pincode']"
submit_button = "//button[@type='submit' and contains(text(),'Submit')]"
user_detail_page = "//span[contains(text(),'User-detail')]"
user_id_on_udp = "//ol[@class='breadcrumb-arrow']/li[4]/span"
user_name_on_udp = "//input[@id='name']"
user_email_on_udp = "//input[@id='email']"
user_phone_on_udp = "//input[@id='mobile']"
user_role_on_udp = "//input[@id='role']"
select_user_role_on_udp = "//ul/li/span[contains(text(),'role')]"
user_status_on_udp = "//input[@id='status']"
update_user_details = "(//button[@type='submit' and contains(text(),'Update')])[1]"
upload_logo = "//button[@type='button' and contains(text(),'Upload')]"
select_user_status_on_udp = "//span[contains(text(),'status')]"
search_card_user_address = "//table[@id='results']/tbody/tr[1]/td[1]"
search_card_user_pincode = "//table[@id='results']/tbody/tr[1]/td[2]"
search_card_row_count = "//tbody[contains(@class,'table__body-border')]/tr"
update_user_role = "(//button[@type='submit' and contains(text(),'Update')])[2]"
address_info_link = "//a[contains(@href,'/manage-user/address-info/')]"
address_field_on_address_page = "//input[@id='address']"
country_field_on_address_page = "//div[contains(text(),'Country')]"
state_field_on_address_page = "//div[contains(text(),'State')]"
city_field_on_address_page = "//div[contains(text(),'City')]"
pincode_field_on_address_page = "//input[@id='pincode']"
update_button_on_address_page = "//button[contains(text(),'Update')]"
clear_country_field = "(//div[contains(@class,'react-select__clear-indicator')])[1]"
clear_state_field = "(//div[contains(@class,'react-select__clear-indicator')])[2]"
clear_city_field = "(//div[contains(@class,'react-select__clear-indicator')])[3]"
#Error messages
error_message_for_update_address = "You are not allowed to update fields : [addressInfo.address, addressInfo.pincode, addressInfo.cityInfo.name, addressInfo.cityInfo.state, addressInfo.cityInfo.country]"
error_message_for_invalid_data = "No Data Found!"
error_message_for_update_details = "You are not allowed to update fields : [name, email, mobile, role]"
error_message_for_email = "Given Email id already exist"
error_message_for_mobile = "Given Mobile number already exist"
error_message_for_role = "Change of role is not allowed"
error_message_for_user_status = "You are not allowed to update fields : [status]"
error_for_user_status_by_admin = "Following fields are mandatory to enable the entity : [additionalInfo.accountingCode]"
error_message_for_date = "Following fields are mandatory to access the filter : [createdOnAfterDate, createdOnBeforeDate, and days difference should be less than 45]"
user_status_update_msg="Account Details successfully saved for user"
error_message_for_role_if_empty = "Please provide user's role"