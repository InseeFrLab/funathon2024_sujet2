library(stringi)
library(yaml)
library(readr)
library(janitor)

create_data_list <- function(source_file = "sources.yml"){
  catalogue <- yaml::read_yaml(source_file)
}

simplify_text <- function(text){
  text <- gsub('[:punct:]',' ', text)
  text <- gsub(' ','', text)
  return(
    tolower(stri_trans_general(text, "Latin-ASCII"))
  )
}

load_data <- function(catalogue, source = "airport", year = 2018){
  
  url <- catalogue[[source]][[as.character(year)]]
  
  data <- read_csv2(url)
  data <- data %>%
    mutate(an = as.numeric(str_sub(ANMOIS,1,4))) %>%
    mutate(mois = str_sub(ANMOIS,5,6)) %>%
    janitor::clean_names()
  
  return(data)
}

catalogue <- create_data_list()
pax_apt = load_data(catalogue, "airports")
pax_cie = load_data(catalogue, "compagnies")
pax_lsn = load_data(catalogue, "liaisons")
