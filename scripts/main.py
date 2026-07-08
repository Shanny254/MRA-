import time

from scripts.extract import get_sheet_names, read_sheet
from scripts.transform import clean_dataframe
from scripts.load import load_dataframe
from scripts.logger import logger


def clean_table_name(sheet):
    return (
        sheet.lower()
             .replace(" ", "_")
             .replace("-", "_")
             .replace("/", "_")
    )


def main():

    start_time = time.time()

    logger.info("=" * 60)
    logger.info("KPLC MRA ETL STARTED")
    logger.info("=" * 60)

    sheets = get_sheet_names()

    total_rows = 0
    successful_sheets = 0
    failed_sheets = 0

    for sheet in sheets:

        try:

            logger.info(f"Reading sheet: {sheet}")

            df = read_sheet(sheet)

            logger.info(f"Rows found: {len(df)}")

            df = clean_dataframe(df)

            table = clean_table_name(sheet)

            load_dataframe(df, table)

            logger.info(f"{sheet} imported successfully.")

            total_rows += len(df)
            successful_sheets += 1

        except Exception as e:

            failed_sheets += 1

            logger.exception(f"Failed to import sheet: {sheet}")

    execution_time = time.time() - start_time

    logger.info("=" * 60)
    logger.info("ETL COMPLETED")
    logger.info("=" * 60)
    logger.info(f"Successful Sheets : {successful_sheets}")
    logger.info(f"Failed Sheets     : {failed_sheets}")
    logger.info(f"Total Rows Loaded : {total_rows:,}")
    logger.info(f"Execution Time    : {execution_time:.2f} seconds")
    logger.info("=" * 60)


if __name__ == "__main__":
    main()