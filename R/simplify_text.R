simplify_text <- function(text){
  text <- gsub('[:punct:]',' ', text)
  text <- gsub(' ','', text)
  return(
    tolower(stri_trans_general(text, "Latin-ASCII"))
  )
}