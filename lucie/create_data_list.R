#' Fonction pour transformer un fichier yml en liste imbriquée
#'
#' @param source_file 
#' fichier yml avec les url
#'
#' @return liste_data liste 
#' (aéroports, liaisons et compagnies) de listes (années 2018  à 2022)
#'
#' @examples create_data_list("sources.yml)
#' 
create_data_list <- function(source_file) {
  liste_data <- read_yaml(source_file)
  return(liste_data)
}


