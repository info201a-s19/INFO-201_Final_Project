library("shiny")
library("lintr")
library("dplyr")
library("ggplot2")
library("plotly")

# Sourcing Files
source("app_server.R")
source("app_ui.R")

shinyApp(ui = ui, server = server)