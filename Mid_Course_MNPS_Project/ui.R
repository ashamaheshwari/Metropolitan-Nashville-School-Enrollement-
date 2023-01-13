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
                                        checkboxGroupInput("school_level", 
                                                           label = h3("Select School level"), 
                                                           choices = unique (school_enrollment$SCHOOL_TYPE)),
                                        
                                        # dateRangeInput("YEARS", strong("Year Range"), start = "07-08", end = "22-23",
                                        #                 min = "07-08", max = "22-23")),
                                        # checkboxGroupInput("Years", 
                                        #                    label = h3("Select Years"), 
                                        #                    choices = unique (school_enrollment$YEARS)), 
                                      ),#sidbarpanel
                                      mainPanel(plotOutput("line_plot")),
                             ),
                                      tabPanel("MNPS Map", 
                                               sidebarPanel(
                                                 selectInput("School_Level", "Select School level",
                                                             choices = unique (school_enrollment$SCHOOL_TYPE)),
                                                uiOutput("School_Select")
                                                  #selectInput("School", "Select School",
                                                    #         choices = unique(school_enrollment_sf$SCHOOL_NAME))
                                            
                                                ),
                                                 mainPanel(leafletOutput("mymap"), 
                                                          plotOutput(("bar_plot"), width = "50%"))  #mainpanel
                                                 )
                                               )
                                      
                                           )
                                      )

        




