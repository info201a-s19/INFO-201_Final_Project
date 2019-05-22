library("dplyr")
airports_csv <- read.csv("data/airports.csv")

#table
busiest_airport <- airports_csv %>%
  filter(!is.na(iso_region)) %>%
  group_by(iso_region) %>% 
  summarise(
    n = n(),
    most_type = tail(names(sort(table(airports_csv$type))), 1),
    average_elevation = mean(elevation_ft, na.rm = T)) %>%
  top_n(10, wt = n) %>%
  arrange(-n) %>%
  select(iso_region, n, most_type, average_elevation)