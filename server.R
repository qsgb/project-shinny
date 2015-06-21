library(shiny)
library(dplyr)
library(ggplot2)
# Load data processing file
load("data.RData")
dataagr<-function(data=data3,int1,int2,conse){
  dt <- data %>% filter(YEAR >= int1, YEAR <= int2)
  index<-which(names(dt)==conse)
  df<-aggregate(dt[,index], by = list(dt$EVTYPE), FUN = "sum")
  return(df)
}

# Shiny server
shinyServer(
  function(input, output) {
    # Prepare dataset
    data <- reactive({
        dataagr(data3, input$timeline[1], input$timeline[2],input$conse)
    })
    
    output$Plot <- renderPlot({
     # p <- qplot(data=data(),Group.1, weight =x, geom = "bar", binwidth = 1) +
      #  scale_y_continuous(input$conse) + 
      #  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
      #  xlab("Event Type")
   # print(p) 
      barplot(data()[,1], 
              main=input$conse,
              xlab="Event type")
})
  } # end of function(input, output)
)