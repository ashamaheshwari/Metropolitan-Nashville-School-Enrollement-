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
  
## pie chart for total enrollment
output$pie_chart <- renderPlot({
  
  school_enrollment %>%
    group_by (YEARS, SCHOOL_TYPE) %>%
    filter (YEARS == input$Year) %>%
    filter(SCHOOL_TYPE %in% input$school_level) %>%
    summarise(enrollment = sum(TOTAL_ENROLLMENT)) %>%
    ungroup() %>%
    ggplot(aes(x = "",  y= enrollment, fill = SCHOOL_TYPE))+
    geom_col(stat = "identity", width= 1)+
    coord_polar("y", start=0)+
    theme_void()+
    labs(fill='School level') +
    scale_fill_brewer(palette="Reds")+
    ggtitle(" Total Student Enrollment")+
    theme(plot.title = element_text(size = 16, hjust = 0.5))
  
})  # Page 1

# table for data shown in piechart
output$table <- renderTable({
  
  
  school_enrollment %>%
    select(SCHOOL_TYPE, YEARS, TOTAL_ENROLLMENT) %>%
    group_by (YEARS, SCHOOL_TYPE) %>%
    filter (YEARS == input$Year) %>%
    filter(SCHOOL_TYPE %in% input$school_level) %>%
    transmute (Enrollment = sum(TOTAL_ENROLLMENT)) %>%
    unique() %>% 
    rename(Year = YEARS, School_level = SCHOOL_TYPE)%>%
    ungroup() %>% 
    select(School_level, Enrollment) 
  
}, digits = 0) # Page 1

# line plot for comparing enrollment trend for different school levels over the years
output$line_plot <- renderPlot ({ 
   
     school_enrollment %>%
     group_by (START_YEAR, YEARS, SCHOOL_TYPE) %>%
     filter(SCHOOL_TYPE %in% input$school_level) %>%
     filter((START_YEAR >= input$Years[1]) & (START_YEAR < input$Years[2])) %>%
     summarise(enrollment = sum(TOTAL_ENROLLMENT)) %>%
     ungroup() %>%
     ggplot(aes(x = YEARS, y= enrollment, group = SCHOOL_TYPE, color = SCHOOL_TYPE))+
     geom_line()+
     geom_point()+
     labs(x = "", y = "Total Enrollment", col = "School Level") +
     theme(axis.text.x = element_text(size = 10, angle = 45, vjust = 1, hjust=1),
           plot.title = element_text(size = 16, hjust = 0.5),
           legend.position ="right", 
           axis.title.y = element_text(size = 12, vjust = 3),
           axis.text.y  = element_text(size = 10))+
     ggtitle("Enrollment trends over the years")
         
     }) #Page 1

# table to show percentage change in enrollment at different school levels over the years

output$table1 <- renderTable({
    
  school_enrollment %>%
        group_by (START_YEAR, YEARS, SCHOOL_TYPE) %>%
       filter (SCHOOL_TYPE %in% input$school_level) %>%
       filter((START_YEAR >= input$Years[1]) & (START_YEAR < input$Years[2])) %>%
       summarise(Enrollment = sum(TOTAL_ENROLLMENT)) %>%
       rename(Years = YEARS, School_level = SCHOOL_TYPE) %>%
       ungroup() %>%
       group_by(School_level) %>%
       mutate(Percentage_Change = (Enrollment/lag(Enrollment)-1)*100) %>%
      select(School_level, Years, Percentage_Change) %>%
      pivot_wider(names_from = Years, values_from = Percentage_Change) 
  
  }) # Page 1 End
 
  
# Page 2 
# plot for enrollment trend for individual schools
  
output$bar_plot <- renderPlot ({ 
  school_enrollment %>%
    filter(SCHOOL_TYPE == input$School_Level) %>%
    filter(SCHOOL_NAME == input$School) %>%
    ggplot(aes(x = YEARS, y= TOTAL_ENROLLMENT, fill = YEARS))+
    geom_col(stat="identity")+
    labs(x = "", y= "Total Enrollment")+
    theme(axis.text.x = element_text(size = 10, angle = 45, vjust = 1, hjust=1),
          plot.title = element_text(hjust = 0.5, size = 16),
          legend.position = "NULL",
          axis.title.y = element_text(size = 12, vjust = 3),
          axis.text.y  = element_text(size = 10))+
    ggtitle("Enrollment trends over the years")
  
}) #Page 2

# to update the choices of schools based on school level selected
output$School_Select <- renderUI({
  choices <- school_enrollment %>%
    filter(SCHOOL_TYPE == input$School_Level) %>% 
    pull(SCHOOL_NAME) %>%
    unique() %>%
    sort()
  
  selectInput("School", 
              label = h4 ("Select School"),
              choices = choices)
}) #Page 2
 
# plot for distribution of gender in each school

output$bar_plot1 <- renderPlot({
 
   school_demographics %>%
    filter(Year == input$YEAR) %>%
    filter(School_Name == input$School) %>%
    group_by(Gender) %>%
    summarise(Total_Student = sum(White) + sum(`Hispanic/Latino`) + sum(`Black or African American`) + sum(Asian) + sum(`American Indian or Alaska Native`+ sum(`Native Hawaiian or Other Pacific Islander`))) %>%
    ggplot(aes(x = Gender, y = Total_Student, fill = Gender ))+
    geom_col(width = 0.5)+
    scale_fill_manual(values = c("coral1", "turquoise3"))+
    ggtitle(" Student Enrollment")+
    labs(x= "", y = "Total Students") +
    theme(plot.title = element_text(size = 16, hjust = 0.5),
          legend.position="none",
          axis.text.x  = element_text(size = 12),
          axis.title.y = element_text(size = 12, vjust = 3),
          axis.text.y  = element_text(size = 10)) 
})# Page 2

# plot for school demographics

output$bar_plot2 <- renderPlot({
  
  school_dem <- school_demographics %>%
    filter(Year == input$YEAR) %>%
    filter(School_Name == input$School ) %>%
    group_by(Gender) %>%
    summarise(WHITE = sum(White), `HISPANIC/LATINO`= sum(`Hispanic/Latino`), `BLACK OR AFRICAN AMERICAN` =sum(`Black or African American`), ASIAN = sum(Asian), `AMERICAN INDIAN OR ALASKA NATIVE`= sum(`American Indian or Alaska Native`, `NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER`= sum(`Native Hawaiian or Other Pacific Islander`))) 
  
  school_dem %>%
    pivot_longer(cols=-Gender) %>%
    ggplot(aes(x= reorder(name, - value) , y = value, fill = Gender))+
    geom_col(width = 0.5) +
    ggtitle(" Student Demographics")+
    labs(x = "", y = "Total Students") +
    theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust=1, size = 8),
          plot.title = element_text(hjust = 0.5, size = 16),
          legend.position="right",
          axis.title.y = element_text(size = 12, vjust = 3),
          axis.text.y  = element_text(size = 10)
          )
 
}) # Page 2 finish

# Page 3 Map for school districs 

output$mymap <- renderLeaflet({
  
  pal <- colorFactor(palette = 'Paired', domain = NULL)
  pal2 <- colorBin("Spectral", domain = NULL)
  
  
   leaflet(options = leafletOptions(minZoom = 10)) %>%
     addProviderTiles(provider = "CartoDB.Positron") %>%
     setView(lng = -86.6715, lat = 36.1700, zoom = 10) %>%
     setMaxBounds(lng1 = -86.7819 + 1, 
                  lat1 = 36.1766 + 1, 
                  lng2 = -86.7819 - 1, 
                  lat2 = 36.1766 - 1) %>%
     addPolygons(data = MNPS,
                 fillColor = ~pal2(DISTRICT),
                 color = "black",
                 weight = 2,
                 fillOpacity = 0.3) %>%
     addCircleMarkers(data = school_enrollment_sf,
                      radius = 4,
                      color = ~pal(SCHOOL_TYPE),
                      weight = 0.2,
                      fillColor = ~pal(SCHOOL_TYPE),
                      fillOpacity = 0.9,
                      label = ~popup) %>%
     addLegend(pal = pal, values = factor(school_enrollment_sf$SCHOOL_TYPE), opacity = 1.0, title = 'School Level',
               position = "bottomright")
   
 })#Page 3
 
})