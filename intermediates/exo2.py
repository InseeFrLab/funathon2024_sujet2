import pandas as pd
import geopandas as gpd

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
