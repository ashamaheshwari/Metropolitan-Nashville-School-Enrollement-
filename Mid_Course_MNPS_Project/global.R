
library(shiny)
library(shinythemes)
library(shinydashboard)
library(tidyverse)
library(leaflet)
library(sf)

school_enrollment <-read_csv('Data/school_enrollment.csv')

school_enrollment$LONGITUDE[(is.na(school_enrollment$LONGITUDE))] <-
  -86.74527

school_enrollment$LATITUDE[(is.na(school_enrollment$LATITUDE))] <-
  36.23366

school_enrollment_sf <- st_as_sf(school_enrollment, coords =c("LONGITUDE","LATITUDE"), crs = 4326)

# MNPS <- st_read("Data/gisMNPS_BoE.shp", as_tibble = T, quiet = T)%>%
#   st_transform('+proj=longlat +datum=WGS84')