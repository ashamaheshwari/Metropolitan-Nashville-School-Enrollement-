
library(htmltools)
library(shiny)
library(shinythemes)
library(shinydashboard)
library(tidyverse)
library(leaflet)
library(sf)

school_enrollment <-read_csv('Data/school_enrollment.csv')

school_demographics <-read_csv('Data/school_demographics.csv')

school_enrollment$LONGITUDE[(is.na(school_enrollment$LONGITUDE))] <-
  -86.74527

school_enrollment$LATITUDE[(is.na(school_enrollment$LATITUDE))] <-
  36.23366

school_enrollment_sf <- st_as_sf(school_enrollment, coords =c("LONGITUDE","LATITUDE"), crs = 4326)

MNPS <- st_read("GISMNPS_SCHOOLS_2122/gisMNPS_BoE.shp", as_tibble = T, quiet = T)%>%
st_transform('+proj=longlat +datum=WGS84')

school_enrollment_sf$popup <- 
  paste0("<b>School Name:</b> ", school_enrollment_sf$SCHOOL_NAME, "<br>",
         "<b>School Type:</b> ", school_enrollment_sf$SCHOOL_TYPE, "<br>",
         "<b>Grades:</b> ", school_enrollment_sf$GRADES, "<br>",
         "<b>District:</b> ", school_enrollment_sf$SCHBRD_DIST, "<br>" , 
         "<b>Cluster:</b> ", school_enrollment_sf$CLUSTER_NAME, "<br>",
         "<b>Street Address:</b> ", school_enrollment_sf$ADDRESS, "<br>",
         "<b>Phone:</b> ", school_enrollment_sf$PHONE, "<br>",
         "<b>Web Link:</b> ", school_enrollment_sf$WEB_LINK, "<br>")  %>%
  lapply(htmltools::HTML)
