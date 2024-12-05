from datetime import datetime
from robot.api.deco import keyword


@keyword
def remove_currency_symbols(input_string):
    return input_string.replace('₹', '').replace(',', '')
@keyword
def convert_number_format(number_with_zeros):
    return str(float(number_with_zeros))