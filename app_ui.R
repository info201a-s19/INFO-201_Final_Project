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


# Shiny User Interface #


information_page <- tabPanel(
  "Introduction",
  h1(strong("Flights in the United States"), align = "center"),
  h2("By Shareen C, Erya M, Sarah P, Jerome O", align = "center"),
  htmlOutput("airplane", align = "center"),
  br(),
  p("This report is about flights in the United States. We wanted to limit
    our scope in the United States rather than internationally to get a better
    sense of the flights around us. Knowing information about flights in the
    United States can benefit us if we travel. For example, we can find what
    airlines are usually delayed, so we could possibly avoid them in the
    future."),
  p("The datasets we used are: "),
  tags$ul(
    tags$li(tags$a(
      href = "https://www.kaggle.com/usdot/flight-delays",
      "2015 Flight Delays and Cancellations"),
      "found on Kaggle"
      ),
    tags$li(tags$a(
      href = "http://ourairports.com/data/",
      "OurAirports"), "compiled by David Megginson"
    )
  )
)

map_page <- tabPanel()

# Page for scatter plot; compares delays of two airlines
plot_page <- tabPanel(
  "Comparing Delays of Airlines",
  h1(strong(
    "Q: What airlines are most likely to have delays?", align = "center")),
  p("This chart compares arrival and departure delays of various airlines.
    All of the data was randomly sampled by 50 for each airline and was
    collected from ", em(tags$a(
      href = "https://www.kaggle.com/usdot/flight-delays",
      "2015 Flight Delays and Cancellations")),
    "from Kaggle. The data shown is in minutes, negative values meaning
    the airline arrived or departed early and positive value meaning a
    late arrival or departure. Knowing which airlines have delays is
    important because it helps us make decisions on which airline
    to take when traveling. If we know what airlines are most likely
    to have delays, then we can take other airlines instead."),
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
  h2(strong("Here is a table showing the number of airlines with
            arrival and departure delays longer than 60 minutes each")),
  tableOutput("delays_table"),
  h2(strong("What can we learn from this?", align = "center")),
  p("The airline with the most delays longer than 60 minutes is JetBlue
    Airways (B6), having 5 flights delayed longer than 60 minutes. Other
    airlines with a notable number of long delays are Frontier Airlines (F9)
    and Spirit Airlines (NK), both having 4 flights having long delays. The
    only airline that did not have long delays was Delta Airlines (DL),
    showing that Delta is a favorable airline to use to avoid long delays."),
  p("We can process some other key points from this data:"),
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

bar_chart_page <- tabPanel(
  "Stacked Bar Chart",
  h1(strong(
    "Q: Is there a correlation between arrival delays
    and departure delays?", align = "center")),
  p("This chart shows the number of Flights between American and Delta Airlines
    throughout the year 2015."),
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
      plotlyOutput(outputId = "bar_chart")
    )
  )
)

summary_page <- tabPanel()

proj_ui <- navbarPage(
  "Flights in the United States",
  information_page,
  map_page,
  plot_page,
  bar_chart_page,
  summary_page
)

