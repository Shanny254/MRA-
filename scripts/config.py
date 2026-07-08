# config.py

SERVER = "localhost"
DATABASE = "MRAs"
DRIVER = "ODBC Driver 18 for SQL Server"

EXCEL_FILE = r"data\raw\MRA_Raw_Data.xlsx"

# Automatically import every sheet except these
IGNORE_SHEETS = [
    "Instructions",
    "Summary"
]