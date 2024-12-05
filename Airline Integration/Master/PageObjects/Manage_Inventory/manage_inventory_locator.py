# for create a new inventory
manage_inventory_field = "//a[text()='Manage Inventory']"
inventory_name_input = "//input[@id='name']"
disable_departure_input = "//input[@id='disableBfrDept']"
type_input = "(//div[@class='search__form__section__wrapper'])[1]//div[@class='form__field__multiSelect']//input"
journey_type_inventory = '(//input[@data-selected-id="ONEWAY"])[1]'
round_trip_dropdown = '(//li[@data-option-id="RETURN"]//span)[1]'
source_input = '(//section[@class="search__form__section segment-details__container"]//input)[1]'
destination_input = '(//section[@class="search__form__section segment-details__container"]//input)[2]'
airline_input = '(//section[@class="search__form__section segment-details__container"]//input)[3]'
flight_number_input = '//input[@id="flightNumber"]'
departure_time_input = '//input[@id="departureTime"]'
arrival_time_input = '//input[@id="arrivalTime"]'
arrival_next_day_field = '(//div[@class="form__field form__field--one-fourth"])[7]//input'
arrival_next_day_yes = '//div[@role="option" and text()="Yes"]'
journey_type_input_segment = '//input[@id="journeyType"]'
round_trip_journey = '//section[@class="search__form__section segment-details__container"]//following-sibling::ul//span[text()="Round Trip"]'
add_more_segment_button = '//button[text()="+ Add More Segments"]'
save_continue_button = '//button[text()="Save + Continue"]'
add_icon = "//span[@class='floating__icon-link']"
source_input_return = '((//section[@class="search__form__section segment-details__container"])[2]/div[@class="search__form__section__wrapper"]//input)[1]'
destination_input_return = '((//section[@class="search__form__section segment-details__container"])[2]/div[@class="search__form__section__wrapper"]//input)[2]'
airline_input_round = '((//section[@class="search__form__section segment-details__container"])[2]/div[@class="search__form__section__wrapper"]//input)[3]'
flight_number_input_round = '(//input[@id="flightNumber"])[2]'
departure_time_input_round = '(//input[@id="departureTime"])[2]'
arrival_time_input_round = '(//input[@id="arrivalTime"])[2]'
arrival_next_day_field_round = '(//div[@class="form__field form__field--one-fourth"])[13]//input'
journey_type_input_segment_round = '(//input[@id="journeyType"])[2]'
return_round_trip_journey = '//section[@class="search__form__section segment-details__container"][2]//following-sibling::ul//span[text()="Round Trip"]'




# for inventory Search
source_search = '(//section[@class="search__form__section"]//input)[1]'
destination_search = '(//section[@class="search__form__section"]//input)[2]'
airline_search = '(//section[@class="search__form__section"]//input)[3]'
inventory_enable_select = '(//section[@class="search__form__section"]//input)[4]'
is_deleted_select = '(//section[@class="search__form__section"]//input)[5]'
search_button = '//button[text()="Search"]'
top_search_result = '(//div[@role = "option"])[1]'


# search result
result_source_name = '(//tbody[@class="table__body-border"]//following::span)[4]'
result_destination_name = '(//tbody[@class="table__body-border"]//following::span)[5]'
result_airline = '(//tbody[@class="table__body-border"]//following::span)[8]'






# rate plan selection
# rate_plan_name = '(//div[@class="search__form__section__wrapper"]//following::div[text()="Rate plan Name"]//following::input)[1]'
rate_plan_name = '//div[@class="trip-box__body trip-box__body__inventory"]//ancestor::div[@class="search__form__section__wrapper"]//div[text()="Rate plan Name"]'
rate_plan_input_field = '//div[@class="trip-box__body trip-box__body__inventory"]//ancestor::div[@class="search__form__section__wrapper"]//div[text()="Rate plan Name"]//following-sibling::div//div//input'
# start_date = '//input[@id="sd"]'
start_date = '//div[@class="trip-box__body trip-box__body__inventory"]//ancestor::div[@class="search__form__section__wrapper"]//input[@id="sd"]'
# end_date = '//input[@id="ed"]'
end_date = '//div[@class="trip-box__body trip-box__body__inventory"]//ancestor::div[@class="search__form__section__wrapper"]//input[@id="ed"]'
# seat_available = '//input[@id="ts"]'
seat_available = '//div[@class="trip-box__body trip-box__body__inventory"]//ancestor::div[@class="search__form__section__wrapper"]//input[@id="ts"]'
# airline_pnr = '//input[@id="aPnr"]'
airline_pnr = '//div[@class="trip-box__body trip-box__body__inventory"]//ancestor::div[@class="search__form__section__wrapper"]//input[@id="aPnr"]'
save_seat_allocation_button = '//button[text()="Save Seat Allocation"]'
final_date_locator_to_replace = "//div[text()='replacemonth replaceyear']/parent::div/../div[@class='react-datepicker__month']/div/div[not(contains(@class,'react-datepicker__day--disabled')) and not(contains(@class,'react-datepicker__day--outside-month')) and text()='replaceday']"
download_button = '//span[text()=" Download "]'
displayed_rate_plan_name = '(//tbody[@class="table__body-border"]//td//span)[1]'
displayed_rate_text = '(//tbody[@class="table__body-border"]//td//span)[6]'
displayed_plan_name_count = '//tbody[@class="table__body-border"]//td[1]'
displayed_seat_count = '//tbody/tr/td[5]/div/span'
table_columns = "//thead/tr/td"
switch_back_button = '//ul[@class="topbar"]//li[text()="Switch Back"]'
calendar_container = '//div[@class="react-datepicker__month-container"]'
date_to_be_replaced = '//div[text()="replacemonth replaceyear"]/parent::div/following::div/div[not(contains(@class,"outside")) and @aria-label="day-replaceday"]'
next_month_btn = '//button[text()="Next month"]'
allocate_more_button = '//button[text()="Allocate More"]'
total_allocation_field = '//div[@class="trip-box__body trip-box__body__inventory"]//ancestor::h2'
#search
clear_date_field="(//button[@class='react-datepicker__close-icon'])[1]"
clear_user_role_field = "//div[contains(@class,'react-select__clear-indicator')]"
search_button = "//button[text()='Search']"
show_more_button = "//span[text()='Show More']"
select_user_id = "//div[contains(@class,'css-1lhitd')][1]"
user_id_link_on_search_card="//a[contains(text(),'replace')]"
emulate_user_link = "//a[text()='Emulate']"


# manage inventory admin
supplier_name_input = "(//div[text()='Supplier Name']//following::input)[1]"
inventory_enable_admin = '(//section[@class="search__form__section"]//input)[5]'
display_plan_name = '(//div[@class="table-responsive manage__user-table-container"]//td//following::span)[1]'
display_start_date = '(//div[@class="table-responsive manage__user-table-container"]//td//following::span)[3]'
display_end_date = '(//div[@class="table-responsive manage__user-table-container"]//td//following::span)[4]'
display_seats = '(//div[@class="table-responsive manage__user-table-container"]//td//following::span)[6]'

# seat allocation admin
update_element = '//span[@data-message="SEAT_ALLOCATION:UPDATE_SEAT_ALLOCATION"]'
force_display = '//input[@type="checkbox" and @value="false"]'
updated_display_plan = '(//div[@class="search__form__section__wrapper"]//label[text()="Rate plan Name"]//following::div)[4]'
updated_display_seat = '//div[@class="search__form__section__wrapper"]//following::input[@id="ts"]'
updated_display_start_date = '//div[@class="search__form__section__wrapper"]//following::input[@id="sd"]'
updated_display_end_date = '//div[@class="search__form__section__wrapper"]//following::input[@id="ed"]'
update_button = '//button[text()="Update"]'

# manage user
manage_user_menu = "//a[text()='Manage User']"
display_agent_id = '(//li[@class="topbar__list"])[1]'

# search page
i_icon_single = "(//div[@class='asr-albtmround '])[1]//span[@class='fa fa-info-circle edit-icon-tiles']"
i_icon_return = "(//div[@class='asr-albtmround'])[1]//span[@class='fa fa-info-circle edit-icon-tiles']"
inventory_id_single = "(//div[@class='asr-albtmround '])[1]//span[text()='Inventory Id']//following::div//a"
inventory_id_return = "(//div[@class='asr-albtmround'])[1]//span[text()='Inventory Id']//following::div//a"
cross_icon_single = "(//div[@class='asr-albtmround '])[1]//button[@class='airlineInfo__headerButton']"
cross_icon_return = "(//div[@class='asr-albtmround'])[1]//button[@class='airlineInfo__headerButton']"
offer_fare_text_single = "(//div[@class='asr-albtmround '])[1]//span[text()='Offer Return Fare']"
offer_fare_text_return = "(//div[@class='asr-albtmround'])[1]//span[text()='Offer Return Fare']"
from_city_single = "(//div[@class='asr-albtmround '][1]//p[@class='ars-city'])[1]"
to_city_single = "(//div[@class='asr-albtmround '][1]//p[@class='ars-city'])[2]"
from_city_return = "(//div[@class='asr-albtmround'][1]//p[@class='ars-city'])[1]"
to_city_return = "(//div[@class='asr-albtmround'][1]//p[@class='ars-city'])[2]"
time_from_single = "(//div[@class='asr-albtmround '][1]//span[@class='dep-timefont'])[1]"
time_to_single = "(//div[@class='asr-albtmround '][1]//span[@class='dep-timefont'])[2]"
time_from_return = "(//div[@class='asr-albtmround'][1]//span[@class='dep-timefont'])[1]"
time_to_return = "(//div[@class='asr-albtmround'][1]//span[@class='dep-timefont'])[2]"
date_from_single = "(//div[@class='asr-albtmround '][1]//span[@class='ar-fontrntrip'])[1]"
date_to_single = "(//div[@class='asr-albtmround '][1]//span[@class='ar-fontrntrip'])[2]"
date_from_return = "(//div[@class='asr-albtmround'][1]//span[@class='ar-fontrntrip'])[1]"
date_to_return = "(//div[@class='asr-albtmround'][1]//span[@class='ar-fontrntrip'])[2]"
flight_number_from_single = "(//div[@class='asr-albtmround '])[1]//span[@class='at-fontweight apt-flightids elips-roundtrip']"
flight_number_to_return = "(//div[@class='asr-albtmround'])[1]//span[@class='at-fontweight apt-flightids elips-roundtrip']"
seat_text_single = "(//div[@class='asr-albtmround '])[1]//p[@class='indicator-content indicator-content-positionHandle']//span"
seat_text_return = "(//div[@class='asr-albtmround'])[1]//p[@class='indicator-content indicator-content-positionHandle']//span"
view_details_button = "//button[text()='View Details']"
view_details_button_single = "(//div[@class='asr-albtmround '])[1]//button[text()='View Details']"
view_details_button_return = "(//div[@class='asr-albtmround'])[1]//button[text()='View Details']"
display_city_from_to = "(//div[@class='asr-albtmround '])//b"
display_city_to_from = "(//div[@class='trip-sepration-line'])//b"

# for search inventory name
inventory_name_as_supplier = '//tbody[@class="table__body-border"]//td[4]'

# search result for international
i_icon = '(//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[1]//span[@class="fa fa-info-circle edit-icon-tiles"]'
inventory_id = '//div[@class="airline_withId" and span[contains(text(),"Inventory Id")]]//following-sibling::div'
# if layover is visible
round_trip_from = '//div[@class="row flightDetails-row-positionHandle"]/div[2]/ul/li[1]'
round_trip_to = '//div[@class="row flightDetails-row-positionHandle"]/div[2]/ul/li[3]'