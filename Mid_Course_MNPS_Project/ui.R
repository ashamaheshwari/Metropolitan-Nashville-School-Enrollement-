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
                  navbarPage("Metropolitan Nashville Public School",
                             tabPanel("Total Enrollment",
                                      sidebarPanel(width = 3, 
                                        
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
                                                  
                                      ),#sidbarpanel Page 1
                                      
                                      mainPanel(
                                        fluidRow(column(8,
                                                        plotOutput("pie_chart")), # pie chart for total enrollment
                                                 
                                                 column(4,
                                                        tableOutput("table")), # table for data in piechart
                                                 
                                                 column(12,
                                                        plotOutput("line_plot")), # plot to compare enrollment trends over years
                                                 
                                                  column(12, 
                                                        tableOutput("table1")) # table for percentage change in enrollment
                                                        )
                                        )
                                        
                             ), # main panel Page 1
                             
                             tabPanel("School Enrollment and Demographics", 
                                      sidebarPanel(width = 3, 
                                        selectInput("School_Level", 
                                                    label= h4 ("Select School level"),
                                                    choices = unique (school_enrollment$SCHOOL_TYPE)),
                                        uiOutput("School_Select"),
                                        
                                        selectInput("YEAR", 
                                                    label = h4 ("Select Enrollment Year"),
                                                    choices = school_demographics %>%
                                                      pull(Year) %>%
                                                      unique() %>%
                                                      sort()),
                                      ),
                                      
                                      mainPanel(
                                        fluidRow(column(12,
                                                  plotOutput(("bar_plot"), width = "75%")),
                                                  
                                        
                                                  column(4, 
                                                         plotOutput("bar_plot1")),
                                                br(),
                                                br(), 
                                                  column(8,
                                                         plotOutput(("bar_plot2"), height = "400px")
                                                 
                                                  
                                        )
                                        )  #mainpanel page 2
                             )
                             ),
                             tabPanel("School District Map",
                                
                                       mainPanel(
                                        leafletOutput(("mymap"),width = "100%", height = "500px")) #mainpanel)
                  )
                  
))
)
