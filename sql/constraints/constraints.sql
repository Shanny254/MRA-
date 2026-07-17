/*
Project : MRA ETL
Database: MRAs
Purpose : Creates all database constraints.
*/

USE MRA;
GO

/*==========================================================
FOREIGN KEYS - CUSTOMER ACCOUNT
==========================================================*/

ALTER TABLE lp_accs
ADD CONSTRAINT FK_lp_accs_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

ALTER TABLE offline_smart_meters
ADD CONSTRAINT FK_offline_smart_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

ALTER TABLE offline_meters_cycle_reading
ADD CONSTRAINT FK_cycle_reading_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

ALTER TABLE ordinary_debtlist
ADD CONSTRAINT FK_debtlist_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

ALTER TABLE ordinary_acs_meter_rdg
ADD CONSTRAINT FK_acs_meter_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

ALTER TABLE postpaid_billing
ADD CONSTRAINT FK_postpaid_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

ALTER TABLE smart_meter_billing
ADD CONSTRAINT FK_smart_billing_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

ALTER TABLE admd
ADD CONSTRAINT FK_admd_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

ALTER TABLE change_of_tariff
ADD CONSTRAINT FK_change_tariff_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

ALTER TABLE zero_cons
ADD CONSTRAINT FK_zero_cons_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

ALTER TABLE load_factor
ADD CONSTRAINT FK_load_factor_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

ALTER TABLE cons_deviation
ADD CONSTRAINT FK_cons_deviation_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

ALTER TABLE pf_1st_time
ADD CONSTRAINT FK_pf_first_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

ALTER TABLE poor_pf
ADD CONSTRAINT FK_poor_pf_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

ALTER TABLE lp_debt
ADD CONSTRAINT FK_lp_debt_account
FOREIGN KEY (account_number)
REFERENCES customer_account(account_number);
GO

/*==========================================================
FOREIGN KEYS - STAFF
==========================================================*/

ALTER TABLE tools
ADD CONSTRAINT FK_tools_staff
FOREIGN KEY (staff_no)
REFERENCES staff(staff_no);
GO

ALTER TABLE offline_smart_meters
ADD CONSTRAINT FK_offline_smart_staff
FOREIGN KEY (staff_no)
REFERENCES staff(staff_no);
GO

ALTER TABLE offline_meters_cycle_reading
ADD CONSTRAINT FK_cycle_reading_staff
FOREIGN KEY (staff_no)
REFERENCES staff(staff_no);
GO

/*==========================================================
FOREIGN KEYS - METER
==========================================================*/

USE MRA;
GO


ALTER TABLE customer_account
ADD CONSTRAINT FK_customer_account_meter
FOREIGN KEY (meter_number)
REFERENCES meter(meter_number);
GO

ALTER TABLE lp_accs
ADD CONSTRAINT FK_lp_accs_meter
FOREIGN KEY (meter_number)
REFERENCES meter(meter_number);
GO

ALTER TABLE offline_smart_meters
ADD CONSTRAINT FK_offline_smart_meter
FOREIGN KEY (meter_number)
REFERENCES meter(meter_number);
GO

ALTER TABLE offline_meters_cycle_reading
ADD CONSTRAINT FK_cycle_reading_meter
FOREIGN KEY (meter_number)
REFERENCES meter(meter_number);
GO

ALTER TABLE ordinary_acs_meter_rdg
ADD CONSTRAINT FK_ordinary_acs_meter
FOREIGN KEY (meter_number)
REFERENCES meter(meter_number);
GO

ALTER TABLE smart_meter_billing
ADD CONSTRAINT FK_smart_meter_billing_meter
FOREIGN KEY (meter_number)
REFERENCES meter(meter_number);
GO

/*==========================================================
CHECK CONSTRAINTS
==========================================================*/

ALTER TABLE offline_meters_cycle_reading
ADD CONSTRAINT CHK_cycle_total_reading
CHECK (total_reading >= 0);
GO

ALTER TABLE offline_meters_cycle_reading
ADD CONSTRAINT CHK_cycle_high_rate
CHECK (high_rate_reading >= 0);
GO

ALTER TABLE offline_meters_cycle_reading
ADD CONSTRAINT CHK_cycle_low_rate
CHECK (low_rate_reading >= 0);
GO

ALTER TABLE offline_meters_cycle_reading
ADD CONSTRAINT CHK_cycle_kva_reading
CHECK (kva_reading >= 0);
GO

ALTER TABLE offline_meters_cycle_reading
ADD CONSTRAINT CHK_cycle_kw_reading
CHECK (kw_reading >= 0);
GO

ALTER TABLE offline_meters_cycle_reading
ADD CONSTRAINT CHK_cycle_overdue_debt
CHECK (overdue_debt >= 0);
GO

ALTER TABLE offline_meters_cycle_reading
ADD CONSTRAINT CHK_cycle_revenue
CHECK (revenue_collected >= 0);
GO

ALTER TABLE offline_meters_cycle_reading
ADD CONSTRAINT CHK_cycle_kva
CHECK (kva >= 0);
GO

ALTER TABLE offline_meters_cycle_reading
ADD CONSTRAINT CHK_cycle_kwh
CHECK (kwh >= 0);
GO

ALTER TABLE offline_meters_cycle_reading
ADD CONSTRAINT CHK_cycle_earth_current
CHECK (earth_current >= 0);
GO

ALTER TABLE offline_meters_cycle_reading
ADD CONSTRAINT CHK_cycle_number_of_meters
CHECK (number_of_meters_on_site >= 0);
GO

ALTER TABLE tools
ADD CONSTRAINT CHK_tools_mileage
CHECK (TRY_CONVERT(decimal(10,2), mileage) IS NOT NULL OR mileage IS NULL);
GO