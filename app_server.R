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
  # Delays table
  output$delays_table <- renderTable({
    delays_of_60_min <- delays %>%
      group_by(AIRLINE) %>%
      filter(ARRIVAL_DELAY >= 60 & DEPARTURE_DELAY >= 60) %>%
      summarize(COUNT = n())
    delays_of_60_min
  }, align = "c")
  # Stacked Bar chart
  total_flights <- nrow(flights)
  
  compare_airlines <- flights %>%
    group_by(MONTH, AIRLINE) %>%
    summarize(count = n())
  
  output$bar_chart <- renderPlotly({
    num_flights_bar_chart <- ggplot(data = compare_airlines) +
      aes(x = MONTH,
          y = count,
          fill = AIRLINE,
          text = paste("# of Flights: ", count)) +
    ggtitle("Number of Flights across Months in 2015") +
    xlab("Months") + ylab("Number of Flights") +
    scale_x_discrete(limits = c("Jan",
                                "Feb",
                                "Mar",
                                "Apr",
                                "May",
                                "Jun",
                                "Jul",
                                "Aug",
                                "Sep",
                                "Oct",
                                "Nov",
                                "Dec")) +
    scale_fill_discrete(name = "Airlines", labels = c("American Airlines (AA)",
                                                      "Delta Airlines (DL)")) +
    scale_fill_manual(values = alpha(c("lightblue", "pink"), 1)) +
    geom_bar(stat = "identity") +
    theme(plot.title = element_text(hjust = 0.5)) # Center title
  num_flights_bar_chart
  })
}
