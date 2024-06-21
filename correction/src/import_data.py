import pandas as pd
from .clean_dataframe import clean_dataframe

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
