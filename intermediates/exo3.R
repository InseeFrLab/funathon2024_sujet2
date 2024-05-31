library(dplyr)
library(ggplot2)
library(plotly)

trafic_aeroports <- pax_apt_all %>%
  mutate(trafic = apt_pax_dep + apt_pax_tr + apt_pax_arr) %>%
  filter(apt %in% default_airport) %>%
  mutate(
    date = as.Date(paste(an, mois, "01", sep="-"))
  )

figure_ggplot <- ggplot(trafic_aeroports) + geom_line(aes(x = date, y = trafic))


figure_plotly <- trafic_aeroports %>%
  plot_ly(
    x = ~date, y = ~trafic,
    text = ~apt_nom,
    hovertemplate = paste("<i>Aéroport:</i> %{text}<br>Trafic: %{y}") ,
    type = 'scatter', mode = 'lines+markers')
