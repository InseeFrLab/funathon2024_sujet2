library(readr)
library(dplyr)
library(stringr)
library(sf)
library(ggplot2)
library(plotly)
library(leaflet)

source("R/import_data.R")
source("R/create_data_list.R")
source("R/clean_dataframe.R")
source("R/divers_functions.R")
source("R/figures.R")

YEARS_LIST  <- as.character(2018:2022)
MONTHS_LIST <- c(paste0("0", 1:9), 10:12)
year <- YEARS_LIST[1]
month <- MONTHS_LIST[1]


# Load data ----------------------------------
urls <- create_data_list("./sources.yml")


pax_apt_all <- import_airport_data(unlist(urls$airports))
pax_cie_all <- import_compagnies_data(unlist(urls$compagnies))
pax_lsn_all <- import_liaisons_data(unlist(urls$liaisons))

airports_location <- st_read(urls$geojson$airport)

liste_aeroports <- unique(pax_apt_all$apt)
default_airport <- liste_aeroports[1]

# OBJETS NECESSAIRES A L'APPLICATION ------------------------

trafic_aeroports <- pax_apt_all %>%
  mutate(trafic = apt_pax_dep + apt_pax_tr + apt_pax_arr) %>%
  filter(apt %in% default_airport) %>%
  mutate(
    date = as.Date(paste(an, mois, "01", sep="-"))
  )

stats_aeroports <- summary_stat_airport(
  create_data_from_input(pax_apt_all, year, month)
)
stats_liaisons  <- summary_stat_liaisons(
  create_data_from_input(pax_lsn_all, year, month)
)


# VALORISATIONS ----------------------------------------------

figure_plotly <- plot_airport_line(trafic_aeroports,default_airport)

