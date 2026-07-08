# KPLC Meter Risk Assessment (MRA) ETL

## Overview

This project automates the extraction of Meter Risk Assessment (MRA) Excel reports into Microsoft SQL Server using Python.

The ETL pipeline performs:

- Extract data from Excel
- Transform and clean data
- Load data into SQL Server
- Prepare data for Power BI dashboards

---

## Technologies

- Python 3.13+
- SQL Server
- SQLAlchemy
- PyODBC
- Pandas
- OpenPyXL

---

## Project Structure

```
MRA_ETL
│
├── dashboard
│
├── data
│   ├── archive
│   ├── processed
│   └── raw
│        └── MRA_Raw_Data.xlsx
│
├── docs
│
├── logs
│
├── scripts
│   ├── config.py
│   ├── database.py
│   ├── extract.py
│   ├── load.py
│   ├── main.py
│   └── transform.py
│
├── sql
│   ├── indexes.sql
│   ├── procedures.sql
│   ├── schema.sql
│   └── views.sql
│
├── tests
│   ├── check_driver.py
│   └── test_connection.py
│
├── .gitignore
├── README.md
└── requirements.txt
```

---

## Installation

### 1. Clone the repository

```bash
git clone <repository-url>
cd MRA_ETL
```

### 2. Create a virtual environment

Windows

```bash
py -m venv venv
```

Activate

```bash
.\venv\Scripts\Activate.ps1
```

### 3. Install required packages

```bash
pip install -r requirements.txt
```

---

## Configure SQL Server

Open `config.py`

Update:

- SQL Server name
- Database name
- Driver

Example:

```python
SERVER = "YOUR_SERVER_NAME"
DATABASE = "MRAs"
DRIVER = "ODBC Driver 17 for SQL Server"
```

---

## Import Data

Place the latest MRA Excel workbook inside

```
data/raw
```

---

## Run the ETL

```bash
 py -m scripts.main
```

The program will:

- Read every worksheet
- Create/update SQL tables
- Import all records

---

## Future Improvements

- ETL logging
- Data validation
- Incremental loading
- SQL Views
- Power BI Dashboard
- GIS Mapping

---


