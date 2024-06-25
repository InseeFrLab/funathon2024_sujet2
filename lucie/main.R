# Import des packages nécessaires ----------------------------------------------

library(yaml)
library(readr)
library(dplyr)
library(stringr)
library(sf)
library(leaflet)

# Import des fichiers de fonctions ---------------------------------------------

source("lucie/create_data_list.R")
source("lucie/clean_data_frame.R")
source("lucie/import_data.R")

# Création de tous les urls des sources ----------------------------------------

urls <- create_data_list("sources.yml")


# Import des données -----------------------------------------------------------

# Données sur les aéroports ====================================================

aeroports <- import_airport_data(urls)

aeroports %>% glimpse()

# Données sur les compagnies ===================================================

compagnies <- import_compagnies_data(urls)

compagnies %>% glimpse()

# Données sur les liaisons== ===================================================

liaisons <- import_liaisons_data(urls)

liaisons %>% glimpse()


# Localisation des données des aéroports ---------------------------------------

localisations_aeroports <- st_read(urls$geojson$airport)

# Carte minimaliste pour vérifier la bonne localisation des données
leaflet(localisations_aeroports) %>% 
  addTiles() %>% 
  addMarkers(label = ~Nom)
