# Data Dictionary

## Project

**Project:** KPLC MRA ETL Pipeline

**Database:** MRAs

---

# Accounts (Planned)

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| account_number | VARCHAR | Current customer account number | Primary Key |
| old_account_number | VARCHAR | Previous account number | |
| customer_name | VARCHAR | Customer name | |
| meter_number | VARCHAR | Meter serial number | |
| county | VARCHAR | Customer county | |
| region | VARCHAR | Customer region | |
| zone_name | VARCHAR | Customer zone | |

---

# Staff (Planned)

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| staff_no | VARCHAR | Staff identification number | Primary Key |
| staff_name | VARCHAR | Staff full name | |
| county | VARCHAR | Assigned county | |
| work_station | VARCHAR | Work station | |
| section | VARCHAR | Department/Section | |

---

# Smart Meter Billing

| Column | Description |
|---------|-------------|
| account_number | Customer account number |
| customer_name | Customer name |
| meter_number | Meter number |
| total_consumption | Energy consumed |
| total_amount | Bill amount |
