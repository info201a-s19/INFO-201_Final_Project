# Loading Libraries
library("shiny")
library("ggplot2")
library("dplyr")
library("plotly")

# Sourcing Files
source("app_ui.R")
source("app_server.R")

shinyApp(ui = proj_ui, server = proj_server)