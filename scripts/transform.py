import re
import pandas as pd

from scripts.column_mapping import COLUMN_MAPPING
from scripts.table_schema import TABLE_SCHEMA


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

    # Trim text columns
    for column in df.select_dtypes(include="object").columns:

        df[column] = (
            df[column]
            .astype("string")
            .str.strip()
            .replace("", pd.NA)
        )

    # Preserve identifiers as text
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


def filter_table_columns(df: pd.DataFrame, table_name: str):
    """
    Keep only the SQL table columns.
    """

    if table_name not in TABLE_SCHEMA:
        return df

    allowed_columns = TABLE_SCHEMA[table_name]

    existing_columns = [
        column
        for column in allowed_columns
        if column in df.columns
    ]

    return df[existing_columns].copy()


def build_accounts_master(tables: dict):
    """
    Build the Accounts master table.
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

    for _, df in tables.items():

        if "account_number" not in df.columns:
            continue

        available_columns = [
            column
            for column in columns_to_keep
            if column in df.columns
        ]

        if available_columns:
            account_frames.append(df[available_columns].copy())

    if not account_frames:
        return pd.DataFrame(columns=columns_to_keep)

    accounts = pd.concat(
        account_frames,
        ignore_index=True,
        sort=False
    )

    accounts = accounts.dropna(subset=["account_number"])

    accounts = accounts[
        accounts["account_number"].astype(str).str.strip() != ""
    ]

    # Keep the most complete record for each account
    accounts["completeness_score"] = accounts.notna().sum(axis=1)

    accounts = (
        accounts
        .sort_values("completeness_score", ascending=False)
        .drop_duplicates("account_number", keep="first")
        .drop(columns="completeness_score")
        .reset_index(drop=True)
    )

    # Match SQL column order
    accounts = accounts.reindex(columns=columns_to_keep)

    return accounts