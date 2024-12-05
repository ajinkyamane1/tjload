manage_deposit_request_tab = "//a[text()='Manage Deposit Requests']"
from_date_input = '//input[@name="createdOnAfterDateTime"]'
to_date_input = '//input[@name="createdOnBeforeDateTime"]'
search_btn = '//button[normalize-space()="Search"]/i'
deposit_status_locator = "//div[text()='Deposit Status']"
deposit_status_input = "//div[@class='search__form__section__wrapper']//div[4]//input"
header_manage_deposit_tab = "//span[text()='manage-deposit-request']"
deposit_type_locator = "//div[text()='Deposit Type']"
assigned_user_locator = "//div[text()='Assigned User']"
assigned_user_input = "//div[@class='search__form__section__wrapper']//div[7]//input"
rc_number_input = "//input[@id='rcNo']"
dr_id_input = "//input[@id='reqId']"
dr_amount_input = "//input[@id='requestedAmount']"
table_columns = "//thead/tr/td"
summary_row_data = "//div[@class='no-ellipsis']"
update_details_edit_popup = "//h3[text()='Update Details']"
update_button_edit_popup = "//button[text()='Update']"
download_button = "//span[@class='csv__download-button']"
save_preferences_button = "//button[text()='Save Preferences']"
deselect_all_btn = '//button[@class="btn sign_btn"][text()="De-select All"]'
download_file_button = "//button[text()='Download File']"
rc_number_edit_input = "//input[@id='rcno']"
dh_number_edit_input = "//input[@id='dhno']"
customize_btn = '//div[@class="custom_btn-container"]//a[@class="btn_custom"]'
save_btn = '//button[@class="btn sign_btn"][text()="Save"]'
after_deselect_rows_count = '//div[@class="col-sm-3"]//descendant::span'
created_on_checkbox = "//div[text()='Created On']/input"
edit_checkbox = "//div[text()='Edit']/input"
history_checkbox = "//div[text()='History']/input"
summary_checkbox = "//div[text()='Summary']/input"
created_on_text = '//thead[@class="theader table__tableHeader-container"]//td[text()="Created On"]'
edit_text = '//thead[@class="theader table__tableHeader-container"]//td[text()="Edit"]'
summary_text = '//thead[@class="theader table__tableHeader-container"]//td[text()="Summary"]'

# User ID
breadcrumbs_userid_field = "//ol[@class='breadcrumb-arrow']/li[4]/span"
edit_eye_icon = "//td[text()='Edit']/i[contains(@class,'fa-eye')]"

# search result locators
date_to_be_replaced = '//div[text()="replacemonth replaceyear"]/parent::div/following::div/div[not(contains(@class,"outside")) and @aria-label="day-replaceday"]'
back_month_btn = '//button[text()="Previous Month"]'
calendar_container = '//div[@class="react-datepicker__month-container"]'
data_rows = '//tr[contains(@class,"table__row__container banklist__propper-header-class")]'
time_to_replace = '//li[contains(@class,"datepicker__time") and text()="timetoreplace"]'
to_close_icon = "//div[@class='react-datepicker__input-container']/following::button[@class='react-datepicker__close-icon']"
user_id = '(//td[@class="generic-td "])[1]'
view_icon = '(//td[@class="generic-td fixedColumn"])[1]//descendant::i'
user_id_manage_user_page = '//ol[@class="breadcrumb-arrow"]//descendant::span[2]'
edit_link = '(//tbody[@class="table__body-border"]//descendant::i[@class="fa fa-eye"])[1]'
history_link = '(//a[@data-modal="historyList"])[1]'
popup_user_id = '((//table[@class="table table__fixed-container"])[2]//descendant::div[@class="generic-td "]//descendant::span)[1]'
full_screen_deposit_data = '//td[@class="generic-td "]/a'
reset_btn = '//div[@class="custom_btn-container"]//a[@class="btn_reset"]'
popup_reset_btn = '//button[@class="btn sign_btn cancel-btn-generic"]//descendant::i'
half_screen_deposit_data = '//tr[@class="table__row__container banklist__propper-header-class "]//td[@class="generic-td "]/a'
full_screen_icon = '//span[@class="fullscreen-icos btn_custom"]/span'
reset_btn = '//div[@class="custom_btn-container"]//a[@class="btn_reset"]'
popup_reset_btn = '//button[@class="btn sign_btn cancel-btn-generic"]//descendant::i'
no_data_found_text = '//h2[@class="table__body-nodata"]'
reset_cancel_btn = '//button[@class="btn sign_btn"][text()="Cancel"]'
history_text = '//thead[@class="theader table__tableHeader-container"]//td[text()="History"]'
download_created_on_checkbox = "//div[text()='Created On']/input"
download_dr_id_checkbox = "//div[text()='DR ID']/input"
file_name_input_text = '//input[@class="input-floating-lebel"]'
download_created_on_text = '//div[@class="drag_item"][text()="Created On"]'
dashboard_tab = "//a[text()='Dashboard']"
balance_locator = "//span[contains(text(), 'My Balance')]"
switch_back_btn = "//li[text()='Switch Back']"
username_locator = "//div[text()='Username']"
username_input = "//div[@class='search__form__section__wrapper']//div[1]/input[@id='react-select-6-input']"
