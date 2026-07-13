from pathlib import Path
import pandas as pd


# Report Folder


BASE_DIR = Path(__file__).resolve().parent.parent
REPORT_DIR = BASE_DIR / "data" / "reports"

REPORT_DIR.mkdir(parents=True, exist_ok=True)

REPORT_FILE = REPORT_DIR / "validation_report.csv"


class ValidationReport:

    def __init__(self):
        self.records = []

    def add_issue(self, table, column, issue, value):

        self.records.append({
            "Table": table,
            "Column": column,
            "Issue": issue,
            "Value": value
        })

    def save(self):

        if not self.records:
            return

        df = pd.DataFrame(self.records)

        df.to_csv(REPORT_FILE, index=False)