import openpyxl
from openpyxl import Workbook

def append_to_excel(file_name, From=None, To=None, Adults=None, Childrens=None, Infants=None, Booking_Id=None, Pax_Label=None, Connectivity=None):

    try:
        # Try to open the existing workbook
        workbook = openpyxl.load_workbook(file_name)
        sheet = workbook.active
    except FileNotFoundError:
        # If the file doesn't exist, create a new workbook and add headers
        workbook = Workbook()
        sheet = workbook.active
        # Add headers to the new file
        sheet.append(["From", "To", "Adults", "Childrens", "Infants", "Booking_Id","Pax_Label", "Connectivity"])
        print(f"File {file_name} not found. Creating a new file with headers.")

    # Find the next empty row and append the data
    sheet.append([From, To, Adults, Childrens, Infants, Booking_Id, Pax_Label, Connectivity])

    # Save the workbook
    workbook.save(file_name)

    print(f"Data appended to {file_name} successfully.")

append_to_excel("bookings.xlsx", From="New York", To="Los Angeles", Adults=2, Childrens=1, Infants=0, Booking_Id="B12345",Pax_Label=None, Connectivity=None)
