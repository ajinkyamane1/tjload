book_button = "//button[contains(@class,'btn btn-warning asr-book')][normalize-space()='BOOK']"
add_passanger_button = "//button[@class='btn btn-warning asr-book asr-book-positionHandle']"
refundable_booking_title = "//span[@class='protectGrp__heading']"
show_seat_map_button = "//button[@type='button'][normalize-space()='Show Seat Map']"
selected_seat_xpath = "//span[contains(@class,'text--selected')]/..//div[contains(@class,'tooltip')]/p[2]"
continue_button = "//button[normalize-space()='Continue']"

#select seat window
select_seat_title = "//h3[normalize-space()='Select Seats']"
airline_info = "//div[@class='seat-map__flight-info seat-map__airline-info']"
source_destination = "//div[@class='seat-map__flight-info']"
passanger_details = "//body//div//ul[2]"
proceed_button = "//li[@class='seat-map__select-box__item seat-map__select-box__item--proceed']"
proceed_without_seats = "//div[@class='seat-map__select-box__item seat-map--proceedLabel']"
seat_status_heading = "//span[normalize-space()='Seat Status']"
seat_fees_section = "//ul[@class='seat-map__legend']//li[2]"
aircraft_body = "//div[@class='aircraft__body']"
select_seat_airline_name = "//h5[@class='search-flightsname seat-map__flight-info--carriername']"
displayed_source_city = "(//h5[@class='search-flightsname seat-map__flight-info--flightname'])[1]"
displayed_destination_city = "(//h5[@class='search-flightsname seat-map__flight-info--flightname'])[2]"
booked_seat = "//div[contains(@class,'box--booked')]"
meal_baggage_section = "//span[normalize-space()='Meal, Baggage & Seat']"
meal_baggage_seat_price = "//span[contains(text(),'Meal, Baggage & Seat')]/following-sibling::span[@class='pull-right fareSummary-prices-positionHandle']"
adult_pax = "//div[contains(normalize-space(.), 'ADULT-') and contains(@class,'seat-map--passenger')]"
child_pax = "//div[contains(normalize-space(.), 'CHILD-') and contains(@class,'seat-map--passenger')]"
displayed_airline_name = "//li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']"
seat_selection_not_applicable = "//span[text()='Seat Selection Not Applicable for this Itinerary']"
available_seats_locator = '//div[@class="grid-item seat-map__box--background-0" or @class="grid-item seat-map__box--background-1" or @class="grid-item seat-map__box--background-2" or @class="grid-item seat-map__box--background-3" or @class="grid-item seat-map__box--background-4" or @class="grid-item seat-map__box--background-5" or @class="grid-item seat-map__box--background-6"]//span'
selected_seat_locator = '(//div[@class="seat-map__select-box__item seat-map--seatNo"])'
seat_detail_locator = '//div[@class="col-sm-4 seatmap-box--seat"]/p[@class="p-20"]'
selected_seat_price_locator = '//div[@class="seat-map__select-box__item seat-map--fee"]'
seat_filter_checkbox_4 = '(//input[@class="seat-map__box__filtercheckbox"])[4]'
seat_filter_checkbox_5 = '(//input[@class="seat-map__box__filtercheckbox"])[5]'
total_fare_locator_pax_details = '''//span[text()='Amount to Pay']//following-sibling::span'''
seat_map_seat_data_div = '//li[@class="seat-map__seat-data "]'
seat_fee_seat_map = '(//div[@class="seat-map__select-box__item seat-map--fee"])'
seat_no_seat_map = '//div[@class="seat-map__select-box__item seat-map--seatNo"]'
aircraft_body_seats = "//div[@class='aircraft__body--seats']"

# pax details page
seat_detail_pax = '//div[@class="col-sm-4 seatmap-box--seat"]/p[@class="p-20"]'
baggage_seat_locator_pax = "//span[text()='Meal, Baggage & Seat']"
seat_fare_pax = '''//span[text()='Seat']//following-sibling::span[@class="pull-right fareSummary-prices-positionHandle"]'''

#iternary
amount_to_pay = "//div[@class = 'bold-font btm-border fareSummary-boldFont-positionHandle']/child::span[@class= 'pull-right fareSummary-prices-positionHandle']"