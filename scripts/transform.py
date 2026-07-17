import re
import pandas as pd

from scripts.column_mapping import COLUMN_MAPPING
from scripts.table_schema import TABLE_SCHEMA


def standardize_column_name(column):
    """
    Convert Excel column names into SQL column names using COLUMN_MAPPING.
    """

    column = str(column).strip()

    if column in COLUMN_MAPPING:
        return COLUMN_MAPPING[column]

    column = column.lower()
    column = re.sub(r"[^\w\s]", "", column)
    column = column.replace(" ", "_")

    return column


def clean_dataframe(df: pd.DataFrame):
    """
    Clean dataframe before loading into SQL Server.
    """

    # Standardize column names
    df.columns = [standardize_column_name(col) for col in df.columns]

    # Remove duplicate columns
    df = df.loc[:, ~df.columns.duplicated()]

    # Trim whitespace
    object_columns = df.select_dtypes(include=["object", "string"]).columns

    for column in object_columns:
        df[column] = (
            df[column]
            .astype("string")
            .str.strip()
            .replace("", pd.NA)
        )

    # Preserve IDs exactly as they appear
    identifier_columns = [
        "account_number",
        "old_account_number",
        "meter_number",
        "staff_no",
        "location_id",
        "reading_unit",
        "business_unit",
        "office_name",
        "route_reference",
        "sim_serial",
        "globalid",
        "sys_accnumber",
        "sys_mtrnumber",
        "niss",
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
    Keep only columns that exist in the SQL table.
    """

    if table_name not in TABLE_SCHEMA:
        return df

    sql_columns = TABLE_SCHEMA[table_name]

    existing_columns = [
        column
        for column in sql_columns
        if column in df.columns
    ]

    return df[existing_columns].copy()


def build_customer_account(tables: dict):
    """
    Build customer_account master table.
    """

    master_columns = [
        "account_number",
        "old_account_number",
        "customer_name",
        "meter_number",
        "tariff",
        "contract_status",
    ]

    frames = []

    for df in tables.values():

        if "account_number" not in df.columns:
            continue

        available = [
            column
            for column in master_columns
            if column in df.columns
        ]

        if available:
            frames.append(df[available].copy())

    if not frames:
        return pd.DataFrame(columns=master_columns)

    accounts = pd.concat(
        frames,
        ignore_index=True,
        sort=False
    )

    accounts = accounts.dropna(subset=["account_number"])

    accounts = accounts[
        accounts["account_number"].astype(str).str.strip() != ""
    ]

    accounts["score"] = accounts.notna().sum(axis=1)

    accounts = (
        accounts
        .sort_values("score", ascending=False)
        .drop_duplicates("account_number", keep="first")
        .drop(columns="score")
        .reset_index(drop=True)
    )

    return accounts.reindex(columns=master_columns)


def build_location(tables: dict):
    """
    Build location master table.
    """

    location_columns = [
        "region",
        "county",
        "sector_name",
        "zone_name",
        "itinerary",
        "business_unit",
        "office_name",
        "reading_unit",
        "supply_location",
        "latitude",
        "longitude",
    ]

    frames = []

    for df in tables.values():

        available = [
            column
            for column in location_columns
            if column in df.columns
        ]

        if available:
            frames.append(df[available].copy())

    if not frames:
        return pd.DataFrame(columns=location_columns)

    locations = pd.concat(
        frames,
        ignore_index=True,
        sort=False
    )

    locations = locations.drop_duplicates().reset_index(drop=True)

    return locations.reindex(columns=location_columns)


def build_meter(tables: dict):
    """
    Build meter master table.
    """

    meter_columns = [
        "meter_number",
        "meter_serial_number",
        "meter_type",
        "meter_phase_type",
        "model_name",
        "mark_name",
    ]

    frames = []

    for df in tables.values():

        if "meter_number" not in df.columns:
            continue

        available = [
            column
            for column in meter_columns
            if column in df.columns
        ]

        if available:
            frames.append(df[available].copy())

    if not frames:
        return pd.DataFrame(columns=meter_columns)

    meters = pd.concat(
        frames,
        ignore_index=True,
        sort=False
    )

    meters = meters.dropna(subset=["meter_number"])

    meters = (
        meters
        .drop_duplicates("meter_number")
        .reset_index(drop=True)
    )

    return meters.reindex(columns=meter_columns)


def build_staff(tables: dict):
    """
    Build staff master table.
    """

    staff_columns = [
        "staff_no",
        "staff_name",
        "county",
        "workstation",
        "section_name",
    ]

    frames = []

    for df in tables.values():

        if "staff_no" not in df.columns:
            continue

        available = [
            column
            for column in staff_columns
            if column in df.columns
        ]

        if available:
            frames.append(df[available].copy())

    if not frames:
        return pd.DataFrame(columns=staff_columns)

    staff = pd.concat(
        frames,
        ignore_index=True,
        sort=False
    )

    staff = staff.dropna(subset=["staff_no"])

    staff = (
        staff
        .drop_duplicates("staff_no")
        .reset_index(drop=True)
    )

    return staff.reindex(columns=staff_columns)