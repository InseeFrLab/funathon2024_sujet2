import pandas as pd
from .clean_dataframe import clean_dataframe

import requests
import zipfile
import os


def download_and_unzip(zip_url, extract_to="temp/"):
    """
    Downloads a zip file, extracts it, and returns the list of files inside.

    Args:
        zip_url (str): URL of the zip file to download.
        extract_to (str, optional): Directory to extract to. Defaults to a temporary directory.

    Returns:
        list: List of extracted file paths.
    """

    # Create the directory if it doesn't exist
    os.makedirs(extract_to, exist_ok=True)

    # Download the zip file
    response = requests.get(zip_url)
    response.raise_for_status()  # Raise an error for bad status codes

    # Save the zip file temporarily
    zip_path = os.path.join(extract_to, "downloaded_file.zip")
    with open(zip_path, 'wb') as f:
        f.write(response.content)

    # Unzip the file
    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall(extract_to)

    # List all extracted files (excluding directories)
    extracted_files = [
        os.path.join(extract_to, f)
        for f in zip_ref.namelist()
        if not f.endswith('/')  # Skip directories
    ]

    # Clean up the zip file
    os.remove(zip_path)

    return extracted_files


def import_airport_data(list_files):
    # Define the data types for each column
    col_types = {
        "ANMOIS": "str",
        "APT": "str",     # equivalent to col_character()
        "APT_NOM": "str", # equivalent to col_character()
        "APT_ZON": "str", # equivalent to col_character()
    }

    # Read the CSV file(s) with the specified column types
    pax_apt_all = pd.concat([
        pd.read_csv(file, delimiter = ';', dtype = col_types)
        for file in list_files
        ])

    # Clean the DataFrame (assuming clean_dataframe is a predefined function)
    pax_apt_all = clean_dataframe(pax_apt_all)

    return pax_apt_all



def import_compagnies_data(list_files):
    # Define the data types for each column
    col_types = {
        "ANMOIS": "str",
        "CIE": "str",
        "CIE_NOM": "str",
        "CIE_NAT": "str",
        "CIE_PAYS": "str"
    }

    # Read the CSV file(s) with the specified column types
    pax_cie_all = pd.concat([
        pd.read_csv(file, delimiter = ';', dtype = col_types)
        for file in list_files
        ])

    # Clean the DataFrame (assuming clean_dataframe is a predefined function)
    pax_cie_all = clean_dataframe(pax_cie_all)


    return pax_cie_all


def import_liaisons_data(list_files):
    # Define the data types for each column
    col_types = {
        "ANMOIS": "str",
        "LSN": "str",
        "LSN_DEP_NOM": "str",
        "LSN_ARR_NOM": "str",
        "LSN_SCT": "str",
        "LSN_FSC": "str"
    }

    # Read the CSV file(s) with the specified column types
    pax_lsn_all = pd.concat([
        pd.read_csv(file, delimiter = ';', dtype = col_types)
        for file in list_files
        ])

    # Clean the DataFrame
    pax_lsn_all = clean_dataframe(pax_lsn_all)

    return pax_lsn_all
