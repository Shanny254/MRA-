/*
Project : MRA ETL
Database: MRA
Purpose : Creates performance indexes.
*/

USE MRA;
GO

/*==========================================================
CUSTOMER ACCOUNT
==========================================================*/

CREATE NONCLUSTERED INDEX IX_customer_account_meter
ON customer_account (meter_number);
GO

CREATE NONCLUSTERED INDEX IX_customer_account_tariff
ON customer_account (tariff);
GO

CREATE NONCLUSTERED INDEX IX_customer_account_contract
ON customer_account (contract_status);
GO


/*==========================================================
STAFF
==========================================================*/

CREATE NONCLUSTERED INDEX IX_staff_county
ON staff (county);
GO

CREATE NONCLUSTERED INDEX IX_staff_section
ON staff (section_name);
GO


/*==========================================================
LOCATION
==========================================================*/

CREATE NONCLUSTERED INDEX IX_location_region_county
ON location (region, county);
GO

CREATE NONCLUSTERED INDEX IX_location_itinerary
ON location (itinerary);
GO


/*==========================================================
TOOLS
==========================================================*/

CREATE NONCLUSTERED INDEX IX_tools_staff
ON tools (staff_no);
GO


/*==========================================================
LP ACCOUNTS
==========================================================*/

CREATE NONCLUSTERED INDEX IX_lp_accs_account
ON lp_accs (account_number);
GO

CREATE NONCLUSTERED INDEX IX_lp_accs_meter
ON lp_accs (meter_number);
GO


/*==========================================================
OFFLINE SMART METERS
==========================================================*/

CREATE NONCLUSTERED INDEX IX_offline_smart_account
ON offline_smart_meters (account_number);
GO

CREATE NONCLUSTERED INDEX IX_offline_smart_meter
ON offline_smart_meters (meter_number);
GO

CREATE NONCLUSTERED INDEX IX_offline_smart_staff
ON offline_smart_meters (staff_no);
GO


/*==========================================================
OFFLINE METER CYCLE READING
==========================================================*/

CREATE NONCLUSTERED INDEX IX_cycle_account
ON offline_meters_cycle_reading (account_number);
GO

CREATE NONCLUSTERED INDEX IX_cycle_meter
ON offline_meters_cycle_reading (meter_number);
GO

CREATE NONCLUSTERED INDEX IX_cycle_staff
ON offline_meters_cycle_reading (staff_no);
GO

CREATE NONCLUSTERED INDEX IX_cycle_date
ON offline_meters_cycle_reading (inspection_date);
GO


/*==========================================================
ORDINARY ACS METER READING
==========================================================*/

CREATE NONCLUSTERED INDEX IX_acs_account
ON ordinary_acs_meter_rdg (account_number);
GO

CREATE NONCLUSTERED INDEX IX_acs_meter
ON ordinary_acs_meter_rdg (meter_number);
GO

CREATE NONCLUSTERED INDEX IX_acs_date
ON ordinary_acs_meter_rdg (reading_date);
GO


/*==========================================================
POSTPAID BILLING
==========================================================*/

CREATE NONCLUSTERED INDEX IX_postpaid_account
ON postpaid_billing (account_number);
GO

CREATE NONCLUSTERED INDEX IX_postpaid_month
ON postpaid_billing (bill_month);
GO


/*==========================================================
SMART METER BILLING
==========================================================*/

CREATE NONCLUSTERED INDEX IX_smart_account
ON smart_meter_billing (account_number);
GO

CREATE NONCLUSTERED INDEX IX_smart_meter
ON smart_meter_billing (meter_number);
GO


/*==========================================================
ORDINARY DEBTLIST
==========================================================*/

CREATE NONCLUSTERED INDEX IX_debtlist_account
ON ordinary_debtlist (account_number);
GO


/*==========================================================
LP DEBT
==========================================================*/

CREATE NONCLUSTERED INDEX IX_lp_debt_account
ON lp_debt (account_number);
GO

CREATE NONCLUSTERED INDEX IX_lp_debt_month
ON lp_debt (bill_month);
GO


/*==========================================================
ADMD
==========================================================*/

CREATE NONCLUSTERED INDEX IX_admd_account
ON admd (account_number);
GO

CREATE NONCLUSTERED INDEX IX_admd_date
ON admd (inspection_date);
GO


/*==========================================================
CHANGE OF TARIFF
==========================================================*/

CREATE NONCLUSTERED INDEX IX_change_tariff_account
ON change_of_tariff (account_number);
GO


/*==========================================================
CONSUMPTION DEVIATION
==========================================================*/

CREATE NONCLUSTERED INDEX IX_cons_deviation_account
ON cons_deviation (account_number);
GO


/*==========================================================
LOAD FACTOR
==========================================================*/

CREATE NONCLUSTERED INDEX IX_load_factor_account
ON load_factor (account_number);
GO

CREATE NONCLUSTERED INDEX IX_load_factor_period
ON load_factor (analysis_period);
GO


/*==========================================================
ZERO CONSUMPTION
==========================================================*/

CREATE NONCLUSTERED INDEX IX_zero_cons_account
ON zero_cons (account_number);
GO

CREATE NONCLUSTERED INDEX IX_zero_cons_period
ON zero_cons (billing_period);
GO


/*==========================================================
POWER FACTOR
==========================================================*/

CREATE NONCLUSTERED INDEX IX_pf_first_account
ON pf_1st_time (account_number);
GO

CREATE NONCLUSTERED INDEX IX_pf_first_date
ON pf_1st_time (inspection_date);
GO

CREATE NONCLUSTERED INDEX IX_poor_pf_account
ON poor_pf (account_number);
GO

CREATE NONCLUSTERED INDEX IX_poor_pf_date
ON poor_pf (inspection_date);
GO