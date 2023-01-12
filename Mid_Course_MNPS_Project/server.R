#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
#  #  selected_years <-  reactive({
#  #  #req(input$YEARS)
#  # #validate(need(!is.na(input$YEARS[1]) & !is.na(input$YEARS[2]), "Error: Please provide both a start and an end enrollemnt year."))
#  #  #validate(need(input$YEARS[1] < input$YEARS[2], "Error: Start year should be earlier than end year."))
#  #  school_enrollment %>%
#  #   filter(
#  #  SCHOOL_TYPE== input$SCHOOL_TYPE)
#  #  # YEARS > as.POSIXct(input$YEARS[1]) & YEARS < as.POSIXct(input$YEARS[2]
#  #   ))
#  #  })
# 
 output$line_plot <- renderPlot ({ 
   school_enrollment %>%
     group_by (YEARS, SCHOOL_TYPE) %>%
     filter (YEARS == input$YEARS) %>%
     filter(SCHOOL_TYPE == input$SCHOOL_TYPE) %>%
     summarise(enrollment = sum(TOTAL_ENROLLMENT)) %>%
     ungroup() %>%
     ggplot(aes(x = YEARS, y= enrollment, group = SCHOOL_TYPE, color = SCHOOL_TYPE))+
     geom_line()+
     geom_point()+
     theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1),
           plot.title = element_text(hjust = 0.5),
           legend.position="right", 
           axis.title.y = element_text(size=12, vjust = 3),
           axis.text.y  = element_text(size = 10))+
     ggtitle("Enrollment trends over the years")
 })
 
 })