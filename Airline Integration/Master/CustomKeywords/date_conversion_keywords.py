from datetime import datetime

from robot.api.deco import keyword
from openpyxl import load_workbook

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
def format_date_in_month(input_date):
    date_obj = datetime.strptime(input_date, '%d-%m-%Y')
    formatted_date = date_obj.strftime('%b %d')
    return formatted_date
