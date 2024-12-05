# departure and arrival time range
departure_time1 = "//div[@class='al-listbtm pb-10'][1]//li[1]//span[@class='icon_aftsort']"
departure_time2 = "//div[@class='al-listbtm pb-10'][1]//li[2]//span[@class='icon_aftsort']"
departure_time3 = "//div[@class='al-listbtm pb-10'][1]//li[3]//span[@class='icon_aftsort']"
departure_time4 = "//div[@class='al-listbtm pb-10'][1]//li[4]//span[@class='icon_aftsort']"

no_flights_available= "//div[@class='no_flight-content']/child::p[contains(text(),'no flights found')]"
search_processing_icon= "//div[@class='lds-ellipsis lds-ellipsis-positionHandle']"
departure_time_elements = "//span[@class='arrow-allright arrowclass-loader-flight-search arrow-allright-positionHandle']/parent::div/preceding-sibling::div/descendant::span[@class='dep-timefont']"
arrival_time_elements = "//span[@class='arrow-allright arrowclass-loader-flight-search arrow-allright-positionHandle']/parent::div/following-sibling::div/descendant::span[@class='dep-timefont']"
arrival_time1 = "//div[@class='al-listbtm pb-10'][2]//li[1]//span[@class='icon_aftsort']"
arrival_time2 = "//div[@class='al-listbtm pb-10'][2]//li[2]//span[@class='icon_aftsort']"
arrival_time3 = "//div[@class='al-listbtm pb-10'][2]//li[3]//span[@class='icon_aftsort']"
arrival_time4 = "//div[@class='al-listbtm pb-10'][2]//li[4]//span[@class='icon_aftsort']"

commission_tab = "//div[@id='commission']"
cheapest_price_tab = "//div[@id='price']"
fare_amounts = "//div[@class='ar-sortby']//span[@class='fare__amount']"
flight_numbers_elements = "//span[@class='at-fontweight apt-flightids']"
flight_number_input = "//input[@id='0']"
nav_scroll_bar = "//div[@{class='col-sm-2 al-leftbgcolor  '}]"

stops_flight_text = "//div[@class='atls-holdid']/child::span[@class='ars-arrowsun']"
stops_filter_title = "//span[normalize-space()='Stops']"
zero_stops_option = "//a[normalize-space()='0']"
one_stops_option = "//a[normalize-space()='1']"
two_stops_option = "//a[normalize-space()='2']"
three_stops_option = "//a[normalize-space()='3+']"
modify_button = "//button[normalize-space()='Please, Modify your search and try again.']"
view_details_button = "//button[text()='View Details']"

#fair identifier
wrap_redcolor = "//div[@class='fliterlist__wrap--list fliterlist__wrap--redcolor']"
wrap_orangecolor = "//div[@class='fliterlist__wrap--list fliterlist__wrap--orangecolor']"
wrap_magenta = "//div[@class='fliterlist__wrap--list fliterlist__wrap--magenta']"
wrap_lightSeaGreen = "//div[@class='fliterlist__wrap--list fliterlist__wrap--lightSeaGreen']"
wrap_rose = "//div[@class='fliterlist__wrap--list fliterlist__wrap--rose']"
wrap_brass = "//div[@class='fliterlist__wrap--list fliterlist__wrap--brass']"
wrap_fawn = "//div[@class='fliterlist__wrap--list fliterlist__wrap--fawn']"
wrap_khaki = "//div[@class='fliterlist__wrap--list fliterlist__wrap--khaki']"
wrap_azure = "//div[@class='fliterlist__wrap--list fliterlist__wrap--azure']"
wrap_robinsegg = "//div[@class='fliterlist__wrap--list fliterlist__wrap--robinsegg']"
published_tag = "//span[@class='label label-warning ars-flightlabel ars-refunsleft ars-flightlabel-positionHandle']"
instant_offer_fair_tag = "//span[@class='label label-purple ars-flightlabel ars-refunsleft ars-flightlabel-positionHandle']"
marine_tag = "//span[@class='label label-lightSeaGreen ars-flightlabel ars-refunsleft ars-flightlabel-positionHandle']"
economy_basic_tag = "//span[@class='label label-fawn ars-flightlabel ars-refunsleft ars-flightlabel-positionHandle']"
economy_semi_tag = "//span[@class='label label-khaki ars-flightlabel ars-refunsleft ars-flightlabel-positionHandle']"
lite_tag = "//span[@class='label label-azure ars-flightlabel ars-refunsleft ars-flightlabel-positionHandle']"
sme_tag = "//span[@class='label label-cor-orange ars-flightlabel ars-refunsleft ars-flightlabel-positionHandle']"
total_list = "//li[@class='fliterlist__element']"
common_elements = "//span[contains(@class,'ars-refunsleft ars-flightlabel-positionHandle')]"
redcolor_tag = "//span[contains(@class, 'label label-warning ars-flightlabel')]"
orangecolor_tag = "//span[contains(@class, 'orange')]"
magenta_tag = "//span[contains(@class, 'purple')]"
lightSeaGreen_tag = "//span[contains(@class, 'lightSeaGreen')]"
azure_tag = "//span[contains(@class, 'label-azure')]"
robinsegg_tag = "//span[contains(@class, 'robinsegg')]"
fawn_tag = "//span[contains(@class, 'fawn')]"
khaki_tag = "//span[contains(@class, 'khaki')]"
rose_tag = "//span[contains(@class, 'rose')]"
brass_tag = "//span[contains(@class, 'brass')]"

#airlines
fair_identifier_title = "//p[text() = 'Fare Identifier']"
terminal_minus_icon = "//p[contains(text(),'Terminal')]/i"
airlines_title = "//span[normalize-space()='Airlines']"
total_airlines = "//span[@class='flight__airline__name']"
total_prices = "//span[@class='airline__total-price']"
total_search_count = "//span[@class='airline_total-search']"
airline_name = "//span[@class='flight__airline__name']"
displayed_airline_name = "//li[@class='ars-mobcss sort-detailist multiair-lines-list ars-positionHandle']"
displayed_price = "//span[@class='fare__amount']"
airline_checkbox = "//span[text()='Airlines']/ancestor::div[@class='al-listbtm pb-0']/descendant::i[@class='fa fa-check']"
displayed_flight_count ="//b"
airport_plus_icon = "//p[contains(text(),' Airport')]/i"

#show net
show_net_checkbox = "//label[@for='netfare']//i[@class='fa fa-check']"

book_btn_first='(//button[normalize-space()="BOOK"])[1]'
arrival_flight_checkbox='((//span[text()="Arrival"])[2]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]/parent::div/label/div/i'
departure_flight_checkbox='((//span[text()="Departure"])[2]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]/parent::div/label/div/i'
departure_terminal_checkbox='((//span[text()="Departure"])[1]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]/parent::div/label/div/i[@class="fa fa-check"]'
onward_terminal_icon='//p[contains(normalize-space(),"Onward Terminal")]/i'
onward_terminal_section='//p[contains(normalize-space(),"Onward Terminal")]/i/parent::p'
terminal_section='//p[contains(text(),"Terminal")]/i/parent::p'
layover_section='//p[contains(text(),"Lay")]/i/parent::p'
airport_section='//p[contains(text(),"Airport")]/i/parent::p'
airport_plus_icon='//p[contains(text(),"Airport")]/i'
terminal_plus_icon='//p[contains(text(),"Terminal")]/i'

xpathofterminalinViewDetails='(//div[@class="row flightDetails-row-positionHandle"])[1]/div[2]/ul/li/span[contains(text(),"Terminal")]'


total_left_airports_xpath='(//div[@class="row flightDetails-row-positionHandle"])'
total_left_airports_xpathTo_replace='((//div[@class="row flightDetails-row-positionHandle"])[replace]/div[2]/ul/li/span[2])[1]'
right_airport_to_replace='((//div[@class="row flightDetails-row-positionHandle"])/div[2]/ul/li[3])[replace]/span[2]'

all_flights='(//div[@class="row flight-rowmain flight-rowmain-positionHandle"])'
return_domestic_flight_section='((//div[@class="col-sm-6 domestic_tiles_view"])[2]/div[@class="asr-roundbtm"]/div/span/div/div[@class="row flight-rowmain flight-rowmain-positionHandle"])'
onward_layover_icon='//p[normalize-space()="Onward Layover"]/i'
onward_layover_checkbox='(//p[normalize-space()="Onward Layover"]/parent::div/following-sibling::div/descendant::div[@class="filter__inputContainer"]//label/div/i)[1]'
layover_icon='//p[normalize-space()="Layover"]/i'
layover_checkbox='(//p[normalize-space()="Layover"]/parent::div/following-sibling::div/descendant::div[@class="filter__inputContainer"]//label/div/i)[1]'

return_layover_section='//p[contains(normalize-space()," Lay") and contains(normalize-space(),"Return")]/i/parent::p'
Selected_layover_txt='(//p[normalize-space()="Onward Layover"]/parent::div/following-sibling::div/descendant::div[@class="filter__inputContainer"]/p)[1]'
cancel_view_details='//span[text()="×"]'
fastest_tab='//div[@id="time"]/div[2]/p'
onward_airport='//p[contains(normalize-space(),"Onward") and contains(normalize-space(),"Airport")]/i/parent::p'
onward_airport_icon='//p[contains(normalize-space(),"Onward Airport")]/i'
onward_airport_checkbox='((//span[text()="Departure"])[3]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]/parent::div/label/div/i'
departure_airport_text='((//span[text()="Departure"])[2]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]'
domestic_departure_terminal_txt='((//span[text()="Departure"])[1]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]'


arrival_airport_txt_onway='((//span[text()="Arrival"])[2]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]'
domestic_round_arrival_txt='((//span[text()="Arrival"])[3]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]'
arrival_checkbox_roundtrip='((//span[text()="Arrival"])[3]/parent::p/parent::div/following-sibling::div/div/div[@class="filter__inputContainer"]/p)[1]/parent::div/label/div/i'

number_stop_text = '(//div[@class="row flight-rowmain flight-rowmain-positionHandle"])[1]//span[@class="ars-arrowsun"]'
number_stop_text_under_view = '//span[@class="stop-itinery"]'
round_trip_way = '//li[@class="multicity__wrapper--cityname multicity__wrapper--activecity"]'

send_icon="//button[text()='Send']"
send_with_price_button="//button[text()='With Price']"
email_input_field="//div[@class='form_content']//descendant::input"
total_fare_checkbox="((//div[@class='row flight-rowmain flight-rowmain-positionHandle'])/div/following::div//ul[@class='ars-radiolist']/descendant::label[@class='al-label'][1])"
select_fare_checkbox="((//div[@class='row flight-rowmain flight-rowmain-positionHandle'])/div/following::div//ul[@class='ars-radiolist']/descendant::label[@class='al-label'][1])[index]"
total_fare_count="//div[@class='ar-sortby']//descendant::label"

whatsapp_icon="//button[text()='Whatsapp']"
email_icon="//button[text()='Email']"
share_icon="//button[text()='Share']"

