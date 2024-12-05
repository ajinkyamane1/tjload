pabot --testlevelsplit --processes 4 --listener RetryFailed:1 --listener allure_robotframework:.\allure-results ..\TestCases

rd /s /q .\allure-results\history\

mkdir allure-results\history

allure generate allure-results/ --clean