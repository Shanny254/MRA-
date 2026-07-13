# Database Schema

## Database

MRAs

---

## Master Tables

### accounts

Primary Key

- account_number

Description

Stores the current customer account information.

Business Rule

If an account changes, the New Account No. becomes the primary account number.
The previous number is stored as old_account_number.

---

### staff

Primary Key

- staff_no

Description

Stores KPLC staff and assigned workstations.

---

## Transaction Tables

- smart_meter_billing
- offline_smart_meters
- offline_meters_cycle_reading
- ordinary_debtlist
- lp_debt
- admd
- change_of_tariff
- zero_cons
- load_factor
- pf_1st_time
- poor_pf
- cons_deviation
- postpaid_billing
- ordinary_acs_meter_rdg

---

## Relationships

accounts
    |
    +------ smart_meter_billing
    |
    +------ ordinary_debtlist
    |
    +------ lp_debt
    |
    +------ offline_smart_meters
    |
    +------ postpaid_billing
    |
    +------ ordinary_acs_meter_rdg

staff
    |
    +------ offline_meters_cycle_reading
    |
    +------ admd
    |
    +------ load_factor
    |
    +------ zero_cons