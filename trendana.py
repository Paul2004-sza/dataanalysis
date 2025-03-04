import pandas as pd
import plotly.express as px
from statsmodels.tsa.holtwinters import ExponentialSmoothing

# Load Data
bookings = pd.read_csv("bookings.csv")
bookings['travel_date'] = pd.to_datetime(bookings['travel_date'])
bookings['month'] = bookings['travel_date'].dt.strftime('%Y-%m')

# Aggregate Bookings by Month
monthly_bookings = bookings.groupby('month').size().reset_index(name='num_bookings')

# 📊 Plot Monthly Trend
fig = px.line(monthly_bookings, x='month', y='num_bookings', markers=True,
              title="📅 Monthly Travel Demand Trend",
              labels={'month': "Month", 'num_bookings': "Number of Bookings"},
              template="plotly_dark")
fig.show()
# Convert to Time Series
monthly_bookings['month'] = pd.to_datetime(monthly_bookings['month'])
monthly_bookings.set_index('month', inplace=True)

# Fit Exponential Smoothing Model
if len(monthly_bookings) >= 24:
    model = ExponentialSmoothing(monthly_bookings['num_bookings'], trend='add', seasonal='add', seasonal_periods=12)
else:
    model = ExponentialSmoothing(monthly_bookings['num_bookings'], trend='add')  # No seasonal

fitted_model = model.fit()
forecast = fitted_model.forecast(12)

# 📉 Forecast Visualization
forecast_df = pd.DataFrame({'month': pd.date_range(start=monthly_bookings.index[-1], periods=13, freq='M')[1:], 'forecast': forecast})

fig = px.line(monthly_bookings.reset_index(), x='month', y='num_bookings', markers=True,
              title="📈 Travel Demand Forecast",
              labels={'month': "Month", 'num_bookings': "Number of Bookings"},
              template="plotly_dark")
fig.add_scatter(x=forecast_df['month'], y=forecast_df['forecast'], mode='lines+markers', name="Forecast", line=dict(dash='dot', color='red'))
fig.show()
