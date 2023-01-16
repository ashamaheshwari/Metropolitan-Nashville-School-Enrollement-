#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram
library(shiny)


shinyUI(fluidPage(theme = shinytheme("united"),
                  navbarPage("School Enrollment",
                             tabPanel("Enrollment",
                                      sidebarPanel(
                                        
                                        selectInput("Year", 
                                                    label = h4 ("Select Enrollment Year"),
                                                   choices = unique (school_enrollment$YEARS)),
                                        
                                        checkboxGroupInput("school_level", 
                                                           label = h4("Select School level"), 
                                                           choices = c(unique (school_enrollment$SCHOOL_TYPE)
                                                                       
                                                           )),
                                         
                                        sliderInput("Years", 
                                                    label = h4 ("Select Range of Years"),
                                                    min = 2007, 
                                                    max = 2023,
                                                    value = c (2008, 2017),
                                                    sep = "" 
                                                    ), 
                                                  
                                        
                                        # checkboxGroupInput("Years", 
                                        #                    label = h3("Select Years"), 
                                        #                    choices = unique (school_enrollment$YEARS)), 
                                      ),#sidbarpanel
                                      
                                      mainPanel(
                                        fluidRow(column(8,
                                                        plotOutput("pie_chart")),
                                                 
                                                 column(4,tableOutput("table")),
                                                 
                                                 column(12, plotOutput("line_plot"))     
                                                        )
                                        )
                                        # plotOutput(("pie_chart"),width = "50%"),
                                        # tableOutput("table"), 
                                        # plotOutput("line_plot"),),
                             ), 
                             tabPanel("tab", 
                                      sidebarPanel(
                                        selectInput("School_Level", "Select School level",
                                                    choices = unique (school_enrollment$SCHOOL_TYPE)),
                                        uiOutput("School_Select"),
                                        #selectInput("School", "Select School",
                                        #         choices = unique(school_enrollment_sf$SCHOOL_NAME))
                                        
                                      ),
                                      mainPanel(
                                        plotOutput(("bar_plot"), width = "75%"),
                                        )  #mainpanel
                             ),
                             tabPanel("MNPS District Map",
                                      mainPanel(
                                        leafletOutput(("mymap"),width = "150%", height = "500px")) #mainpanel)
                  )
                  
))
)
