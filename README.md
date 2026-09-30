# Campaign Performance & Ad Spend ROI Dashboard

An end-to-end data analytics project for analyzing advertising campaign performance across Meta, Google Ads, TikTok, and LinkedIn.

## Dashboard
Link to the interactive dashboard -> https://public.tableau.com/views/Book1_17905283222390/CampaignPerformanceDashboard?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

![Campaign Performance Dashboard](dashboard/dashboard_preview.png)

The dashboard provides interactive analysis of:

- Revenue
- Spend
- ROAS
- ROI
- Conversions
- Platform performance
- Campaign performance
- Monthly performance

### Filters

- Date
- Platform
- Country
- Campaign Objective
- Ad Type

## Tech Stack

- Python
- Pandas
- MySQL
- SQL
- Tableau Public
- Git & GitHub

## About the Project

Campaign Performance & Ad Spend ROI Dashboard is an end-to-end data analytics project built to analyze advertising campaign performance across Meta, Google Ads, TikTok, and LinkedIn.

The project covers the complete data workflow, from generating and cleaning campaign data to storing it in MySQL, analyzing it with SQL, and building an interactive Tableau dashboard.

### What I Did

- Generated a realistic campaign performance dataset containing 10,000+ records.
- Created campaign data across multiple advertising platforms, countries, campaign objectives, and ad types.
- Built a Python data generation and ingestion script using Pandas.
- Performed data validation and quality checks, including:
  - Missing-value detection
  - Duplicate detection
  - Negative-value checks
  - Data-type validation
  - Inconsistent category/value detection
- Cleaned and prepared the campaign data for analysis.
- Organized the project into separate ingestion, cleaning, transformation, SQL, dashboard, and documentation layers.
- Loaded the cleaned campaign data into MySQL.
- Designed SQL queries to analyze overall campaign performance.
- Analyzed advertising performance by platform.
- Analyzed individual campaign performance.
- Analyzed campaign performance over time and by month.
- Performed advanced SQL analysis using CTEs, aggregate functions, `HAVING`, subqueries, and window functions.
- Calculated key marketing metrics including:
  - Spend
  - Revenue
  - ROAS
  - ROI
  - CPC
  - CPA
  - CTR
  - Conversion Rate
- Used ranking and window functions to compare campaigns within platforms.
- Analyzed monthly revenue changes and growth using `LAG()`.
- Created a SQL data source for the dashboard layer.
- Built an interactive Tableau dashboard containing:
  - Total Revenue
  - Total Spend
  - ROAS
  - ROI
  - Total Conversions
  - Monthly Revenue vs Spend
  - Platform Performance
  - Platform ROAS
  - Campaign Performance
  - Monthly Conversions
- Added interactive filters for:
  - Date
  - Platform
  - Country
  - Campaign Objective
  - Ad Type
- Connected the dashboard workflow to the SQL/MySQL analysis layer.
- Used Git and GitHub to version-control the project and document the development process.
