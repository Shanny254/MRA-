"""
Utility script used to inspect Excel worksheet column names.

Run this whenever the workbook structure changes.
Not part of the ETL pipeline.
"""


import pandas as pd

from scripts.extract import get_sheet_names
from scripts.extract import read_sheet

for sheet in get_sheet_names():

    print("=" * 70)
    print(sheet.upper())

    df = read_sheet(sheet)

    print(df.columns.tolist())