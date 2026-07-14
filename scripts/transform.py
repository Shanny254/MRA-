import re
import pandas as pd
from scripts.column_mapping import COLUMN_MAPPING

def standardize_column_name(column):
    """
    Convert Excel column names into standardized database column names.
    """

    column = column.strip()

    if column in COLUMN_MAPPING:
        return COLUMN_MAPPING[column]

    column = column.lower()

    column = re.sub(r"[^\w\s]", "", column)

    column = column.replace(" ", "_")

    return column


def clean_dataframe(df: pd.DataFrame):
    """
    Clean and standardize a dataframe before loading into SQL Server.
    """

    # Standardize column names
    df.columns = [standardize_column_name(column) for column in df.columns]

    # Remove duplicate columns
    df = df.loc[:, ~df.columns.duplicated()]

    # Strip whitespace from all text values
    for column in df.select_dtypes(include="object").columns:
        df[column] = df[column].astype(str).str.strip()

        # Convert empty strings to None
        df[column] = df[column].replace("", None)

    # Preserve identifier columns as text
    identifier_columns = [
        "account_number",
        "old_account_number",
        "meter_number",
        "staff_no",
    ]

    for column in identifier_columns:
        if column in df.columns:
            df[column] = (
                df[column]
                .astype("string")
                .str.strip()
            )

    return df


def build_accounts_master(tables: dict):
    """
    Build a master Accounts table from all worksheets.

    The Account Number is the authoritative primary key.
    If multiple worksheets contain the same account,
    information is merged into a single record.
    """

    columns_to_keep = [
    "account_number",
    "old_account_number",
    "customer_name",
    "meter_number",
    "region",
    "county",
    "sector_name",
    "zone_name",
    "itinerary",
    "tariff",
    "contract_status",
]

    account_frames = []

    for table_name, df in tables.items():

        if "account_number" not in df.columns:
            continue

        available_columns = [
            column
            for column in columns_to_keep
            if column in df.columns
        ]

        if not available_columns:
            continue

        account_frames.append(df[available_columns].copy())

    if not account_frames:
        return pd.DataFrame(columns=columns_to_keep)

    accounts = pd.concat(
        account_frames,
        ignore_index=True,
        sort=False
    )

    # Remove missing account numbers
    accounts = accounts.dropna(subset=["account_number"])

    # Remove blank account numbers
    accounts = accounts[
        accounts["account_number"]
        .astype(str)
        .str
        .strip()
        != ""
    ]

    # Sort so records with more information appear first
    accounts["completeness_score"] = accounts.notna().sum(axis=1)

    accounts = (
        accounts
        .sort_values(
            by="completeness_score",
            ascending=False
        )
        .drop_duplicates(
            subset="account_number",
            keep="first"
        )
        .drop(columns="completeness_score")
        .reset_index(drop=True)
    )

    return accounts