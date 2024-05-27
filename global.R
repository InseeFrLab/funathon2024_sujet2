# Environment ----------------------------------

library(stringi)
library(yaml)
library(readr)
library(janitor)
library(dplyr)
library(stringr)
library(bslib)

source("R/create_data_list.R")
source("R/clean_dataframe.R")
source("R/divers_functions.R")
source("R/simplify_text.R")

# Global variables ---------------------------

YEARS_LIST <- as.character(2018:2022)
MONTHS_LIST = c(paste0("0", 1:9), 10:12)

# Load data ----------------------------------
urls <- create_data_list("./sources.yml")

pax_apt_all <- readr::read_csv2(
  unlist(urls$airports), 
  col_types = cols(
    ANMOIS = col_character(),
    APT = col_character(),
    APT_NOM = col_character(),
    APT_ZON = col_character(),
    .default = col_double()
  )
) %>% 
  clean_dataframe()

pax_cie_all <- readr::read_csv2(
  file = unlist(urls$compagnies),
  col_types = cols(
    ANMOIS = col_character(),
    CIE = col_character(),
    CIE_NOM = col_character(),
    CIE_NAT = col_character(),
    CIE_PAYS = col_character(),
    .default = col_double()
  )
) %>% 
  clean_dataframe()
                       
pax_lsn_all <- readr::read_csv2(
  file = unlist(urls$liaisons),
  col_types = cols(
    ANMOIS = col_character(),
    LSN = col_character(),
    LSN_DEP_NOM = col_character(),
    LSN_ARR_NOM = col_character(),
    LSN_SCT = col_character(),
    LSN_FSC = col_character(),
    .default = col_double()
  ) 
) %>% 
  clean_dataframe()
