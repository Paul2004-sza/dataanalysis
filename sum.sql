SELECT 
    c.channel,
    SUM(p.revenue_generated) AS total_revenue,
    MAX(p.revenue_generated) AS max_revenue,
    MIN(p.revenue_generated) AS min_revenue,
    SUM(p.conversions) AS total_conversions,
    MAX(p.conversions) AS max_conversions,
    MIN(p.conversions) AS min_conversions,
    SUM(p.clicks) AS total_clicks,
    MAX(p.clicks) AS max_clicks,
    MIN(p.clicks) AS min_clicks
FROM Campaign_Performance p
JOIN Marketing_Campaigns c ON p.campaign_id = c.campaign_id
GROUP BY c.channel
ORDER BY total_revenue DESC;
