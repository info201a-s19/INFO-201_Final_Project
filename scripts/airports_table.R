library("dplyr")
library("lintr")

# Source in airports
source("scripts/datasets.R")

airports <- read.csv("data/airports.csv", stringsAsFactors = F)

# table
busiest_airport <- airports %>%
  filter(iso_country == "US") %>%
  filter(!is.na(iso_region)) %>%
  group_by(iso_region) %>%
  summarise(
    n = n(),
    most_type = tail(names(sort(table(airports$type))), 1),
    average_elevation = mean(elevation_ft, na.rm = T)) %>%
  top_n(10, wt = n) %>%
  arrange(-n) %>%
  select(iso_region, n, most_type, average_elevation)
