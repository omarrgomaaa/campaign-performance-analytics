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
