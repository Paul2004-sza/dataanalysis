LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv'
INTO TABLE Users
FIELDS TERMINATED BY ','
IGNORE 1 LINES;


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/bookings.csv'
INTO TABLE Bookings
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/campaigns.csv'
INTO TABLE Marketing_Campaigns
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/campaign_performance.csv'
INTO TABLE Campaign_Performance
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reviews.csv'
INTO TABLE Reviews
FIELDS TERMINATED BY ','
IGNORE 1 LINES;