"""
==========================================================
Project : MRA ETL
File    : table_schema.py
Purpose : Defines SQL table names and primary keys.
==========================================================
"""

TABLE_SCHEMA = {

    # ======================================================
    # MASTER TABLES
    # ======================================================

    "customer_account": {
        "primary_key": "account_number"
    },

    "location": {
        "primary_key": "location_id"
    },

    "meter": {
        "primary_key": "meter_number"
    },

    "staff": {
        "primary_key": "staff_no"
    },

    # ======================================================
    # TRANSACTION TABLES
    # ======================================================

    "smart_meter_billing": {
        "primary_key": "billing_id"
    },

    "offline_smart_meters": {
        "primary_key": "offline_meter_id"
    },

    "offline_meters_cycle_reading": {
        "primary_key": "inspection_id"
    },

    "ordinary_debtlist": {
        "primary_key": "debt_id"
    },

    "ordinary_acs_meter_rdg": {
        "primary_key": "reading_id"
    },

    "lp_accs": {
        "primary_key": "lp_acc_id"
    },

    "lp_debt": {
        "primary_key": "lp_debt_id"
    },

    "admd": {
        "primary_key": "admd_id"
    },

    "change_of_tariff": {
        "primary_key": "tariff_change_id"
    },

    "zero_cons": {
        "primary_key": "zero_cons_id"
    },

    "load_factor": {
        "primary_key": "load_factor_id"
    },

    "pf_1st_time": {
        "primary_key": "pf_1st_time_id"
    },

    "poor_pf": {
        "primary_key": "poor_pf_id"
    },

    "cons_deviation": {
        "primary_key": "cons_deviation_id"
    },

    "postpaid_billing": {
        "primary_key": "billing_id"
    },

    "tools": {
        "primary_key": "tool_assignment_id"
    }
}