import pandas as pd
import geopandas as gpd

import src.import_data as sid
from src.create_data_list import create_data_list

# Load data ----------------------------------
urls = create_data_list("./sources.yml")


pax_apt_all = sid.import_airport_data(sid.download_and_unzip(urls['airports']))
pax_cie_all = sid.import_airport_data(sid.download_and_unzip(urls['compagnies']))
pax_lsn_all = sid.import_airport_data(sid.download_and_unzip(urls['liaisons']))


airports_location = gpd.read_file(
    urls['geojson']['airport']
)
