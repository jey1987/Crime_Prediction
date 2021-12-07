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
    titlePanel("Hotspots of Crime Over Time"), 
    sidebarLayout(
        sidebarPanel(selectInput("select", label = h2("City"), 
                                 choices = df_area_summary$City, 
                                 selected = 1,multiple=FALSE,
                                 width = '50%'),width = 1000),
        selectInput("year_select", label = h2("State"), 
                    choices = df_type_summary$Year, 
                    multiple=TRUE,
                    width = '50%')),
        
        mainPanel(
            plotOutput("Year_Plot"),width = 1000
        )
    )


server <- function(input, output) {
    output$Year_Plot <- renderPlot({
        df_area_summary %>%
            select(Year,Area,n,City) %>%
            filter(Year==input$year_select,City==input$select ) %>%
            ggplot(aes(x=Area, y= n)) + geom_bar(stat='identity',color="red", fill="white")+theme(axis.text.x=element_text(angle=90,hjust=1)) +
            scale_fill_brewer(palette="Reds")
    }, width = 'auto', height = 'auto')
}

shinyApp(ui = ui, server = server)
