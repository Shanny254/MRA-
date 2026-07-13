# ETL Flow

## Overview

The ETL pipeline extracts inspection data from Excel workbooks,
cleans the data,
validates it,
and loads it into SQL Server.

---

## Workflow

Raw Excel Workbook

↓

Extract

↓

Transform

↓

Validate

↓

Generate Validation Report

↓

Load into SQL Server

↓

ETL Log Generated

---

## Pipeline Components

extract.py

Reads worksheets from the Excel workbook.

---

transform.py

Standardizes column names and cleans data.

---

validate.py

Performs generic and table-specific validation.

---

report.py

Creates timestamped validation reports.

---

load.py

Loads validated data into SQL Server.

---

logger.py

Generates timestamped ETL log files.

---

main.py

Coordinates the entire ETL process.