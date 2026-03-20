import geopandas as gpd
import pandas as pd
import src.import_data as sid
from src.create_data_list import create_data_list

# Load data ----------------------------------
urls = create_data_list("./sources.yml")


pax_apt_all = sid.import_airport_data(sid.download_and_unzip(urls["airports"]))
pax_cie_all = sid.import_airport_data(sid.download_and_unzip(urls["compagnies"]))
pax_lsn_all = sid.import_airport_data(sid.download_and_unzip(urls["liaisons"]))


airports_location = gpd.read_file(urls["geojson"]["airport"])


liste_aeroports = pax_apt_all["apt"].unique()
default_airport = liste_aeroports[0]


# OBJETS NECESSAIRES A L'APPLICATION ------------------------

pax_apt_all["trafic"] = (
    pax_apt_all["apt_pax_dep"] + pax_apt_all["apt_pax_tr"] + pax_apt_all["apt_pax_arr"]
)

trafic_aeroports = pax_apt_all.loc[pax_apt_all["apt"] == default_airport]
trafic_aeroports["date"] = pd.to_datetime(
    trafic_aeroports["anmois"] + "01", format="%Y%m%d"
)


# VALORISATIONS ----------------------------------------------

from src.figures import plot_airport_line

figure_plotly = plot_airport_line(trafic_aeroports, default_airport)
