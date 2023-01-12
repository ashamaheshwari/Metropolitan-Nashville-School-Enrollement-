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
                             tabPanel("Tabname",
                                      sidebarPanel(
                                        checkboxGroupInput("checkGroupo", 
                                                           label = h3("Select School level"), 
                                                           choices = unique (school_enrollment$SCHOOL_TYPE)),
                                        
                                        # checkboxGroupInput("checkGroupr", 
                                        #                    label = h3("Select Years"), 
                                        #                    choices = unique (school_enrollment$YEARS)), 
                                      ),#sidbarpanel
                                      mainPanel(plotOutput("line_plot")),
                                               # leafletOutput("mymap")) #mainpanel
                             )))
)



# shinyUI(fluidPage(theme = shinytheme("united"),
#   titlePanel("MNPS School Enrollment",
#                   ),
#   sidebarLayout(
#     sidebarPanel (
#       selectInput("SCHOOL_TYPE", 
#                   "Choose School type:",
#                   choices = unique (school_enrollment$SCHOOL_TYPE),
#                   selected = "All"),
#       
#       # dateRangeInput("YEARS", strong("Year Range"), start = "07-08", end = "22-23",
#       #                min = "07-08", max = "22-23")
#       # ),
#     mainPanel(plotOutput("line_plot", height = "300px"))
#     )
#   )
#   )
#   # tabPanel( "Enrollment", 
#   #                    selectInput("SCHOOL_TYPE", 
#   #                                "Choose School type:",
#   #                                choices = c ("All", "Elementary School", "Middle School", "High School", "Charter")),
#   #                   mainPanel(plotOutput("plot1"))
#   #                    # selectInput("Years", 
#   #                    #             "Choose Year of Enrollment:",
#   #                    #             choices = c ("All", "2007-2008", "2008-2009", "2009-20010")),
#   #                   )
#     )
# 
# 
#   
# 
