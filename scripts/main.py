import os
import time
from datetime import datetime

from scripts.config import DATABASE, EXCEL_FILE
from scripts.extract import get_sheet_names, read_sheet
from scripts.load import load_dataframe
from scripts.logger import logger
from scripts.transform import clean_dataframe, filter_table_columns
from scripts.validate import validate_dataframe, report


def clean_table_name(sheet_name):
    return (
        sheet_name.lower()
        .replace(" ", "_")
        .replace("-", "_")
        .replace("/", "_")
    )


def main():

    start_time = time.time()
    start_datetime = datetime.now()

    workbook_name = os.path.basename(EXCEL_FILE)

    logger.info("=" * 80)
    logger.info("KPLC MRA ETL STARTED")
    logger.info("=" * 80)
    logger.info(f"Workbook : {workbook_name}")
    logger.info(f"Database : {DATABASE}")
    logger.info(f"Started  : {start_datetime:%Y-%m-%d %H:%M:%S}")

    sheets = get_sheet_names()

    logger.info(f"Worksheets Found : {len(sheets)}")

    successful = 0
    failed = 0
    total_rows = 0
    loaded_tables = []

    for index, sheet in enumerate(sheets, start=1):

        table = clean_table_name(sheet)

        logger.info("")
        logger.info("-" * 80)
        logger.info(f"[{index}/{len(sheets)}] {sheet}")
        logger.info("-" * 80)

        try:

            # -------------------------
            # EXTRACT
            # -------------------------

            df = read_sheet(sheet)

            logger.info(f"Rows Extracted : {len(df):,}")

            # -------------------------
            # TRANSFORM
            # -------------------------

            df = clean_dataframe(df)

            df = filter_table_columns(
                df,
                table
            )

            # -------------------------
            # VALIDATE
            # -------------------------

            validation = validate_dataframe(
                df,
                table
            )

            logger.info(
                f"Validation -> Rows:{validation['rows']} "
                f"Warnings:{validation['warnings']} "
                f"Errors:{validation['errors']}"
            )

            if not validation["passed"]:

                logger.warning(
                    f"{table} failed validation. Skipping..."
                )

                failed += 1
                continue

            # -------------------------
            # LOAD
            # -------------------------

            load_dataframe(
                df,
                table
            )

            successful += 1
            total_rows += len(df)

            loaded_tables.append(table)

            logger.info(f"{table} imported successfully.")

        except Exception:

            failed += 1

            logger.exception(
                f"Failed importing worksheet: {sheet}"
            )

    logger.info("")
    logger.info("=" * 80)
    logger.info("TABLES IMPORTED")
    logger.info("=" * 80)

    for table in loaded_tables:
        logger.info(table)

    report_file = report.save()

    if report_file:

        logger.info("")
        logger.info(f"Validation Report : {report_file}")

    end_datetime = datetime.now()

    execution_time = round(
        time.time() - start_time,
        2
    )

    logger.info("")
    logger.info("=" * 80)
    logger.info("ETL SUMMARY")
    logger.info("=" * 80)

    logger.info(f"Workbook          : {workbook_name}")
    logger.info(f"Database          : {DATABASE}")
    logger.info(f"Started           : {start_datetime:%Y-%m-%d %H:%M:%S}")
    logger.info(f"Completed         : {end_datetime:%Y-%m-%d %H:%M:%S}")
    logger.info(f"Worksheets        : {len(sheets)}")
    logger.info(f"Successful Loads  : {successful}")
    logger.info(f"Failed Loads      : {failed}")
    logger.info(f"Rows Loaded       : {total_rows:,}")
    logger.info(f"Execution Time    : {execution_time} seconds")

    if failed == 0:
        logger.info("ETL Status        : SUCCESS")
    else:
        logger.warning("ETL Status        : COMPLETED WITH ERRORS")

    logger.info("=" * 80)


if __name__ == "__main__":
    main()