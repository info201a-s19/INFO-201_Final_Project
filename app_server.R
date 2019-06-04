source("app_ui.R")

proj_server <- function(input, output) {
  # Image of airplane
  output$airplane <- renderText({
    src <- "https://tinyurl.com/y2p3makn"
    airplane_pic <- c('<img src="', src, '">')
    airplane_pic
  })
  # Scatter plot
  output$scatter_plot <- renderPlotly({
    scatter_plot_of_delays <- plot_ly(
      data = do.call("rbind", airline_delays[input$delays]),
      x = ~ARRIVAL_DELAY,
      y = ~DEPARTURE_DELAY,
      type = "scatter",
      mode = "markers",
      text = ~paste0("Airline: ", names(airline_delays[input$delays]),
                     "<br>Arrival Delay: ", ARRIVAL_DELAY,
                     "<br>Departure Delay: ", DEPARTURE_DELAY),
      hoverinfo = "text",
      color = ~AIRLINE,
      colors = c("lightblue", "pink")
    ) %>%
      layout(
        title = "Airlines' Delays by Arrival and Departure",
        xaxis = list(title = "Arrival Delays (in minutes)"),
        yaxis = list(title = "Departure Delays (in minutes)")
      )
    scatter_plot_of_delays
  })
}