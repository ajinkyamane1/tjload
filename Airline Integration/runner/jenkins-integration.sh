
RETURN_DATA=$(python -c "import Listener; print(Listener.extract_suites())")

# Add spaces before '../' in the returned data
RETURN_DATA="${RETURN_DATA}"

#Execution Steps

rm -rf allure-report allure-results pabot_results output.xml log.html

pip install -r ../requirements.txt

pabot --testlevelsplit --processes 12 --listener RetryFailed:1 --listener allure_robotframework:./allure-results $RETURN_DATA

python3 EmailNotifier.py


pause
