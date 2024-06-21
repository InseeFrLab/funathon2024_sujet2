import pandas as pd
import geopandas as gpd

import streamlit as st
import streamlit.components.v1 as components
from streamlit_folium import st_folium

import src.import_data as sid
from src.create_data_list import create_data_list
from src.divers_functions import (
  create_data_from_input,
  summary_stat_airport
)
from src.tables import create_table_airports
from src.figures import plot_airport_line, map_leaflet_airport

# Constants --------------------------------------------------

YEARS_LIST = [str(year) for year in range(2018, 2023)]
MONTHS_LIST = list(range(1, 13))
default_year = YEARS_LIST[0]
default_month = MONTHS_LIST[0]

urls = create_data_list("./sources.yml")

# Load Data ---------------------------------------------

pax_apt_all = sid.import_airport_data(urls['airports'].values())
pax_cie_all = sid.import_airport_data(urls['compagnies'].values())
pax_lsn_all = sid.import_airport_data(urls['liaisons'].values())

airports_location = gpd.read_file(urls['geojson']['airport'])

liste_aeroports = pax_apt_all['apt'].unique()
default_airport = liste_aeroports[0]

# Data Processing ----------------------------------------------
pax_apt_all['trafic'] = pax_apt_all['apt_pax_dep'] +\
  pax_apt_all['apt_pax_tr'] +\
  pax_apt_all['apt_pax_arr']

trafic_aeroports = pax_apt_all.loc[
  pax_apt_all['apt'] == default_airport
]
trafic_aeroports['date'] = pd.to_datetime(
  trafic_aeroports['anmois'] + '01', format='%Y%m%d'
)

# Streamlit Layout --------------------------------------

st.set_page_config(
  page_title="Tableau de bord des aéroports français", layout="wide",
  page_icon="✈️"
  )
col1, col2 = st.columns(2)


# MAIN BODY --------------------------------------

# COLUMN 1 =======================================

col1.markdown("👉️ [Retourner au tutoriel pour construire cette application](https://inseefrlab.github.io/funathon2024_sujet2/)")

selected_date = col1.date_input(
    "Mois choisi",
    pd.to_datetime("2019-01-01"),
    min_value=pd.to_datetime("2018-01-01"),
    max_value=pd.to_datetime("2022-12-01")
  )

year = selected_date.year
month = selected_date.month


# Aggregate using input values
stats_aeroports = summary_stat_airport(
  create_data_from_input(pax_apt_all, year, month)
)

# Transform GT table into HTML
table_airports = (
  create_table_airports(stats_aeroports)
  .as_raw_html()
)


components.html(table_airports, height=600)

st.subheader("Carte des aéroports")
carte_interactive = map_leaflet_airport(
    pax_apt_all, airports_location, month, year
)
st_folium(carte_interactive, height=300)

# Line Plot Output
st.subheader("Fréquentation d'un aéroport")
selected_airport = st.selectbox(
    "Aéroport choisi", options=liste_aeroports, index=0
)
figure_plotly = plot_airport_line(pax_apt_all, selected_airport)
st.plotly_chart(figure_plotly)


print(year)