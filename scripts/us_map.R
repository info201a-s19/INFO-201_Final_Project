# Loaded libraries
library("dplyr")
library("ggplot2")
library("plotly")
library("tidyr")
library("leaflet")
library("lintr")

# Source in airports
source("scripts/datasets.R")

us_airports <- airports %>%
  filter(iso_country == "US", longitude_deg < -50, latitude_deg > 15)

types <- us_airports %>%
  group_by(type) %>%
  summarize(count = n())

# Filtered dataset to only include small, medium, and large airport
airports <- us_airports %>%
  filter(type == "small_airport" |
           type == "medium_airport" |
           type == "large_airport")

us_map <- leaflet(data = airports) %>%
  addTiles() %>%
  addCircleMarkers(
    lat = ~latitude_deg,
    lng = ~longitude_deg,
    popup = ~paste("Name:", name, "<br>",
                   "Type:", type, "<br>",
                   "Elevation:", elevation_ft),
    radius = 0.01,
    weight = 0
)