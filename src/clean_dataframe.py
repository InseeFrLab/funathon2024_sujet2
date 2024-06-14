def clean_dataframe(df):
    # Create 'an' and 'mois' columns
    df['an'] = df['ANMOIS'].str.slice(0, 4)
    df['mois'] = df['ANMOIS'].str.slice(4, 2)

    # Remove leading zeros from 'mois' column
    df['mois'] = df['mois'].str.replace(r'^0+', '')

    # Convert all column names to lowercase
    df.columns = df.columns.str.lower()

    return df
