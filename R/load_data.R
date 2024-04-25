library(stringi)
library(yaml)
library(readr)
library(janitor)
library(dplyr)

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

create_data_from_input <- function(data, years, months){
  data <- data %>%
    filter(mois %in% months, an %in% years)
  return(data)
}

summary_stat_liaisons <- function(data){
  agg_data <- data %>%
    group_by(lsn_fsc) %>%
    summarise(
      paxloc = round(sum(lsn_pax_loc, na.rm = TRUE)*1e-6,3)
    ) %>%
    ungroup()
  return(agg_data)
}
summary_stat_airport <- function(data){
  table2 <- data %>%
    group_by(apt, apt_nom) %>%
    summarise(
      paxdep = round(sum(apt_pax_dep, na.rm = T)/1000000,3),
      paxarr = round(sum(apt_pax_arr, na.rm = T)/1000000,3),
      paxtra = round(sum(apt_pax_tr, na.rm = T)/1000000,3)) %>%
    arrange(desc(paxdep)) %>%
    ungroup()
  
  return(table2)
}









