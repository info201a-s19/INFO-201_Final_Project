library(dplyr)
library(plotly)
library(lintr)

# Source in American Airlines and Delta Airlines flights
source("scripts/datasets.R")

# This scatter plot compares arrival delays and departure delays
# from American Airlines and Delta Airlines

# Data wrangling
delays <- flights %>%
  select(AIRLINE, ARRIVAL_DELAY, DEPARTURE_DELAY) %>%
  filter(!is.na(ARRIVAL_DELAY) & !is.na(DEPARTURE_DELAY))

# Random sampling, taking 50 from each airline
american_airlines <- delays %>%
  filter(AIRLINE == "AA") %>%
  sample_n(size = 50)

delta_airlines <- delays %>%
  filter(AIRLINE == "DL") %>%
  sample_n(size = 50)

delays <- rbind(american_airlines, delta_airlines)

# Scatter plot comparing arrival delays and departure delays
# between American Airlines and Delta Airlines
scatter_plot_of_delays <- plot_ly(
  data = delays,
  x = ~ARRIVAL_DELAY,
  y = ~DEPARTURE_DELAY,
  type = "scatter",
  mode = "markers",
  text = ~paste0("Airline: ", AIRLINE,
                 "<br>Arrival Delay: ", ARRIVAL_DELAY,
                 "<br>Departure Delay: ", DEPARTURE_DELAY),
  hoverinfo = "text",
  color = ~AIRLINE,
  colors = c("lightblue", "pink")
) %>%
  layout(
    title =
      "American Airlines and Delta Airlines' Delays by Arrival and Departure",
    xaxis = list(title = "Arrival Delay"),
    yaxis = list(title = "Departure Delay")
  )