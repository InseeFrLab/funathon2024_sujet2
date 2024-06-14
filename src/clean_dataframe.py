def clean_dataframe(df):
    # Create 'an' and 'mois' columns
    df['an'] = df['ANMOIS'].str.slice(0, 4)
    df['mois'] = df['ANMOIS'].str.slice(4, 2)

    # Remove leading zeros from 'mois' column
    df['mois'] = df['mois'].str.replace(r'^0+', '')

    # Convert all column names to lowercase
    df.columns = df.columns.str.lower()

    return df


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
    pax_cie_all = pd.read_csv(
        list_files,
        sep=";",
        dtype=col_types
    )

    # Clean the DataFrame (assuming clean_dataframe is a predefined function)
    pax_cie_all = clean_dataframe(pax_cie_all)

    return pax_cie_all