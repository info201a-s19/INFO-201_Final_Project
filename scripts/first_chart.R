# Density map of number of airports in the US
us_airports <- read.csv("data/airports.csv", stringsAsFactors = F)

# Loaded libraries
library("dplyr")
library("ggplot2")
library("plotly")
library("tidyr")

only_us_airports <- us_airports %>%
  filter(iso_country == "US", longitude_deg < -50, latitude_deg > 15)


# gg <- ggplot()
# gg <- gg + geom_polygon(data=only_us_airpots, aes(x=longitude_deg, y=latitude_deg, fill=NA), color = "black", fill=NA, size=0.5) +
#   geom_point(mapping = aes(x=longitude_deg, y=latitude_deg, color="red"))
# gg <- gg +  coord_map()
# gg
# 
# us_map <- leaflet() %>% addTiles()
# us_map %>% addCircleMarkers(
#   lat = only_us_airpots$latitude_deg,
#   lng = only_us_airpots$longitude_deg
# )