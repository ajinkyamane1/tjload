rate_plan_link = "//a[@href='/rate-plan' and contains(text(),'Rate Plan')]"
download_report_link = "//a[@href='/download-report' and contains(text(),'Download Report')]"
plus_icon_button = "//span[contains(@class,'floating__icon-link')]"
manage_inventory_link = "//a[contains(text(),'Manage Inventory')]"
bulk_update_link = "//a[contains(text(),'Bulk Update')]"


# Buttons
search_button = "//button[contains(text(),'Search')]"
submit_button = "//button[contains(text(),'Submit')]"
download_button = "//span[contains(text(),'Download ')]"
download_file_button = "//button[contains(text(),'Download File')]"



# Input Fileds
from_date_field = "//input[@id='createdOnAfterDate']"
clear_date_field = "(//button[@class='react-datepicker__close-icon'])[1]"
supplier_name_field = "//div[contains(text(),'Supplier Name')]//following::div[@class='react-select__input']/input"
select_supplier_name = "//div[contains(@class,'css-1lhitdy react-select__option react-select__option--is-focused')]"
rate_plan_name_field = "(//input[@id='name'])[1]"
plan_name_field = "(//input[@id='name'])[2]"
booking_class_field = "//input[@id='bookingClass']"
cabin_class_field = "//input[@id='cabinClass']"
select_cabin_class = "//span[contains(text(),'CabinClass')]"
adult_base_fare_field = "//input[@id='adultBaseFare']"
adult_tax_field = "//input[@id='adultTaxRate']"
adult_gst_field = "//input[@id='adultGstRate']"
child_base_fare_field = "//input[@id='childBaseFare']"
child_tax_field = "//input[@id='childTaxRate']"
child_gst_field = "//input[@id='childGstRate']"
infant_base_fare_field = "//input[@id='infantBaseFare']"
infant_tax_field = "//input[@id='infantTaxRate']"
infant_gst_field = "//input[@id='infantGstRate']"
file_name_field = "//input[@id='filename']"
inventory_rate_plan_name_field = "//div[contains(text(),'Rate plan Name')]"





# Search Card
head_column_count = "//thead[@class='theader table__tableHeader-container']/tr/td"
body_row_count = "//tbody[@class='table__body-border']/tr/td"
first_inventory_view_link = "(//a[contains(@href,'/manage-inventory/seat-allocation/')])[1]"
first_inventory_update_link = "//tbody[contains(@class,'table__body')]/tr/td[8]/span"
clear_rate_plan_field = "//div[contains(@class,'react-select__clear-indicator')]"


search_card_thead_count="//thead[contains(@class,'theader')]/tr/td"
search_card_tbody_count="//tbody[contains(@class,'table')]/tr"

# Error Message of Rate Plan page

plan_name_field_error_message = "Please provide plan name"
booking_class_field_error_message = "Please provide Booking Class"
cabin_class_field_error_message = "Please Provide Cabin Class"
base_fare_error_message = "Base fare must be greater than 0"



