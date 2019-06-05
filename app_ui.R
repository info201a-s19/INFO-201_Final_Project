library("shiny")
library("lintr")
library("dplyr")
library("ggplot2")
library("plotly")

# Source for all datasets
source("scripts/datasets.R")
source("app_server.R")

# Data wrangling space #

unique_desti <- unique(july_flight$origin)
unique_origin <- unique(july_flight$destination)

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
  h2("By Shareen C, Erya M, Jerome O, Sarah P", align = "center"),
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

# Bar Chart
airline_name <- unique(delay_time_months$AIRLINE)

bar_chart_page <- tabPanel(
  "Bar Chart",
  h1(strong(
    "Q: Throughout the year, which ?", align = "center")),
  p("This chart shows the number of Flights between American and Delta Airlines
    throughout the year 2015."),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        inputId = "delays",
        label = "Choose which airlines to display",
        choices = airline_name,
        selected = airline_name
      )
    ),
    mainPanel(
      plotlyOutput(outputId = "bar_chart"),
      plotlyOutput(outputId = "delay_bar_chart")
    ),
    p("What we can learn from this data:"),
    tags$ul(
      tags$li("We expected December to have the most flights,
              but based off the graph, it was surprising to see that October
              had more overall flights than December. July and August were a
              part of summer, where people are on vacation, so we were not
              surprised by them having the most flights."),
      tags$li("The month with the most American Airline flights was .
              The month with the most Delta Airlines flights was ,
              and the month with the most overall flights was ."),
      tags$li("The month with the least overall flights was .
              Many people were probably busy during this month,
              which was why people did not travel as much.")
    )
  )
)

map_page <- tabPanel(
  "Route Map",
  h1(strong(
    "Q: Where can you fly from these airports?", align = "certer")),
  p("This map shows the route distribution of each destination airport in July"),
  sidebarLayout(
    sidebarPanel(
    selectInput(
      "origin",
      label = "Choose an Origin",
      choices = unique_origin,
      selected = "LAX"
    )
    ),
    mainPanel(
      plotOutput(outputId = "july_map")
    )
  )
)

summary_page <- tabPanel(
  h1(strong("A Summary of Our Analysis"), align = "center"),
  h2(strong("Comparing Delays of Airlines"), align = "center"),
  p("To compare delays between Alaska Airlines and 
    Delta Airlines, we visualized the data with a scatter plot. The plot
    is set up so that the x-axis symbolizes arrival delay and the y-axis
    sybmolizes departure delay. A value at 0 means the flight is on time,
    while negative and positive numbers will determine earlier or later
    arrivals respectively. From this plot, we can conclude that most 
    flights arrive earlier or on time and that there isn't a difference 
    in which airline will arrive earlier. Most of the points are located
    in the third quadrant, meaning their arrival and departure times are
    earlier than expected. While Delta Airlines has an outlier with a 201
    min arrival delay, the next two outliers are from Alaska Arilines at 
    77 and 81 minutes. This comparison supports the argument that
    while Alaska and Delta Airlines are popular airlines with devoted 
    customers, no airline is 'better' than the other in terms of timeliness."),
  br(),
  h2(strong("Correlation Between Arrival and Departure"), align = "center"),
  p(""),
  br(),
  h2(strong("Route Distribution in July"), align = "center"),
  p("The route distribution of flights in July are visualized on a map of
    the United States. The map consists of dots representing an")
)

ui <- navbarPage(
  "Flights in the United States",
  information_page,
  map_page,
  plot_page,
  bar_chart_page,
  summary_page
)

