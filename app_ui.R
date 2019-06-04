library("shiny")
library("lintr")
library("dplyr")
library("ggplot2")
library("plotly")

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


# Shiny User Interface#


information_page <- tabPanel(
  "Introduction",
  h1(strong("Flights in the United States")),
  h2("By Shareen C, Erya M, Sarah P, Jerome O"),
  tags$iframe(src = "https://media.giphy.com/media/AOQ1ekVBqBTt6/giphy.gif",
           width = "730px", height = "405px")
)

#map_page <- tabPanel()

# Page for scatter plot; compares delays of two airlines
plot_page <- tabPanel(
  "Comparing Delays of Airlines",
  h1(strong(
    "Q: Is there a correlation between arrival delays and departure delays?")),
  p("This chart compares arrival and departure delays of two airlines.
    All of the data was randomly sampled by 50 for each airline and was
    collected from ", em(tags$a(
      href = "https://www.kaggle.com/usdot/flight-delays",
      "2015 Flight Delays and Cancellations")),
    ", found on Kaggle. The data shown is in minutes, negative values meaning
     the airline arrived or departed early and positive value meaning a
     late arrival or departure."),
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
  ),
  p("We can process a few key points from this data:"),
  tags$ul(
    tags$li("There is a positive correlation between arrival delays and
            departure delays. This means that as arrival delays go up,
            departure delays go up as well."),
    tags$li("We can infer that if a plane were to arrive late, then their
            schedule would become messed up, and that would cause them
            to depart late as well."),
    tags$li("Most of the observations hovered around the (0, 0) mark.
            This means that most flights were mostly on time."),
    tags$li("There are not prominent outliers; some flights end up having
            major late arrivals and departures, but they follow the overall
            positive trend of the data. A prominent example of this is one of
            US Airways' flights, having an arrival time of 398 minutes late
            and departure time of 352 minutes late!")
  )
)

#bar_chart_page <- tabPanel()

#summary_page <- tabPanel()

proj_ui <- navbarPage(
  "Flights in the United States",
  information_page,
  #map_page,
  plot_page
  #bar_chart_page,
  #summary_page
)

