# Stacked bar chart
filtered_flights <- read.csv("data/american_and_delta_airlines.csv", stringsAsFactors = F)

total_flights <- nrow(filtered_flights)

compare_airlines <- filtered_flights %>%
  group_by(MONTH, AIRLINE) %>%
  summarize(count = n())

# american_flights <- filtered_flights %>%
#   filter(AIRLINE == "AA") %>%
#   group_by(MONTH) %>%
#   summarize(count = n())
# 
# delta_flights <- filtered_flights %>%
#   filter(AIRLINE == "DL") %>%
#   group_by(MONTH) %>%
#   summarize(count = n())
# 
# compare_flights <- left_join(american_flights, delta_flights, by = "MONTH")