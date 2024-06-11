create_table_airports <- function(stats_aeroports){

  stats_aeroports_table <- stats_aeroports %>%
    mutate(name_clean = paste0(str_to_sentence(apt_nom), " _(", apt, ")_")
    ) %>%
    select(name_clean, everything())
    
  table_aeroports <- gt(stats_aeroports_table)
  
  table_aeroports <- table_aeroports %>%
    cols_hide(columns = starts_with("apt"))
  
  table_aeroports <- table_aeroports %>%
    fmt_number(columns = starts_with("pax"), suffixing = TRUE)
  
  table_aeroports <- table_aeroports %>%
    fmt_markdown(columns = "name_clean")
  
  table_aeroports <- table_aeroports %>%
    cols_label(
      name_clean = md("**Aéroport**"),
      paxdep = md("**Départs**"),
      paxarr = md("**Arrivée**"),
      paxtra = md("**Transit**")
    ) %>%
    tab_header(
      title = md("**Statistiques de fréquentation**"),
      subtitle = md("Classement des aéroports")
    ) %>%
    tab_style(
      style = cell_fill(color = "powderblue"),
      locations = cells_title()
    ) %>%
    tab_source_note(source_note = md("_Source: DGAC, à partir des données sur data.gouv.fr_"))
  
  table_aeroports <- table_aeroports %>%
    opt_interactive()
  
  return(table_aeroports)

}
