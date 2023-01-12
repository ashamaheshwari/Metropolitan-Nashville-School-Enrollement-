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
                     selectInput("SCHOOL_TYPE", 
                                 "Choose School type:",
                                 choices = c ("All", "Elementary School", "Middle School", "High School", "Charter")),
                    mainPanel(plotOutput("plot1"))
                     # selectInput("Years", 
                     #             "Choose Year of Enrollment:",
                     #             choices = c ("All", "2007-2008", "2008-2009", "2009-20010")),
                    ), 

   dashboardBody(
   fluidRow(
  box(plotOutput("plot1")),
    )
  )
)
  

