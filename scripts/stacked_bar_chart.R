# Stacked bar chart
filtered_flights <- read.csv("data/american_and_delta_airlines.csv", stringsAsFactors = F)

total_flights <- nrow(filtered_flights)

compare_airlines <- filtered_flights %>%
  group_by(MONTH, AIRLINE) %>%
  summarize(count = n())