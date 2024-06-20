import yaml

def create_data_list(source_file):
    """
    Reads a YAML file and returns the contents as a dictionary.

    Args:
        source_file (str): The path to the YAML file.

    Returns:
        dict: The contents of the YAML file.
    """
    with open(source_file, 'r') as file:
        catalogue = yaml.safe_load(file)
    return catalogue
