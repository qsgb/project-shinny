library(shiny)
library(dplyr)
library(ggplot2)
load("data.RData")
dataagr<-function(data=data3,int1,int2,conse){
  dt <- data %>% filter(YEAR >= int1, YEAR <= int2)
  index<-which(names(dt)==conse)
  df<-aggregate(dt[,index], by = list(dt$TYPE), FUN = "sum")
  names(df)<-c("Type","sum")
  ord<-order(df$sum,decreasing = TRUE)
  result<-df[ord,]
  result<-head(result,n=10)
  return(result)
}

# Shiny server
shinyServer(
  function(input, output) {
    # Prepare dataset
    data <- reactive({
        dataagr(data3, input$timeline[1], input$timeline[2],input$conse)
    })
    
    output$Plot <- renderPlot({
      p <- qplot(data=data(),Type, weight =sum, geom = "bar", binwidth = 1) +
        scale_y_continuous(input$conse) + 
        theme(axis.text.x = element_text(angle = 45)) + 
        xlab("Event Type")
    print(p) 
      
})
  } # end of function(input, output)
)