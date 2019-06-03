library("shiny")
library("plotly")
library("lintr")
library("dplyr")


# Source for all datasets
source("scripts/datasets.R")


# Data wrangling space #


# All airlines and their delays, each with a random sample of 50
airline_delays <- list(
  AmericanAirlines = filter(delays, AIRLINE == "AA"),
  AlaskaAirlines = filter(delays, AIRLINE == "AS"),
  JetBlueAirways = filter(delays, AIRLINE == "B6"),
  DeltaAirlines = filter(delays, AIRLINE == "DL"),
  AtlanticSoutheastAirlines = filter(delays, AIRLINE == "EV"),
  FrontierAirlines = filter(delays, AIRLINE == "F9"),
  HawaiianAirlines = filter(delays, AIRLINE == "HA"),
  AmericanEagleAirlines = filter(delays, AIRLINE == "MQ"),
  SpiritAirlines = filter(delays, AIRLINE == "NK"),
  SkywestAirlines = filter(delays, AIRLINE == "OO"),
  UnitedAirlines = filter(delays, AIRLINE == "UA"),
  USAirways = filter(delays, AIRLINE == "US"),
  VirginAmerica = filter(delays, AIRLINE == "VX"),
  SouthwestAirlines = filter(delays, AIRLINE == "WN")
)


information_page <- tabPanel()

map_page <- tabPanel()

# Page for scatter plot; compares delays of two airlines
plot_page <- tabPanel(
  "Comparing Delays of Airlines",
  h1(strong(
    "Q: Is there a correlation between arrival delays and departure delays?")),
  p("This chart compares arrival and departure delays of two airlines. ",
    "All of the data was randomly sampled by 50 for each airline and was ",
    "collected from ", em("2015 Flight Delays and Cancellations,"),
    " found on Kaggle."),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        inputId = "delays",
        label = "Choose which airlines to display",
        choices = names(airline_delays),
        selected = names(airline_delays)
      )
    ),
    mainPanel(
      plotlyOutput(outputId = "scatter_plot")
    )
  )
)

bar_chart_page <- tabPanel()

summary_page <- tabPanel()

proj_ui <- navbarPage(
  "Flights in the United States",
  information_page,
  map_page,
  plot_page
  bar_chart_page,
  summary_page
)

