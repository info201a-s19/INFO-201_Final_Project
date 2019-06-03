# Calculates summary information to be included in the index.Rmd

# Load packages
library("lintr")
library("dplyr")

# Create datasets
airport <- read.csv("data/airports.csv", stringsAsFactors = F)
flight <- read.csv("data/american_and_delta_airlines.csv",
                   stringsAsFactors = F)

# A function that takes in the airport dataset and returns a list of info about it:
summary <- function(dataset) {
  common_details <- list(
    # most common type of airport
    type_table <- as.data.frame(table(dataset$type)),
    type_decreasing <- arrange(type_table, -Freq),
    type = type_decreasing$Freq[1],
    # most common type of service
    scheduled_column <- as.data.frame(table(dataset$scheduled_service)),
    scheduled = scheduled_column$Freq[1]
  )
  return (common_details)
} 
airport_list <- summary(airport)

# A function that takes in the flight dataset and returns a list of info about it:
summary2 <- function(data) {
  max <- list(
    # most common airline
    common_airline <- as.data.frame(table(data$AIRLINE)),
    airline_max = max(common_airline$Freq),
    # max number of flights on a day of the week
    day_table <- as.data.frame(table(data$DAY_OF_WEEK)),
    day_max <- max(day_table$Freq),
    max = day_max,
    # most common day of the week to travel
    common_day = which(grepl(day_max, day_table$Freq))
  )
  return (max)
}
flight_summary <- summary2(flight)