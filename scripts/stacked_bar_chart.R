library("dplyr")
library("ggplot2")
library("lintr")

# Stacked bar chart
filtered_flights <- read.csv("data/american_and_delta_airlines.csv",
                             stringsAsFactors = F)

total_flights <- nrow(filtered_flights)

compare_airlines <- filtered_flights %>%
  group_by(MONTH, AIRLINE) %>%
  summarize(count = n())

num_flights_chart <- ggplot(data = compare_airlines,
                            aes(x = MONTH,
                                y = count,
                                fill = AIRLINE,
                                text = paste("# of Flights: ", count))) +
  ggtitle("Number of Flights across Months in 2015") +
  xlab("Months") + ylab("Number of Flights") +
  scale_x_discrete(limits = c("Jan",
                              "Feb",
                              "Mar",
                              "Apr",
                              "May",
                              "Jun",
                              "Jul",
                              "Aug",
                              "Sep",
                              "Oct",
                              "Nov",
                              "Dec")) +
  scale_fill_discrete(name = "Airlines", labels = c("American Airlines (AA)",
                                                    "Delta Airlines(DL)")) +
  scale_fill_manual(values = alpha(c("lightblue", "pink"), 1)) +
  geom_bar(stat = "identity") +
  theme(plot.title = element_text(hjust = 0.5)) # Center title