import imaplib
import email
import re


def search_and_fetch_email(server, port, email_address, password, subject):
    # Connect to the email server
    mail = imaplib.IMAP4_SSL(server, port)
    mail.login(email_address, password)
    mail.select('inbox')

    # Search for emails with the specified subject
    result, data = mail.search(None, f'(SUBJECT "{subject}")')
    email_ids = data[0].split()

    # Fetch the latest email and extract the OTP from its body
    if email_ids:
        latest_email_id = email_ids[-1]
        result, data = mail.fetch(latest_email_id, '(RFC822)')
        raw_email = data[0][1].decode('utf-8')  # Decode bytes to string

        email_message = email.message_from_string(raw_email)  # Use message_from_string to parse email content

        # Extract the OTP from the email body
        email_body = ""
        if email_message.is_multipart():
            for part in email_message.walk():
                if part.get_content_type() == "text/plain":
                    email_body += part.get_payload(decode=True).decode()
        else:
            email_body = email_message.get_payload(decode=True).decode()

        return email_body
    # If no email with the specified subject is found or no OTP is found in the email body
    return None


def get_otp_from_email(server, port, email_address, password, subject):
    email_body = search_and_fetch_email(server, port, email_address, password, subject)
    print(email_body)
    otp_matches = re.findall(r'\b\d{6}\b', email_body)  # Adjust the regular expression based on OTP format
    print(otp_matches)
    if otp_matches:
        otp = otp_matches[0]
        return otp


def check_email_contains_otp(server, port, email_address, password, subject):
    email_body = search_and_fetch_email(server, port, email_address, password, subject)
    if re.search(r'\b\d{6}\b', email_body):
        return True
    else:
        return False

def validate_email(email):
    # Regular expression pattern for validating email addresses
    pattern = r'^[\w\.-]+@[\w\.-]+\.\w+$'
    return re.match(pattern, email) is not None


def validate_mobile_number(mobile_number):
    # Regular expression pattern for validating mobile numbers (assumed 10 digits)
    pattern = r'^\d{10}$'
    return re.match(pattern, mobile_number) is not None
