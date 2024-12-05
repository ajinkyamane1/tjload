from datetime import datetime
from robot.api.deco import keyword
import re


@keyword
def convert_input_to_date(a):
    print(a)
    ans = []
    month_dic = {'1': "January", '2': "February", '3': "March", '4': "April", '5': "May", '6': "June", '7': "July",
                 '8': "August", '9': "September", '10': "October", '11': "November", '12': "December"}
    list1 = a.split("/")
    day = list1[0]
    month = list1[1]
    year = list1[2]
    ans.append(day)
    ans.append(month_dic[month])
    ans.append(year)
    return ans


@keyword
def update_the_string(input_string):
    # Remove the '₹' symbol
    cleaned_string = input_string.replace('₹', '')

    # Split the string by 'x' if present
    parts = cleaned_string.split('x')

    # Convert the first part to a number
    amount = float(parts[0].strip().replace(',', ''))

    # Check if 'x' is present for multiplication
    if len(parts) == 2:
        quantity = int(parts[1].strip())
        result = amount * quantity
    else:
        result = amount

    # Format the result as a string and return
    result_string = f"{result:.2f}"
    # changed_string = result_string.split('.')
    return result_string


@keyword
def split_string_by_colon(input_string):
    changed_string = input_string.split(':')
    return changed_string[1]

@keyword
def is_date_start_from(start_date_str, check_date_str):
    # Convert input strings to datetime objects
    start_date = datetime.strptime(start_date_str, '%d-%m-%Y')
    check_date = datetime.strptime(check_date_str, '%d-%m-%Y')

    # Check if the check_date is between start_date and end_date (inclusive)
    return start_date <= check_date


@keyword
def convert_to_standard_date_format(a):
    a = a.replace("/", "-")
    return a


@keyword
def fetch_rc_number(input_string):
    print(input_string)
    # Define a regular expression pattern to match the RC number
    pattern = r'RC:(\w+)'

    # Use re.search to find the match
    match = re.search(pattern, input_string)

    # Check if a match is found
    if match:
        rc_number = match.group(1)
        return rc_number
    else:
        return 'Null'


@keyword
def fetch_dh_number(input_string):
    print(input_string)
    # Define a regular expression pattern to match the RC number
    pattern = r'DH:(\w+)'

    # Use re.search to find the match
    match = re.search(pattern, input_string)

    # Check if a match is found
    if match:
        dh_number = match.group(1)
        return dh_number
    else:
        return 'Null'
