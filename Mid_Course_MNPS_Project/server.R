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
    
# enrollment_filtered <- reactive ({
#     E <- school_enrollment %>% group_by (YEARS, SCHOOL_TYPE) %>%
#      filter(SCHOOL_TYPE == input$Years)
#    return(E)
#  })

 output$line_plot <- renderPlot ({ 
   school_enrollment %>%
     group_by (YEARS, SCHOOL_TYPE) %>%
     filter(SCHOOL_TYPE == input$school_level) %>%
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
 
 
 output$mymap <- renderLeaflet({
   
   # school_enrollment_sf$popup <- 
   #   paste0("<b>School Name:</b> ", school_enrollment_sf$SCHOOL_NAME, "<br>",
   #          "<b>School Type:</b> ", school_enrollment_sf$SCHOOL_TYPE, "<br>",
   #          "<b>District:</b> ", school_enrollment_sf$METRO_DIST, "<br>" , 
   #          "<b>Cluster:</b> ", school_enrollment_sf$CLUSTER_NAME, "<br>",
   #          "<b>Street Address:</b> ", school_enrollment_sf$ADDRESS, "<br>",
   #          "<b>Phone:</b> ", school_enrollment_sf$PHONE, "<br>") %>%
   #          lapply(htmltools::HTML)
   # 
   leaflet(options = leafletOptions(minZoom = 10)) %>%
     addProviderTiles(provider = "CartoDB.Positron") %>%
     setView(lng = -86.7816, lat = 36.1627, zoom = 12) %>%
     setMaxBounds(lng1 = -86.7816 + 1, 
                  lat1 = 36.1627 + 1, 
                  lng2 = -86.7816 - 1, 
                  lat2 = 36.1627 - 1) %>%
     addPolygons(data = MNPS,
                 weight = 2,
                 fillOpacity = 0.0) %>%
     addCircleMarkers(data = school_enrollment_sf,
                      radius = 3,
                      color = "white",
                      weight = 0.25,
                      fillColor = "red",
                      fillOpacity = 0.75,
                      label = ~popup)
 })
 
 output$bar_plot <- renderPlot ({ 
   school_enrollment %>%
     filter(SCHOOL_TYPE == input$School_Level) %>%
     filter(SCHOOL_NAME == input$School) %>%
     ggplot(aes(x = YEARS, y= TOTAL_ENROLLMENT), fill = YEARS)+
     geom_col(stat="identity")+
     theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1),
           plot.title = element_text(hjust = 0.5),
           legend.position="right", 
           axis.title.y = element_text(size=12, vjust = 3),
           axis.text.y  = element_text(size = 10))+
     ggtitle("Enrollment trends over the years")
   
 })
 
output$School_Select <- renderUI({
   choices <- school_enrollment %>%
             filter(SCHOOL_TYPE == input$School_Level) %>% 
             pull(SCHOOL_NAME) %>%
             unique() %>%
             sort()
   
  selectInput("School", "Select School",
               choices = choices)
})
  
})