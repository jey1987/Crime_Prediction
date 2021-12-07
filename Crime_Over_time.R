#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# Define UI for application that draws a histogram

library(ggplot2)
library(shiny)
library(shinythemes)
library(dplyr)
library(readr)

df_year_summary_final <- df_year_summary %>%
    filter(Year > 2000)
ui <- fluidPage(
    titlePanel("Crime Over Time"), 
    sidebarLayout(
        sidebarPanel(selectInput("select", label = h2("City"), 
                                 choices = df_year_summary_final$City, 
                                 selected = 1,multiple=TRUE,
                                 width = '50%'),width = 1000),
        mainPanel(
            plotOutput("Year_Plot"),width = 1000
        )
    )
)

server <- function(input, output) {
    output$Year_Plot <- renderPlot({
        ggplot(df_year_summary_final[df_year_summary_final$City == input$select,] , aes(x = Year, y = n)) +
            labs(x = "Year", y = "Crime Count") +  
            geom_bar(stat = "identity",color="red")
    }, width = 'auto', height = 'auto')
}

shinyApp(ui = ui, server = server)
