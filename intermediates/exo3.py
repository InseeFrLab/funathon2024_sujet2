import pandas as pd
import geopandas as gpd
import plotly.express as px
from plotnine import ggplot, geom_line, aes

import src.import_data as sid
from src.create_data_list import create_data_list

# Load data ----------------------------------
urls = create_data_list("./sources.yml")


pax_apt_all = pd.concat(
    [sid.import_airport_data(l) for l in urls['airports'].values()]
)
pax_cie_all = pd.concat(
    [sid.import_airport_data(l) for l in urls['compagnies'].values()]
)
pax_lsn_all = pd.concat(
    [sid.import_airport_data(l) for l in urls['liaisons'].values()]
)

airports_location = gpd.read_file(
    urls['geojson']['airport']
)


liste_aeroports = pax_apt_all['apt'].unique()
default_airport = liste_aeroports[0]


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


# VALORISATIONS ----------------------------------------------

from src.figures import plot_airport_line


figure_ggplot = (
    ggplot(trafic_aeroports) +
    geom_line(aes(x = "date", y = "trafic"))
)


figure_plotly = px.line(
  trafic_aeroports, x="date", y="trafic",
  text="apt_nom"
)

figure_plotly.update_traces(
  mode="markers+lines", type = "scatter",
  hovertemplate="<i>Aéroport:</i> %{text}<br>Trafic: %{y}"
)