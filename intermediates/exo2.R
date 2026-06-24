library(readr)
library(dplyr)
library(stringr)
library(sf)
library(httr2)
library(utils)

source("correction/R/import_data.R")
source("correction/R/create_data_list.R")
source("correction/R/clean_dataframe.R")


# Load data ----------------------------------
urls <- create_data_list("./sources.yml")


pax_apt_all <- import_airport_data(download_and_unzip(urls$airports))
pax_cie_all <- import_compagnies_data(download_and_unzip(urls$compagnies))
pax_lsn_all <- import_liaisons_data(download_and_unzip(urls$liaisons))

airports_location <- st_read(urls$geojson$airport)
