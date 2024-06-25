#' Fonction pour importer les données sur les aéroports
#'
#' @param liste_urls donnée par la fonction create_data_list
#' @param annee année souhaitée (au format caractère)
#'
#' @return data
#'
#' @examples 
#' urls <- create_data_list("sources.yml")
#' import_data_airports(urls, "2018)
#' 
import_data_airports <- function(liste_urls, annee) {
  urls <- unlist(liste_urls$airports)
  data <- readr::read_csv(urls[[annee]],
                          col_types = cols(
                            ANMOIS = col_character(),
                            APT = col_character(),
                            APT_NOM = col_character(),
                            APT_ZON = col_character(),
                            .default = col_double()
                          ))
  return(data)
}