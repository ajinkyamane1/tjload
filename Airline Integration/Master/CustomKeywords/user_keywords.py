import math
import random
import string
import pandas as pd
from robot.api.deco import keyword
from datetime import datetime, timedelta
import re
import time
# import pyautogui
import os
import glob
import getpass
from datetime import datetime
from robot.api import logger
import csv
import calendar
import openpyxl
from openpyxl import Workbook
# import keyboard


@keyword
def extract_final_fare_as_string(input_string):
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
    return result_string


@keyword
def compare_fares_prices(a_base_fare, a_taxes, a_total_base_fare, a_total_taxes):
    calculated_base_fare = extract_final_fare_as_string(a_base_fare)
    calculate_total_fare = extract_final_fare_as_string(a_total_base_fare)
    assert calculated_base_fare == calculate_total_fare, \
        f"Base Fare mismatch: Expected {calculate_total_fare}, got {calculated_base_fare}"

    calculated_taxes = extract_final_fare_as_string(a_taxes)
    calculated_taxes_total = extract_final_fare_as_string(a_total_taxes)
    assert calculated_taxes == calculated_taxes_total, \
        f"Taxes mismatch: Expected {calculated_taxes_total}, got {calculated_taxes}"


@keyword
def format_date(input_date):
    date_obj = datetime.strptime(input_date, '%d-%m-%Y')
    suffix = 'th' if 11 <= date_obj.day <= 13 else {1: 'st', 2: 'nd', 3: 'rd'}.get(date_obj.day % 10, 'th')
    formatted_date = date_obj.strftime('%a, %b %d') + suffix + date_obj.strftime(' %Y')
    return formatted_date


@keyword
def format_date_for_departure(input_date):
    date_obj = datetime.strptime(input_date, '%d-%m-%Y')
    formatted_date = date_obj.strftime('%b %d, %a')
    return formatted_date


@keyword
def extract_airline(input_string):
    match = re.search(r'([A-Z]{2}-)', input_string)
    if match:
        input_string = input_string.replace(match.group(), '')
    match = re.search(r'^[A-Za-z]+(?:\s[A-Za-z]+)?', input_string)
    if match:
        return match.group().strip()
    else:
        return None


@keyword
def extract_time(input_text):
    parts = input_text.split(',')
    for part in parts:
        text = part.strip()
        import re
        time_match = re.search(r'\b\d{1,2}:\d{2}\b', text)
        if time_match:
            extracted_time = time_match.group()
            return f"{extracted_time}"
    return None


@keyword
def ascending_order(elements):
    return sorted(elements)


@keyword
def calculate_time_difference(time1_str, time2_str):
    time_format = "%H:%M"
    time1 = datetime.strptime(time1_str, time_format)
    time2 = datetime.strptime(time2_str, time_format)
    if time2 < time1:
        time2 += timedelta(days=1)
    time_difference = abs(time2 - time1)
    hours, remainder = divmod(time_difference.seconds, 3600)
    minutes, _ = divmod(remainder, 60)
    if minutes == 0:
        return f"{hours}h 00m"
    elif hours == 0:
        return f"00h {minutes}m"
    else:
        return f"{hours}h {minutes}m"


@keyword
def extract_only_class(input_string):
    split_values = input_string.split(',')
    return split_values[0].strip()


@keyword
def add_list_by_markup_amount(input_list, markup_amount):
    return [value + markup_amount for value in input_list]


@keyword
def check_for_match(value_list, target_value):
    for value in value_list:
        if value == target_value:
            return True  # Return True if a match is found
    return False


@keyword
def remove_space(txt):
    txt = txt.replace(" ", "")
    return txt


@keyword
def random_name():
    try:
        length = random.randint(5, 10)
        random_string = ''.join(random.choice(string.ascii_letters) for _ in range(length))
        return random_string
    except Exception as e:
        print(f"An error occurred: {e}")
        return None


@keyword
def generate_adult_birth_date():
    # Generate a random age between 13 and 70 years
    min_age = 13
    max_age = 70
    random_age = random.randint(min_age, max_age)
    # Calculate the birth date
    today = datetime.now()
    birth_date = today - timedelta(days=random_age * 365 + random.randint(0, 365))
    # Format the date as dd/mm/yyyy
    formatted_birth_date = birth_date.strftime("%d/%m/%Y")
    return formatted_birth_date


@keyword
def generate_infant_birth_date():
    # Generate a random age between 0 and 2 years
    min_age = 1
    max_age = 1.5
    random_age = random.uniform(min_age, max_age)
    # Calculate the birth date
    today = datetime.now()
    birth_date = today - timedelta(days=int(random_age * 365))
    # Format the date as dd/mm/yyyy
    formatted_birth_date = birth_date.strftime("%d/%m/%Y")
    return formatted_birth_date


@keyword
def generate_child_birth_date():
    # Generate a random age between 2 and 12 years
    min_age = 4
    max_age = 12
    random_age = random.randint(min_age, max_age)
    # Calculate the birth date
    today = datetime.now()
    # Adjust the minimum days to subtract based on the range of years
    min_days = random_age * 365 - 365  # Adjusting for a year
    max_days = random_age * 365  # Maximum days based on age
    birth_date = today - timedelta(days=random.randint(min_days, max_days))
    # Format the date as dd/mm/yyyy
    formatted_birth_date = birth_date.strftime("%d/%m/%Y")
    return formatted_birth_date


@keyword
def generate_random_gst_number():
    # Generate a random GST number (15 digits)
    gst_number = ''.join(random.choice(string.digits) for _ in range(15))
    return gst_number


@keyword
def generate_random_company_name():
    # Generate a random company name
    length = random.randint(5, 15)
    company_name = ''.join(random.choice(string.ascii_letters + string.whitespace) for _ in range(length))
    return company_name


@keyword
def generate_random_email():
    # Generate a random email address
    user_length = random.randint(5, 10)
    domain_length = random.randint(5, 10)
    user = ''.join(random.choice(string.ascii_letters) for _ in range(user_length))
    domain = ''.join(random.choice(string.ascii_lowercase) for _ in range(domain_length))
    email = f"{user}@{domain}.com"
    return email


@keyword
def generate_random_phone_number():
    # Generate a random phone number (10 digits)
    phone_number = ''.join([str(random.randint(1, 9)) for _ in range(10)])
    return phone_number


@keyword
def generate_random_address():
    city = ''.join(random.choices(string.ascii_letters, k=random.randint(3, 10)))
    state = ''.join(random.choices(string.ascii_letters, k=random.randint(3, 10)))
    address_parts = [city, state]
    return ', '.join(address_parts)


@keyword
def generate_wrong_infant_birth_date():
    # Generate a random age between 0 and 2 years
    min_age = 3
    max_age = 10
    random_age = random.uniform(min_age, max_age)
    # Calculate the birth date
    today = datetime.now()
    birth_date = today - timedelta(days=int(random_age * 365))
    # Format the date as dd/mm/yyyy
    formatted_birth_date = birth_date.strftime("%d/%m/%Y")
    return formatted_birth_date


@keyword
def generate_wrong_child_birth_date():
    # Generate a random age between 2 and 12 years
    min_age = 0
    max_age = 2
    random_age = random.randint(min_age, max_age)
    # Calculate the birth date
    today = datetime.now()
    birth_date = today - timedelta(days=random_age * 365 + random.randint(0, 365))
    # Format the date as dd/mm/yyyy
    formatted_birth_date = birth_date.strftime("%d/%m/%Y")
    return formatted_birth_date


@keyword
def generate_wrong_adult_birth_date():
    # Generate a random age between 13 and 70 years
    min_age = 111
    max_age = 120
    random_age = random.randint(min_age, max_age)
    # Calculate the birth date
    today = datetime.now()
    birth_date = today - timedelta(days=random_age * 365 + random.randint(0, 365))
    # Format the date as dd/mm/yyyy
    formatted_birth_date = birth_date.strftime("%d/%m/%Y")
    return formatted_birth_date


@keyword
def random_wrong_mobile_number():
    try:
        # Generate a random 10-digit mobile number
        mobile_number = ''.join([str(random.randint(0, 9)) for _ in range(5)])
        return mobile_number
    except Exception as e:
        # Handle any exception that might occur during the generation
        print(f"An error occurred: {e}")
        return None


@keyword
def random_number():
    try:
        # Generate a random 10-digit mobile number
        number = ''.join([str(random.randint(0, 9)) for _ in range(3)])
        return number
    except Exception as e:
        # Handle any exception that might occur during the generation
        print(f"An error occurred: {e}")
        return None


@keyword
def format_date_for_seat_map(input_date):
    parsed_date = datetime.strptime(input_date, "%a, %b %dth %Y")
    # Convert to the desired format
    formatted_date = parsed_date.strftime("%B %d, %Y")
    return formatted_date


@keyword
def extract_on_text(input_date):
    # Splitting the string based on space
    words = input_date.split()
    # Removing the first word from the string
    date_without_on = ' '.join(words[1:])
    return date_without_on


@keyword
def remove_newline(input_string):
    cleaned_string = input_string.replace('\n', ' ')
    cleaned_string = cleaned_string.replace(',', '')
    return cleaned_string


@keyword
def remove_letter(a, b):
    a = a.replace(b, "")
    return a


@keyword
def remove_space_from_first_char(input_string):
    # Check if the string is not empty
    if input_string:
        # Find the index of the first non-space character
        index_of_first_non_space = next((i for i, char in enumerate(input_string) if char != ' '), None)

        # Remove spaces from the beginning of the string
        result_string = input_string[index_of_first_non_space:] if index_of_first_non_space is not None else ''

        return result_string
    else:
        # Return an empty string if the input is empty
        return ''


@keyword
def separate_name_and_date(original_list):
    # Extracting the name and date from the first element of the list
    name, date = original_list[0].rsplit(' ', 1)
    # Creating a new list with separated name and date
    modified_list = [name, date]
    return modified_list


@keyword
def no_of_months_ahead(a):
    current_date = datetime.now()
    # a=int(a)
    a = int(a)
    new_month = current_date.month + a
    # Calculate the new year by adding 1 to the current year if the new month is greater than 12
    new_year = current_date.year + (new_month - 1) // 12

    # Calculate the new month (taking into account that 12 is December)
    new_month = (new_month - 1) % 12 + 1

    # Calculate the day of the new date (taking care of leap years and different month lengths)
    new_day = min(current_date.day, [31,
                                     29 if new_year % 4 == 0 and (new_year % 100 != 0 or new_year % 400 == 0) else 28,
                                     31, 30, 31, 30, 31, 31, 30, 31, 30, 31][new_month - 1])

    # Create the new date
    new_date = datetime(new_year, new_month, new_day)

    print("Current Date:", current_date.strftime("%d-%m-%Y"))
    print("New Date after adding 3 months:", new_date.strftime("%Y-%m-%d"))
    str = new_date.strftime("%d-%m-%Y")
    print(current_date.strftime("%B"))
    monthnew = (new_date.strftime("%B"))
    daynew = (new_date.strftime("%d"))
    tmp = ""
    print("old ", daynew[1])
    if (daynew[0] == "0"):
        daynew = daynew[1]
    print("removed zero ", daynew)

    Yearnew = (new_date.strftime("%Y"))
    print(daynew, " ", Yearnew, " ", monthnew)

    mainlist = [daynew, monthnew, Yearnew]
    return mainlist


@keyword
def is_ascending(l1):
    l2 = sorted(l1)
    if (l1 == l2):
        return True
    else:
        return False


@keyword
def convert_to_minutes(hours, mins):
    hours = int(hours)
    mins = int(mins)
    ans = (hours * 60) + mins
    return ans


@keyword
def remove_letter(a, b):
    a = a.replace(b, "")
    return a


@keyword
def remove_space_from_first_char(input_string):
    # Check if the string is not empty
    if input_string:
        # Find the index of the first non-space character
        index_of_first_non_space = next((i for i, char in enumerate(input_string) if char != ' '), None)

        # Remove spaces from the beginning of the string
        result_string = input_string[index_of_first_non_space:] if index_of_first_non_space is not None else ''

        return result_string
    else:
        # Return an empty string if the input is empty
        return ''


@keyword
def check_if_list_contains(a, l):
    if (a in l):
        return True
    else:
        return False


###
@keyword
def contains_substring(a, b):
    if (a in b):
        return True
    else:
        return False


@keyword
def reverse_current_datefunction(a):
    current_date = datetime.now()
    a = int(a)
    new_month = current_date.month - a
    # Calculate the new year by adding 1 to the current year if the new month is greater than 12
    new_year = current_date.year + (new_month - 1) // 12

    # Calculate the new month (taking into account that 12 is December)
    new_month = (new_month - 1) % 12 + 1

    # Calculate the day of the new date (taking care of leap years and different month lengths)
    new_day = min(current_date.day, [31,
                                     29 if new_year % 4 == 0 and (new_year % 100 != 0 or new_year % 400 == 0) else 28,
                                     31, 30, 31, 30, 31, 31, 30, 31, 30, 31][new_month - 1])
    new_date = datetime(new_year, new_month, new_day)

    print("Current Date:", current_date.strftime("%d-%m-%Y"))
    print("New Date after adding 3 months:", new_date.strftime("%Y-%m-%d"))
    str = new_date.strftime("%d-%m-%Y")
    print(current_date.strftime("%B"))
    monthnew = (new_date.strftime("%B"))
    daynew = (new_date.strftime("%d"))
    tmp = ""
    print("old ", daynew[1])
    if (daynew[0] == "0"):
        daynew = daynew[1]
    print("removed zero ", daynew)

    Yearnew = (new_date.strftime("%Y"))
    print(daynew, " ", Yearnew, " ", monthnew)

    mainlist = [daynew, monthnew, Yearnew]
    return mainlist


@keyword
def get_current_Date():
    current_date = datetime.now()
    month = current_date.month
    year = current_date.year
    day = current_date.day
    l1 = []
    monthnew = (current_date.strftime("%B"))
    daynew = (current_date.strftime("%d"))
    if (daynew[0] == "0"):
        daynew = daynew[1]
    l1.append(daynew)
    l1.append(monthnew)
    l1.append(year)
    return l1


@keyword
def convertdate(a):
    ans = []
    monthdic = {'1': "January", '2': "February", '3': "March", '4': "April", '5': "May", '6': "June", '7': "July",
                '8': "August", '9': "September", '10': "October", '11': "November", '12': "December"}
    list1 = a.split("/")
    day = list1[0]
    month = list1[1]
    year = list1[2]

    # print(day,month,year)
    # print("original month ",monthdic[month])
    ans.append(day)
    ans.append(monthdic[month])
    ans.append(year)
    return ans


@keyword
def convertdate_reverse(a):
    ans = []
    monthdic = {'Jan': "1", 'Feb': "2", 'Mar': "3", 'Apr': "4", 'May': "5", 'Jun': "6", 'Jul': "7",
                'Aug': "8", 'Sep': "9", 'Oct': "10", 'Nov': "11", 'Dec': "12"}
    list1 = a.split(" ")
    month = list1[0]
    month = monthdic[month]
    day = list1[1]
    day = day.replace(",", "")
    year = list1[2]

    # print(day,month,year)
    # print("original month ",monthdic[month])
    ans.append(day)
    ans.append(month)
    ans.append(year)
    final_date = "-".join(ans)
    return final_date


@keyword
def is_date_between(start_date_str, end_date_str, check_date_str):
    # Convert input strings to datetime objects
    start_date = datetime.strptime(start_date_str, '%d-%m-%Y')
    end_date = datetime.strptime(end_date_str, '%d-%m-%Y')
    check_date = datetime.strptime(check_date_str, '%d-%m-%Y')

    # Check if the check_date is between start_date and end_date (inclusive)
    return start_date <= check_date <= end_date


@keyword
def convert_to_standard_date_fromat(a):
    a = a.replace("/", "-")
    return a


@keyword
def generate_random_number(limit):
    a = random.randint(1, limit - 1)
    return a


@keyword
def airline(airline_name):
    print(airline_name)
    match = re.search(r'\b6E\b', airline_name)

    if match:
        result = match.group(0)
        return result
        print(result)
    else:
        print("Pattern not found.")


@keyword
def extract_first_name(name):
    # Extract the first name using a regular expression
    match = re.search(r'(?:Mrs|Mr) (\w+)', name, re.IGNORECASE)

    if match:
        first_name = match.group(1)
        return first_name
    else:
        return "First name not found."


@keyword
def extract_last_name(name):
    # Extract the last name using a regular expression
    match = re.search(r'(\w+)$', name)

    if match:
        last_name = match.group(1)
        return last_name
    else:
        return "Last name not found."


@keyword
def extract_user_id(user_id_text):
    match = re.search(r'\((\d+)\)', user_id_text)

    if match:
        numeric_value = match.group(1)
        return numeric_value
        print("Numeric Value:", numeric_value)
    else:
        print("Numeric value not found.")


@keyword
def get_to_date_table_format():
    current_date = datetime.now()
    monthnew = current_date.month
    year = current_date.year
    day = current_date.day
    l1 = []
    daynew = (current_date.strftime("%d"))
    if (daynew[0] == "0"):
        daynew = daynew[1]
    daynew = str(daynew)
    monthnew = str(monthnew)
    year = str(year)
    l1.append(daynew)
    l1.append(monthnew)
    l1.append(year)
    l1 = "-".join(l1)
    return l1


@keyword
def from_date_table_format(a):
    a = int(a)
    current_date = datetime.now()
    new_month = current_date.month - a
    # Calculate the new year by adding 1 to the current year if the new month is greater than 12
    new_year = current_date.year + (new_month - 1) // 12
    # Calculate the new month (taking into account that 12 is December)
    new_month = (new_month - 1) % 12 + 1

    # Calculate the day of the new date (taking care of leap years and different month lengths)
    new_day = min(current_date.day, [31,
                                     29 if new_year % 4 == 0 and (new_year % 100 != 0 or new_year % 400 == 0) else 28,
                                     31, 30, 31, 30, 31, 31, 30, 31, 30, 31][new_month - 1])
    new_date = datetime(new_year, new_month, new_day)

    print("Current Date:", current_date.strftime("%d-%m-%Y"))
    print("New Date after adding 3 months:", new_date.strftime("%Y-%m-%d"))
    stri = new_date.strftime("%d-%m-%Y")
    print(current_date.strftime("%B"))

    daynew = (new_date.strftime("%d"))
    tmp = ""
    print("old ", daynew[1])
    if (daynew[0] == "0"):
        daynew = daynew[1]
    print("removed zero ", daynew)

    Yearnew = (new_date.strftime("%Y"))

    print(daynew, " ", Yearnew, " ", new_month)
    daynew = str(daynew)
    new_month = str(new_month)
    Yearnew = str(Yearnew)
    mainlist = [daynew, new_month, Yearnew]

    mainlist = "-".join(mainlist)
    return mainlist


@keyword
def is_date_in_range(start_date, end_date, date_to_check):
    # Convert string inputs to datetime objects
    start_date = datetime.strptime(start_date, '%d/%m/%Y')
    end_date = datetime.strptime(end_date, '%d/%m/%Y')
    date_to_check = datetime.strptime(date_to_check, '%d/%m/%Y')
    # Check if date_to_check is within the range
    return start_date <= date_to_check <= end_date


#
def remove_spaces(input_string):
    try:
        # Remove spaces from the input string
        result_string = input_string.replace(" ", "")
        return result_string
    except Exception as e:
        # Handle any exception that might occur during the removal
        print(f"An error occurred: {e}")
        return None


@keyword
def extract_date(input_string):
    try:
        # Convert the input string to a datetime object
        date_obj = datetime.strptime(input_string, '%b %d, %Y %I:%M %p')
        # Extract and return the date component
        return date_obj.strftime('%d/%m/%Y')
    except ValueError:
        # Handle the case where the input string is not in the expected format
        return None


def convert_to_float_with_two_decimals(value):
    try:
        formatted_string = "{:.2f}".format(float(value))
        return formatted_string
    except ValueError:
        print("Error: Input cannot be converted to a float.")
        return None


def extract_PNR_Number(text):
    match = re.search(r'\b[A-Z0-9]{6}\b', text)
    if match:
        return match.group(0)
    else:
        return None


def extract_Ticket_No(text):
    match = re.search(r'\d{13}', text)
    if match:
        return match.group(0)
    else:
        return None


def added_markup_price(total_taxes, markup_added_value):
    total_taxes_float = float(total_taxes)
    markup_added_value_float = float(markup_added_value)
    calculated_markup = total_taxes_float + markup_added_value_float
    formatted_calculated_markup = "{:.2f}".format(calculated_markup)
    return formatted_calculated_markup

    # removed_decimal_from_total_taxes = str(int(float(total_taxes)))
    # calculated_markup_without_decimal = float(removed_decimal_from_total_taxes) + float(markup_added_value)
    # converted_calculated_markup = "{:.2f}".format(calculated_markup_without_decimal)
    # return converted_calculated_markup


def calculate_total_sum(baggage_dict):
    total_sum = sum(float(value.split('=')[1]) for value in baggage_dict.values())
    return total_sum


def generate_passport_number():
    # Define the format of a passport number
    passport_format = 'AB1234567'  # Example format, where A represents a letter and 1 represents a digit
    # Generate random letters for A's
    random_letters = ''.join(random.choices(string.ascii_uppercase, k=2))
    # Generate random digits for 1's
    random_digits = ''.join(random.choices(string.digits, k=7))
    # Combine letters and digits according to the format
    passport_number = passport_format.replace('A', random_letters).replace('1', random_digits)
    return passport_number


def generate_passport_issue_date():
    # Get the current date
    current_date = datetime.now()

    # Calculate the passport issue date (2 days before the current date)
    issue_date = current_date - timedelta(days=2)

    # Format the dates as "dd/mm/yyyy"
    formatted_issue_date = issue_date.strftime("%d/%m/%Y")

    return formatted_issue_date


#
# def transpose_list(list_of_lists):
#     return [list(row) for row in zip(*list_of_lists)]
#
# def extract_values_from_each_row(transposed_list):
#     return [[row[i] for row in transposed_list] for i in range(len(transposed_list[0]))]
@keyword
def transpose_list(list_of_lists):
    return [list(row) for row in zip(*list_of_lists)]


@keyword
def extract_values_from_each_row(transposed_list):
    return [[row[i] for row in transposed_list] for i in range(len(transposed_list[0]))]


def format_output_for_transposed_string(input_list):
    formatted_list = []
    for sublist in input_list:
        formatted_sublist = []
        for item in sublist:
            formatted_item = item.replace(" ", "")
            formatted_item = ": ".join(part.strip() for part in formatted_item.split(":"))
            formatted_sublist.append(formatted_item)
        formatted_list.append(" ,".join(formatted_sublist))
    return formatted_list


@keyword
def convert_name_format(name):
    # Splitting the input string into parts
    parts = name.split(' ')
    # Extracting relevant parts of the name
    last_name = parts[1].split('/')[0]
    first_name = parts[1].split('/')[1]
    title = parts[2]
    suffix = parts[3]
    # Constructing the new format
    new_format = f"{title} {first_name} {last_name} {suffix}"
    return new_format


@keyword
def calculate_totals_of_fares_and_taxes(dictionary):
    total_base_fare = 0
    total_taxes = 0
    for key, value in dictionary.items():
        if 'Base_Fare' in key:
            total_base_fare += float(value)
        elif 'Taxes' in key:
            total_taxes += float(value)
    return {'Total_Base_Fare': total_base_fare, 'Total_Taxes': total_taxes}


@keyword
def extract_time_and_date(input_string):
    time_pattern = r'\b\d{1,2}:\d{2}\b'
    date_pattern1 = r'\b\w{3} \d{1,2}-\w{3}\b'
    date_pattern2 = r'\b\w{3} \d{1,2}, \w{3}\b'
    try:
        time_match = re.search(time_pattern, input_string)
        time = time_match.group()
    except AttributeError:
        time = None
    try:
        date_match1 = re.search(date_pattern1, input_string)
        date1 = date_match1.group()
    except AttributeError:
        date1 = None
    try:
        date_match2 = re.search(date_pattern2, input_string)
        date2 = date_match2.group()
    except AttributeError:
        date2 = None
    return time, date1 or date2


@keyword
def convert_list_to_dictionary(input_list):
    result_dict = {}
    counts = {}
    for item in input_list:
        try:
            key, value = item.split('=')
        except ValueError:
            print(f"Issue splitting item: {item}")
            continue
        counts[key] = counts.get(key, 0) + 1
        if counts[key] > 1:
            key += str(counts[key])
        result_dict[key] = value
    return result_dict


@keyword
def calculate_totals(dictionary):
    totals = {}
    for key, value in dictionary.items():
        base_key = key.split('2')[0]  # Extract base key without numeric suffix
        if base_key.startswith('Base Fare'):
            if 'Base Fare' not in totals:
                totals['Base Fare'] = 0
            try:
                totals['Base Fare'] += float(value)
            except ValueError:
                print(f"Value '{value}' for key '{key}' is not a valid number.")
        else:
            if base_key not in totals:
                totals[base_key] = 0
            try:
                totals[base_key] += float(value)
            except ValueError:
                print(f"Value '{value}' for key '{key}' is not a valid number.")
    return totals


def handle_print_dialog():
    # Wait for the print dialog to appear (adjust the delay as needed)
    time.sleep(2)

    # Send keyboard shortcut to close the print dialog (usually 'Esc')
    keyboard.press_and_release('esc')


def remove_date_before_pp(lst):
    def remove_date(input_string):
        # Split the string by space
        components = input_string.split()

        # Find the index of 'PP' if it exists
        pp_index = next((i for i, comp in enumerate(components) if 'PP' in comp), None)

        # If 'PP' is found, remove dates before it, else return the original string
        if pp_index is not None:
            filtered_components = components[pp_index:]
            return ' '.join(filtered_components)
        else:
            return input_string

    return [remove_date(item) for item in lst]


def extract_passport_details(text):
    parts = text.split(",")  # Split the text by comma
    passport_info = parts[1:]  # Get the parts containing passport details (excluding the date)
    passport_info_cleaned = [info.strip() for info in passport_info if
                             info.strip()]  # Remove any empty or whitespace-only parts
    passport_info_str = ' '.join(passport_info_cleaned)  # Join the cleaned parts into a single string
    # Replace colon-space with colon
    passport_info_str = passport_info_str.replace(" : ", " :")
    return passport_info_str


def convert_to_round_off_number(value):
    try:
        formatted_number = math.trunc(value)
        return formatted_number
    except ValueError:
        print("Error: Input should be a number")
        return None


def check_download(timestamp):
    # user_name = getpass.getuser()
    script_dir = os.path.dirname(__file__)
    default_download_path = os.path.join(script_dir, '..', '..', 'Download', 'csv_files', '*')
    # default_download_path = os.path.abspath(r'..\\Login\Download\*')
    files_list = glob.glob(default_download_path)
    print(files_list)
    for i in files_list:
        if (timestamp < os.path.getctime(i)):
            print(timestamp)
            os.path.getctime(i)
            return i
    return False


def verify_partial_equality(dict1, dict2, key_mapping):
    for key1, key2 in key_mapping.items():
        if key1 in dict1 and key2 in dict2:
            value1 = dict1[key1].split(" - ")[-1].split("\n")[0].split(",")[0].strip()
            value2 = dict2[key2].split("(")[-1].split(")")[0].strip()
            if value1 == value2:
                logger.info(f"Values for keys '{key1}' and '{key2}' are equal: {value1}")
            else:
                logger.error(f"Values for keys '{key1}' and '{key2}' are not equal: {value1} != {value2}")
                return False
        else:
            logger.error(f"Keys '{key1}' and '{key2}' not found in both dictionaries")
            return False

    logger.info("All specified keys and their values are equal")
    return True


def get_csv_headers(filepath):
    with open(filepath, 'r') as f:
        dict_reader = csv.DictReader(f)
        # get header fieldnames from DictReader and store in list
        headers = dict_reader.fieldnames
        # sample file reading logic
    return headers


def get_csv_headers_for_amendment(filepath):
    with open(filepath, 'r', encoding='utf-8-sig') as f:
        dict_reader = csv.DictReader(f)

        headers = dict_reader.fieldnames

        cleaned_headers = [header.replace('"', '') for header in headers if not header.startswith('ï»¿')]
    return cleaned_headers


def get_data_by_header_row(filepath, header, row_number):
    try:
        df = pd.read_csv(filepath)
        if header not in df.columns:
            logger.error(f"Error: Header '{header}' not found in the CSV file.")
            return None
        if row_number < 0 or row_number >= len(df):
            logger.error(f"Error: Row number {row_number} is out of range.")
            return None
        return df.loc[row_number, header]
    except FileNotFoundError:
        logger.error(f"Error: File not found - {filepath}")
        return None
    except Exception as e:
        logger.error(f"Error reading CSV file: {e}")
        return None


@keyword
def extract_date_only(datetime_str):
    # Parse the datetime string into a datetime object
    dt_obj = datetime.strptime(datetime_str, '%d/%m/%YT%H:%M')

    # Extract the date portion from the datetime object
    date_only = dt_obj.date()

    return date_only.strftime('%d/%m/%Y')


def next_month_date(selected_day):
    # Ensure selected_day is an integer
    selected_day = int(selected_day)

    current_date = datetime.now()
    a = 1  # Setting 'a' to 1 to move one month ahead
    new_month = current_date.month + a
    # Calculate the new year if the new month is greater than 12
    new_year = current_date.year + (new_month - 1) // 12

    # Adjust the new month to be within 1 to 12
    new_month = (new_month - 1) % 12 + 1

    # Calculate the day of the new date, taking care of leap years and different month lengths
    new_day = min(selected_day, [31,
                                 29 if new_year % 4 == 0 and (new_year % 100 != 0 or new_year % 400 == 0) else 28,
                                 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][new_month - 1])
    new_date = datetime(new_year, new_month, new_day)

    print("Current Date:", current_date.strftime("%d-%m-%Y"))
    print(f"Selected Date in Next Month: {new_date.strftime('%d-%m-%Y')}")

    month_new = new_date.strftime("%B")
    day_new = new_date.strftime("%d").lstrip('0')  # Remove leading zero for day
    year_new = new_date.strftime("%Y")

    print(day_new, year_new, month_new)

    main_list = [day_new, month_new, year_new]
    return main_list


def convert_date_for_inventory(date_string):
    # Assuming the date_string is in the format '01/05/2024'
    date_object = datetime.strptime(date_string, '%d/%m/%Y')
    formatted_date = date_object.strftime('%B %d, %a')
    return formatted_date


@keyword
def extract_fare_rule_user_id(user_id_text):
    try:
        user_id = re.search(r'\d+', user_id_text).group()
        return user_id
    except AttributeError:
        print("User ID not found in the text.")
        return None


def get_layover_time(string):
    split_text = string.split("-", 1)
    # Check if "layover" is found in the text
    if len(split_text) > 1:
        # Get the substring after "layover"
        substring_after_layover = split_text[1].strip()
        print(substring_after_layover)
        return substring_after_layover


def replace_month_name(text):
    month_mapping = {
        'Jan': 'January',
        'Feb': 'February',
        'Mar': 'March',
        'Apr': 'April',
        'May': 'May',
        'Jun': 'June',
        'Jul': 'July',
        'Aug': 'August',
        'Sep': 'September',
        'Oct': 'October',
        'Nov': 'November',
        'Dec': 'December'
    }

    original_text = text  # Save the original text before modification

    for month_abbr, month_full in month_mapping.items():
        if month_abbr in text:
            text = text.replace(month_abbr, month_full)

    print("Original Text:", original_text)
    print("Modified Text:", text)
    return text


def extract_values_inside_parentheses(string_list):
    extracted_values = []
    pattern = r'\((.*?)\)'  # Regular expression to match content inside parentheses
    for item in string_list:
        match = re.search(pattern, item)
        if match:
            extracted_values.append(match.group(1))
    return extracted_values


@keyword
def get_month_name(month_number):
    try:
        month_name = calendar.month_name[month_number]
        return month_name
    except (IndexError, KeyError):
        return "Invalid month number"


@keyword
def compare_dates(user_date):
    try:
        user_date_obj = datetime.strptime(user_date, '%d-%m-%Y')
        current_date_obj = datetime.now()
        if user_date_obj > current_date_obj:
            return 1
        elif user_date_obj < current_date_obj:
            return 2
        else:
            return 0
    except ValueError:
        return "Invalid date format. Please enter the date in the format YYYY-MM-DD."


@keyword
def extract_date_component(date_str):
    # Split the date string by '/' to separate day, month, and year
    day, month, year = map(int, date_str.split('-'))

    # Return a list containing day, month, and year
    return [day, month, year]


@keyword
def compare_dates_for_to(user_dateto, user_datefrom):
    try:
        user_datefrom = datetime.strptime(user_datefrom, '%d-%m-%Y')
        user_dateto = datetime.strptime(user_dateto, '%d-%m-%Y')
        if user_datefrom > user_dateto:
            return 1
        elif user_datefrom < user_dateto:
            return 2
        else:
            return 0
    except ValueError:
        return "Invalid date format. Please enter the date in the format YYYY-MM-DD."


def extract_digits_after_rupee(string):
    pattern = r'₹(\d+)'
    match = re.search(pattern, string)
    if match:
        return match.group(1)
    else:
        return None


def extract_passport_number_from_booking_summary(booking_summary):
    parts = booking_summary.split()  # Split the string by spaces
    for i, part in enumerate(parts):
        if part == 'PP':  # Look for 'PP' in the parts
            return parts[i + 1].lstrip(':')


def extract_issue_date_from_booking_summary(booking_summary):
    parts = booking_summary.split()  # Split the string by spaces
    try:
        index = parts.index('ID')  # Find the index of 'ED'
        date = parts[index + 1]  # Get the date after 'ED'
        return date.lstrip(':')  # Remove any leading ':' character
    except ValueError:
        return None  # Return None if 'ED' is not found


def extract_expiry_date_from_booking_summary(booking_summary):
    parts = booking_summary.split()  # Split the string by spaces
    try:
        index = parts.index('ED')  # Find the index of 'ED'
        date = parts[index + 1]  # Get the date after 'ED'
        return date.lstrip(':')  # Remove any leading ':' character
    except ValueError:
        return None  # Return None if 'ED' is not found


def convert_lock_date_format(date_str):
    # Convert the input string to a datetime object
    date_obj = datetime.strptime(date_str, "%d/%m/%YT%H:%M")

    # Convert the datetime object to the desired format
    formatted_date = date_obj.strftime("%b %d, %Y %I:%M %p").lstrip("0").replace(" 0", " ")

    return formatted_date


def select_next_30_days_from_current_date():
    current_date = datetime.now()
    new_date = current_date + timedelta(days=40)

    new_day = new_date.strftime("%d")
    month_new = new_date.strftime("%B")
    year_new = new_date.strftime("%Y")

    # Remove leading zero if present
    if new_day[0] == "0":
        new_day = new_day[1]

    main_list = [new_day, month_new, year_new]
    return main_list


def convert_date_for_pdf(date_string):
    # Parse the input date string
    input_date = datetime.strptime(date_string, '%b %d, %Y %I:%M %p')
    # Format the date as "Feb2,2024"
    output_date = input_date.strftime('%b') + str(input_date.day) + ',' + str(input_date.year)
    return output_date


def is_next_three_months(date_str):
    # Convert the date string to a datetime object
    date = datetime.strptime(date_str, '%d/%m/%Y')

    # Get the current month
    current_month = datetime.now().month

    # Calculate the month 3 months from now
    three_months_from_now_month = (current_month + 3) % 12

    # Adjust the year if the month exceeds 12
    three_months_from_now_year = datetime.now().year + ((current_month + 3) // 12)

    # Check if the month of the given date is exactly 3 months from the current month
    if date.month == three_months_from_now_month and date.year == three_months_from_now_year:
        return True
    else:
        return False


def round_numbers(numbers):
    rounded_numbers = round(float(numbers))
    return rounded_numbers

def extract_city(text):
    text_before_comma = text.split(',')[0].strip()
    return text_before_comma


def convert_date_format(input_date):
    # Split the input date string into day, month, and year
    day, month, year = input_date.split('-')

    # Rearrange the parts to form the output date string
    output_date = f"{year}-{month}-{day}"

    return output_date

def get_valid_url(url):
    base_url = url.split(".com/")[0] + ".com/"
    return base_url


def is_real_number(value):
    # Remove ₹ symbols, commas, spaces, and any special characters except digits
    numbers = re.findall(r'\d+', value)

    # Check if we have at least one valid number
    if numbers:
        return True
    return False


from openpyxl import Workbook
from openpyxl.utils.exceptions import InvalidFileException
import openpyxl
import os

@keyword
def append_booking_id_to_excel(file_name, From=None, To=None, Adults=None, Childrens=None, Infants=None, Booking_Id=None, Pax_Label=None, FareType=None):
    print(">>>>>")
    print(file_name)

    # Check if file exists and is .xlsx format
    if not file_name.endswith('.xlsx'):
        print(f"Invalid file format for {file_name}. Expected .xlsx file.")
        return

    if not os.path.isfile(file_name):
        print(f"File {file_name} not found. Creating a new file.")
        workbook = Workbook()
        sheet = workbook.active
        sheet.append(["From", "To", "Adults", "Childrens", "Infants", "Booking_Id", "Pax_Label", "FareType"])
        workbook.save(file_name)
        return

    try:
        # Try to open the existing workbook
        workbook = openpyxl.load_workbook(file_name)
        sheet = workbook.active
    except InvalidFileException:
        print(f"Error: The file {file_name} is not a valid .xlsx file.")
        return

    # Append data
    sheet.append([From, To, Adults, Childrens, Infants, Booking_Id, Pax_Label, FareType])
    workbook.save(file_name)



import random
import string

@keyword
def generate_valid_pan():
    # First 5 characters are uppercase letters
    first_five = ''.join(random.choices(string.ascii_uppercase, k=5))

    # Next 4 characters are digits
    next_four = ''.join(random.choices(string.digits, k=4))

    # Last character is an uppercase letter
    last_char = random.choice(string.ascii_uppercase)

    # Combine all to form a valid PAN number
    pan_number = first_five + next_four + last_char
    return pan_number

# # Example usage
# valid_pan = generate_valid_pan()
# print("Generated PAN:", valid_pan)

