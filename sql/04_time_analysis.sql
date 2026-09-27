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
