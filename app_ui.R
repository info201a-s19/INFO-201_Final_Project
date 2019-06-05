library("shiny")
library("plotly")
library("lintr")
library("dplyr")

unique_day_of_week <- unique(sea_jan_airports$DAY_OF_WEEK)
unique_desti <- unique(july_flight$origin)
unique_origin <- unique(july_flight$destination)

map_page <- tabPanel(
  "Map Page",
  
  titlePanel("Map Page"),
  
  sidebarLayout(
    selectInput(
      "origin",
      label = "Choose an Origin",
      choices = unique_origin,
      selected = "LAX"
    ),
    mainPanel(
      plotOutput(outputId = "july_map")
    )
  )
)

ui <- navbarPage(
  "Airport",
  map_page
)

# selectInput(
#   inputId = "day_of_week",
#   label = "Choose a day of week",
#   choices = unique_day_of_week
# )

# map_page <- tabPanel(
#   "Map Page",
#   titlePanel("Map Page"),
#   sidebarLayout(
#     sidebarPanel(
#       selectInput(
#         inputId = "day_of_week",
#         label = "Choose a day of week",
#         choices = unique_day_of_week
#       ),
#       size_input <- sliderInput(
#         "size",
#         label = "Size of point", min = 1, max = 10, value = 5
#       )
#     )
#   ),
#   mainPanel(
#     leafletOutput(outputId = "seattle-january_map")
#   )
# )