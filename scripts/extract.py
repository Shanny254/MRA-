import pandas as pd
from scripts.config import EXCEL_FILE, IGNORE_SHEETS


def get_excel():
    return pd.ExcelFile(EXCEL_FILE)


def get_sheet_names():
    excel = get_excel()

    return [
        sheet
        for sheet in excel.sheet_names
        if sheet not in IGNORE_SHEETS
    ]


def read_sheet(sheet_name):
    return pd.read_excel(EXCEL_FILE, sheet_name=sheet_name)