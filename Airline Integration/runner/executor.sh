#rm -rf allure-report allure-results pabot_results output.xml log.html
#
#sudo kill -9 `sudo lsof -t -i:8900`

pip3 install -r ../requirements.txt

pabot --testlevelsplit --pabotlib --processes 20 ../TestCases/BookingFlowTestCases


#python3 PerformanceMetrics.py

#allure generate --single-file allure-results --clean

#rm -rf report_data.txt
#rm -rf **screenshot**
#
#cp allure-results/output.xml ../runner/
#
##allure generate allure-results --clean
#
#allure serve allure-results --port 8900 >> report_data.txt &
#
#python3 RemoveFirst.py &
#
#python3 ExtractLocation.py &
#
#python3 EmailNotifier.py
#

pause


