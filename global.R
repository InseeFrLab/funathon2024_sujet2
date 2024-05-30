# Environment ----------------------------------

library(stringi)
library(yaml)
library(readr)
library(janitor)
library(dplyr)
library(stringr)
library(sf)
library(bslib)

source("R/import_data.R")
source("R/create_data_list.R")
source("R/clean_dataframe.R")
source("R/divers_functions.R")
source("R/simplify_text.R")

# Global variables ---------------------------

YEARS_LIST <- as.character(2018:2022)
MONTHS_LIST = c(paste0("0", 1:9), 10:12)

# Load data ----------------------------------
urls <- create_data_list("./sources.yml")


pax_apt_all <- import_airport_data(unlist(urls$compagnies))
pax_cie_all <- import_compagnies_data(unlist(urls$compagnies))
pax_lsn_all <- import_liaisons_data(unlist(urls$liaisons))


airports_location <- st_read(urls$geojson$airport) %>% sf::st_drop_geometry()
airports_location <- st_as_sf(airports_location, coords = c("Longitude", "Latitude"), crs = 4326)

