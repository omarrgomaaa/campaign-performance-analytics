create database campaign_analytics;
use campaign_analytics;

create table campaign_performance(
	campaign_id VARCHAR(20) primary key,
	campaign_name VARCHAR(100),
	platform VARCHAR(50),
	date DATE,
	country VARCHAR(50),
	campaign_objective VARCHAR(50),
	ad_type VARCHAR(50),
	impressions INT,
	clicks INT,
	conversions INT,
	spend DECIMAL(12,2),
	revenue DECIMAL(12,2)
    );
    
DESCRIBE campaign_performance;

SELECT COUNT(*) AS total_rows
FROM campaign_performance;

SELECT *
FROM campaign_performance
LIMIT 5;

-- How much total money was spent on advertising across all campaigns?
SELECT sum(spend) 
from campaign_performance;

-- How much total revenue was generated across all campaigns?
SELECT sum(revenue) 
from campaign_performance;

-- How much total advertising spend did each platform have?
SELECT platform , sum(spend)
from campaign_performance
group by platform;

-- Total revenue by platform
SELECT platform , sum(revenue)
from campaign_performance
group by platform;

-- How many campaign records does each platform have?
SELECT platform , count(campaign_id)
from campaign_performance
group by platform;

-- What is the average advertising spend per campaign record for each platform?
SELECT platform , avg(spend)
from campaign_performance
group by platform;

-- Find the campaign record with the highest spend.
select campaign_id , campaign_name , spend
from campaign_performance
ORDER BY spend desc
LIMIT 1;

-- Find the 10 campaigns with the highest advertising spend.
select campaign_id , campaign_name , spend
from campaign_performance
ORDER BY spend desc
LIMIT 10;

-- Find the 10 campaigns with the lowest advertising spend.
select campaign_id , campaign_name , spend
from campaign_performance
ORDER BY spend asc
LIMIT 10;

-- Find all campaign records where the platform is Meta.
Select campaign_id, campaign_name, platform, spend
from campaign_performance
where platform = 'Meta';

-- Find the 10 highest-spending Meta campaigns.
Select campaign_id, campaign_name , spend
from campaign_performance
where platform = 'Meta'
ORDER BY spend DESC
LIMIT 10;

-- Find all campaigns where spend is greater than 30,000.
Select campaign_id, campaign_name , spend
from campaign_performance
where spend > 30000
ORDER BY spend DESC;

-- Find campaigns where spend is greater than 30,000 AND conversions are greater than 1,000.
SELECT campaign_id, campaign_name, spend, conversions
FROM campaign_performance
WHERE spend > 30000 AND conversions > 1000
ORDER BY spend DESC;

-- Find campaigns that are either Meta OR TikTok.
select campaign_id, campaign_name, platform, spend
from campaign_performance
where platform = 'TikTok' or platform = 'Meta'
ORDER BY spend DESC;

-- Find campaigns where spend is between 10,000 and 20,000, inclusive.
select campaign_id, campaign_name, platform, spend
from campaign_performance
where spend between 9999 and 20001
ORDER BY spend DESC;

-- Find campaigns from Meta, TikTok, or LinkedIn.
SELECT campaign_id, campaign_name, platform, spend
FROM campaign_performance
WHERE platform IN ('Meta', 'TikTok', 'LinkedIn')
ORDER BY spend DESC;

-- Find all campaigns where the campaign_name contains the word "Sale".
SELECT campaign_id, campaign_name, platform, spend
FROM campaign_performance
where campaign_name like '%sale%';

-- Find all campaigns where the campaign_name contains "Sale", and show the highest-spending campaigns first.
SELECT campaign_id, campaign_name, platform, spend
FROM campaign_performance
where campaign_name like '%sale%'
ORDER BY spend DESC;

-- Calculate the total spend for each platform, but only include campaigns where spend is greater than 20,000.
SELECT platform, sum(spend)
FROM campaign_performance
where spend > 20000
group by platform;

-- Calculate the total spend for each platform, but only show platforms whose total spend is greater than 30,000,000.
SELECT platform, SUM(spend)
FROM campaign_performance
GROUP BY platform
HAVING SUM(spend) > 30000000;

-- Calculate the total spend for each platform and call the calculated column total_spend.
SELECT platform, SUM(spend) AS total_spend
FROM campaign_performance
GROUP BY platform;

-- Multiple aggregates
SELECT platform, SUM(spend) AS total_spend , sum(revenue) as total_revenue, sum(conversions) as total_conversions
FROM campaign_performance
GROUP BY platform;

-- ROAS = Total Revenue / Total Spend
SELECT platform, SUM(spend) AS total_spend , sum(revenue) as total_revenue,  sum(revenue) / SUM(spend) as ROAS
FROM campaign_performance
GROUP BY platform;

-- ROI = (Revenue − Spend) / Spend × 100
SELECT platform, SUM(spend) AS total_spend , sum(revenue) as total_revenue,  (sum(revenue) - SUM(spend)) /  SUM(spend) * 100 as roi
FROM campaign_performance
GROUP BY platform;

-- Calculate the CTR (Click-Through Rate) for each platform.
SELECT platform, SUM(clicks) AS total_clicks , sum(impressions) as total_impressions ,  SUM(clicks) /  sum(impressions) * 100  as ctr
FROM campaign_performance
GROUP BY platform;

-- Conversion Rate = Total Conversions / Total Clicks × 100
SELECT platform, SUM(clicks) AS total_clicks , sum(conversions) as total_conversions ,  SUM(conversions) /  sum(clicks) * 100  as conversion_rate
FROM campaign_performance
GROUP BY platform;

-- CPC = Total Spend / Total Clicks
SELECT platform, SUM(clicks) AS total_clicks , sum(spend) as total_spend ,  SUM(spend) /  sum(clicks) as cpc
FROM campaign_performance
GROUP BY platform;

-- Calculate Cost Per Acquisition (CPA) for each platform.
SELECT platform, SUM(conversions) AS total_conversions , sum(spend) as total_spend ,  SUM(spend) /  sum(conversions) as cpa
FROM campaign_performance
GROUP BY platform;

-- Calculate CPM (Cost Per 1,000 Impressions) for each platform.
SELECT platform, SUM(impressions) AS total_impressions , sum(spend) as total_spend ,  SUM(spend) /  sum(impressions) * 1000  as cpm
FROM campaign_performance
GROUP BY platform;

-- Let's combine several of these into one platform performance report.
SELECT platform , sum(spend) as total_spend ,
sum(revenue) as total_revenue, 
SUM(clicks) AS total_clicks ,
SUM(conversions) AS total_conversions,
sum(revenue) / SUM(spend) as roas ,
(sum(revenue) - SUM(spend)) /  SUM(spend) * 100 as roi ,
SUM(spend) / NULLIF(SUM(clicks), 0) as cpc ,
SUM(spend) /  sum(conversions) as cpa
FROM campaign_performance
GROUP BY platform;

-- Add CTR + Conversion Rate
SELECT
	campaign_id,
	campaign_name,
    platform,
    SUM(spend) AS total_spend,
    SUM(revenue) AS total_revenue,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions,
    SUM(revenue) / NULLIF(SUM(spend), 0) AS roas,
    (SUM(revenue) - SUM(spend))
        / NULLIF(SUM(spend), 0) * 100 AS roi,
    SUM(spend) / NULLIF(SUM(clicks), 0) AS cpc,
    SUM(spend) / NULLIF(SUM(conversions), 0) AS cpa,
    SUM(clicks) / NULLIF(SUM(impressions), 0) * 100 AS ctr,
    SUM(conversions) / NULLIF(SUM(clicks), 0) * 100 AS conversion_rate
FROM campaign_performance
GROUP BY campaign_id, campaign_name, platform;

SELECT COUNT(DISTINCT campaign_id) AS campaign_count
FROM campaign_performance;
-- Highest ROAS → lowest ROAS
SELECT platform, SUM(spend) AS total_spend ,
sum(revenue) as total_revenue,
sum(revenue) / SUM(spend) as ROAS
FROM campaign_performance
GROUP BY platform
order by roas desc;

-- Best campaign by ROAS
select campaign_id,
campaign_name,
platform,
spend,
revenue,
revenue / spend as roas
FROM campaign_performance
ORDER BY roas DESC
LIMIT 10;

-- Campaign CTR
SELECT
    campaign_id,
    campaign_name,
    platform,
    impressions,
    clicks,
    clicks / impressions * 100 AS ctr
FROM campaign_performance
ORDER BY ctr DESC
LIMIT 10;

-- Find the 10 campaigns with the lowest CPA.
SELECT
    campaign_id,
    campaign_name,
    platform,
    spend,
    conversions,
    spend / conversions AS cpa
FROM campaign_performance
ORDER BY cpa ASC
LIMIT 10;

-- Task 66 — Campaign Conversion Rate
SELECT
    campaign_id,
    campaign_name,
    platform,
    clicks,
    conversions,
    conversions / clicks * 100 AS conversion_rate
FROM campaign_performance
ORDER BY conversion_rate DESC
LIMIT 10;

-- Write a query that calculates total performance by country.
SELECT
    country,
    SUM(spend) AS total_spend,
	SUM(revenue) AS total_revenue,
	SUM(conversions) AS total_conversions,
    sum(revenue) / sum(spend) AS roas
FROM campaign_performance
group by country
order by roas desc;

-- Task 68 — Performance by Campaign Objective
SELECT
    campaign_objective,
    SUM(spend) AS total_spend,
	SUM(revenue) AS total_revenue,
	SUM(conversions) AS total_conversions,
    sum(revenue) / sum(spend) AS roas
FROM campaign_performance
group by campaign_objective
order by roas desc;

-- Task 69 — Monthly Performance
SELECT
    DATE_FORMAT(date, '%Y-%m') AS month,
    SUM(spend) AS total_spend,
    SUM(revenue) AS total_revenue,
    SUM(conversions) AS total_conversions,
    SUM(revenue) / NULLIF(SUM(spend), 0) AS roas,
    (SUM(revenue) - SUM(spend))
        / NULLIF(SUM(spend), 0) * 100 AS roi
FROM campaign_performance
GROUP BY DATE_FORMAT(date, '%Y-%m')
ORDER BY DATE_FORMAT(date, '%Y-%m');

-- Task 70 — Monthly Spend Trend
select 
	 DATE_FORMAT(date, '%Y-%m') as date,
     SUM(spend) AS total_spend,
     SUM(revenue) AS total_revenue,
	 sum(revenue) / sum(spend) AS roas
FROM campaign_performance
group by DATE_FORMAT(date, '%Y-%m')
order by DATE_FORMAT(date, '%Y-%m');

-- Task 71 — Monthly ROAS Ranking
select 
	 DATE_FORMAT(date, '%Y-%m') as date,
     SUM(spend) AS total_spend,
     SUM(revenue) AS total_revenue,
	 sum(revenue) / sum(spend) AS roas
FROM campaign_performance
group by DATE_FORMAT(date, '%Y-%m')
order by roas desc;

-- Task 72 — Best Campaign Objective by ROAS
select 
	 campaign_objective,
     SUM(spend) AS total_spend,
     SUM(revenue) AS total_revenue,
	 sum(revenue) / sum(spend) AS roas
FROM campaign_performance
group by campaign_objective
order by roas desc
limit 1;

-- Task 73 — CASE WHEN
select
	campaign_id,
	campaign_name,
	platform,
	revenue / spend AS roas,
	CASE
		WHEN revenue / spend >= 4 THEN 'Excellent'
		WHEN revenue / spend >= 2 THEN 'Good'
		ELSE 'Poor'
	END AS performance_category
from campaign_performance
order by roas desc;

-- Task 74 — CASE WHEN + Aggregation
select
	platform,
	sum(spend),
	sum(revenue),
	sum(revenue) / sum(spend) AS roas,
	CASE
		WHEN sum(revenue) / sum(spend) >= 4 THEN 'Excellent'
		WHEN sum(revenue) / sum(spend) >= 2 THEN 'Good'
		ELSE 'Poor'
	END AS performance_category
from campaign_performance
group by platform
order by roas desc;

-- Task 75 — Find campaigns above the platform average
select 
	campaign_id,
	campaign_name,
	platform,
	revenue / spend as roas
from campaign_performance
where revenue / spend > (
	select avg(revenue / spend)
    from campaign_performance)
order by roas desc;

-- Task 76 — Platform vs Overall Average ROAS
select 
	platform, 
	sum(revenue) / sum(spend) AS roas
from campaign_performance
GROUP BY platform
HAVING SUM(revenue) / SUM(spend) > (
    SELECT AVG(revenue / spend)
    FROM campaign_performance
)
ORDER BY roas DESC;

-- Task 77 — CTE
WITH campaign_metrics AS (
    SELECT 
		campaign_id,
		campaign_name,
		platform,
		spend,
		revenue,
		revenue / spend as roas
    FROM campaign_performance
)
SELECT *
FROM campaign_metrics
WHERE roas >= 4
ORDER BY roas desc;

-- Task 78 — CTE + Aggregation
WITH platform_metrics AS (
    SELECT 
		platform,
		sum(spend),
		sum(revenue),
		sum(revenue) / sum(spend) as roas
    FROM campaign_performance
    group by platform
)
SELECT *
FROM platform_metrics
WHERE roas >= 3
ORDER BY roas desc;

-- Task 79 — CTE + Ranking
WITH campaign_metrics AS (
    SELECT 
		campaign_id,
		campaign_name,
		platform,
		spend,
		revenue,
        conversions,
		revenue / spend as roas
    FROM campaign_performance
)
SELECT *
FROM campaign_metrics
where conversions >= 1000
ORDER BY roas desc
limit 10;

-- Task 80 — CTE + Multiple Metrics
WITH campaign_metrics AS (
    SELECT 
		campaign_id,
		campaign_name,
		platform,
		spend,
		revenue,
        clicks,
        conversions,
		revenue / spend as roas,
        spend / clicks as cpc,
        spend / conversions as cpa
    FROM campaign_performance
)
SELECT *
FROM campaign_metrics
where roas >= 3 and cpa < 50
order by roas desc;

-- Task 81 — CTE + Aggregation + Ranking
WITH platform_metrics AS (
    SELECT 
		platform,
		sum(spend) as total_spend,
		sum(revenue) as total_revenue,
        sum(clicks) as total_clicks,
        sum(conversions) as total_conversions,
		sum(revenue) / sum(spend) as roas,
        sum(spend) / sum(clicks) as cpc,
        sum(spend) / sum(conversions) as cpa
    FROM campaign_performance
    group by platform
)
SELECT *
FROM platform_metrics
where roas >= 3 and cpa < 50
order by roas desc;

-- Task 82 — CTE + Window Function
with campaign_metrics as(
	select
		campaign_id,
		campaign_name,
		platform,
		spend,
		revenue,
		revenue / spend as roas,
		ROW_NUMBER() OVER (
		PARTITION BY platform
		ORDER BY revenue / spend DESC
		) as platform_rank
	from campaign_performance
)
select *
from campaign_metrics;

-- Task 83 — Top 3 Campaigns per Platform
with campaign_metrics as(
	select
		campaign_id,
		campaign_name,
		platform,
		spend,
		revenue,
		revenue / spend as roas,
		ROW_NUMBER() OVER (
		PARTITION BY platform
		ORDER BY revenue / spend DESC
		) as platform_rank
	from campaign_performance
)
select *
from campaign_metrics
where platform_rank <= 3
ORDER BY platform, platform_rank;

-- Task 84 — RANK() vs ROW_NUMBER()
with campaign_metrics as(
	select
		campaign_id,
		campaign_name,
		platform,
		spend,
		revenue,
		revenue / spend as roas,
		ROW_NUMBER() OVER (
		PARTITION BY platform
		ORDER BY revenue / spend DESC
		) as platform_rank
	from campaign_performance
)
select *
from campaign_metrics;

-- Task 83 — Top 3 Campaigns per Platform
with campaign_metrics as(
	select
		campaign_id,
		campaign_name,
		platform,
		spend,
		revenue,
		revenue / spend as roas,
		ROW_NUMBER() OVER (
		PARTITION BY platform
		ORDER BY revenue / spend DESC
		) as platform_rank
	from campaign_performance
)
select *
from campaign_metrics
where platform_rank <= 3
ORDER BY platform, platform_rank;

-- Task 84 — RANK() vs ROW_NUMBER()
with campaign_metrics as(
	select
		campaign_id,
		campaign_name,
		platform,
		spend,
		revenue,
		revenue / spend as roas,
		rank() OVER (
		PARTITION BY platform
		ORDER BY revenue / spend DESC
		) as platform_rank
	from campaign_performance
)
select *
from campaign_metrics
ORDER BY platform, platform_rank;

-- Task 85 — Find the Top 3 Using RANK()
with campaign_metrics as(
	select
		campaign_id,
		campaign_name,
		platform,
		spend,
		revenue,
		revenue / spend as roas,
		RANK() OVER (
		PARTITION BY platform
		ORDER BY revenue / spend DESC
		) as platform_rank
	from campaign_performance
)
select *
from campaign_metrics
where platform_rank <= 3
ORDER BY platform, platform_rank;

-- Task 86 — LAG() and Month-over-Month Analysis
with monthly_metrics as(
	select
		DATE_FORMAT(date, '%Y-%m') AS month,
        sum(spend) as total_spend,
        sum(revenue) as total_revenue,
        sum(revenue) / sum(spend) as roas
	from campaign_performance
    group by month
    order by month
)
select *, LAG(total_revenue) OVER (ORDER BY month) as previous_month_revenue 
, (total_revenue - LAG(total_revenue) OVER (ORDER BY month)) as revenue_change
from monthly_metrics;

-- Task 87 — Month-over-Month Revenue Growth %
WITH monthly_metrics AS (
    SELECT
        DATE_FORMAT(date, '%Y-%m') AS month,
        SUM(revenue) AS total_revenue
    FROM campaign_performance
    GROUP BY DATE_FORMAT(date, '%Y-%m')
),
monthly_with_previous AS (
    SELECT
        *,
        LAG(total_revenue) OVER (ORDER BY month) AS previous_month_revenue
    FROM monthly_metrics
)
SELECT
    *,
    total_revenue - previous_month_revenue AS revenue_change,
    (total_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0) * 100 AS revenue_growth_pct
FROM monthly_with_previous
ORDER BY month;

-- Task 88 — Final Advanced SQL Challenge top-performing campaign on each platform
with campaign_metrics as(
	select
		campaign_id,
		campaign_name,
		platform,
		spend,
		revenue,
		revenue / spend as roas,
		rank() OVER (
		PARTITION BY platform
		ORDER BY revenue / spend DESC
		) as platform_rank
	from campaign_performance
)
select *
from campaign_metrics
where platform_rank = 1
order by platform;
