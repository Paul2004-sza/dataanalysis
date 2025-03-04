LOAD DATA INFILE 'users.csv'
INTO TABLE Users
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE 'bookings.csv'
INTO TABLE Bookings
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE 'campaigns.csv'
INTO TABLE Marketing_Campaigns
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE 'campaign_performance.csv'
INTO TABLE Campaign_Performance
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE 'reviews.csv'
INTO TABLE Reviews
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

SELECT 
    c.channel,
    SUM(p.revenue_generated) AS total_revenue,
    SUM(p.conversions) AS total_conversions,
    SUM(p.clicks) AS total_clicks
FROM Campaign_Performance p
JOIN Marketing_Campaigns c ON p.campaign_id = c.campaign_id
GROUP BY c.channel
ORDER BY total_revenue DESC;
