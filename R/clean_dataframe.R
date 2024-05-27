clean_dataframe <- function(df){
  
  # Create an et mois columns
  df <- df %>% 
    mutate(
      an = str_sub(ANMOIS,1,4),
      mois = str_sub(ANMOIS,5,6)
    )
  
  # lower case for variable names
  colnames(df) <- tolower(colnames(df))
  
  return(df)

}