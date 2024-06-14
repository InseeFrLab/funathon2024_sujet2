import pandas as pd
from .clean_dataframe import clean_dataframe

def import_airport_data(list_files):
    """
    Reads a CSV file or list of CSV files, applies specified column data types, and cleans the DataFrame.

    Args:
        list_files (str or list of str): The path to the CSV file or list of CSV files.

    Returns:
        DataFrame: The cleaned DataFrame with specified data types.
    """
    # Define the data types for each column
    col_types = {
        "ANMOIS": "str",
        "APT": "str",     # equivalent to col_character()
        "APT_NOM": "str", # equivalent to col_character()
        "APT_ZON": "str", # equivalent to col_character()
    }

    # Read the CSV file(s) with the specified column types
    pax_apt_all = pd.read_csv(
        list_files,
        sep=";",
        dtype=col_types
    )

    # Clean the DataFrame (assuming clean_dataframe is a predefined function)
    pax_apt_all = clean_dataframe(pax_apt_all)

    return pax_apt_all


