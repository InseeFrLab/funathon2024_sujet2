#' Creates a 2-levels list of urls, pointing to open source data
#' 
#' @param source_file yaml file containing data urls 
#' @return list (level 1 = concepts, level 2 = year).
#'
#' @examples
#'  create_data_list("sources.yml")
#'  
create_data_list <- function(source_file){
  catalogue <- yaml::read_yaml(source_file)
  return(catalogue)
}