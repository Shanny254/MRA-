import pandas as pd
from sqlalchemy import inspect, text

from scripts.database import engine
from scripts.logger import logger


def load_dataframe(df: pd.DataFrame, table_name: str):
    """
    Load a DataFrame into an existing SQL Server table.
    """

    inspector = inspect(engine)

    # Ensure the table already exists
    if not inspector.has_table(table_name):
        raise Exception(
            f"SQL table '{table_name}' does not exist. "
            "Run the SQL scripts before running the ETL."
        )

    # Get SQL table columns
    sql_columns = [col["name"] for col in inspector.get_columns(table_name)]

    # Ignore auto-generated SQL columns
    ignored_sql_columns = {
        "created_at",
        "lp_account_id"
    }

    expected_columns = [
        col for col in sql_columns
        if col not in ignored_sql_columns
    ]

    # Check for duplicate columns
    duplicate_columns = df.columns[df.columns.duplicated()]

    if len(duplicate_columns) > 0:
        raise ValueError(
            f"Duplicate DataFrame columns found: {duplicate_columns.tolist()}"
        )

    dataframe_columns = list(df.columns)

    # Remove unexpected columns
    unexpected_columns = [
        col for col in dataframe_columns
        if col not in expected_columns
    ]

    if unexpected_columns:
        logger.warning(
            f"{table_name}: Removing unexpected DataFrame columns:"
        )

        for col in unexpected_columns:
            logger.warning(f"   -> {col}")

        df = df.drop(columns=unexpected_columns)

    # Report missing SQL columns
    missing_columns = [
        col for col in expected_columns
        if col not in df.columns
    ]

    if missing_columns:
        logger.warning(
            f"{table_name}: Missing SQL columns (NULL/default will be used):"
        )

        for col in missing_columns:
            logger.warning(f"   -> {col}")

    logger.info(f"Loading table: {table_name}")
    logger.info(f"Rows: {len(df):,}")

    try:
        # Remove existing data but keep the table structure
        with engine.begin() as connection:
            connection.execute(text(f"DELETE FROM [{table_name}]"))

        # Insert new data
        df.to_sql(
            name=table_name,
            con=engine,
            if_exists="append",
            index=False,
            chunksize=1000,
            method="multi"
        )

        logger.info(f"{table_name} imported successfully.")

    except Exception:
        logger.exception(f"Failed loading {table_name}")
        raise