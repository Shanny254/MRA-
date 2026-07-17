import pandas as pd
from sqlalchemy import inspect, text

from scripts.database import engine
from scripts.logger import logger


def load_dataframe(df: pd.DataFrame, table_name: str):
    """
    Load a cleaned DataFrame into an existing SQL Server table.
    """

    inspector = inspect(engine)

    if not inspector.has_table(table_name):
        raise ValueError(f"Table '{table_name}' does not exist.")

    # SQL table columns
    sql_columns = [
        column["name"]
        for column in inspector.get_columns(table_name)
    ]

    # Ignore auto-generated columns
    ignored_columns = {
        "created_at",
        "updated_at",
    }

    expected_columns = [
        column
        for column in sql_columns
        if column not in ignored_columns
    ]

    # Remove duplicate dataframe columns
    df = df.loc[:, ~df.columns.duplicated()]

    # Keep only columns that exist in SQL
    existing_columns = [
        column
        for column in expected_columns
        if column in df.columns
    ]

    df = df[existing_columns].copy()

    # Add missing SQL columns as NULL
    for column in expected_columns:

        if column not in df.columns:
            df[column] = None

    # Match SQL column order
    df = df[expected_columns]

    logger.info(f"Loading {table_name}")
    logger.info(f"Rows: {len(df):,}")

    try:

        with engine.begin() as connection:
            connection.execute(
                text(f"DELETE FROM [{table_name}]")
            )

        df.to_sql(
            table_name,
            con=engine,
            if_exists="append",
            index=False,
            chunksize=1000,
            method="multi"
        )

        logger.info(f"{table_name} loaded successfully.")

    except Exception:
        logger.exception(f"Failed loading {table_name}")
        raise