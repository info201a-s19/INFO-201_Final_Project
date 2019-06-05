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
      text = ~paste0(
        "Airline: ", names(airline_delays[input$delays]),
        "<br>Arrival Delay: ", ARRIVAL_DELAY,
        "<br>Departure Delay: ", DEPARTURE_DELAY
      ),
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
  output$bar_chart <- renderPlotly({
    num_flights_bar_chart <- ggplot(data = do.call("rbind", american_delta_airlines[input$flights]),
                                    aes(x = MONTH,
                                        y = NUM_FLIGHTS,
                                        fill = AIRLINE,
                                        text = paste0("Airline: ",
                                                      names(
                                                        american_delta_airlines
                                                        [input$flights]),
                                                      "<br># of Flights: ",
                                                      NUM_FLIGHTS))) +
      geom_bar(stat = "identity", position = 'dodge') +
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
      theme(plot.title = element_text(hjust = 0.5)) # Center title
    ggplotly(num_flights_bar_chart, tooltip = "text")
  })

  output$delay_bar_chart <- renderPlotly({
    delay_time_chart <- ggplot(data = do.call("rbind", american_delta_airlines[input$flights]),
                                    aes(x = MONTH,
                                        y = DELAY_MEAN,
                                        fill = AIRLINE,
                                        text = paste0("Airline: ",
                                                      names(
                                                        american_delta_airlines
                                                        [input$flights]),
                                                      "<br>Mean Delay in min:",
                                                      " ",
                                                      round(
                                                        DELAY_MEAN,
                                                        digits = 2)))) +
      geom_bar(stat = "identity", position = 'dodge') +
      ggtitle("Delay Time Average across Months in 2015") +
      xlab("Months") + ylab("Delay Time Average (minutes)") +
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
      scale_fill_manual(values = alpha(c("lightblue", "pink"), 1)) +
      theme(plot.title = element_text(hjust = 0.5)) # Center title
    ggplotly(delay_time_chart, tooltip = "text")
  })

  # Map
  output$july_map <- renderPlot({
    title1 <- paste0("Origin: ", input$origin)
    data1 <- july_flight %>% filter(origin == input$origin)
    p <- ggplot() + usmap +
    geom_curve(
      data = data1,
      aes(
        y = ori_latitude, x = ori_longitude,
        yend = desti_latitude, xend = desti_longitude
      ),
      size = 0.5,
      curvature = 0.2
    ) +
      geom_point(
        data = data1,
        aes(y = ori_latitude, x = ori_longitude),
        colour = "violet",
        size = 1.5
      ) +
      geom_point(
        data = data1,
        aes(y = desti_latitude, x = desti_longitude),
        colour = "violet"
      ) +
      theme(
        axis.line = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank()
      ) +
      labs(title = title1)
    p
  })
}

