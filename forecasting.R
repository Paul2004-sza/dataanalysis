library(ggplot2)
library(forecast)

# Load the dataset
bookings <- read.csv("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/bookings.csv")
bookings$travel_date <- as.Date(bookings$travel_date, format="%Y-%m-%d")
bookings$month <- format(bookings$travel_date, "%Y-%m")

# Aggregate bookings by month
monthly_demand <- aggregate(booking_id ~ month, data=bookings, FUN=length)

# Convert month column to Date format for proper ordering
monthly_demand$month <- as.Date(paste0(monthly_demand$month, "-01"))

# Create time series object
ts_data <- ts(monthly_demand$booking_id, frequency=12, start=c(2023, 1))

# Train ARIMA model
model <- auto.arima(ts_data)

# Forecast for next 12 months
forecasted <- forecast(model, h=12)

# Convert forecast to a data frame for custom ggplot visualization
forecast_df <- data.frame(
  Date = seq(from=monthly_demand$month[length(monthly_demand$month)], 
             by="month", length.out=12),
  Forecast = forecasted$mean,
  Lower80 = forecasted$lower[,1],
  Upper80 = forecasted$upper[,1],
  Lower95 = forecasted$lower[,2],
  Upper95 = forecasted$upper[,2]
)

# Plot the actual data and forecast using ggplot2
ggplot() +
  geom_line(data=monthly_demand, aes(x=month, y=booking_id), color="blue", size=1.2) +
  geom_line(data=forecast_df, aes(x=Date, y=Forecast), color="red", size=1.2, linetype="dashed") +
  geom_ribbon(data=forecast_df, aes(x=Date, ymin=Lower95, ymax=Upper95), 
              fill="red", alpha=0.2) +
  geom_ribbon(data=forecast_df, aes(x=Date, ymin=Lower80, ymax=Upper80), 
              fill="red", alpha=0.3) +
  labs(title="Monthly Booking Demand Forecast",
       subtitle="ARIMA Forecast with Confidence Intervals",
       x="Date", 
       y="Number of Bookings") +
  theme_minimal() +
  theme(plot.title = element_text(hjust=0.5, face="bold", size=16),
        plot.subtitle = element_text(hjust=0.5, size=12),
        axis.text.x = element_text(angle=45, hjust=1),
        legend.position = "none") +
  scale_x_date(date_labels="%b %Y", date_breaks="2 months")
