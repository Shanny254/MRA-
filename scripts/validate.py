import pandas as pd
from datetime import datetime

from scripts.logger import logger
from scripts.report import ValidationReport

# ==========================================================
# Validation Report Object
# ==========================================================

report = ValidationReport()


# ==========================================================
# Tools Table Validation
# ==========================================================

def validate_tools(df, table_name):

    warnings = 0

    if "STAFF_NO" in df.columns:

        duplicate_staff = (
            df[df["STAFF_NO"].duplicated(keep=False)]["STAFF_NO"]
            .drop_duplicates()
            .tolist()
        )

        if duplicate_staff:

            logger.warning(f"Duplicate STAFF_NO values: {len(duplicate_staff)}")

            warnings += 1

            for staff in duplicate_staff:
                report.add_issue(
                    table_name,
                    "STAFF_NO",
                    "Duplicate",
                    staff
                )

    if "STAFF_NAME" in df.columns:

        missing_rows = df[df["STAFF_NAME"].isna()].index.tolist()

        if missing_rows:

            logger.warning(f"Missing STAFF_NAME values: {len(missing_rows)}")

            warnings += 1

            for row in missing_rows:
                report.add_issue(
                    table_name,
                    "STAFF_NAME",
                    "Missing Value",
                    f"Excel Row {row + 2}"
                )

    return warnings


# ==========================================================
# Offline Smart Meters Validation
# ==========================================================

def validate_offline_smart_meters(df, table_name):

    warnings = 0

    if "ACCOUNT" in df.columns:

        duplicate_accounts = (
            df[df["ACCOUNT"].duplicated(keep=False)]["ACCOUNT"]
            .drop_duplicates()
            .tolist()
        )

        if duplicate_accounts:

            logger.warning(
                f"Duplicate ACCOUNT values: {len(duplicate_accounts)}"
            )

            warnings += 1

            for account in duplicate_accounts:

                report.add_issue(
                    table_name,
                    "ACCOUNT",
                    "Duplicate",
                    account
                )

    if "METER_NUMBER" in df.columns:

        missing_rows = df[df["METER_NUMBER"].isna()].index.tolist()

        if missing_rows:

            logger.warning(
                f"Missing METER_NUMBER values: {len(missing_rows)}"
            )

            warnings += 1

            for row in missing_rows:

                report.add_issue(
                    table_name,
                    "METER_NUMBER",
                    "Missing Value",
                    f"Excel Row {row + 2}"
                )

    return warnings


# ==========================================================
# Cycle Reading Validation
# ==========================================================

def validate_cycle_reading(df, table_name):

    warnings = 0

    if "INSPECTION_DATE" in df.columns:

        dates = pd.to_datetime(
            df["INSPECTION_DATE"],
            errors="coerce"
        )

        future_dates = df[dates > datetime.today()]

        if not future_dates.empty:

            logger.warning(
                f"Future inspection dates found: {len(future_dates)}"
            )

            warnings += 1

            for value in future_dates["INSPECTION_DATE"]:

                report.add_issue(
                    table_name,
                    "INSPECTION_DATE",
                    "Future Date",
                    value
                )

    return warnings


# ==========================================================
# Smart Meter Billing Validation
# ==========================================================

def validate_smart_meter_billing(df, table_name):

    warnings = 0

    if "TOTAL_READING" in df.columns:

        negative = df[df["TOTAL_READING"] < 0]

        if not negative.empty:

            logger.warning(
                f"Negative TOTAL_READING values: {len(negative)}"
            )

            warnings += 1

            for value in negative["TOTAL_READING"]:

                report.add_issue(
                    table_name,
                    "TOTAL_READING",
                    "Negative Reading",
                    value
                )

    return warnings


# ==========================================================
# Main Validation Function
# ==========================================================

def validate_dataframe(df: pd.DataFrame, table_name: str):

    logger.info(f"Validating table: {table_name}")

    warnings = 0
    errors = 0

    # ------------------------------------------------------
    # Generic Validation
    # ------------------------------------------------------

    if df.empty:

        logger.error("Worksheet contains no data.")

        report.add_issue(
            table_name,
            "",
            "Empty Worksheet",
            ""
        )

        errors += 1

    duplicate_columns = df.columns[df.columns.duplicated()]

    if len(duplicate_columns) > 0:

        logger.error(
            f"Duplicate columns found: {list(duplicate_columns)}"
        )

        for column in duplicate_columns:

            report.add_issue(
                table_name,
                column,
                "Duplicate Column",
                column
            )

        errors += 1

    # ------------------------------------------------------
    # Table Specific Validation
    # ------------------------------------------------------

    if table_name == "tools":

        warnings += validate_tools(df, table_name)

    elif table_name == "offline_smart_meters":

        warnings += validate_offline_smart_meters(df, table_name)

    elif table_name == "offline_meters_cycle_reading":

        warnings += validate_cycle_reading(df, table_name)

    elif table_name == "smart_meter_billing":

        warnings += validate_smart_meter_billing(df, table_name)

    logger.info("Validation completed.")

    return {
        "passed": errors == 0,
        "rows": len(df),
        "warnings": warnings,
        "errors": errors,
    }