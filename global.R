source("R/load_data.R")

catalogue <- create_data_list()
year_list <- 2018:2022
month_list = c(paste0("0", 1:9),10:12)


pax_apt_all = lapply(
  year_list,
  function(year) load_data(catalogue, "airports", year)
) %>% bind_rows()

pax_cie_all = lapply(
  year_list,
  function(year) load_data(catalogue, "compagnies", year)
) %>% bind_rows()

pax_lsn_all = lapply(
  year_list,
  function(year) load_data(catalogue, "liaisons", year)
) %>% bind_rows()
