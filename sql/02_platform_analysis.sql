SELECT
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
GROUP BY platform;
