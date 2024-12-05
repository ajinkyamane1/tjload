import xml.etree.ElementTree as ET
from datetime import datetime
import pandas as pd
import matplotlib.pyplot as plt
import io
import base64

def calculate_elapsed_times(xml_paths):
    keyword_data = []
    test_data = []
    suite_data = []  # Added list for suite data

    for xml_path in xml_paths:
        context = ET.iterparse(xml_path, events=("start", "end"))
        _, root = next(context)

        for event, elem in context:
            if event == "end" and elem.tag == "kw":
                keyword_name = elem.attrib.get('name', 'Unknown Keyword')
                keyword_library = elem.attrib.get('library', 'Unknown Library')

                if keyword_name not in [
                    "((//div[@class='col-sm-6 domestic_tiles_view'])[2]//child::button[text()='View Details'])[1]"]:
                    # Check if the library is not SeleniumLibrary or BuiltIn
                    if keyword_library not in ['SeleniumLibrary', 'BuiltIn', 'Collections', 'String']:
                        status_element = elem.find('status')

                        if status_element is not None and 'status' in status_element.attrib:
                            status = status_element.attrib['status']
                        else:
                            status = 'Unknown Status'

                        if status.upper() in ['PASS', 'FAIL']:
                            start_time_str = status_element.attrib.get('starttime', '')
                            end_time_str = status_element.attrib.get('endtime', '')

                            start_time = datetime.strptime(start_time_str, "%Y%m%d %H:%M:%S.%f")
                            end_time = datetime.strptime(end_time_str, "%Y%m%d %H:%M:%S.%f")

                            elapsed_time = (end_time - start_time).total_seconds()
                            keyword_data.append({'name': keyword_name, 'elapsed_time': elapsed_time, 'status': status})

            elif event == "end" and elem.tag == "suite":
                suite_name = elem.attrib.get('name', 'Unknown Suite')
                suite_id = elem.attrib.get('id', 'Unknown id')

                # Exclude suites with id 's1' and 's1-s1'
                if suite_id in ['s1-s1', 's1-s2', 's1-s3', 's1-s4', 's1-s5', 's1-s6', 's1-s7', 's1-s8', 's1-s9',
                                's1-s10', 's1-s11', 's1-s12', 's1-s13']:
                    total_suite_elapsed_time = 0

                    for test in elem.findall('.//test'):
                        test_name = test.attrib.get('name', 'Unknown Test')
                        status_element = test.find('status')

                        if status_element is not None and 'status' in status_element.attrib:
                            status = status_element.attrib['status']
                        else:
                            status = 'Unknown Status'

                        start_time_str = status_element.attrib.get('starttime', '')
                        end_time_str = status_element.attrib.get('endtime', '')

                        start_time = datetime.strptime(start_time_str, "%Y%m%d %H:%M:%S.%f")
                        end_time = datetime.strptime(end_time_str, "%Y%m%d %H:%M:%S.%f")

                        elapsed_time = (end_time - start_time).total_seconds()
                        total_suite_elapsed_time += elapsed_time

                        test_data.append({'suite_name': suite_name, 'test_name': test_name, 'status': status,
                                          'elapsed_time': elapsed_time})

                        status_element = elem.find('status')
                        status = status_element.attrib['status']
                        suite_data.append(
                            {'suite_name': suite_name, 'status': status, 'elapsed_time': total_suite_elapsed_time})

                root.clear()  # Clear the processed elements from memory

    return keyword_data, test_data, suite_data


def generate_report(keyword_data, test_data, suite_data):
    # Create DataFrames from the lists of dictionaries
    keyword_df = pd.DataFrame(keyword_data)
    test_df = pd.DataFrame(test_data)
    suite_df = pd.DataFrame(suite_data)

    # Group by 'name', 'library'; calculate the min, max, and average elapsed time, and count the occurrences
    keyword_grouped = keyword_df.groupby(['name']).agg(
        {'elapsed_time': ['min', 'max', 'mean'], 'name': 'count'}).rename(
        columns={'name': 'execution_count'}).reset_index()

    # Rename columns for clarity
    keyword_grouped.columns = ['name', 'min_duration', 'max_duration', 'avg_duration', 'execution_count']

    # Add 'Pass Count' and 'Fail Count' columns
    pass_fail_counts = keyword_df[keyword_df['status'].isin(['PASS', 'FAIL'])].groupby(
        ['name', 'status']).size().unstack(fill_value=0).reset_index()
    keyword_grouped = pd.merge(keyword_grouped, pass_fail_counts[['name', 'PASS', 'FAIL']], on='name',
                               how='left').fillna(0)

    # Highlight rows with average duration more than 20 seconds
    keyword_grouped['highlight'] = keyword_grouped['avg_duration'] > 20
    keyword_grouped['highlight_style'] = keyword_grouped['highlight'].apply(
        lambda x: 'background-color: #ffcccc;' if x else '')

    # Save the grouped DataFrame to an HTML file with navigation links and CSS styles
    with open('../Output/Performance_report.EmailWebScrapping', 'w') as html_file:
        html_file.write('<head><link rel="stylesheet" type="text/css" href="../runner/styles.css"></head>\n')
        html_file.write(
            '<body><nav><a href="dashboard.EmailWebScrapping">Dashboard</a>  <a href="Suite_Report.EmailWebScrapping">Suite</a>  <a href="Test_Case_Report.EmailWebScrapping">Test</a>  <a href="Performance_report.EmailWebScrapping">Keywords</a></nav>\n')

        html_file.write('<div id="keywords"><h2>Keyword Tab</h2>')
        # create div for both
        html_file.write(
            '<div id="whole" style="display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); grid-gap: 10px; padding: 20px; border-radius: 10px; margin-top: 20px;">')
        # Create a pie chart for the distribution of Pass and Fail
        plt.figure(figsize=(4, 4))
        plt.pie([keyword_grouped['PASS'].sum(), keyword_grouped['FAIL'].sum()], labels=['Pass', 'Fail'],
                autopct='%1.1f%%', startangle=140, colors=['#1FAB89', '#FF0000'])

        plt.title('Keyword Pass/Fail Distribution')

        # Save the pie chart as an image
        img_data = io.BytesIO()
        plt.savefig(img_data, format='png')
        img_data.seek(0)

        # Convert the image data to base64
        img_base64 = base64.b64encode(img_data.read()).decode('utf-8')

        # Embed the image in the HTML file
        html_file.write(f'<img src="data:image/png;base64,{img_base64}" alt="Pass/Fail Pie Chart">')

        # Create a div for summary information
        html_file.write(
            '<div id="summary-info" style="display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); grid-gap: 10px; padding: 20px; background-color: white; border-radius: 10px; margin-top: 20px;"><h2 style="text-align: center; grid-column: span 2;">Summary Information</h2>')
        html_file.write(
            '<div id="total-keywords" style="text-align: center;"><h3>Total Keywords</h3><p>{}</p></div>'.format(
                len(keyword_grouped)))
        html_file.write(
            '<div id="total-executions" style="text-align: center;"><h3>Total Executions</h3><p>{}</p></div>'.format(
                keyword_grouped['execution_count'].sum()))
        html_file.write('<div id="total-pass" style="text-align: center;"><h3>Total Pass</h3><p>{}</p></div>'.format(
            keyword_grouped['PASS'].sum()))
        html_file.write('<div id="total-fail" style="text-align: center;"><h3>Total Fail</h3><p>{}</p></div>'.format(
            keyword_grouped['FAIL'].sum()))

        html_file.write('</div>')
        html_file.write('</div>')
        html_file.write('<div><br></div>')
        # Add the CSS inline styles to the HTML table rows based on the 'highlight' column
        html_file.write('<table border="1" style="border-collapse: collapse; width: 100%;">\n')
        html_file.write(
            '<thead><tr><th>Keyword Name</th><th>Min Duration</th><th>Max Duration</th><th>Avg Duration</th><th>Execution Count</th><th>Pass Count</th><th>Fail Count</th></tr></thead>\n')
        html_file.write('<tbody>\n')
        for index, row in keyword_grouped.iterrows():
            html_file.write(f'<tr style="{row["highlight_style"]}">')
            html_file.write(f'<td>{row["name"]}</td>')
            html_file.write(f'<td>{row["min_duration"]:.2f}</td>')
            html_file.write(f'<td>{row["max_duration"]:.2f}</td>')
            html_file.write(f'<td>{row["avg_duration"]:.2f}</td>')
            html_file.write(f'<td>{row["execution_count"]}</td>')
            html_file.write(f'<td>{row["PASS"]}</td>')
            html_file.write(f'<td>{row["FAIL"]}</td>')
            html_file.write('</tr>\n')
        html_file.write('</tbody></table></div>')
        # html_file.write(f'{keyword_grouped.to_html(index=False, escape=False)}</div>')

    print("Tabular Report, Summary Information, and Pass/Fail Pie Chart saved to Performance_report.EmailWebScrapping")
    # Generate a separate HTML page for test case results
    test_count = generate_test_results_html(test_df)
    # Generate a separate HTML page for suite results
    generate_suite_report_html(suite_df)
    # Generate the Suite Report HTML
    generate_dashboard_html(keyword_grouped, test_count)
    # return keyword_df, test_count, suite_count

def generate_test_results_html(test_df):
    # Create a separate HTML page for test case results
    with open('../Output/Test_Case_Report.EmailWebScrapping', 'w') as test_html_file:
        test_html_file.write('<head><link rel="stylesheet" type="text/css" href="../runner/styles.css"></head>\n')
        test_html_file.write(
            '<body><nav><a href="dashboard.EmailWebScrapping">Dashboard</a>  <a href="Suite_Report.EmailWebScrapping">Suite</a>  <a href="Test_Case_Report.EmailWebScrapping">Test</a>  <a href="Performance_report.EmailWebScrapping">Keywords</a></nav>\n')
        test_html_file.write('<div id="test-data"><h2>Test Case Results</h2>')
        # Add a div for the pie chart
        plt.figure(figsize=(4, 4))
        plt.pie(test_df['status'].value_counts(), labels=test_df['status'].value_counts().index,
                autopct='%1.1f%%', startangle=140, colors=['#1FAB89', '#eb2d53'])
        plt.title('Test Case Pass/Fail Distribution')

        # Save the pie chart as an image
        img_data = io.BytesIO()
        plt.savefig(img_data, format='png')
        img_data.seek(0)

        # Convert the image data to base64
        img_base64 = base64.b64encode(img_data.read()).decode('utf-8')

        # Embed the image in the HTML file
        test_html_file.write(f'<img src="data:image/png;base64,{img_base64}" alt="Pass/Fail Pie Chart">')
        test_html_file.write('</div>')
        test_html_file.write('</div>')
        # Add table header
        test_html_file.write('<table border="1">\n')
        test_html_file.write(
            '<thead><tr><th>Suite Name</th><th>Test Name</th><th>Status</th><th>Elapsed Time</th></tr></thead>\n')
        test_html_file.write('<tbody>\n')
        # Add rows with links for each test name
        for index, row in test_df.iterrows():
            test_html_file.write('<tr>')
            test_html_file.write(f'<td>{row["suite_name"]}</td>')
            test_html_file.write(f'<td><a href="log.EmailWebScrapping">{row["test_name"]}</a></td>')
            test_html_file.write(f'<td>{row["status"]}</td>')
            test_html_file.write(f'<td>{row["elapsed_time"]:.2f} </td>')
            test_html_file.write('</tr>\n')
        # Close the table and div
        test_html_file.write('</tbody></table></div></div></body>')
    print("Test Case Report saved to Test_Case_Report.EmailWebScrapping")
    return test_df


def generate_suite_report_html(suite_df):
    # Create a separate HTML page for suite results
    with open('../Output/Suite_Report.EmailWebScrapping', 'w') as suite_html_file:
        suite_html_file.write('<head><link rel="stylesheet" type="text/css" href="../runner/styles.css"></head>\n')
        suite_html_file.write(
            '<body><nav><a href="dashboard.EmailWebScrapping">Dashboard</a>  <a href="Suite_Report.EmailWebScrapping">Suite</a>  <a href="Test_Case_Report.EmailWebScrapping">Test</a>  <a href="Performance_report.EmailWebScrapping">Keywords</a></nav>\n')
        suite_html_file.write('<div id="suite-data"><h2>Suite Results</h2><div class="scrollable-table">')

        # Group by 'suite_name' and select the first row for each group
        unique_suites = suite_df.groupby('suite_name').first().reset_index()

        # Add table header
        suite_html_file.write('<table border="1">\n')
        suite_html_file.write('<thead><tr><th>Suite Name</th><th>Status</th></tr></thead>\n')
        suite_html_file.write('<tbody>\n')

        # Add rows for each unique suite
        for index, row in unique_suites.iterrows():
            suite_html_file.write('<tr>')
            suite_html_file.write(f'<td>{row["suite_name"]}</td>')
            suite_html_file.write(f'<td>{row["status"]}</td>')
            suite_html_file.write('</tr>\n')

        suite_html_file.write('</tbody></table></div></div></body>')

    print("Suite Report saved to Suite_Report.EmailWebScrapping")
    return unique_suites


def generate_dashboard_html(keyword_grouped, test_df):
    # Calculate total passed and failed test cases
    total_pass_test_cases = test_df[test_df['status'] == 'PASS'].shape[0]
    total_fail_test_cases = test_df[test_df['status'] == 'FAIL'].shape[0]

    # Create a separate HTML page for the dashboard
    with open('../Output/dashboard.EmailWebScrapping', 'w') as dashboard_html_file:
        dashboard_html_file.write('<head><link rel="stylesheet" type="text/css" href="../runner/styles.css"></head>\n')
        dashboard_html_file.write(
            '<body><nav><a href="dashboard.EmailWebScrapping">Dashboard</a>  <a href="Suite_Report.EmailWebScrapping">Suite</a>  <a href="Test_Case_Report.EmailWebScrapping">Test</a>  <a href="Performance_report.EmailWebScrapping">Keywords</a></nav>\n')
        dashboard_html_file.write('<div id="dashboard"><h2>Overall Performance Dashboard</h2>')

        # Add a div for the pie chart of overall Pass/Fail Distribution for Test Cases
        plt.figure(figsize=(4, 4))
        plt.pie([total_pass_test_cases, total_fail_test_cases],
                labels=['Pass', 'Fail'], autopct='%1.1f%%', startangle=140, colors=['#1FAB89', '#eb2d53'])
        plt.title('Overall Pass/Fail Distribution for Test Cases')

        # Save the pie chart as an image
        img_data = io.BytesIO()
        plt.savefig(img_data, format='png')
        img_data.seek(0)

        # Convert the image data to base64
        img_base64 = base64.b64encode(img_data.read()).decode('utf-8')
        dashboard_html_file.write(
            '<div id="whole" style="display: grid; grid-gap: 10px; grid-template-columns: repeat(3, minmax(0, 1fr)); grid-gap: 10px; padding: 20px; border-radius: 10px; margin-top: 20px;">')
        # Embed the image in the HTML file
        dashboard_html_file.write(
            f'<img src="data:image/png;base64,{img_base64}" alt="Pass/Fail Pie Chart for Test Cases" style="margin-left:40px; margin-right:50px">')
        # Add a div for the pie chart of keyword Pass/Fail Distribution
        plt.figure(figsize=(4, 4))
        plt.pie([keyword_grouped['PASS'].sum(), keyword_grouped['FAIL'].sum()],
                labels=['Pass', 'Fail'], autopct='%1.1f%%', startangle=140, colors=['#1FAB89', '#eb2d53'])
        plt.title('Keyword Pass/Fail Distribution')

        # Save the pie chart as an image
        img_data = io.BytesIO()
        plt.savefig(img_data, format='png')
        img_data.seek(0)

        # Convert the image data to base64
        img_base64 = base64.b64encode(img_data.read()).decode('utf-8')

        # Embed the image in the HTML file
        dashboard_html_file.write(
            f'<img src="data:image/png;base64,{img_base64}" alt="Pass/Fail Pie Chart for Keywords" style="margin-left:30px;">')
        dashboard_html_file.write(
            '<div id="whole" style="display: grid; grid-template-columns: repeat(3); margin-left:30px; grid-gap: 10px; padding: 0px; border-radius: 0px; margin-top: 0px;">')

        # Add summary information
        dashboard_html_file.write(
            '<div id="summary-info" style="text-align: center; margin-top: 0px; background-color:white">')
        dashboard_html_file.write(f'<h3>Total Test Cases</h3><p>{len(test_df)}</p></div>')
        dashboard_html_file.write(
            '<div id="summary-info" style="text-align: center; margin-top: 20px; background-color:white">')
        dashboard_html_file.write(
            f'<h3 style="text-align: center;font-weight: bold; color:Green">Passed</h3><p style="text-align: center;font-weight: bold; color:Green">{total_pass_test_cases}</p></div>')
        dashboard_html_file.write(
            '<div id="summary-info" style="text-align: center; margin-top: 20px; background-color:white">')
        dashboard_html_file.write(
            f'<h3 style="text-align: center;font-weight: bold; color:Red">Failed</h3><p style="text-align: center;font-weight: bold; color:Red">{total_fail_test_cases}</p></div>')
        # dashboard_html_file.write(
        #     '<div id="summary-info" style="text-align: center; margin-top: 20px; background-color:white">')
        # dashboard_html_file.write(f'<h3>Total Suites</h3><p>{len(suite_df)}</p></div>')
        # dashboard_html_file.write(
        #     '<div id="summary-info" style="text-align: center; margin-top: 20px; background-color:white">')
        # dashboard_html_file.write(f'<h3>Total Keywords</h3><p>{len(keyword_grouped)}</p></div>')
        dashboard_html_file.write('</div>')
        dashboard_html_file.write('</div>')
        dashboard_html_file.write('</div></body>')
    print("Dashboard saved to dashboard.EmailWebScrapping")


if __name__ == "__main__":
    xml_paths = ["../Output/output.xml"]  # Update with the actual paths
    keyword_data, test_data, suite_data = calculate_elapsed_times(xml_paths)
    # Generate and print the report
    generate_report(keyword_data, test_data, suite_data)
