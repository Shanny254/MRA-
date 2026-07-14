# Database Schema

## Database

**Name:** MRAs

---

# Overview

The MRAs database is designed to support the ETL pipeline for KPLC inspection and billing data.

The source data originates from multiple Excel worksheets that contain customer information, billing records, inspection results, debt information and staff assignments.

The database follows a **normalized relational design** where:

- Master tables store core business entities.
- Transaction tables store business events.
- Relationships are enforced using foreign keys.
- SQL Server owns the database schema.
- Python is responsible only for ETL (Extract, Transform, Validate and Load).

---

# Database Design Principles

This project follows these principles:

1. A customer account exists only once.
2. A staff member exists only once.
3. Transaction tables reference master tables.
4. Duplicate customer information is minimized.
5. SQL Server is responsible for enforcing data integrity.
6. Python never creates database tables.

---

# Master Tables

## accounts

### Primary Key

- account_number

### Description

Stores the latest customer account information.

Every customer account exists only once in this table.

### Business Rules

- Account Number is the authoritative business identifier.
- If an account changes, the **New Account Number** becomes the active account_number.
- The previous account number is stored in old_account_number.
- Customer information should be maintained only in this table whenever possible.

### Main Attributes

- account_number
- old_account_number
- customer_name
- meter_number
- region
- county
- sector_name
- zone_name
- itinerary
- tariff
- contract_status
- created_at

---

## staff

### Primary Key

- staff_no

### Description

Stores KPLC staff information.

Each staff member exists only once.

### Main Attributes

- staff_no
- staff_name
- county
- work_station
- section
- created_at

---

# Transaction Tables

These tables store business transactions and operational records.

Every transaction references one or more master tables.

| Table | Primary Key | References |
|---------|-------------|------------|
| smart_meter_billing | billing_id | accounts |
| offline_smart_meters | offline_meter_id | accounts |
| offline_meters_cycle_reading | cycle_reading_id | accounts, staff |
| ordinary_debtlist | debtlist_id | accounts |
| lp_debt | lp_debt_id | accounts |
| admd | admd_id | accounts, staff |
| change_of_tariff | tariff_change_id | accounts, staff |
| zero_cons | zero_consumption_id | accounts, staff |
| load_factor | load_factor_id | accounts, staff |
| pf_1st_time | pf_first_time_id | accounts, staff |
| poor_pf | poor_pf_id | accounts, staff |
| cons_deviation | consumption_deviation_id | accounts, staff |
| postpaid_billing | postpaid_billing_id | accounts |
| ordinary_acs_meter_rdg | meter_reading_id | accounts |
| tools | tool_assignment_id | staff |

---

# Entity Relationships

## Accounts

The Accounts table is the parent table for all customer-related transactions.

```
accounts
│
├── smart_meter_billing
├── offline_smart_meters
├── offline_meters_cycle_reading
├── ordinary_debtlist
├── lp_debt
├── admd
├── change_of_tariff
├── zero_cons
├── load_factor
├── pf_1st_time
├── poor_pf
├── cons_deviation
├── postpaid_billing
└── ordinary_acs_meter_rdg
```

---

## Staff

The Staff table is the parent table for staff-related activities.

```
staff
│
├── tools
├── offline_meters_cycle_reading
├── admd
├── change_of_tariff
├── zero_cons
├── load_factor
├── pf_1st_time
├── poor_pf
└── cons_deviation
```

---

# Column Ownership

## Accounts owns

- account_number
- old_account_number
- customer_name
- meter_number
- region
- county
- sector_name
- zone_name
- itinerary
- tariff
- contract_status

---

## Staff owns

- staff_no
- staff_name
- work_station
- section
- county

---

## Transaction tables own

Transaction-specific values such as:

- billing amounts
- meter readings
- inspection dates
- debt balances
- power factor values
- remarks
- validation status
- revenue collected
- communication status

These values describe events and therefore belong to their respective transaction tables.

---

# Naming Convention

## Tables

- snake_case

Example

```
smart_meter_billing
```

---

## Columns

- snake_case

Example

```
account_number
customer_name
inspection_date
```

---

## Primary Keys

Master Tables

- account_number
- staff_no

Transaction Tables

- billing_id
- debtlist_id
- cycle_reading_id
- tariff_change_id

---

## Foreign Keys

Foreign key names will match the referenced primary key.

Examples

```
account_number
staff_no
```

---

## SQL Objects

Views

```
vw_
```

Stored Procedures

```
sp_
```

Indexes

```
ix_
```

Primary Keys

```
pk_
```

Foreign Keys

```
fk_
```

---

# Data Flow

The database receives data through the ETL pipeline.

```
Excel Workbook
        │
        ▼
Python Extract
        │
        ▼
Python Transform
        │
        ▼
Python Validation
        │
        ▼
Staging Tables
        │
        ▼
Master Tables
(accounts, staff)
        │
        ▼
Transaction Tables
        │
        ▼
SQL Views
        │
        ▼
Power BI
```

---

# Future Enhancements

The following features are planned as the project evolves.

- SQL staging schema
- Stored procedures for data loading
- MERGE-based incremental loading
- SQL views for reporting
- Power BI star schema
- Additional lookup tables (for example Tariff)
- Database indexes
- Stored validation procedures
- Scheduled ETL execution

---

# Version

Current Version: **1.0**

Last Updated: July 2026


