import os
import time
from datetime import datetime

from scripts.extract import get_sheet_names, read_sheet
from scripts.transform import (
    clean_dataframe,
    filter_table_columns,
    build_accounts_master,
)
from scripts.load import load_dataframe
from scripts.logger import logger
from scripts.config import EXCEL_FILE
from scripts.validate import validate_dataframe, report


def clean_table_name(sheet):
    """
    Convert an Excel worksheet name into a SQL Server table name.
    """

    return (
        sheet.lower()
        .replace(" ", "_")
        .replace("-", "_")
        .replace("/", "_")
    )


def main():

    start_time = time.time()
    start_datetime = datetime.now()

    workbook_name = os.path.basename(EXCEL_FILE)
    database_name = "MRAs"

    logger.info("KPLC MRA ETL PIPELINE STARTED")
    logger.info(f"Workbook          : {workbook_name}")
    logger.info(f"Database          : {database_name}")
    logger.info(f"Started At        : {start_datetime:%Y-%m-%d %H:%M:%S}")

    sheets = get_sheet_names()

    logger.info(f"Worksheets Found  : {len(sheets)}")

    total_rows = 0
    successful_sheets = 0
    failed_sheets = 0

    tables = {}

    for index, sheet in enumerate(sheets, start=1):

        try:

            logger.info(f"[{index}/{len(sheets)}] Processing: {sheet}")

            # Extract
            df = read_sheet(sheet)

            logger.info(f"Rows Extracted    : {len(df):,}")

            # Destination table
            table = clean_table_name(sheet)

            logger.info(f"Destination Table : {table}")

            # Transform
            df = clean_dataframe(df)

            # Keep only SQL table columns
            df = filter_table_columns(df, table)

            # Validate
            validation = validate_dataframe(df, table)

            logger.info("Validation Summary")
            logger.info(f"Rows Checked      : {validation['rows']:,}")
            logger.info(f"Warnings          : {validation['warnings']}")
            logger.info(f"Errors            : {validation['errors']}")

            if not validation["passed"]:

                logger.warning(f"{sheet} failed validation. Skipping load.")

                failed_sheets += 1
                continue

            tables[table] = df

            logger.info("Stored dataframe in memory.")

            load_dataframe(df, table)

            successful_sheets += 1
            total_rows += len(df)

            logger.info("Load Status       : SUCCESS")

        except Exception:

            failed_sheets += 1

            logger.exception(f"FAILED TO IMPORT SHEET: {sheet}")

    # Build Accounts Master

    logger.info("Building Accounts Master Table")

    try:

        accounts = build_accounts_master(tables)

        if accounts.empty:
            raise ValueError("Accounts Master is empty.")

        tables["accounts"] = accounts

        logger.info(
            f"Accounts Master Records : {len(accounts):,}"
        )

        load_dataframe(accounts, "accounts")

        logger.info("Accounts Master imported successfully.")

    except Exception:

        logger.exception("Failed to build Accounts Master.")

    # Memory Summary

    logger.info("Tables Stored In Memory")

    for table_name in tables:
        logger.info(f" - {table_name}")

    logger.info(f"Total Tables      : {len(tables)}")

    # Validation Report

    report_file = report.save()

    logger.info("VALIDATION REPORT")

    if report_file:

        logger.info("Validation report successfully generated.")
        logger.info(f"Validation Report : {report_file}")

    else:

        logger.info("No validation issues found.")
        logger.info("Validation report was not created.")

    # ETL Summary

    end_datetime = datetime.now()
    execution_time = time.time() - start_time

    logger.info("ETL SUMMARY")

    logger.info(f"Workbook          : {workbook_name}")
    logger.info(f"Database          : {database_name}")
    logger.info(f"Started At        : {start_datetime:%Y-%m-%d %H:%M:%S}")
    logger.info(f"Completed At      : {end_datetime:%Y-%m-%d %H:%M:%S}")

    logger.info(f"Total Worksheets  : {len(sheets)}")
    logger.info(f"Successful Loads  : {successful_sheets}")
    logger.info(f"Failed Loads      : {failed_sheets}")
    logger.info(f"Total Rows Loaded : {total_rows:,}")
    logger.info(f"Execution Time    : {execution_time:.2f} seconds")

    if failed_sheets == 0:
        logger.info("ETL Status        : SUCCESS")
    else:
        logger.warning("ETL Status        : COMPLETED WITH ERRORS")


if __name__ == "__main__":
    main()