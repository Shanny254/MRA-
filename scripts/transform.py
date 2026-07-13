import re
import pandas as pd


COLUMN_MAPPING = {

    "Account Number": "account_number",
    "ACCOUNT": "account_number",
    "New Account No.": "account_number",
    "Old Account No.": "old_account_number",

    "Customer Name": "customer_name",
    "Customers Name": "customer_name",
    "Customer": "customer_name",
    "Cliente": "customer_name",

    "Staff": "staff_name",
    "Staff No": "staff_no",

    "Meters": "meter_number",
    "Meter": "meter_number",
    "Meter No.": "meter_number",

    "Region": "region",
    "REGION": "region",

    "County": "county",
    "COUNTY": "county",

    "Sector Name": "sector_name",
    "SECTOR_NAME": "sector_name",
    "sector_nam": "sector_name",

    "Zone Name": "zone_name",
    "ZONE_NAME": "zone_name",

    "Itin": "itinerary",
    "Itin ": "itinerary",
    "Itinerary": "itinerary",

    "Contract Status": "contract_status",

    "Tariff": "tariff",
    "Cod Tariff": "tariff",
    "COD_TARIFF": "tariff",

    "COMM STATUS": "communication_status",

    "GOOGLE_LAT": "latitude",
    "GOOGLE_LONG": "longitude",
}


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

    df.columns = [standardize_column_name(column) for column in df.columns]

    df = df.loc[:, ~df.columns.duplicated()]

    return df