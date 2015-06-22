# The user-interface definition of the Shiny web app.
library(shiny)
require(markdown)
library(dplyr)

shinyUI(
    navbarPage("Stormdata exploring", 
    # multi-page user-interface that includes a navigation bar.
        tabPanel("Explore the Data",
             sidebarPanel(
                sliderInput("timeline", 
                            "Timeline:", 
                            min = 1996,
                            max = 2015,
                            value = c(1996, 2015)),
                selectInput(inputId = "conse",
                            label = "Consequence of sever events:",
                            choices = c("INJURIES_DIRECT", "DEATHS_DIRECT", "DAMAGE_PROPERTY", "DAMAGE_CROPS"),
                            selected = "DEATHS_DIRECT")
             ),
             mainPanel(     
                      h4('Concequence of most harmful events', align = "center"),
                      plotOutput(outputId = "Plot")
                   ) # end of "Visualize the Data" tab panel
                 ),
        tabPanel("About",
                 mainPanel(
                   includeMarkdown("about.md")
                 )
        ) # end of "About" tab panel
    )
  
)
