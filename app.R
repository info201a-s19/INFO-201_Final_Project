library("shiny")
library("lintr")
library("dplyr")
library("ggplot2")
library("plotly")

# Sourcing Files
source("app_server.R")

shinyApp(ui = proj_ui, server = proj_server)
