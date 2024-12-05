# link
manage_source = "//a[@href='/manage-source']"
manage_inventory = "//a[@href='/manage-inventory']"

# input
supplier_field = "(//div[@class='react-select__input']//input)[1]"
source_field = "(//div[@class='react-select__input']//input)[2]"
status_field = "(//div[@class='react-select__input']//input)[3]"

# dropdown
select_supplier = "//div[text()='Supplier']"
select_source = "//div[text()='Source']"
airasia_source = "//div[contains(text(),'AirAsiaDotRez')]"
select_status = "//div[contains(text(),'Status')]"
supplier_field_arrow = "(//div[@class='css-1s7wec9 react-select__indicator react-select__dropdown-indicator'])[1]"
source_field_arrow = "(//div[@class='css-1s7wec9 react-select__indicator react-select__dropdown-indicator'])[2]"
status_field_arrow = "(//div[@class='css-1s7wec9 react-select__indicator react-select__dropdown-indicator'])[3]"

all_checkboxes = "//input[@type='checkbox']"

#button
search_button = "//button[@type='submit' and text()='Search']"
add_button = "//a[@class='floating__icon-link']"
plus_button = "//a[@title='Manage Source']"
submit_button = "//button[text()='Submit']"
cancel_button = "//button[text()='Cancel']"
hide_unhide_button = "//button[@class='hideShow-button-box']"
full_screen_button = "//span[contains(@class,'fa fa-expand')]"
close_full_screen_button = "//span[@class='fullscreen-icos btn_custom']"


#table
table_count = "//span[@class='table--count']"
inclusion_fields = "//div[@class='inc_exc']"

#add new by plus button
select_source_field = "//div[@class='search__form__section manageSupplier__form-padding-wrapper']//select[@class='form-control']"
select_source_option = "//option[text()='Source']"
select_supplier_id_option = "//option[text()='Supplier']"
supplier_id_field = "//select[@name='supplierId']"
fare_class_field = "//div[@class='css-1hwfws3 Fare Class__value-container']"
lowest_fare_class = "//div[text()='Lowest Fare Class']"
compress_by_product_class = "//div[text()='Compress By Product Class']"
# first_edit_button = "(//a[@href='/manage-source/edit/323'])[1]"
first_edit_button = "(//a[contains(@href,'/manage-source/edit/')])[1]"
first_history_button = "(//span[@class='link_container-link' and text()='History'])[1]"
close_button = "//button[@class='styles_closeButton__20ID4']"

# input fields
description_field = "//input[@placeholder='Description']"

history_popup_table = "//div[@class='table-responsive manage__user-table-container']"