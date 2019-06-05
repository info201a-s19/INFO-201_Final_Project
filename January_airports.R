library("dplyr")
library("airportr")

us_airports <- read.csv("data/american_and_delta_airlines.csv", stringsAsFactors = F)

#july dataset plus routes
airports7 <- us_airports %>% filter(MONTH == 7)
airports7$route <- paste(airports7$ORIGIN_AIRPORT, airports7$DESTINATION_AIRPORT, sep= "-")

#df group by route
new_airport_7 <- airports7 %>% group_by(route) %>%
  summarise(arr_delay = mean(ARRIVAL_DELAY),
            dep_delay = mean(DEPARTURE_DELAY),
            total_routes = n()
            ) %>%
  select(arr_delay, dep_delay, total_routes, route)

#destination
destination <- substr(new_airport_7$route, start = 5, stop = 7)
df_destination <- data.frame(destination)
expanded_desti7 <- df_destination %>% mutate(index = row_number() - 1)

#origin
origin <- substr(new_airport_7$route, start = 1, stop = 3)
df_origin <- data.frame(origin)
expanded_origin <- df_origin %>% mutate(index = row_number() - 1)

#detail of oriigin
origin_details <- lapply(origin, airport_detail)
#detail of destination
destination_details <- lapply(destination, airport_detail)

#desti, long,lat
desti_latitude <- unlist(lapply(destination_details, `[[`, 7))
df_lat_des <- data.frame(desti_latitude)
expanded_lat_des <- df_lat_des %>% mutate(index = row_number() - 1)

desti_longitude <- unlist(lapply(destination_details, `[[`, 8))
df_long_des <- data.frame(desti_longitude)
expanded_long_des <- df_long_des %>% mutate(index = row_number() - 1)

#ori,long,lat
ori_latitude <- unlist(lapply(origin_details, `[[`, 7))
df_lat_ori <- data.frame(ori_latitude)
expanded_lat_ori <- df_lat_ori %>% mutate(index = row_number() - 1)

ori_longitude <- unlist(lapply(origin_details, `[[`, 8))
df_long_ori <- data.frame(ori_longitude)
expanded_long_ori <- df_long_ori %>% mutate(index = row_number() - 1)

#ori'lat and long
ori_lat_long <- merge.data.frame(expanded_lat_ori, expanded_long_ori, by = "index", all.x = T)
#and name
ori_lat_long2 <- merge.data.frame(expanded_origin, ori_lat_long, by = "index", all.x = T)
#des'lat and long
des_lat_long <- merge.data.frame(expanded_lat_des, expanded_long_des, by = "index", all.x = T)
#and name
des_lat_long2 <- merge.data.frame(expanded_desti7, des_lat_long, by = "index", all.x = T)

#ori and des latlong
long_lat_df <-  merge.data.frame(ori_lat_long2, des_lat_long2, by = "index", all.x = T)

#lat,long, others
expanded_new_a_7 <- new_airport_7 %>% mutate(index = row_number() - 1)
final_df <- merge.data.frame(long_lat_df, expanded_new_a_7, by = "index", all.x = T)

write.csv(final_df, "data/final_df.csv")
