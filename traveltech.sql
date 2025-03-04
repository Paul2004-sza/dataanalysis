CREATE DATABASE traveltech;
USE traveltech;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    country VARCHAR(50),
    signup_date DATE
);


CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    destination VARCHAR(100),
    travel_date DATE,
    price DECIMAL(10,2),
    booking_platform VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Marketing_Campaigns (
    campaign_id INT PRIMARY KEY AUTO_INCREMENT,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(10,2),
    channel VARCHAR(50)
);

CREATE TABLE Campaign_Performance (
    performance_id INT PRIMARY KEY AUTO_INCREMENT,
    campaign_id INT,
    impressions INT,
    clicks INT,
    conversions INT,
    revenue_generated DECIMAL(10,2),
    FOREIGN KEY (campaign_id) REFERENCES Marketing_Campaigns(campaign_id)
);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    destination VARCHAR(100),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
SHOW VARIABLES LIKE 'secure_file_priv';
