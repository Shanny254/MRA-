import os
import time
from datetime import datetime

from scripts.extract import get_sheet_names, read_sheet
from scripts.transform import clean_dataframe
from scripts.load import load_dataframe
from scripts.logger import logger
from scripts.config import EXCEL_FILE
from scripts.validate import validate_dataframe


def clean_table_name(sheet):
    """
    Converts an Excel worksheet name into a SQL Server table name.
    """
    return (
        sheet.lower()
        .replace(" ", "_")
        .replace("-", "_")
        .replace("/", "_")
    )


def main():

    # ==========================================================
    # ETL START
    # ==========================================================

    start_time = time.time()
    start_datetime = datetime.now()

    workbook_name = os.path.basename(EXCEL_FILE)
    database_name = "MRAs"

    logger.info("=" * 70)
    logger.info("KPLC MRA ETL PIPELINE STARTED")
    logger.info("=" * 70)
    logger.info(f"Workbook          : {workbook_name}")
    logger.info(f"Database          : {database_name}")
    logger.info(f"Started At        : {start_datetime:%Y-%m-%d %H:%M:%S}")

    sheets = get_sheet_names()

    logger.info(f"Worksheets Found  : {len(sheets)}")
    logger.info("-" * 70)

    total_rows = 0
    successful_sheets = 0
    failed_sheets = 0

    # ==========================================================
    # PROCESS EACH WORKSHEET
    # ==========================================================

    for index, sheet in enumerate(sheets, start=1):

        try:

            logger.info(f"[{index}/{len(sheets)}] Processing: {sheet}")

            # -----------------------------
            # Extract
            # -----------------------------
            df = read_sheet(sheet)

            logger.info(f"Rows Extracted    : {len(df):,}")

            # -----------------------------
            # Transform
            # -----------------------------
            df = clean_dataframe(df)

            # -----------------------------
            # Destination Table
            # -----------------------------
            table = clean_table_name(sheet)

            logger.info(f"Destination Table : {table}")

            # -----------------------------
            # Validate
            # -----------------------------
            validation = validate_dataframe(df, table)

            logger.info("Validation Summary")
            logger.info(f"Rows Checked      : {validation['rows']}")
            logger.info(f"Warnings          : {validation['warnings']}")
            logger.info(f"Errors            : {validation['errors']}")

            if not validation["passed"]:

                logger.warning(f"{sheet} failed validation. Skipping load.")

                failed_sheets += 1

                logger.info("-" * 70)

                continue

            # -----------------------------
            # Load
            # -----------------------------
            load_dataframe(df, table)

            successful_sheets += 1
            total_rows += len(df)

            logger.info("Load Status       : SUCCESS")
            logger.info("-" * 70)

        except Exception:

            failed_sheets += 1

            logger.exception(f"FAILED TO IMPORT SHEET: {sheet}")

            logger.info("-" * 70)

    # ==========================================================
    # ETL SUMMARY
    # ==========================================================

    end_datetime = datetime.now()
    execution_time = time.time() - start_time

    logger.info("=" * 70)
    logger.info("ETL SUMMARY")
    logger.info("=" * 70)

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

    logger.info("=" * 70)


if __name__ == "__main__":
    main()