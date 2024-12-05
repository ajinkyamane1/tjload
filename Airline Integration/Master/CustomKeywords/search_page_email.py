import imaplib
import email
import os
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
        email_body = ""
        if email_message.is_multipart():
            for part in email_message.walk():
                if part.get_content_type() == "text/EmailWebScrapping":
                    email_body += part.get_payload(decode=True).decode()
        else:
            email_body = email_message.get_payload(decode=True).decode()
            #print(email_body)
            return email_body

    return None


def get_email(server, port, email_address, password, subject):
    email_body = search_and_fetch_email(server, port, email_address, password, subject)


    return str(email_body)

# if __name__ == '__main__':
#     server = 'imap.gmail.com'
#     IMAP_PORT = 993
#     EMAIL = 'ajinkya.mane@indexnine.com'
#     PASSWORD = "ozum ydlx yttm jveq"
#     SUBJECT = "Flights | Goa In -> Bengaluru | 2024-08-28"
#     notifier = get_email(server, IMAP_PORT, EMAIL, PASSWORD, SUBJECT)
#     print(notifier)
#     print("<<<...>>>")
