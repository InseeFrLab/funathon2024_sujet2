
create_data_from_input <- function(data, years, months){
  data <- data %>%
    filter(mois %in% months, an %in% years)
  return(data)
}

summary_stat_liaisons <- function(data){
  agg_data <- data %>%
    group_by(lsn_fsc) %>%
    summarise(
      paxloc = round(sum(lsn_pax_loc, na.rm = TRUE)*1e-6,3)
    ) %>%
    ungroup()
  return(agg_data)
}
summary_stat_airport <- function(data){
  table2 <- data %>%
    group_by(apt, apt_nom) %>%
    summarise(
      paxdep = round(sum(apt_pax_dep, na.rm = T)/1000000,3),
      paxarr = round(sum(apt_pax_arr, na.rm = T)/1000000,3),
      paxtra = round(sum(apt_pax_tr, na.rm = T)/1000000,3)) %>%
    arrange(desc(paxdep)) %>%
    ungroup()
  
  return(table2)
}
