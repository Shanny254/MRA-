# ==========================================================
# Project : MRA ETL
# File    : config.py
# ==========================================================

SERVER = "localhost"
DATABASE = "MRA"
DRIVER = "ODBC Driver 18 for SQL Server"

EXCEL_FILE = r"data\raw\MRA_Raw_Data.xlsx"

IGNORE_SHEETS = [
    "Instructions",
    "Summary"
]

MASTER_TABLES = [
    "customer_account",
    "location",
    "meter",
    "staff"
]

TRANSACTION_TABLES = [
    "admd",
    "change_of_tariff",
    "cons_deviation",
    "load_factor",
    "lp_accs",
    "lp_debt",
    "offline_meters_cycle_reading",
    "offline_smart_meters",
    "ordinary_acs_meter_rdg",
    "ordinary_debtlist",
    "pf_1st_time",
    "poor_pf",
    "postpaid_billing",
    "smart_meter_billing",
    "tools",
    "zero_cons"
]

TABLE_ORDER = [
    "customer_account",
    "location",
    "meter",
    "staff",
    "tools",
    "offline_smart_meters",
    "offline_meters_cycle_reading",
    "ordinary_acs_meter_rdg",
    "ordinary_debtlist",
    "smart_meter_billing",
    "postpaid_billing",
    "lp_accs",
    "lp_debt",
    "admd",
    "change_of_tariff",
    "cons_deviation",
    "load_factor",
    "pf_1st_time",
    "poor_pf",
    "zero_cons"
]