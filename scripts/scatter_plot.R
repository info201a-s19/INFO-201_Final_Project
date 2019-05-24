library(dplyr)
library(plotly)

# This scatter plot compares arrival delays and departure delays

# Data wrangling
flights <- read.csv("../data/american_and_delta_airlines.csv", stringsAsFactors = F)
delays <- flights %>%
  select(AIRLINE, ARRIVAL_DELAY, DEPARTURE_DELAY) %>%
  filter(!is.na(ARRIVAL_DELAY) & !is.na(DEPARTURE_DELAY))

# Scatter plot comparing arrival delays and departure delays
scatter_plot_of_delays <- plot_ly(
  data = delays,
  x = ~ARRIVAL_DELAY,
  y = ~DEPARTURE_DELAY
)
