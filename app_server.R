library("dplyr")
library("ggplot2")
library("airportr")
library("leaflet")
library("plotly")
library("tidyverse")
library("maps")
library("geosphere")

july_flight <- read.csv("data/final_df.csv", stringsAsFactors = F)

server <- function(input, output) {
  output$july_map <- renderPlot({
    title <- paste0("Origin:", input$origin)
    data1 <- july_flight %>% filter(origin == input$origin)
    usmap <- borders("state", colour="grey", fill="white")
    p <- ggplot() + usmap +
      geom_curve(data = data1,
                 aes(y = ori_latitude, x= ori_longitude,
                     yend=desti_latitude, xend=desti_longitude),
                 size=0.5,
                 curvature=0.2) +
      geom_point(data=data1,
                 aes(y = ori_latitude, x= ori_longitude),
                 colour="blue",
                 size=1.5) +
      geom_point(data=data1,
                 aes(y = desti_latitude, x=desti_longitude),
                 colour="purple") +
      theme(axis.line=element_blank(),
            axis.text.x=element_blank(),
            axis.text.y=element_blank(),
            axis.title.x=element_blank(),
            axis.title.y=element_blank(),
            axis.ticks=element_blank())
  p
  })
}

