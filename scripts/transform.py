import pandas as pd


def clean_dataframe(df):

    # Remove leading/trailing spaces
    df.columns = df.columns.str.strip()

    # Replace spaces with underscores
    df.columns = df.columns.str.replace(" ", "_")

    # Remove duplicate columns
    df = df.loc[:, ~df.columns.duplicated()]

    return df