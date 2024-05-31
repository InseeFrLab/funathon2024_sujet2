library(readr)
library(dplyr)
library(stringr)
library(sf)

source("R/import_data.R")
source("R/create_data_list.R")
source("R/clean_dataframe.R")


# Load data ----------------------------------
urls <- create_data_list("./sources.yml")


pax_apt_all <- import_airport_data(unlist(urls$airports))
pax_cie_all <- import_compagnies_data(unlist(urls$compagnies))
pax_lsn_all <- import_liaisons_data(unlist(urls$liaisons))

airports_location <- st_read(urls$geojson$airport)

