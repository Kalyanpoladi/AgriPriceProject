\# AgriPrice Project — Agricultural Price Analytics Pipeline



An end-to-end data analytics project: raw agricultural market data is cleaned with Python, stored in MySQL, analyzed with SQL, automated with a pipeline script, and visualized in a Power BI dashboard with price forecasting.



\---



\## About the Data



\- Source file: Agnamarket.xlsx

\- Time period: February 2023 to September 2026

\- Records: 1,629 monthly rows

\- Fields: State/UT, Commodity Group, Commodity, Month, Arrival Quantity, Arrival Unit, Modal Price, Price Unit



\---



\## Project Steps



1\. Cleaning: Python (pandas) script removes nulls and duplicates, fixes column names, and creates date columns (Month\_dt, Month\_num, Year).

2\. Database: Data is loaded into a MySQL table called agri\_prices in the agriprice database using SQLAlchemy.

3\. Analysis: SQL queries answer three business questions (demand ranking, price changes, seasonality).

4\. Automation: One command (run\_pipeline.py) runs cleaning and loading together, with timestamped log files.

5\. Dashboard: Power BI report with 4 pages, 8 DAX measures, slicers, and a 10-month price forecast.



\---



\## Tech Stack



\- Python (pandas, SQLAlchemy, PyMySQL)

\- MySQL

\- SQL

\- Power BI Desktop (DAX, forecasting)

\- Git and GitHub



\---



\## Key Findings



1\. Demand: Onion is the most demanded commodity with 1,900,718 total arrivals, more than double Tomato (806,984) and Potato (709,943).



2\. Price change (Feb 2023 to Sep 2026):

&#x20;  - Onion: +199 percent (highest demand AND huge price growth)

&#x20;  - Raddish: +268 percent (largest percentage gain)

&#x20;  - Garlic: +6,102 rupees per quintal (largest absolute jump)

&#x20;  - Colacasia: -62 percent (biggest decline)



3\. Seasonality:

&#x20;  - Cheapest month: March (about 2,087 rupees per quintal) - winter harvest supply

&#x20;  - Costliest months: June (3,020) and December (2,968) - monsoon and festival demand

&#x20;  - Onion specifically: cheapest in March-April (about 10 rupees per kg), costliest in September-November (26-28 rupees per kg)



4\. Forecast: The Power BI dashboard predicts Onion prices 10 months into the future with a 95 percent confidence band, using its built-in seasonal forecasting model.



\---



\## How to Run



Step 1: Create the database.

Open MySQL Workbench and run the file sql/01\_create\_database.sql



Step 2: Update the password.

Open scripts/load\_to\_mysql.py and put your MySQL password in the connection string.



Step 3: Run the pipeline.

Open a terminal in the project folder and run:



&#x20;   python scripts/run\_pipeline.py



This cleans the raw data, loads it into MySQL, and saves a log file in the logs folder.



Step 4: Verify the data.

Run this in MySQL Workbench:



&#x20;   SELECT COUNT(\*) FROM agriprice.agri\_prices;



Expected result: 1629 rows.



Step 5: Open the dashboard.

Open dashboard/AgriPrice\_Dashboard.pbix in Power BI Desktop.



\---



\## Problems Solved During the Project



1\. Column rename failed silently: pandas rename() skips keys that do not match exactly. The raw file header contained a date range that changed, so I switched to phrase matching (if "Arrival Quantity" is in the column name) and verified headers after every step.



2\. Table suddenly empty: I accidentally ran TRUNCATE on the whole script in MySQL Workbench. Lesson: the lightning button runs everything if nothing is highlighted. Now TRUNCATE is always commented out in saved scripts.



3\. PowerShell script corrupted: pasting code into Notepad mangled special characters. Fixed by rewriting the runner in Python, which has no such problem.



4\. Wrong price spikes in charts: 52 rows were priced per BUNDLE while 1,577 rows were priced per QUINTAL. Mixing units in averages created false spikes. Fixed with a price unit filter on every page.



5\. Forecast predicted negative prices: Power BI auto-expanded the date into a hierarchy (Year, Month, Day) which broke the forecasting grain. Fixed by using the raw Month\_dt column and setting seasonality to 12 (monthly data).



\---



\## Future Improvements



\- Separate bundle and quintal prices at the pipeline level

\- Incremental loading for larger datasets

\- Python Prophet forecasting for model comparison

\- Scheduled automation for hands-free runs

\- Publishing the report to Power BI Service



\---



This project covers the full analytics lifecycle: raw data, pipeline, database, SQL insights, automation, and an interactive forecasting dashboard.



