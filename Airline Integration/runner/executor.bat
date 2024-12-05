pip install -r ../requirements.txt

pabot --testlevelsplit --processes 4 --outputdir ..\Output ..\TestCases

python EmailNotifier.py

python PerformanceMetrics.py

pause

