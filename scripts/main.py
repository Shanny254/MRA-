import os
import time
from datetime import datetime

from scripts.extract import get_sheet_names, read_sheet
from scripts.transform import clean_dataframe
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

    # ETL START

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

    # Store all cleaned tables in memory
    tables = {}

    # PROCESS EACH WORKSHEET

    for index, sheet in enumerate(sheets, start=1):

        try:

            logger.info(f"[{index}/{len(sheets)}] Processing: {sheet}")

            # Extract

            df = read_sheet(sheet)

            logger.info(f"Rows Extracted    : {len(df):,}")

            # Transform

            df = clean_dataframe(df)

            # Destination Table

            table = clean_table_name(sheet)

            logger.info(f"Destination Table : {table}")

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

            # Store dataframe in memory

            tables[table] = df

            logger.info("Stored dataframe in memory.")

            # Load

            load_dataframe(df, table)

            successful_sheets += 1
            total_rows += len(df)

            logger.info("Load Status       : SUCCESS")

        except Exception:

            failed_sheets += 1

            logger.exception(f"FAILED TO IMPORT SHEET: {sheet}")

    # MEMORY SUMMARY

    logger.info("Tables Stored In Memory")

    for table_name in tables:
        logger.info(f" - {table_name}")

    logger.info(f"Total Tables      : {len(tables)}")

    # SAVE VALIDATION REPORT

    report_file = report.save()

    logger.info("VALIDATION REPORT")

    if report_file:

        logger.info("Validation report successfully generated.")
        logger.info(f"Validation Report : {report_file}")

    else:

        logger.info("No validation issues found.")
        logger.info("Validation report was not created.")

    # ETL SUMMARY

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