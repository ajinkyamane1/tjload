import re
import time
import subprocess
import os
time.sleep(30)



# Read the contents of the file
with open("report_data.txt", "r") as file:
    text = file.read()

# Define a regular expression pattern to extract the path
pattern = r'/tmp/\d+/allure-report'

# Find all matches of the pattern in the text
matches = re.findall(pattern, text)

if matches:
    # Extract the first match (assuming there's only one match)
    path = matches[0]
    print("Extracted path:", path)
else:
    print("No path found in the text file.")


shell_command = 'cp allure-results/**screenshot**'+ ' '+ path+"/data/attachments/"


# Execute the shell command
process = subprocess.Popen(shell_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = process.communicate()

# Check if the command was successful
if process.returncode == 0:
    print("Shell command executed successfully.")
    print("Output:")
    print(stdout.decode())
else:
    print("Error executing shell command:")
    print(stderr.decode())

