import os

# Path to the folder containing PNG files
folder_path = "allure-results"

# Iterate through all files in the folder
for filename in os.listdir(folder_path):
    if filename.endswith(".png"):
        # Split the filename at the first "-" character
        parts = filename.split("-", 1)
        if len(parts) > 1:
            # Get the part after the first "-"
            new_filename = parts[1]
            # Construct the new file path
            new_file_path = os.path.join(folder_path, new_filename)
            # Rename the file
            os.rename(os.path.join(folder_path, filename), new_file_path)
            print(f"Renamed: {filename} -> {new_filename}")
                                                                                                                                                                                        
