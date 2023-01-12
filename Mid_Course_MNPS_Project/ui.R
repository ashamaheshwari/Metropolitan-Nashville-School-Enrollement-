#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram

dashboardPage(
  dashboardHeader(title = "MNPS School Enrollment",
                  titleWidth = "400px"),
  dashboardSidebar( 
                     selectInput("School_level", 
                                 "Choose School level:",
                                 choices = c ("All", "Elementary", "Middle", "High", "Charter")) 
                    ), 

  dashboardBody(
    fluidRow(
      box(plotOutput("plot1")),
    )
  )
)
  

