import pandas as pd
import geopandas as gpd
import plotly.express as px

import src.import_data as sid
from src.create_data_list import create_data_list
from src.divers_functions import (
  create_data_from_input,
  summary_stat_airport
)
from src.tables import create_table_airports
from src.figures import plot_airport_line, map_leaflet_airport


YEARS_LIST = [str(year) for year in range(2018, 2023)]
MONTHS_LIST = list(range(1, 13))
year = YEARS_LIST[0]
month = MONTHS_LIST[0]

# Load data ----------------------------------
urls = create_data_list("./sources.yml")


pax_apt_all = sid.import_airport_data(urls['airports'].values())
pax_cie_all = sid.import_airport_data(urls['compagnies'].values())
pax_lsn_all = sid.import_airport_data(urls['liaisons'].values())

airports_location = gpd.read_file(
    urls['geojson']['airport']
)


liste_aeroports = pax_apt_all['apt'].unique()
default_airport = liste_aeroports[0]


# OBJETS NECESSAIRES A L'APPLICATION ------------------------

pax_apt_all['trafic'] = pax_apt_all['apt_pax_dep'] + \
  pax_apt_all['apt_pax_tr'] + \
  pax_apt_all['apt_pax_arr']

trafic_aeroports = (
  pax_apt_all
  .loc[pax_apt_all['apt'] == default_airport]
)
trafic_aeroports['date'] = pd.to_datetime(
  trafic_aeroports['anmois'] + '01', format='%Y%m%d'
)

stats_aeroports = summary_stat_airport(
  create_data_from_input(pax_apt_all, year, month)
)


# VALORISATIONS ----------------------------------------------

figure_plotly = plot_airport_line(trafic_aeroports, default_airport)

table_airports = create_table_airports(stats_aeroports)

carte_interactive = map_leaflet_airport(
  pax_apt_all, airports_location,
  month, year
)