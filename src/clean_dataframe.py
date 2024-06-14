def clean_dataframe(df):
    """
    Cleans the DataFrame by performing various operations:
    - Creates 'an' and 'mois' columns from the 'ANMOIS' column.
    - Removes leading zeros from the 'mois' column.
    - Converts all column names to lowercase.

    Args:
        df (pl.DataFrame): The input DataFrame.

    Returns:
        pl.DataFrame: The cleaned DataFrame.
    """
    # Create 'an' and 'mois' columns
    df['an'] = df['ANMOIS'].str.slice(0, 4)
    df['mois'] = df['ANMOIS'].str.slice(4, 2)

    # Remove leading zeros from 'mois' column
    df['mois'] = df['mois'].str.replace(r'^0+', '')

    # Convert all column names to lowercase
    df.columns = df.columns.str.lower()

    return df

# Example usage
# df = clean_dataframe(df)
