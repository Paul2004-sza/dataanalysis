import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta

fake = Faker()

# Generate Users Data
users = []
for i in range(1000):
    users.append([
        i + 1,
        fake.name(),
        random.randint(18, 60),
        fake.country(),
        fake.date_between(start_date="-2y", end_date="today")
    ])
users_df = pd.DataFrame(users, columns=['user_id', 'name', 'age', 'country', 'signup_date'])

# Generate Bookings Data
bookings = []
for i in range(3000):
    bookings.append([
        i + 1,
        random.randint(1, 1000),
        fake.city(),
        fake.date_between(start_date="today", end_date="+1y"),
        round(random.uniform(50, 2000), 2),
        random.choice(["Website", "Mobile App", "Travel Agency"])
    ])
bookings_df = pd.DataFrame(bookings, columns=['booking_id', 'user_id', 'destination', 'travel_date', 'price', 'booking_platform'])

# Generate Marketing Campaigns Data
campaigns = []
channels = ["Google Ads", "Social Media", "Email Marketing", "TV Ads"]
for i in range(10):
    start_date = fake.date_between(start_date="-1y", end_date="today")
    end_date = start_date + timedelta(days=random.randint(7, 30))
    campaigns.append([
        i + 1,
        start_date,
        end_date,
        round(random.uniform(10000, 500000), 2),
        random.choice(channels)
    ])
campaigns_df = pd.DataFrame(campaigns, columns=['campaign_id', 'start_date', 'end_date', 'budget', 'channel'])

# Generate Campaign Performance Data
performance = []
for i in range(50):
    campaign_id = random.randint(1, 10)
    impressions = random.randint(10000, 1000000)
    clicks = random.randint(1000, impressions)
    conversions = random.randint(10, clicks)
    revenue_generated = round(conversions * random.uniform(50, 500), 2)
    performance.append([
        i + 1, campaign_id, impressions, clicks, conversions, revenue_generated
    ])
performance_df = pd.DataFrame(performance, columns=['performance_id', 'campaign_id', 'impressions', 'clicks', 'conversions', 'revenue_generated'])

# Generate Reviews Data
reviews = []
for i in range(2000):
    reviews.append([
        i + 1,
        random.randint(1, 1000),
        fake.city(),
        random.randint(1, 5),
        fake.sentence()
    ])
reviews_df = pd.DataFrame(reviews, columns=['review_id', 'user_id', 'destination', 'rating', 'review_text'])

# Save to CSV
users_df.to_csv("users.csv", index=False)
bookings_df.to_csv("bookings.csv", index=False)
campaigns_df.to_csv("campaigns.csv", index=False)
performance_df.to_csv("campaign_performance.csv", index=False)
reviews_df.to_csv("reviews.csv", index=False)

print("Data generation complete!")
