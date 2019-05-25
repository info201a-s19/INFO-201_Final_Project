# Density map of number of airports in the US
us_airports <- read.csv("data/american_and_delta_airlines.csv", stringsAsFactors = F)

# Loaded libraries
library("dplyr")
library("ggplot2")
library("plotly")
library("tidyr")

# only_us_airports <- us_airports %>%
#   filter(iso_country == "US", longitude_deg < -50, latitude_deg > 15)
# 
# types <- only_us_airports %>%
#   group_by(type) %>%
#   summarize(count = n())
# 
# airports <- only_us_airports %>%
#   filter(type == "small_airport" | type == "medium_airport" | type == "large_airport")
