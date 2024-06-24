
plot_airport_line <- function(df, selected_airport){
  trafic_aeroports <- df %>%
    mutate(trafic = apt_pax_dep + apt_pax_tr + apt_pax_arr) %>%
    filter(apt %in% selected_airport) %>%
    mutate(
      date = as.Date(paste(anmois, "01", sep=""), format = "%Y%m%d")
    )
  
  figure_plotly <- trafic_aeroports %>%
    plot_ly(
      x = ~date, y = ~trafic,
      text = ~apt_nom,
      hovertemplate = paste("<i>Aéroport:</i> %{text}<br>Trafic: %{y}") ,
      type = 'scatter', mode = 'lines+markers')
  
  return(figure_plotly)
}


map_leaflet_airport <- function(df, airports_location, month, year){
  
  palette <- c("green", "blue", "red")

  trafic_date <- df %>%
    mutate(
      date = as.Date(paste(anmois, "01", sep=""), format = "%Y%m%d")
    ) %>%
    filter(mois == month, an == year)
  trafic_aeroports <- airports_location %>%
    inner_join(trafic_date, by = c("Code.OACI" = "apt"))
  
  
  trafic_aeroports <- trafic_aeroports %>%
    mutate(
      volume = ntile(trafic, 3)
    ) %>%
    mutate(
      color = palette[volume]
    )  
  
  icons <- awesomeIcons(
    icon = 'plane',
    iconColor = 'black',
    library = 'fa',
    markerColor = trafic_aeroports$color
  )
  
  carte_interactive <- leaflet(trafic_aeroports) %>% addTiles() %>%
    addAwesomeMarkers(
      icon=icons[],
      label=~paste0(Nom, "", " (",Code.OACI, ") : ", trafic, " voyageurs")
    )
  
  return(carte_interactive)
}
