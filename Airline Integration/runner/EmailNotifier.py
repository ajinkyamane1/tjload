import os
import smtplib
import xmltodict
import json
from jinja2 import Template
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import datetime
import pytz
import sys

current_dir = os.path.dirname(os.getcwd())
parent_dir = os.path.join(current_dir, 'Output')
sys.path.append(current_dir)

from Environment import environments

receiver_email_value = environments.receiver_email

htmlTemplate = '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Statistics</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h1 {
            color: #333;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .percentage {
            color: #4CAF50; /* Green color for percentage */
        }
    </style>
</head>
<body>
    <h1><a href = "http://43.205.131.117:8900/index.html" > Total Statistics </a></h1>
    <table border="1">
        <thead>
            <tr>
                <th>Total Stats</th>
                <th>Total</th>
                <th>Pass</th>
                <th>Fail</th>
                <th>Skip</th>
                <th>Percentage %</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>{{ total["#text"] }}</td>
                <td>
                    {%- set pass_value = total["@pass"] | default(0) | int -%}
                    {%- set fail_value = total["@fail"] | default(0) | int -%}
                    {%- set skip_value = total["@skip"] | default(0) | int -%}

                    {%- set total_value = pass_value + fail_value + skip_value -%}

                    {{ total_value }}
                </td>
                <td>{{ total["@pass"] }}</td>
                <td>{{ total["@fail"] }}</td>
                <td>{{ total["@skip"] }}</td>
                <td class="percentage">
                    {%- set percentage = pass_value / total_value * 100 -%}
                    {{ percentage }}
                </td>
            </tr>
        </tbody>
    </table>
</body>
</html>
'''


def generate_html_table(data):
    # template_path = "template.html"
    # with open(template_path, "r") as template_file:
    #     template_content = template_file.read()

    template = Template(htmlTemplate)
    rendered_html = template.render(suites=data["statistics"]["suite"]["stat"],
                                    total=data["statistics"]["total"]["stat"])
    print(data["statistics"]["suite"]["stat"])
    with open("../test_statistics.html", "w") as output_file:
        output_file.write(rendered_html)


def convert_xml_to_json(xml_string):
    # Parse the XML string to an OrderedDict
    xml_dict = xmltodict.parse(xml_string)

    # Convert the OrderedDict to a JSON-formatted string
    json_string = json.dumps(xml_dict, indent=2)

    # Load the JSON string back to a Python object (dictionary)
    json_data = json.loads(json_string)

    return json_data


class EmailNotifier:
    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self, output_file='output.xml'):
        # def __init__(self):
        self.output_file = output_file
        file_name = output_file

        with open(file_name, "r") as file:
            file_contents = file.read()
            data = convert_xml_to_json(file_contents)
            generate_html_table(data['robot'])
            # generate_html_table(convert_xml_to_json(file_contents))
        send_email()


def send_email():
    # Email configuration
    date = get_date()
    sender_email = "noreplytripjackqaautomation@gmail.com"
    receiver_email = receiver_email_value
    # receiver_email = "airautoreport@tripjack.com"
    subject = "TripJack QA Automation Report " + date

    # Create the MIME object
    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = ", ".join(receiver_email)
    message["Subject"] = subject
    # file_path = "./allure-report/index.html"

    # file_name = os.path.basename(file_path)
    # Attach the file
    # with open(file_path, "rb") as attachment_file:
    #     attachment_part = MIMEApplication(attachment_file.read(), Name=file_name)
    #     attachment_part['Content-Disposition'] = f'attachment; filename="{file_name}"'
    #     message.attach(attachment_part)

    # Attach the HTML file
    html_file_path = "../test_statistics.html"
    with open(html_file_path, "r") as html_file:
        html_content = html_file.read()
        html_part = MIMEText(html_content, "html")
        message.attach(html_part)

        # Send the email
        smtp_server = "smtp.gmail.com"
        smtp_port = 587
        smtp_username = "noreplytripjackqaautomation@gmail.com"
        smtp_password = "dplljkedwxslibfp"
        with smtplib.SMTP(smtp_server, smtp_port) as server:
            server.starttls()
            server.login(smtp_username, smtp_password)
            server.sendmail(sender_email, receiver_email, message.as_string())


def get_date():
    utc_datetime = datetime.datetime.now(tz=pytz.utc)
    ist_timezone = pytz.timezone('Asia/Kolkata')
    ist_datetime = utc_datetime.astimezone(ist_timezone)
    return ist_datetime.strftime('%d-%m-%Y %H:%M')


if __name__ == '__main__':
    notifier = EmailNotifier()
