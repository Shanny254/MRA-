import pandas as pd
from sqlalchemy import inspect

from scripts.database import engine
from scripts.logger import logger


def load_dataframe(df: pd.DataFrame, table_name: str):
    """
    Load a dataframe into SQL Server.

    Before loading, compare dataframe columns with the SQL table
    to identify missing or unexpected columns.
    """

    inspector = inspect(engine)

    sql_columns = [
        column["name"]
        for column in inspector.get_columns(table_name)
    ]

    dataframe_columns = list(df.columns)

    missing_in_sql = [
        column
        for column in dataframe_columns
        if column not in sql_columns
    ]

    missing_in_dataframe = [
        column
        for column in sql_columns
        if column not in dataframe_columns
        and column not in ("created_at",)
    ]

    if missing_in_sql:

        logger.error(f"{table_name}: Columns not found in SQL table")

        for column in missing_in_sql:
            logger.error(f"   -> {column}")

        raise ValueError(
            f"{table_name}: SQL table is missing required columns."
        )

    if missing_in_dataframe:

        logger.warning(f"{table_name}: SQL columns not supplied by dataframe")

        for column in missing_in_dataframe:
            logger.warning(f"   -> {column}")

    df.to_sql(
        name=table_name,
        con=engine,
        if_exists="append",
        index=False,
        method="multi",
        chunksize=1000
    )

    logger.info(f"{table_name} imported successfully.")