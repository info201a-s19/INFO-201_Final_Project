library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")

source("app_server.R")

shinyApp(ui = proj_ui, server = proj_server)