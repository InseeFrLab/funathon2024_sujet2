
plot_airport_line <- function(df, selected_airport){
  trafic_aeroports <- df %>%
    mutate(trafic = apt_pax_dep + apt_pax_tr + apt_pax_arr) %>%
    filter(apt %in% selected_airport) %>%
    mutate(
      date = as.Date(paste(an, mois, "01", sep="-"))
    )
  
  figure_plotly <- trafic_aeroports %>%
    plot_ly(
      x = ~date, y = ~trafic,
      text = ~apt_nom,
      hovertemplate = paste("<i>Aéroport:</i> %{text}<br>Trafic: %{y}") ,
      type = 'scatter', mode = 'lines+markers')
  
  return(figure_plotly)
}
