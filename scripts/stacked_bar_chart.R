library("dplyr")
library("ggplot2")
library("lintr")

# Source in for American Airlines and Delta Airlines data
source("scripts/datasets.R")

total_flights <- nrow(flights)

compare_airlines <- flights %>%
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
                                                    "Delta Airlines (DL)")) +
  scale_fill_manual(values = alpha(c("lightblue", "pink"), 1)) +
  geom_bar(stat = "identity") +
  theme(plot.title = element_text(hjust = 0.5)) # Center title

# Calculating insights of data
num_month_with_most_aa_flights <- compare_airlines %>%
  filter(AIRLINE == "AA") %>%
  arrange(-count) %>%
  head(1) %>%
  pull(MONTH)

month_with_most_aa_flights <- month.name[num_month_with_most_aa_flights]

num_month_with_most_dl_flights <- compare_airlines %>%
  filter(AIRLINE == "DL") %>%
  arrange(-count) %>%
  head(1) %>%
  pull(MONTH)

month_with_most_dl_flights <- month.name[num_month_with_most_dl_flights]

num_month_with_most_flights <- compare_airlines %>%
  group_by(MONTH) %>%
  summarize(count = sum(count)) %>%
  arrange(-count) %>%
  head(1) %>%
  pull(MONTH)

month_with_most_flights <- month.name[num_month_with_most_flights]

num_month_with_least_flights <- compare_airlines %>%
  group_by(MONTH) %>%
  summarize(count = sum(count)) %>%
  arrange(count) %>%
  head(1) %>%
  pull(MONTH)

month_with_least_flights <- month.name[num_month_with_least_flights]