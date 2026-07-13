import pandas as pd
from datetime import datetime
from scripts.logger import logger


def validate_tools(df):
    warnings = 0

    if "STAFF_NO" in df.columns:
        duplicates = df["STAFF_NO"].duplicated().sum()
        if duplicates > 0:
            logger.warning(f"Duplicate STAFF_NO values: {duplicates}")
            warnings += 1

    if "STAFF_NAME" in df.columns:
        missing = df["STAFF_NAME"].isna().sum()
        if missing > 0:
            logger.warning(f"Missing STAFF_NAME values: {missing}")
            warnings += 1

    return warnings


def validate_offline_smart_meters(df):
    warnings = 0

    if "ACCOUNT" in df.columns:
        duplicates = df["ACCOUNT"].duplicated().sum()
        if duplicates > 0:
            logger.warning(f"Duplicate ACCOUNT values: {duplicates}")
            warnings += 1

    if "METER_NUMBER" in df.columns:
        missing = df["METER_NUMBER"].isna().sum()
        if missing > 0:
            logger.warning(f"Missing METER_NUMBER values: {missing}")
            warnings += 1

    return warnings


def validate_cycle_reading(df):
    warnings = 0

    if "INSPECTION_DATE" in df.columns:

        dates = pd.to_datetime(df["INSPECTION_DATE"], errors="coerce")

        future_dates = (dates > datetime.today()).sum()

        if future_dates > 0:
            logger.warning(f"Future inspection dates found: {future_dates}")
            warnings += 1

    return warnings


def validate_smart_meter_billing(df):
    warnings = 0

    if "TOTAL_READING" in df.columns:

        negative = (df["TOTAL_READING"] < 0).sum()

        if negative > 0:
            logger.warning(f"Negative TOTAL_READING values: {negative}")
            warnings += 1

    return warnings


def validate_dataframe(df: pd.DataFrame, table_name: str):
    """
    Validate a dataframe before loading into SQL Server.

    Returns
    -------
    dict
        {
            "passed": bool,
            "rows": int,
            "warnings": int,
            "errors": int
        }
    """

    logger.info(f"Validating table: {table_name}")

    warnings = 0
    errors = 0

    # ---------------------------------
    # Generic Validation
    # ---------------------------------

    if df.empty:
        logger.error("Worksheet contains no data.")
        errors += 1

    duplicate_columns = df.columns[df.columns.duplicated()]

    if len(duplicate_columns) > 0:
        logger.error(
            f"Duplicate columns found: {list(duplicate_columns)}"
        )
        errors += 1

    # ---------------------------------
    # Table Specific Validation
    # ---------------------------------

    if table_name == "tools":
        warnings += validate_tools(df)

    elif table_name == "offline_smart_meters":
        warnings += validate_offline_smart_meters(df)

    elif table_name == "offline_meters_cycle_reading":
        warnings += validate_cycle_reading(df)

    elif table_name == "smart_meter_billing":
        warnings += validate_smart_meter_billing(df)

    logger.info("Validation completed.")

    return {
        "passed": errors == 0,
        "rows": len(df),
        "warnings": warnings,
        "errors": errors,
    }