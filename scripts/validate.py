import pandas as pd
from datetime import datetime

from scripts.logger import logger
from scripts.report import ValidationReport

# Validation Report Object
report = ValidationReport()


# Generic Validation Functions

def check_duplicate_values(df, table_name, column):

    warnings = 0

    if column in df.columns:

        duplicates = (
            df[df[column].duplicated(keep=False)][column]
            .drop_duplicates()
            .tolist()
        )

        if duplicates:

            logger.warning(f"Duplicate {column}: {len(duplicates)}")

            warnings += 1

            for value in duplicates:

                report.add_issue(
                    table_name,
                    column,
                    "Duplicate",
                    value
                )

    return warnings


def check_missing_values(df, table_name, column):

    warnings = 0

    if column in df.columns:

        missing_rows = df[df[column].isna()].index.tolist()

        if missing_rows:

            logger.warning(f"Missing {column}: {len(missing_rows)}")

            warnings += 1

            for row in missing_rows:

                report.add_issue(
                    table_name,
                    column,
                    "Missing Value",
                    f"Excel Row {row + 2}"
                )

    return warnings


def check_future_dates(df, table_name, column):

    warnings = 0

    if column in df.columns:

        dates = pd.to_datetime(df[column], errors="coerce")

        future_dates = df[dates > datetime.today()]

        if not future_dates.empty:

            logger.warning(
                f"Future {column}: {len(future_dates)}"
            )

            warnings += 1

            for value in future_dates[column]:

                report.add_issue(
                    table_name,
                    column,
                    "Future Date",
                    value
                )

    return warnings


def check_negative_values(df, table_name, column):

    warnings = 0

    if column in df.columns:

        negative = df[df[column] < 0]

        if not negative.empty:

            logger.warning(
                f"Negative {column}: {len(negative)}"
            )

            warnings += 1

            for value in negative[column]:

                report.add_issue(
                    table_name,
                    column,
                    "Negative Value",
                    value
                )

    return warnings


# Table Specific Validation

def validate_tools(df, table_name):

    warnings = 0

    warnings += check_duplicate_values(
        df,
        table_name,
        "staff_no"
    )

    warnings += check_missing_values(
        df,
        table_name,
        "staff_name"
    )

    return warnings


def validate_offline_smart_meters(df, table_name):

    warnings = 0

    warnings += check_duplicate_values(
        df,
        table_name,
        "account_number"
    )

    warnings += check_missing_values(
        df,
        table_name,
        "meter_number"
    )

    return warnings


def validate_cycle_reading(df, table_name):

    return check_future_dates(
        df,
        table_name,
        "inspection_date"
    )


def validate_smart_meter_billing(df, table_name):

    return check_negative_values(
        df,
        table_name,
        "total_reading"
    )


# Table Validator Registry

VALIDATORS = {

    "tools": validate_tools,

    "offline_smart_meters": validate_offline_smart_meters,

    "offline_meters_cycle_reading": validate_cycle_reading,

    "smart_meter_billing": validate_smart_meter_billing,

}


# Main Validation Function

def validate_dataframe(df: pd.DataFrame, table_name: str):

    logger.info(f"Validating table: {table_name}")

    warnings = 0
    errors = 0

    # Generic Validation

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

    empty_rows = df.isna().all(axis=1)

    if empty_rows.any():

        logger.warning(
            f"Empty rows found: {empty_rows.sum()}"
        )

        warnings += 1

        for row in df[empty_rows].index:

            report.add_issue(
                table_name,
                "",
                "Empty Row",
                f"Excel Row {row + 2}"
            )

    # Table Specific Validation

    validator = VALIDATORS.get(table_name)

    if validator:

        warnings += validator(df, table_name)

    logger.info("Validation completed.")

    return {

        "passed": errors == 0,

        "rows": len(df),

        "warnings": warnings,

        "errors": errors,

    }