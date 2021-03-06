library("shiny")
library("lintr")
library("dplyr")
library("ggplot2")
library("plotly")
library("maps")
library("usmap")

# Source for all datasets
source("scripts/datasets.R")

# Data wrangling space #

# For Map
july_flight <- read.csv("data/final_df.csv", stringsAsFactors = F)
unique_desti <- unique(july_flight$origin)
unique_origin <- unique(july_flight$destination)
usmap <- borders("state", colour = "slategrey", fill = "lightskyblue")

dest_airports <- july_flight %>%
  group_by(destination) %>%
  summarize(count = n())
most_flown_to <- max(dest_airports$count)
# For Bar Chart
total_flights <- nrow(flights)

compare_airlines <- flights %>%
  group_by(MONTH, AIRLINE) %>%
  summarize(count = n())

delay_time_months <- flights %>%
  select(MONTH, DEPARTURE_DELAY, AIRLINE) %>%
  group_by(MONTH, AIRLINE) %>%
  summarise(DELAY_MEAN = mean(DEPARTURE_DELAY, na.rm = TRUE), NUM_FLIGHTS = n())

american_delta_airlines <- list(
  AmericanAirlines = filter(delay_time_months, AIRLINE == "AA"),
  DeltaAirlines = filter(delay_time_months, AIRLINE == "DL")
)

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
    tags$li(
      tags$a(
        href = "https://www.kaggle.com/usdot/flight-delays",
        "2015 Flight Delays and Cancellations"
      ),
      "found on Kaggle"
    ),
    tags$li(tags$a(
      href = "http://ourairports.com/data/",
      "OurAirports"
    ), "compiled by David Megginson")
  ),
  h2("Some questions we seek to answer within our report: "),
  tags$ul(
    tags$li("Where can you fly from airports in the United States?
           Knowing airports with multiple destinations is helpful for travel"),
    tags$li("What airlines are most likely to have delays? This information
           is useful to know since we all want to avoid long delays.")
  )
)

# Page for scatter plot; compares delays of two airlines
plot_page <- tabPanel(
  "Comparing Delays of Airlines",
  h1(strong(
    "Q: What airlines are most likely to have delays?",
    align = "center"
  )),
  p(
    "This chart compares arrival and departure delays of various airlines.
    All of the data was randomly sampled by 50 for each airline and was
    collected from ", em(tags$a(
      href = "https://www.kaggle.com/usdot/flight-delays",
      "2015 Flight Delays and Cancellations"
    )),
    "from Kaggle. The data shown is in minutes, negative values meaning
    the airline arrived or departed early and positive value meaning a
    late arrival or departure. Knowing which airlines have delays is
    important because it helps us make decisions on which airline
    to take when traveling. If we know what airlines are most likely
    to have delays, then we can take other airlines instead."
  ),
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
bar_chart_page <- tabPanel(
  "Bar Chart",
  h1(strong(
    "Q: Throughout the year, which month do people fly most and do airlines
     delay more as number of flights increase?",
    align = "center"
  )),
  p("This chart shows the number of Flights between American and Delta Airlines
    throughout the year 2015."),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        inputId = "flights",
        label = "Choose which airlines to display",
        choices = names(american_delta_airlines),
        selected = names(american_delta_airlines)
      )
    ),
    mainPanel(
      plotlyOutput(outputId = "bar_chart"),
      plotlyOutput(outputId = "delay_bar_chart")
    )
  ),
  p("What we can learn from this data:"),
  tags$ul(
    tags$li("We expected December to have the most flights,
            but based off the graph, it was surprising to see that October
            had more overall flights than December. July and August were a
            part of summer, where people are on vacation, so we were not
            surprised by them having the most flights."),
    tags$li("For the first half of the year, there are more Delta Airline
            flights than American Airline flights. Perhaps this is because
            American Airlines have a longer delay time their flights making
            customers that fly during unpopular months go to other airlines
            that depart more time. Since, people flying in unpopular months are
            probably people flying for short business trips, so being on time is
            extremely important to them"),
    tags$li("One aspect that we have not consider is the prices of the flights.
            Since our data does not include the price for each flight, we are
            making conclusions based on the data given to us such as the delay
            departure time for certain airlines and the number of flights in a
            given time"),
    tags$li("We found that June has the highest delay time average overall with
            a total of 25.06 minutes from both airlines. Although July has the
            most number of flights in a year, the delay time average was
            significantly lower than the month before with only
            17.99 minutes."),
    tags$li("Between American and Delta Airlines, we found that American
            Arilines has a higher overall delay time in their flights.
            Therefore, when booking flights especially in the summer, consumers
            should consider which airline he or she would want to fly with if
            being on time is a top priority")
  )
)

map_page <- tabPanel(
  "Route Map",
  h1(strong(
    "Q: Where can you fly from these airports?", align = "certer")),
  p("This map shows the route distribution of each destination airport in July.
    By chooing an origin airport, you could find the busiest airport. "),
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
  ),
  p("What we can learn from this data:"),
  tags$ul(
    tags$li("We found that during July, the month with most flights, the most
            popular destination is Atlanta with 126 flights going to Atlanta."),
    tags$li("We noticed that major cities such as Los Angeles and Atlanta has
            many flight destinations. Since there is a bigger population, there
            having a larger airport can accomodate more people traveling to
            different places.")
  )
)

summary_page <- tabPanel(
  "Summary",
  h1(strong("A Summary of Our Analysis"), align = "center"),
  h2(strong("Route Distribution in July"), align = "center"),
  p("The route distribution of flights in July are visualized on a map of
    the United States. A dot represents an airport. We discovered that 
    most of these dots are located near the coast or close to the 
    destination airport. For example, a customer can fly to three
    airports from ATW and these airports are in surrounding states. 
    Other airports, such as ATL, reaches farther states and even 
    those in Hawaii and on the west coast. This route distribution
    suggests that bigger, more well-known airports such as JFK and
    ORD, are more likely to distribute their flights nation-wide.
    Smaller airports are more likely to fly to neighboring states."),
  h2(strong("Comparing Delays of Airlines"), align = "center"),
  br(),
  p("To compare delays between different airlines, we visualized the data 
    with a scatter plot. The plot
    is set up so that the x-axis symbolizes arrival delay and the y-axis
    sybmolizes departure delay. A value at 0 means the flight is on time,
    while negative and positive numbers will determine earlier or later
    arrivals respectively. From this plot, we can conclude that most
    flights arrive earlier or on time and that there isn't a difference
    in which airline will arrive earlier. Most of the points are located
    in the third quadrant, meaning their arrival and departure times are
    earlier than expected. For example, Delta Airlines has an outlier with a 41
    min arrival delay, but other points are concentrated near 0,0. This comparison 
    supports the argument that late departures and arrivals are outliers at best."),
  br(),
  h2(strong("Most Common Month for Flights"), align = "center"),
  p("We compared data on American Airlines and Delta Airlines to discover when 
    flights were most common and between these two, which airline had more delays.
    We discovered that people travelled most frequently in the summer, especially
    July for American Airlines and August for Delta Airlines. There were 81431
    flights made in July and 80947 flights in August for the respective airlines.
    We also discovered that American Airlines has a higher overall delay. The average
    delay time exceeded 10 minutes for 6 months , even hitting its max at 14.18 minutes
    in June, for American Airlines. The average delay time exceeded 10 minutes for 3 
    months for Delta. While these comparisons were made for only one year, a customer
    will experience less delays when flying with Delta Airlines throughout the year."),
  sidebarLayout(
    sidebarPanel(
      p("To compare delays between American Airlines and
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
        customers, no airline is 'better' than the other in terms of
        timeliness.")
    ),
    mainPanel(
      plotlyOutput(outputId = "summary_plot")
    )
  ),
  br(),
  h2(strong("Correlation Between Arrival and Departure"), align = "center"),
  sidebarLayout(
    sidebarPanel(
      p("We created a table to compare different airlines with arrivals and
        departures longer than 60 minutes. We discovered that while most
        airlines do depart on time, on time departures also mean that
        arrivals are later. A noticable example is that observations hover
        over the 0,0 mark because again, a value at 0 means the flight is on
        time. This table is useful for two reasons. One, we discovered that
        long departures are rare for Delta Airlines. And two, there is a
        strong correlation between arrival and departure time. If a flight
        departs late, it is most likely to arrive later.")
    ),
    mainPanel(
      tableOutput(outputId = "summary_table")
    )
  )
)

proj_ui <- navbarPage(
  "Flights in the United States",
  information_page,
  map_page,
  plot_page,
  bar_chart_page,
  summary_page
)
