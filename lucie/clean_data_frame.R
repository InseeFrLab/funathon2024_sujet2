#' Fonction pour créer des variables d'année et de mois,
#' et mettre les noms de colonnes en minuscules
#'
#' @param data dataframe des aéroports
#'
#' @return data dataframe
#'
#' @examples clean_data_frame(aeroports)
#' 
clean_data_frame <- function(data) {
  data <- data %>% 
    mutate(an = substr(ANMOIS, 1, 4),
           mois = ifelse(substr(ANMOIS, 5, 6) %in% paste0("0", 1:9), 
                         substr(ANMOIS, 6, 6), 
                         substr(ANMOIS, 5, 6))
    ) %>% 
    select(-ANMOIS) %>% 
    rlang::set_names(str_to_lower(colnames(.)))
  
  return(data)
}