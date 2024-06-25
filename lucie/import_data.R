#' Fonction pour importer les données sur les aéroports et les nettoyer
#'
#' @param liste_files donnée par la fonction create_data_list
#'
#' @return data dataframe des aéroports
#'
#' @examples 
#' urls <- create_data_list("sources.yml")
#' import_airport_data(urls)
#' 
import_airport_data <- function(liste_files) {
  data <- read_csv2(unlist(liste_files$airports),
                          col_types = cols(
                            ANMOIS = col_character(),
                            APT = col_character(),
                            APT_NOM = col_character(),
                            APT_ZON = col_character(),
                            .default = col_double()
                          ))
  
  data <- data %>% clean_data_frame()
  
  return(data)
}


# Même fonction, mais pour les données sur les compagnies aérienens
import_compagnies_data <- function(liste_files) {
  data <- read_csv2(unlist(liste_files$compagnies),
                    col_types = cols(
                      ANMOIS = col_character(),
                      CIE = col_character(),
                      CIE_NOM = col_character(),
                      CIE_NAT = col_character(),
                      CIE_PAYS = col_character(),
                      .default = col_double()
                    ))
  
  data <- data %>% clean_data_frame()
  
  return(data)
}

# Même fonction, mais pour les données sur les liaisons aérienens
import_liaisons_data <- function(liste_files) {
  data <- read_csv2(unlist(liste_files$liaisons),
                    col_types = cols(
                      ANMOIS = col_character(),
                      LSN = col_character(),
                      LSN_SCT = col_character(),
                      LSN_FSC = col_character(),
                      LSN_DEP_NOM = col_character(),
                      LSN_ARR_NOM = col_character(),
                      .default = col_double()
                    ))
  
  data <- data %>% clean_data_frame()
  
  return(data)
}
